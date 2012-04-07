#!/opt/bin/perl -w
## HPT log v0.02 by SeaD (2:5054/84.1)

if (!($log_file = $ARGV[0])) { die "usage: $0 <hpt.log>\n" }

$debug = 0;
$debug_file = "/opt/tmp/hpt.debug";

if ($debug) { open(FDEBUG, ">> " . $debug_file) or die "open($debug_file): $!\n" }

open(FLOG, "< " . $log_file) or die "open($log_file): $!\n";

$anew = $agood = $abad = $lnum = $pnum = $unum = $bnum = $lbusy = 0;
while (<FLOG>) {
    if (/.*(Area) (.+)( autocreated by )([\.\/:0-9]+).*/) {
        $area_a[$anew] = $2; $link_a[$anew] = $4; $anew++
    }
    if (/.*(Packing for )([\.\/:0-9]+).*/) {
        for ($n = 0; $n < $lnum; $n++) {
            if ($lnk[$n] eq $2) { $pak[$n]++; last }
        } if ($n == $lnum) { $lnk[$n] = $2; $pak[$n] = 1; $lnum++ }
        $pnum++
    }
    if (/.*(pkt: ).*\[([\.\/:0-9]+)\].*/) {
        for ($n = 0; $n < $unum; $n++) {
            if ($ulk[$n] eq $2) { $bdl[$n]++; last }
        } if ($n == $unum) { $ulk[$n] = $2; $bdl[$n] = 1; $unum++ }
        $bnum++
    }
    if (/.*(areafix: )([ a-z]+) ([\.\/:0-9]+).*/) {
        if ($2 eq "successfully done for") { $agood++ }
        elsif ($2 eq "security violation from") { $abad++ }
    }
    if (/.*(link )([\.\/:0-9]+)( is busy).*/) { $lbusy++ }
}

close(FLOG);

if ($anew) {
    print "Autocreated Areas:\n==================\n";
    for ($n = 0; $n < $anew; $n++) {
        print $area_a[$n] . " by " . $link_a[$n] . "\n";
    }
    print "= total " . $anew . " areas, ";
    print "areafix: " . $agood . " good, " . $abad . " bad\n\n";
}

print "Unpacking Stats:\n==============\n\n";
for ($n = 0; $n < $unum; $n++) {
    print $ulk[$n] . " mail unpacked " . $bdl[$n] . " times\n";
}
print "= total " . $unum . " links, " . $bnum . " unpacks\n\n";

print "Packing Stats:\n==============\n\n";
for ($n = 0; $n < $lnum; $n++) {
    print $lnk[$n] . " mail packed " . $pak[$n] . " times\n";
}
print "= total " . $lnum . " links, " . $pnum . " packs, ";
print "link busy: " . $lbusy . "\n\n";

if ($debug) { close(FDEBUG) }
