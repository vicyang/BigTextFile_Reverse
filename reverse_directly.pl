=info
    文本按行倒序输出
    523066680/vicyang
    2019-01
=cut

use strict;
use Fcntl qw(:seek);
use File::Basename;
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
    my $offset = (-s $srcfile) - 1;
    my $char;
    my $buff;
    while ($offset >= 1) 
    {
        seek $SRC, $offset, SEEK_SET;
        read $SRC, $char, 1;
        $buff .= $char;
        if ( $char eq "\n" ) { 
            $buff = "";
            #printf "%d\n", tell $SRC;
        }
        $offset--;
    }

}

