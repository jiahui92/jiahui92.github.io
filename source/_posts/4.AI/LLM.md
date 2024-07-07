---
title: LLM
# toc: true
---

# ollama
支持快速接入三方的模型 【[官网](https://ollama.com/)】
* 支持api调用: chat & generate
```sh
ollama run qwen2
```


# maxkb
支持使用已有文档结合LLM建立知识库来进行问答（支持chatGPT、ollama等）【[官网](https://github.com/1Panel-dev/MaxKB)】
```sh
# 如果是linux建议直接使用1Panel进行安装
docker run -d --name=maxkb -p 8080:8080 -v ~/.maxkb:/var/lib/postgresql/data 1panel/maxkb
```
## 接入ollama
如果ollama在宿主机，配置api时: http://host.docker.internal:11434/


# auto-gpt
```sh
docker run significantgravitas/auto-gpt
  - OPENAI_API_KEY=<your-open-api-key>
  - GPT3_ONLY=TRUE
```
