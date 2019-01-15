=info
    1. 当Perl数组存储的索引超过一定量，也会提示 out_of_memory
    2. 不以哈希结构存储 pos 和 length 信息。 3GB文件，1024*1024*20行
       耗时 15.2秒，占用600MB。第二次执行因为有缓存，耗时7.7秒
       将 unshift 改为push，耗时差异不大
=cut

use Devel::Size qw(size total_size);
use File::Basename;
STDOUT->autoflush(1);
my $src="F:/A.txt";
my $dst=$src;
$dst=~s/(\.\w+)$/_REV$1/;

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
    $index .= pack("LL", $prev, $len);
    $prev = $pos;
}
printf "Done\n";
printf "%d\n", total_size($index)/(1024*1024);

# for my $idx (@index) 
# {
#     seek($fh, $idx->{pos}, SEEK_SET);
#     read( $fh, $s, $idx->{len} );
#     $s=~s/\r\n//;
#     printf "%s\n", $s; 
# }
