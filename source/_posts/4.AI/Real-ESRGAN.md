---
title: 画质增强
# toc: true
---

# 简介
* 作用：可将图片的画质变清晰和增大分辨率，目前只对动漫有效（色块重复多的图片），其它场景效果不大，特定场景需要自己训练，比如人像修复
* 性能：GPU.2060大致是1张图片修复1s
* 三方库
  * [Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN)
  * [waifu2x](https://github.com/nagadomi/waifu2x)
    * [waifu2x GUI](https://github.com/AaronFeng753/Waifu2x-Extension-GUI)
  * chrome插件：Anime SR


# 例子
转换视频需要搭配`ffmpeg`来使用，先将视频转成图片，再进行画质增强
```sh
# 裁剪视频（copy不编码可能会导致音画不同步）
# ffmpeg -i video.mp4 -ss 00:10:00 -t 00:00:10 -c:v copy -c:a copy video_split.mp4
ffmpeg -i video.mp4 -ss 00:10:00 -to 00:10:10 video_split.mp4

# 视频转图片
ffmpeg -i video_split.mp4 -qscale:v 1 -qmin 1 -qmax 1 -vsync 0 tmp_frames/frame%08d.jpg

# 画质增强
realesrgan-ncnn-vulkan.exe -i tmp_frames -o out_frames -n realesr-animevideov3 -s 2 -f jpg
# realesrgan-ncnn-vulkan.exe -i tmp_frames -o out_frames -n realesrgan-x4plus -s 2 -f jpg

# 图片转视频
ffmpeg -i out_frames/frame%08d.jpg -i video_split.mp4 -map 0:v:0 -map 1:a:0 -c:a copy -c:v libx264 -r 23.976 -pix_fmt yuv420p output_video_split.mp4
```
