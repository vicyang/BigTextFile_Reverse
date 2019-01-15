=info
    文本按行倒序输出
    523066680/vicyang
    2019-01
=cut

use strict;
use Devel::Size qw(size total_size);
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
    

}

