---
title: AI Agent
# toc: true

---
* [auto-gpt](https://github.com/Significant-Gravitas/AutoGPT)
  * https://hub.docker.com/r/ceramicwhite/auto-gpt
* 
# langchain
xxx

# AutoGPT
```sh
# 集成了auto-gpt, gotty(web terminal)
docker run ceramicwhite/auto-gpt
  -p 3000:3000
  - OPENAI_API_KEY=<your-open-api-key>
  - GPT3_ONLY=TRUE
```
# AutoGen & Studio
* [AutoGen Studio](https://microsoft.github.io/autogen/blog/2023/12/01/AutoGenStudio/)
```sh
pip install autogenstudio
export OPENAI_API_KEY=<your_api_key>
autogenstudio ui --port 8081
```

# CrewAI
[CrewAI](https://github.com/crewAIInc)相比AutoGen编码上更简洁，且支持LangChain Tools
* Agent
  * llm: ollama, openai
  * tools: search, file
* Task
  * desc prompt
  * agent
* Crew
  * Agent[]
  * Task[]
