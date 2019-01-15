
* __Perl实现__
  * __偷懒方案__
    先利用 readline 函数自动逐行读取（但是不累积到内存），同时用seek获得每一行对应的offset。这样就得到一系列offset，然后在逆序seek读取并写入到新文件。
  * __Notes__
    1. 当Perl数组存储的索引超过一定量，也会提示 out_of_memory
    2. 仅使用数组，去掉复合哈希结构存储 pos 和 length 信息。 3GB文件，1024*1024*20行耗时15.2秒，占用600MB。第二次执行因为有缓存，耗时7.7秒。将 unshift 改为push，耗时差异不大
    3. 改用 pack 保存二进制序列，如果是L（32位整数），占用大小为90MB，但是32为能够表达的长度信息为：4294967296，对于大于4G的文件，POS数值会溢出。

  

  * __其他发现__
    ```perl
    while ( !eof($fh) )
    {
        readline($fh);
        $pos = tell($fh);
        $index .= pack("L", $pos-$prev);
        $prev = $pos;
    }
    ```
    注意 readline($fh) 返回到空的环境，反复执行，时间都接近18s；而如果赋值到一个临时变量 $s = readline($fh); 则再次执行时，时间会缩减到 8s。