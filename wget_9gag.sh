#!/bin/bash
## wget_9gag.sh for 9gag last post
## 
## Made by glastis
## 
## Last update Sat Oct 17 20:02:00 2015 glastis
##
SCREEN_SIZE_X=1920
SCREEN_SIZE_Y=1080
function remove_img()
{
    printf "\nRemoving pictures...\n"
    rm -f last_post.jpg last_post.png index.html
    printf "Done.\n"
    exit
}
trap remove_img INT
while [ 1 ];do
wget 9gag.com
LINK_IMG=`./a.out`
PICTURE_NAME=`echo $LINK_IMG | awk -F "/" '{print $NF}'`
wget $LINK_IMG
mv $PICTURE_NAME last_post.jpg
rm index.html
convert last_post.jpg last_post.png
SIZE_FILE=`file last_post.png | awk -F " " '{print $5,$7}' | awk -F "," '{print $1}'`
SIZE_X=`echo $SIZE_FILE | awk -F " " '{print $1}'`
SIZE_Y=`echo $SIZE_FILE | awk -F " " '{print $2}'`
if [ $SIZE_X \< $SIZE_Y ];then MAX_SIZE=$(((SCREEN_SIZE_Y * 100) / SIZE_Y));else MAX_SIZE=$(((SCREEN_SIZE_X * 100) / SIZE_X));fi
convert -resize $MAX_SIZE% last_post.png last_post.png
killall i3lock 2>> /dev/null
i3lock -i last_post.png
sleep 30
rm -f last_post.png last_post.jpg
done
