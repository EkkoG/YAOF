#!/bin/bash
file=$(find . | grep "imagebuilder-.*x86_64.tar.xz" | head -n 1)
echo "file size is $(du -sh $file | awk '{print $1}')"
ls
echo "find ImageBuilder file at $file"
cp $file ./IMAGEBUILDER/imagebuilder.tar.xz
cd IMAGEBUILDER
ls
echo "space left: $(df -h . | tail -n 1 | awk '{print $4}')"
# if xz command exist
if command -v xz >/dev/null 2>&1; then
echo "xz command exist"
xz -l imagebuilder.tar.xz
else
echo "xz command not exist"
sudo -E apt-get -qq install xz-utils
xz -l imagebuilder.tar.xz
fi
tar -xvf imagebuilder.tar.xz
mv $(basename $file .tar.xz) imagebuilder
rm -rf imagebuilder.tar.xz