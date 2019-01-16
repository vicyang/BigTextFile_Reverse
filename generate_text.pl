my $file = "F:/B.txt";
open $fh, ">:raw", $file or die $!;
for my $n ( 1 .. 240 ) {
    printf $fh "%d ", $n;
    printf $fh "\r\n" if ($n % 20 == 0 );
}
close $fh;