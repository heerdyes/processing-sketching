ffmpeg -r 24 -f image2 -s 720x720 -i ps_%04d.png -vcodec h264 -crf 25 -pix_fmt yuv420p output.mp4