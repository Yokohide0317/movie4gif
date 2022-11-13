#!/bin/bash

realpath ()
{
    f=$@;
    if [ -d "$f" ]; then
        base="";
        dir="$f";
    else
        base="/$(basename "$f")";
        dir=$(dirname "$f");
    fi;
    dir=$(cd "$dir" && /bin/pwd);
    echo "$dir$base"
}

INP_MP4=$(realpath $1)
OUT_GIF=$(realpath $2)
TMP_DIR=$(realpath ./movie2gif_tmp)

if [ ${INP_MP4##*.} == "mp4" ]; then
    echo "Convert開始"
else
    echo "error: .mp4を指定してください。"
    exit 0
fi

mkdir $TMP_DIR
cd $TMP_DIR

ffmpeg -i $INP_MP4 -an -r 10 %04d.png
convert *.png -resize 40% output_%04d.png
convert output_*.png $OUT_GIF

cd ../
rm -r $TMP_DIR
