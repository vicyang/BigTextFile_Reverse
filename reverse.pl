=info
    BigTextFile - Reverse
    523066680/vicyang
    2019-01
=cut

use Devel::Size qw(size total_size);
use File::Basename;
STDOUT->autoflush(1);
my $src = "F:/A.txt";
my $dst = $src;
   $dst =~s/(\.\w+)$/_REV$1/;

my $index;
get_index( $src, $index);
exit;

open my $DST, ">:raw", $dst or die "$!\n";

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
    #$s=~s/\r\n//;
    printf $DST "%s", $s;
    $sh_pos -= 4;
}
close $sh;
close $fh;

sub get_index
{
    my ($file, $ref) = @_;
    open my $fh, "<:raw", $file or die "$!\n";
    my ($pos, $prev) = (0, 0);
    printf "Loading index ... ";
    $$ref = "";
    my $s;
    while ( !eof($fh) )
    {
        $s = readline($fh);
        $pos = tell($fh);
        $index .= pack("L", $pos-$prev);
        $prev = $pos;
    }
    printf "Done\n";
    printf "Memory usage: %.2f MB\n", total_size($ref)/(1024*1024);
    close $fh;
}
