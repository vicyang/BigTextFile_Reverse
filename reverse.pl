=info
    BigTextFile - Reverse
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

my $index;
get_index( $src, \$index );
reverse_write( $src, $dst, \$index );

sub reverse_write
{
    my ($srcfile, $dstfile, $index) = @_;
    open my $SRC, "<:raw", $srcfile or die "$!\n";
    open my $DST, ">:raw", $dstfile or die "$!\n";
    my $data;
    my $len;
    my $s;
    my $SS_POS = length( $$index );
    my $SRC_POS = -s $srcfile;
    seek($SRC, $SRC_POS, 0);

    # StringStream
    open my $SS, "<", $index;
    while ( $SS_POS >= 4 )
    {
        seek $SS, $SS_POS-4, 0;
        read $SS, $data, 4;
        $len = unpack("L", $data);
        $SRC_POS -= $len;
        seek $SRC, $SRC_POS, 0;
        read( $SRC, $s, $len );
        #$s=~s/\r\n//;
        printf $DST "%s", $s;
        $SS_POS -= 4;
    }

    close $SRC;
    close $SS;
}

sub get_index
{
    my ($file, $ref) = @_;
    open my $fh, "<:raw", $file or die "$!\n";
    printf "Loading index ... ";
    $$ref = "";
    my $s;
    while ( $s = readline($fh) ) {
        $$ref .= pack("L", length($s) );
    }
    printf "Done\n";
    printf "Memory usage: %.2f MB\n", total_size($ref)/(1024*1024);
    close $fh;
}
