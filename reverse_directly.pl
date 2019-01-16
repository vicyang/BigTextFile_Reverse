=info
    文本按行倒序输出
    523066680/vicyang
    2019-01
=cut

use strict;
use Fcntl qw(:seek);
STDOUT->autoflush(1);
my $src = "F:/A_Parts.txt";
my $dst = $src;
$dst =~s/(\.\w+)$/_REV$1/;

reverse_write( $src, $dst );

sub reverse_write
{
    my ($srcfile, $dstfile) = @_;
    open my $SRC, "<:raw", $srcfile or die "$!\n";
    open my $DST, ">:raw", $dstfile or die "$!\n";

    # 缓冲区大小
    my $buffsize = 2**16;
    my $offset = -s $SRC;
    my $buff;
    my @lines;
    my $left = "";
    while ( $offset >= $buffsize )
    {
        $offset -= $buffsize;
        seek $SRC, $offset, SEEK_SET;
        read $SRC, $buff, $buffsize;
        $buff = $buff . $left;
        if ( $buff =~/\r?\n/ ) {
            @lines = reverse( split /\r?\n/, $buff );
            $left = pop @lines;
            printf $DST "%s\r\n", join("\r\n", @lines);
        } else {
            $left = $buff;
            #printf "%s\n", $left;
        }
    }

    return if ($offset <= 0);
    seek $SRC, 0, SEEK_SET;
    read $SRC, $buff, $offset;
    @lines = reverse(split /\r?\n/, $buff .$left );
    print $DST join("\r\n", @lines);
}
