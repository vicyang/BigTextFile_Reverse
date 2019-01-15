=info
    second
    理论上这种操作是对的，
    问题是，当行数超过一定量，数组列表也会爆
=cut

use File::Basename;
STDOUT->autoflush(1);
my $src="F:/A_Parts.txt";
my $dst=$src;
$dst=~s/(\.\w+)$/_REV$1/;
print $dst;
exit;

open my $fh, "<:raw", $src or die "$!\n";
my $s;
my $prev = 0;
my ($len, $pos);
my @index;
printf "Loading index ... ";
while ( !eof($fh) )
{
    $s = readline($fh);
    $pos = tell($fh);
    unshift @index, { 'pos' => $prev, 'len' => $pos-$prev };
    $prev = $pos;
}
printf "Done\n";

for my $idx (@index) 
{
    seek($fh, $idx->{pos}, SEEK_SET);
    read( $fh, $s, $idx->{len} );
    $s=~s/\r\n//;
    printf "%s\n", $s; 
}
