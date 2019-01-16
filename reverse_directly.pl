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
    open my $SRC, "<:raw:crlf", $srcfile or die "$!\n";
    open my $DST, ">:raw", $dstfile or die "$!\n";
    my $buffsize = 2 ** 8;
    my $offset = -s $srcfile;
    my $pool;
    my $buff;
    my @lines;
    my $after;
    my $before;
    while ($offset >= $buffsize)
    {
        $offset-=$buffsize;
        seek $SRC, $offset, SEEK_SET;
        read $SRC, $buff, $buffsize;
        #if ( $buff=~/\n$/ ) { $after = "\n" } else { $after = "" }
        # if ( $buff=~/^\r?\n/ ) { $before = "\n" } else { $before = "" }
        @lines = reverse(split "\n", $buff);
        printf "%s%s%s:", $before,  join("\n", @lines), $after;
        #unless ($lines[-1]=~/\n$/) { print "\n" }
        $buff = "";
        @lines = ();
        exit;
    }

    #printf "%d %d %d %d\n", $count, $count*$buffsize, (-s $srcfile) - $count*$buffsize, $offset;

    seek $SRC, 0, SEEK_SET;
    read $SRC, $buff, $offset;
    @lines = reverse(split /\r?\n/, $buff);
    print join("\n", @lines);

}
