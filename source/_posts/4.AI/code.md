---
title: code
# toc: true

---

* cursor
* claudecode/opencode

## cursor
* rules
  * AGENTS.md
* prompts
  * context
    * components
    * utils
    * hooks
    * code templates
  * workfolw
* commands
  * openspec / spect kit / BMad
* skills
* sub agent?
* MCP
  * figma
  * browser automation
    * rules: TESTING.md
* plugins


## Agent CodeReview

本地设置cursor提交代码时自动review的对比分支

```sh
# https://forum.cursor.com/t/how-to-change-the-default-branch-for-cursor/146478/2
git remote set-head origin your_branch
# 设置完毕后重启cursor

# 测试是否设置成功 or 看Cursor Agent Review区域的分支
git symbolic-ref --short refs/remotes/origin/HEAD
```

## continue

* [quick-start](https://docs.continue.dev/ide-extensions/quick-start)
* [recommended-models](https://docs.continue.dev/customize/models#recommended-models)

```yaml
name: Local Config
version: 1.0.0
schema: v1
models:
  - name: google/gemini-2.0-flash-exp:free
    provider: openrouter
    model: google/gemini-2.0-flash-exp:free
    apiKey: your_api_key
    roles:
      - chat
      - autocomplete
      - edit
  - name: kwaipilot/kat-coder-pro:free
    provider: openrouter
    model: kwaipilot/kat-coder-pro:free
    apiKey: your_api_key
    roles:
      - chat
      - autocomplete
      - edit
  - name: gemma-3-27b
    provider: gemini
    model: gemma-3-27b
    apiKey: your_api_key
    roles:
      - chat
      - autocomplete
      - edit
```

### 高级用法

* [config](https://docs.continue.dev/reference)
  * rules
  * prompts
  * docs
  * mcp
* Integrations
  * github/gitlab
  * sentry
  * slack/teams
  * webhook
* [workflows](https://hub.continue.dev/workflows)
* cli
