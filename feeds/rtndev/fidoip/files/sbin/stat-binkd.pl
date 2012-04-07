#!/opt/bin/perl
use POSIX qw(mktime strftime);
$max = 2;
$stat1, $stat2, $graph1, $graph2, $bad, $log;
$usage = <<EOL
binkdstat - binkd statistic generator v1.21, (c)opyright by val khokhlov

    binkdstat [-l <log>] [-s <start>|- <period>|-] [-g <day>] [-b]
       -l <log>, --log=<log>                           use binkd.log <log>
       -s <start> <period>, --stat=<start>,<period>    set period for summary
       -g <day>, --graph=<day>                         set day to draw a graph
       -b                                              dispay failures table

    If <log> isn't specified, stdin is used
    Date/time consists of token(s): [+-]<NN>[hdwmy]
       use 15x to set value to 15 (h - hour, d - day, m - month, y - year)
       use +2d to advance day forward by 2, -6d to advance day backward by 6
       use -1w to set date to Monday of previous week, +1w - next week
       (if letter [hdwmy] is omitted 'd' is assumed)
    <start> and/or <period> can be '-' not to limit corresponding parameter
    <period> for --stat is relative to the <start> date/time (or current day)
    <day> for --graph is relative to the day after --stat (or current day)

    Examples:
       binkdstat -s -1w +7d            statistics for the previous week
       binkdstat -s -1 +1 -g -1        stats and graph for yesterday
EOL
;
# --------------------------------------------------------------------
# parse binkd log: parse_log($dt_start, $dt_finish)
sub parse_log {
my %MON = (Jan=>0, Feb=>1, Mar=>2, Apr=>3, May=>4, Jun=>5, Jul=>6, Aug=>7, Sep=>8, Oct=>9, Nov=>10, Dec=>11);
my $trsh = 30*60; # treshold
  my ($dt_start, $dt_finish) = @_;
  my $YEAR = (localtime)[5];
  $dt_start = 0 if !defined $dt_start;
  $dt_finish = 0x7fffffff if !defined $dt_finish;
  my %data; my $found = 0; my $cur = 0;
  if (defined $log) {
    open F, $log or die "fatal: can't open log file $log";
  } else { *F = *STDIN; }
  while (<F>) {
    study $_;
    my ($day, $mon, $h, $m, $s, $pid, $cmd) = /^..(..).(...).(..):(..):(..).\[(\d+)\].(.*)/ or next;
    my $dt = mktime($s, $m, $h, $day, $MON{$mon}, $YEAR);
    if ($dt_start == 0 && !defined $stat1) { $stat1 = $dt; }
    if ($dt_finish == 0x7fffffff) { $stat2 = $dt; }
    next if ($dt < $dt_start-$trsh);
    last if ($dt > $dt_finish && $cur <= 0);
    study $cmd;
    if ($cmd =~ /^session with/o && $dt <= $dt_finish) { 
      my ($ip) = /\(([^)]+)/o;
      $data{$pid}{'sthh'} = $h*2 + ($m > 29);
      $data{$pid}{'ip'} = $ip; $data{$pid}{'stdt'} = $dt;
      $cur++; 
    }
    elsif ($cmd =~ /^incoming from/o && $dt <= $dt_finish) { 
      my ($ip) = /\(([^)]+)/o;
      $incoming{$ip} = 1; 
    }
    elsif ($cmd =~ /^call to/o) {
      my ($addr) = $cmd =~ /^call to ([^\@\s]+)/o;
      $addr =~ s/\.0+$//o;
      $node{$addr}{'call'}++;
    }
    # assure defined $data{$pid}
    elsif (!defined $data{$pid}) { next; }
    # $data{$pid} defined
    elsif ($cmd =~ /pwd protected/o) { $data{$pid}{'pwd'} = 1; }
    elsif ($cmd =~ /^(?:rcvd|sent): /o) {
      my ($sz, $cps) = $cmd =~ /(\d+), (\d+\.\d+) CPS/o;
      if (defined $cps) { $data{$pid}{'xcps'} += $cps*$sz; }
    }
    elsif ($dt >= $dt_start && $cmd =~ /^done/o) {
      my ($cmd2, $st, $sf, $rf, $sb, $rb) = $cmd =~ /^done \(([^,]+), (\S+), S\/R: (\d+)\/(\d+) \((\d+)\/(\d+)/o;
      my ($dir, $addr) = $cmd2 =~ /(to|from) ([^\@\s]+)\S*/o;
      if ($dir ne 'from' && $dir ne 'to' 
          && $incoming{ $data{$pid}{'ip'} }) { $dir = 'from'; }
      if ($st ne 'OK') { $st = 'failed'; }
      $addr =~ s/\.0+$//o;
      my $w = $h*2 + ($m > 29);
      if ($data{$pid}{'stdt'} < $graph2 && $dt > $graph1) {
        put_traf($data{$pid}{'stdt'} < $graph1 ? 0 : $data{$pid}{'sthh'}, 
                 $dt > $graph2 ? 0 : $w, 
                 $sb, $rb, $data{$pid}{'pwd'} ? (\@out, \@in) : (\@out2, \@in2));
      }
      $node{$addr}{'sb'} += $sb; $node{$addr}{'rb'} += $rb;
      $node{$addr}{'sec'} += $dt - $data{$pid}{'stdt'};
      $node{$addr}{ $data{$pid}{'pwd'} ? 'pwok' : 'unpw' }++;
      $node{$addr}{'last'} = ($st eq 'OK') ? 1 : 0;
      $node{$addr}{"${dir}_${st}"}++;
      if ($sb+$rb > 0) { $node{$addr}{'xcps'} += $data{$pid}{'xcps'}; }
      if ($st eq 'failed' && !$data{$pid}{'bad'}) {
        put_bad(\@bad, $data{$pid}{'ip'}, $addr, 
                defined $addr ? 'unknown' : 'connection failure');
      }
      undef $data{$pid}; $cur--; 
    }
    elsif ($cmd =~ /^addr/) {
      my ($addr, $st) = $cmd =~ /^addr: ([^\@\s]+)[^(]*(\([^)]+)?/o;
      $addr =~ s/\.0+$//o;
      $data{$pid}{'addr'} = $addr unless defined $data{$pid}{'addr'};
      if ($st =~ /not from allowed remote (?:address|IP)/o) {
        put_bad(\@bad, $data{$pid}{'ip'}, $addr, 'not from allowed remote address');
        $data{$pid}{'bad'} = 1;
      }
    }
    elsif ($cmd =~ /^got M_BSY:/o && !$data{$pid}{'bad'}) {
      put_bad(\@bad, $data{$pid}{'ip'}, $data{$pid}{'addr'}, 'all AKAs busy or domains differ');
      $data{$pid}{'bad'} = 1;
    }
    elsif ($cmd =~ /remote has no such AKA$/o) {
      my ($addr, $st) = $cmd =~ /^called\s+([^,]+)/o;
      $addr =~ s/\.0+$//o;
      put_bad(\@bad, $data{$pid}{'ip'}, $addr, 'no such AKA on remote; actual is '.$data{$pid}{'addr'});
      $data{$pid}{'ignore'} = 1;
    }
    elsif ($cmd =~ /: (?:Bad|incorrect) password$/o) {
      put_bad(\@bad, $data{$pid}{'ip'}, $data{$pid}{'addr'}, 'incorrect password');
      $data{$pid}{'bad'} = 1;
    }
    elsif ($cmd =~ /^skipping/o) {
      my ($type, $mask) = $cmd =~ /(\w+)-?mask\s+(\S+)\)$/;
      if (defined $mask) {
        put_bad(\@bad, $data{$pid}{'ip'}, $data{$pid}{'addr'}, "skipped by ${type}mask $mask");
      }
    }
    elsif ($cmd =~ /^bad pkt addr/o) {
      my ($addr, $st) = $cmd =~ /^bad pkt addr: ([^\@\s]+)/o;
      $addr =~ s/\.0+$//o;
      put_bad(\@bad, $data{$pid}{'ip'}, $data{$pid}{'addr'}, "bad pkt sender: $addr");
    }
    elsif ($cmd =~ /^cannot rename/o) {
      put_bad(\@bad, $data{$pid}{'ip'}, $data{$pid}{'addr'}, 'local filesystem problems');
      $data{$pid}{'bad'} = 1;
    }
    elsif ($cmd eq 'timeout!') {
      put_bad(\@bad, $data{$pid}{'ip'}, $data{$pid}{'addr'}, 'timeout');
      $data{$pid}{'bad'} = 1;
    }
  }
  close F;
  return $found;
}
# --------------------------------------------------------------------
# bytes to string nice conversion: traf2str(@arg)
sub traf2str {
  my $s = '';
  for my $c (@_) {
    if ($c < 1000) { $s .= sprintf "%7d ", $c; }
    elsif ($c < 100000) { $s .= sprintf "%3d,%03d ", int($c/1000), $c%1000; }
    elsif ($c < 1000*1024) { $s .= sprintf "%7dk", int($c/1024); }
    elsif ($c < 100000*1024) { $s .= sprintf "%3d,%03dk", int($c/1024 / 1000), int($c/1024 % 1000); }
    else { $s .= sprintf "%7dM", int($c/1024/1024); }
  }
  return $s;
}
# --------------------------------------------------------------------
# cps to string nice conversion: cps2str(@arg)
sub cps2str {
  my ($c) = @_;
  $c = int($c + 0.5);
  return ' -- ' if ($c <= 0);
  return sprintf "%4d", $c if ($c <= 9999);
  return sprintf "%3dk", int($c/1024) if ($c <= 999*1024);
  return sprintf "%3dM", int($c/1024/1024);
}
# --------------------------------------------------------------------
# summary: out_summary(\%node)
sub out_summary {
  my @out; my @outa; my %tot; my $n = 0; my $xcps = 0;
  while ( my ($addr, $rec) = each %{$_[0]} ) {
    $n++ if $addr;
    my ($s, $pwd, $last); my $cps = 0;
    my $secs = $rec->{'sec'} % 60;
    my $mins = int($rec->{'sec'} / 60) % 60;
    my $hours = int($rec->{'sec'} / 60 / 60);
    if ($rec->{'pwok'} && !$rec->{'unpw'}) { $pwd = '*'; }
    elsif ($rec->{'unpw'} && !$rec->{'pwok'}) { $pwd = ' '; }
    else { $pwd = '?'; }
    $last = $rec->{'last'} ? 'ú' : '';
    if ($rec->{'sec'} > 0) { $cps = ($rec->{'rb'}+$rec->{'sb'}) / $rec->{'sec'}; }
    if ($rec->{'xcps'}) { $rec->{'xcps'} /= $rec->{'rb'}+$rec->{'sb'}; }
    $s = sprintf "º%s%3d %3d %3d %3d %3d³%s%-15s³%4d:%02d:%02d³%s³%s³%sº", 
                 $pwd,
                 $rec->{'from_OK'}, $rec->{'from_failed'}, $rec->{'call'}, $rec->{'to_OK'}, $rec->{'to_failed'},
                 $last, ($addr||'failure'), $hours, $mins, $secs,
                 traf2str($rec->{'rb'}, $rec->{'sb'}), 
                 cps2str($rec->{'xcps'}), cps2str($cps);
    if ($rec->{'xcps'} > 0) { $xcps += $rec->{'xcps'}*($rec->{'sb'}+$rec->{'rb'}); }
    # insert into sorted out
    my ($Z,$N,$F,$P) = $addr =~ /^(\d+):(\d+)\/(\d+)(?:\.(\d+))?$/o;
    for (my $i = 0; $i <= @outa; $i++) {
      if ($i == @outa) { push @out, $s; push @outa, $addr; last; }
      my ($z,$n,$f,$p) = $outa[$i] =~ /^(\d+):(\d+)\/(\d+)(?:\.(\d+))?$/o;
#      my $less = ($Z < $z) || ($Z == $z && $N < $n)
#                 || ($Z == $z && $N == $n && $F < $f)
#                 || ($Z == $z && $N == $n && $F == $f && $P < $p);
      my $less = $addr le $outa[$i];
      if ($less) { splice @out, $i, 0, $s; splice @outa, $i, 0, $addr; last; }
    }
    # add to totals
    for my $s (qw'sec from_OK from_failed call to_OK to_failed sb rb') {
      $tot{$s} += $rec->{$s};
    }
  }
  # hdr
  my @hdr = (
    'Summary link statistics',
    '('.strftime("%a, %d %b %H:%M:%S", localtime $stat1)." - ".strftime("%a, %d %b %H:%M:%S", localtime $stat2).')',
    '',
    " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Password: '*' - Present, ' ' - Absent, '?' - Error",
    " ³                    Ú Last Session Result: 'ú' - Success, '' - Aborted",
    'É'.('Í'x20).'Ñ'.('Í'x16).'Ñ'.('Í'x10).'Ñ'.('Í'x16).'Ñ'.('Í'x9).'»',
    'ºP   In       Out    ³L    Address    ³   Time   ³  Bytes  Bytes  ³   CPS   º',
    'º  ok err call ok err³                ³  Online  ³received  sent  ³Xfer³Efctº',
    'Ç'.('Ä'x20).'Å'.('Ä'x16).'Å'.('Ä'x10).'Å'.('Ä'x16).'Å'.('Ä'x4).'Å'.('Ä'x4).'¶'
  );
  $hdr[0] = (' 'x(39-length($hdr[0])/2)).$hdr[0];
  $hdr[1] = (' 'x(39-length($hdr[0])/2)).$hdr[1];
  splice @out, 0, 0, @hdr;
  # totals
  push @out, 'Ç'.('Ä'x20).'Å'.('Ä'x16).'Å'.('Ä'x10).'Å'.('Ä'x16).'Å'.('Ä'x4).'Å'.('Ä'x4).'¶';
  my $secs = $tot{'sec'} % 60;
  my $mins = int($tot{'sec'} / 60) % 60;
  my $hours = int($tot{'sec'} / 60 / 60);
  my $cps = 0;
  if ($tot{'sec'} > 0) { $cps = ($tot{'rb'}+$tot{'sb'}) / $tot{'sec'}; }
  if ($tot{'sb'}+$tot{'rb'} > 0) { $xcps /= $tot{'sb'} + $tot{'rb'}; } else { $xcps = 0; }
  push @out, sprintf "º %3d %3d %3d %3d %3d³ Stations: %4d ³%4d:%02d:%02d³%s³%s³%sº", 
                 $tot{'from_OK'}, $tot{'from_failed'}, $tot{'call'}, $tot{'to_OK'}, $tot{'to_failed'},
                 $n, $hours, $mins, $secs,
                 traf2str($tot{'rb'}, $tot{'sb'}), cps2str($xcps), cps2str($cps);
  push @out, 'È'.('Í'x20).'Ï'.('Í'x16).'Ï'.('Í'x10).'Ï'.('Í'x16).'Ï'.('Í'x4).'Ï'.('Í'x4).'¼';
  return @out;
}
# --------------------------------------------------------------------
# put traffic into hourly records
#   put_traf($start_hh, $end_hh, $sent, $recv, \@out, \@in)
sub put_traf {
  my ($sthh, $ehh, $sb, $rb, $out, $in) = @_;
  $ehh += 48 if ($ehh < $sthh);
  my $n = $ehh - $sthh;
  for (my $i = 0; $i <= $n; $i++) { 
    $out->[($sthh+$i) % 48] += $sb/($n+1);
    $in->[($sthh+$i) % 48]  += $rb/($n+1);
  }
}
# --------------------------------------------------------------------
# traffic graph: out_graph(\@out,\@in,\@out_unsec,\@in_unsec)
sub out_graph {
my $MAX = $max*1024/8*60*30;
my $trans = 100/16;
my @symb = ('Û', '²', '±', '°', '.');
my (@out, $l, $h, $i);
my ($title, @traf) = @_;
  # graph
  for ($l = 15; $l >= 0; $l--) {
    if (($l+1) % 4 == 0) { $out[15-$l] = sprintf "%3.1fk ´", ($l+1)*$max/16; } 
      else { $out[15-$l] = "     ³"; }
    for ($h = 0; $h < 48; $h++) {
      my $c = 0;
      for ($i = 0; $i < @symb; $i++) {
        if ($i == @symb-1) { $out[15-$l] .= $symb[-1]; last; }
        $c += $traf[$i]->[$h];
        if ($c/$MAX > $l/16) { $out[15-$l] .= $symb[$i]; last; }
      }
    }
  }
  $out[16] = "   0 Å".("ÄÂ"x24);
  $out[17] = "     "; for (my $h = 0; $h < 24; $h++) { 
    if ($h < 10) { $out[17] .= $h.' '; } elsif ($h % 2) { $out[17] .= ' '.$h.' '; }
  }
  # table
  $l = 1;
  for ($i = 0; $i < @symb-1; $i++) {
    my $s = ' ÚÄ['.$symb[$i].'] '.$title->[$i].' ';
    $s .= 'Ä'x(22-length($s));
    $out[$l++] .= $s.'¿';
    my $c = 0;
    for ($h = 0; $h < 48; $h++) { $c += $traf[$i]->[$h]; }
    $out[$l++] .= " ³ traffic :".traf2str($c)."  ³";
    $out[$l++] .= " ³ avg.load: ".sprintf("%6.02f", 8*$c/$max/1024/60/60/24*100)."%  ³";
    $out[$l++] .= " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ";
  }
  # hdr
  my $s = 'Station busy graph for '.strftime("%a, %d %b %Y", localtime $graph1);
  $s = (' 'x(6+24-length($s)/2)).$s;
  splice @out, 0, 0, ($s, '');
  return @out;
}
# --------------------------------------------------------------------
# put bad report to list: put_bad(\@bads, $ip, $addr, $reason)
sub put_bad {
  my ($a, $ip, $addr, $reason) = @_;
  my $i;
  for ($i = 0; $i < @$a; $i++) {
    last if ($a->[$i][1] eq $ip) && ($a->[$i][2] eq $addr) && ($a->[$i][3] eq $reason);
  }
  if ($i == @$a) { push @$a, [1, $ip, $addr, $reason]; } else { $a->[$i][0]++; }
}
# --------------------------------------------------------------------
# bad list
sub out_bad {
  my (@out, @outc, $s);
  @bad = sort { $b->[0] <=> $a->[0] } @bad;
  for my $elem (@bad) {
    my ($cnt, $ip, $addr, $reason) = @$elem;
    $addr = '?' if $addr eq '';
    $reason = 'unknown' if $reason eq '';
    if (length $reason > 36) { substr $reason, 33, length($reason)-33, '...'; }
    push @out, sprintf "º%4d³ %15s³ %-15s³%-36sº", $cnt, $ip, $addr, $reason;
  }
  my @hdr = (
    'Session failures and problems',
    '('.strftime("%a, %d %b %H:%M:%S", localtime $stat1)." - ".strftime("%a, %d %b %H:%M:%S", localtime $stat2).')',
    'É'.('Í'x4).'Ñ'.('Í'x16).'Ñ'.('Í'x16).'Ñ'.('Í'x36).'»',
    'º ## ³   IP address   ³    Address     ³           Reason                   º',
    'Ç'.('Ä'x4).'Å'.('Ä'x16).'Å'.('Ä'x16).'Å'.('Ä'x36).'¶'
  );
  $hdr[0] = (' 'x(39-length($hdr[0])/2)).$hdr[0];
  $hdr[1] = (' 'x(39-length($hdr[0])/2)).$hdr[1];
  splice @out, 0, 0, @hdr;
  push @out, 'È'.('Í'x4).'Ï'.('Í'x16).'Ï'.('Í'x16).'Ï'.('Í'x36).'¼';
  return @out;
}
# --------------------------------------------------------------------
# convert string to datetime: str2time($s[, $base])
sub str2time {
  my ($s, $base) = @_;
  $base = time if !defined $base;
  my ($h, $d, $m, $y, $w) = (localtime $base)[2..6];
  $w = 7 if $w == 0;
  $h = 0 unless $s =~ /[Hh]/o;
  while (length $s > 0) {
    my @a = $s =~ /^([+-]?)(\d+)([hHdDwWmMyY])?/o or return undef;
    substr $s, 0, length(join '', @a), '';
    $a[2] = 'd' if !defined $a[2];
    if (lc $a[2] eq 'y') { 
      if ($a[0] eq '-') { $y -= $a[1]; }
      elsif ($a[0] eq '+') { $y += $a[1]; }
      elsif ($a[1] < 1900) { $y = $a[1]+100; }
      else { $y = $a[1]-1900; }
    }
    elsif (lc $a[2] eq 'm') { $m = $a[0] eq '-' ? $m-$a[1] : $a[1]-1; 
      if ($a[0] eq '-') { $m -= $a[1]; }
      elsif ($a[0] eq '+') { $m += $a[1]; }
      else { $m = $a[1] - 1; }
    }
    elsif (lc $a[2] eq 'w') { 
      if ($a[0] eq '-') { $d -= $w+7*$a[1]-1; $w = 1; }
      elsif ($a[0] eq '+') { $d += 7*$a[1]-$w+1; $w = 1; }
      else { return undef; }
    }
    elsif (lc $a[2] eq 'd') {
      if ($a[0] eq '-') { $d -= $a[1]; }
      elsif ($a[0] eq '+') { $d += $a[1]; }
      else { $d = $a[1]; }
    }
    elsif (lc $a[2] eq 'h') { 
      if ($a[0] eq '-') { $h -= $a[1]; }
      elsif ($a[0] eq '+') { $h += $a[1]; }
      else { $h = $a[1]; }
    }
  }
  return mktime(0, 0, $h, $d, $m, $y, $w);
}
# --------------------------------------------------------------------
# parse command line
sub parse_cmdline {
  my $i = 0;
  my ($dts, $dtf, $dtg);
  my $n = @ARGV;
  while ($i < $n) {
    $_ = lc $ARGV[$i];
    if ($_ eq '-s') {
      die "use: -s <start-time> <end-time>\n" unless $i+2 < $n;
      ($dts, $dtf) = @ARGV[$i+1, $i+2]; $i += 3;
    }
    elsif (/^--stat/o) {
      $i++;
      ($dts, $dtf) = /^--stat=([^,]+),(.+)$/o 
          or die "use: --stat=<start-time>,<end-time>\n";
    }
    elsif ($_ eq '-g') {
      die "use: -g <time>\n" unless $i++ < $n;
      $dtg = $ARGV[$i++];
    }
    elsif (/^--graph/o) {
      $i++;
      ($dtg) =~ /^--graph=(.+)$/o or die "use: --graph=<time>\n";
    }
    elsif ($_ eq '--bad' || $_ eq '-b') { $bad = 1; $i++; }
    elsif ($_ eq '-l') {
        die "use: -l <binkd-log>\n" unless $i++ < $n;
        $log = $ARGV[$i++];
      }
    elsif (/^--log/o) {
        ($log) = $ARGV[$i++] =~ /^--log=(.+)/io or die "use: --log=<binkd-log>";
    }
    elsif (/^(--help|-[h?])/) { print $usage; exit 0; }
    else { die "unknown parameter: $ARGV[$i]\n"; }
  }
  # init values
  if (defined $dts && $dts ne '-') { 
    $stat1 = str2time($dts) or die "wrong format of time: '$dts'\n"; 
  }
  if (defined $dtf && $dtf ne '-') {
    $stat2 = str2time($dtf, $stat1) or die "wrong format of time: '$dtf'\n";
  }
  if (defined $stat1 && defined $stat2) {
    die "<end-time> should be later than <start-time>\n" if ($stat2 < $stat1);
  }
  if (defined $dtg && $dtg ne '-') {
    $graph1 = str2time($dtg, $stat2) or die "wrong format of time: '$dtg'\n";
    $graph2 = $graph1 + 60*60*24-1;           # 23:59:59
  }
#  print "stat1=".strftime("%c", localtime $stat1)."\n" if defined $stat1;
#  print "stat2=".strftime("%c", localtime $stat2)."\n" if defined $stat2;
#  print "graph=".strftime("%c", localtime $graph1)."\n" if defined $graph1;
#  die "all ok\n";
}

parse_cmdline @ARGV;
parse_log($stat1, $stat2);
# graph
if (defined $graph1) {
  print "\n"; print join "\n", out_graph(['incoming', 'incoming unsec', 'outgoing', 'outgoing unsec'], \@in, \@in2, \@out, \@out2); print "\n";
}
# stat
print "\n"; print join "\n", out_summary(\%node); print "\n";
# bad
if ($bad) {
  print "\n"; print join "\n", out_bad(\%bads); print "\n";
}
