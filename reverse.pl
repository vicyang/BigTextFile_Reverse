=info
    BigTextFile - Reverse
    523066680/vicyang
    2019-01
=cut

use Devel::Size qw(size total_size);
use File::Basename;
STDOUT->autoflush(1);
my $src="F:/A_Parts.txt";
my $dst=$src;
$dst=~s/(\.\w+)$/_REV$1/;

open my $DST, "<:raw", $src or die "$!\n";
open my $fh, "<:raw", $src or die "$!\n";
my $s;
my $prev = 0;
my ($len, $pos);
my $index = "";
printf "Loading index ... ";
while ( !eof($fh) )
{
    $s = readline($fh);
    $pos = tell($fh);
    $len = $pos-$prev;
    $index .= pack("L", $len);
    $prev = $pos;
}
printf "Done\n";
printf "%d MB\n", total_size($index)/(1024*1024);

my $data;
my $sh_pos = length($index);
my $fh_pos = -s $src;
seek($fh, $fh_pos, 0);

# string as file handle
open my $sh, "<", \$index;
while ( $sh_pos >= 4 )
{
    seek $sh, $sh_pos-4, 0;
    read $sh, $data, 4;
    $len = unpack("L", $data);
    $fh_pos -= $len;
    seek $fh, $fh_pos, 0;
    read( $fh, $s, $len );
    $s=~s/\r\n//;
    printf "%d %d %s\n", $len, $fh_pos, $s;
    $sh_pos -= 4;
}
close $sh;
close $fh;