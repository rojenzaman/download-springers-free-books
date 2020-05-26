#!/bin/bash

#tor | set the torify or torsocks. by default none
torproxy=""

site="https://link.springer.com/content/pdf/10.1007/"

while IFS= read -r url
do

cutted=`wget -qO- "$url" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si'`
title=${cutted:: -15}
id=${url: -17}

$torproxy wget -O "$title.pdf" $site$id.pdf
[ -s "$title.pdf" ] || rm "$title.pdf"

done < urls
