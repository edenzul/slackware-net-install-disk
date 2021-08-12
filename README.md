# slackware-net-install-disk
The goal is to create a minimum installation/boot disk for Slackware Linux, and continue the installation by selecting installation source from network.

# pre-requisites
## Ubuntu Linux on WSL
- a running Linux machine, or WSL. I am using Ubuntu Linux on Windows WSL.
- install required package:
```
sudo apt install wget
sudo apt install xorriso
```

## CentOS Linux
- install required package:
```
sudo yum install wget xorriso
```


# Instructions
1. Prepare local directory for this project.
```
cd $

mkdir slackware-install 

cd slackware-install/ 
```

2. download both isolinux and kernels directory from slackware any mirror. it requires around 60 MB of downloads.
check available mirrors from this page: https://mirrors.slackware.com/mirrorlist/
```
wget --recursive --no-parent https://slackware.mirror.digitalpacific.com.au/slackware64-current/isolinux/  -R "index.html*" 

wget --recursive --no-parent https://slackware.mirror.digitalpacific.com.au/slackware64-current/kernels/  -R "index.html*" 
```

3. preserve only directory isolinux and kernels. remove the parent directory.
```
mv slackware.mirror.digitalpacific.com.au/slackware64-current/isolinux/ . 

mv slackware.mirror.digitalpacific.com.au/slackware64-current/kernels/  . 

rm -rf slackware.mirror.digitalpacific.com.au/ 
```

4. generate bootable ISO file
```
xorriso -as mkisofs   -iso-level 3   \
-full-iso9660-filenames   \
-R -J -A "Slackware Network Boot"   \
-hide-rr-moved   -v -d -N   \
-eltorito-boot isolinux/isolinux.bin   \
-eltorito-catalog isolinux/boot.cat   \
-no-emul-boot -boot-load-size 4 -boot-info-table    \
-eltorito-alt-boot   \
-e isolinux/efiboot.img   \
-no-emul-boot -isohybrid-gpt-basdat   \
-volid "SlackNetBoot" -output slack-netboot.iso \
. 
```

5. the ISO file is ready. you can use the file as bootable ISO file for virtual machine or burn it into a disk/USB storage to install Slackware Linux from Network source.

good luck :)
