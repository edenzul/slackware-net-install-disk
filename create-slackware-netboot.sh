#!/bin/bash

# Author: Denny Zulfikar
# GitHub: https://github.com/edenzul/slackware-net-install-disk
# created at: 2021-08-13
# this script to download and create a minimum installation/boot disk where you can choose "Network" as installation source.
# it will produce 61MB ISO file.

# pre-requisite: 
# yum install wget xorriso
# or
# apt install wget xorriso

cd $

mkdir slackware-install 

cd slackware-install/ 

# download the isolinux and kernel directory and contents

wget --recursive --no-parent https://slackware.mirror.digitalpacific.com.au/slackware64-current/isolinux/  -R "index.html*" 

wget --recursive --no-parent https://slackware.mirror.digitalpacific.com.au/slackware64-current/kernels/  -R "index.html*" 

# cleanup unnecessary dirs

mv slackware.mirror.digitalpacific.com.au/slackware64-current/isolinux/ . 

mv slackware.mirror.digitalpacific.com.au/slackware64-current/kernels/  . 

rm -rf slackware.mirror.digitalpacific.com.au/ 

# generate iso file
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

echo "Done, please check the ISO file is generated"
