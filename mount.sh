echo "Creating NTFS"
mkdir /ntfs
dd if=/dev/zero of=ntfs.bin bs=8M count=64
mkfs -t ntfs -F ntfs.bin
mount ntfs.bin /ntfs

echo "Creating EXT2"
mkdir /ext2
dd if=/dev/zero of=ext2.bin bs=8M count=64
mkfs -t ext2 -F ext2.bin
mount ext2.bin /ext2

echo "Creating EXT3"
mkdir /ext3
dd if=/dev/zero of=ext3.bin bs=8M count=64
mkfs -t ext3 -F ext3.bin
mount ext3.bin /ext3

echo "Creating EXT4"
mkdir /ext4
dd if=/dev/zero of=ext4.bin bs=8M count=64
mkfs -t ext4 -F ext4.bin
mount ext4.bin /ext4


cp test.zip /ntfs
cp test.zip /ext2
cp test.zip /ext3
cp test.zip /ext4

echo "[*] Testing NTFS"
cd /ntfs
echo "[*] NTFS unzip"
time unzip test.zip
echo "[*] NTFS rm"
time rm -rf *
echo "[*] NTFS scheduler"
DISC="loop1";
cat /sys/block/$DISC/queue/scheduler;
for T in kyber; do
        echo $T > /sys/block/$DISC/queue/scheduler;
        cat /sys/block/$DISC/queue/scheduler;
        sync && /sbin/hdparm -tT /dev/$DISC && echo "----";
        sleep 15;
done


echo "[*] Testing EXT2"
cd /ext2
echo "[*] EXT2 unzip"
time unzip test.zip  
echo "[*] EXT2 rm"
time rm -rf *
echo "[*] EXT2 scheduler"
DISC="loop2";
cat /sys/block/$DISC/queue/scheduler; 
for T in kyber; do 
        echo $T > /sys/block/$DISC/queue/scheduler; 
        cat /sys/block/$DISC/queue/scheduler; 
        sync && /sbin/hdparm -tT /dev/$DISC && echo "----"; 
        sleep 15; 
done


echo "[*] Testing EXT3"
cd /ext3
echo "[*] EXT3 unzip"
time unzip test.zip  
echo "[*] EXT3 rm"
time rm -rf *
echo "[*] EXT3 scheduler"
DISC="loop3";
cat /sys/block/$DISC/queue/scheduler; 
for T in kyber; do 
        echo $T > /sys/block/$DISC/queue/scheduler; 
        cat /sys/block/$DISC/queue/scheduler; 
        sync && /sbin/hdparm -tT /dev/$DISC && echo "----"; 
        sleep 15; 
done


echo "[*] Testing EXT4"
cd /ext4
echo "[*] EXT4 unzip"
time unzip test.zip  
echo "[*] EXT4 rm"
time rm -rf *
echo "[*] EXT4 scheduler"
DISC="loop4";
cat /sys/block/$DISC/queue/scheduler; 
for T in kyber; do 
        echo $T > /sys/block/$DISC/queue/scheduler; 
        cat /sys/block/$DISC/queue/scheduler; 
        sync && /sbin/hdparm -tT /dev/$DISC && echo "----"; 
        sleep 15; 
done

echo "[*] Umounting"
umount /ntfs
umount /ext2
umount /ext3
umount /ext4

echo "[*] Removing"
rm -r /ntfs
rm -r /ext*

