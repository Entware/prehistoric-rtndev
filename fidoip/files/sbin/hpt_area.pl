#!/opt/bin/perl -w
## HPT area v0.02 by SeaD (2:5054/84.1)

$area_parm = "-g [A-Z]? -lr [0-9]? -lw [0-9]?";

if (!($area_file = $ARGV[0])) { die "usage: $0 <hpt.area>\n" }

$debug = 0;
$debug_file = "/opt/tmp/hpt.debug";

if ($debug) { open(FDEBUG, ">> " . $debug_file) or die "open($debug_file): $!\n" }

open(FAREA, "< " . $area_file) or die "open($area_file): $!\n";

$anum = 0;
while (<FAREA>) {
    if (/^EchoArea (.+?) (.+) -a ([\.\/:0-9]+) $area_parm ([\.\/: 0-9]+).*/) {
        $area[$anum] = $1; $sub_a[$anum] = $4; $anum++
    }
}

close(FAREA);

$obec = $ru = $other = $snum = $lnum = $lsnum = $znum = 0;
for ($n = 0; $n < $anum; $n++) {
    if (($area[$n] =~ /^(OBEC)$/) || ($area[$n] =~ /^(OBEC\.).*/)) { $obec++ }
    elsif (($area[$n] =~ /^(RU\.).*/) || ($area[$n] =~ /^(SU\.).*/)) { $ru++ }
    else { $other++ }
    @links = split(" ", $sub_a[$n]); $sub = -1;
    foreach $link (@links) {
        for ($ln = 0; $ln < $lnum; $ln++) {
            if ($lnk[$ln] eq $link) { $lsub[$ln]++; $lsnum++; last }
        } if ($ln == $lnum) { $lnk[$ln] = $link; $lsub[$ln] = 1; $lnum++ }
        $sub++
    }
    if ($sub > $snum) { $snum = $sub }
    if ($sub == 0) { $area_z[$znum] = $area[$n]; $znum++ }
    $area_s[$sub]++;
}

print "Link stats:\n===========\n\n";

for ($n = 0; $n < $lnum; $n++) {
    print $lnk[$n] . " subscribed at " . $lsub[$n] . " areas\n"
}

print "= total " . $lnum . " links, " . $lsnum . " subscribes\n\n";

print "Area passthrough stats:\n===========\n\n";

for ($n = $snum; $n > 0; $n--) {
    if ($area_s[$n]) { print $area_s[$n] . " areas with " . $n . " subscribers\n" }
}

print "= total " . $anum . " areas, OBEC: " . $obec . ", RU&SU: " . $ru . ", other: " . $other . "\n\n";

if ($znum) {
    print "Unsubscribed Areas:\n===================\n";
    for ($n = 0; $n < $znum; $n++) {
        print $area_z[$n] . "\n";
    }
    print "= total " . $znum . " areas\n\n";
}

if ($debug) { close(FDEBUG) }
