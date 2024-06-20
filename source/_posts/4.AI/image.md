---
title: Image
# toc: true
---

# online
* Midjourney
* Stable Diffusion

# local
## Stable Diffusion
[bilibili@秋叶整合包](https://www.bilibili.com/read/cv22159609/)
* 推理
  * 大模型: 所有绘画素材的基础（建筑、写实、漫画）
  * 小模型：LoRA基于大模型的微调小模型（类似英雄的皮肤）
  * prompt
  * ControlNet: 控制大概画面布局
    * 素描打稿
    * 骨骼
  * X/Y图表: 同时生成不同参数的图片进行对比(通常用于模型or参数对比)
  * 图生图: 通常用于蒙版生成圈定画面
* 微调模型
  * LoRA
  * Embedding: 一般用于负向提示词训练
  * VAE: 类似滤镜优化
  * 线上训练
    * Dreambooth
* 常用站点
  * [c站](https://civitai.com/models)
  * [模型解析](https://spell.novelai.dev/)

### prompt
* 类别
  * 画风画质：高质量、高精度、写实风格/二次元风格...
  * 主体+场景： 人物、建筑类型、材质、天气...
* 权重: `(grass:1.1), (water:0.8)`
* lora: `<lora:my_lora_name:1>`
* 控制提示词的生效时间: `[grass:0.8], [tree::0.8], [grass|tree]`
```md
# 正向提示词
masterpiece,best best quality, high detail, high resolution
realistic,

# 否定提示词
lowres, bad anatomy, bad hands, text, error, missing fingers,
extra digit, fewer digits, cropped, worst quality, low quality,
normal quality, jpeg artifacts, signature, watermark, username, blurry,
nude, noise, rough image quality,
```
