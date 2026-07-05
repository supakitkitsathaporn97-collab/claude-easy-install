# Claude Code Easy Install — 一键安装 Claude Code

[English](README.md) · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · [한국어](README.ko.md) · **中文**

**一条命令 → 装好 Claude Code → 拥有属于你自己的个人 AI 助手，用你的语言。**

> 英语和越南语是主要支持的引导语言。泰语、韩语、中文在 `/onboard` 和本文档中均获完整支持；其他语言可通过访谈中的"其他"选项使用。

> 📸 *截图即将补充*

---

## 这是什么?

大多数 Claude Code 入门套件只会丢给你一堆需要手动编辑的文件。而这一款会**采访你**，然后替你写好全部配置:

1. 使用 **Anthropic 官方安装程序**安装 [Claude Code](https://code.claude.com)（我们绝不自行分发他们的软件）。
2. 从本仓库安装 `nick-starter` 插件。
3. 你输入 `/onboard` → 一场轻松友好的访谈会询问你的名字、需要哪些帮助、助手的**名字**和**性格** → 然后自动写出个性化档案，并为助手建立持久记忆（"第二大脑"）。

不需要 Node.js，不需要 Git，不需要管理员权限。

## 安装 — Windows

打开 **PowerShell**（按开始键，输入 "PowerShell"，回车），然后粘贴:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
```

## 安装 — macOS / Linux

打开**终端**，然后粘贴:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
```

## 接下来

1. 输入 `claude` 并回车。
2. 浏览器打开后登录 — **需要付费的 Claude 订阅（Pro 或 Max）**。
3. 输入 `/onboard`，选择语言，认识你的新助手。

## 系统要求

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+
- 网络连接
- 付费 Claude 订阅（Pro、Max 或 Team）— [claude.ai](https://claude.ai)

## 插件里有什么

| 技能 | 作用 |
|---|---|
| `/onboard` | 创建个性化助手 + 记忆的访谈 — 支持英语、越南语、泰语、韩语、中文，或你自己的语言 |
| `remember` | 把事实/偏好存入助手的长期记忆 |
| `recall` | 找回你以前告诉过它的内容 |
| `learn-from-mistakes` | 把你的纠正变成永久规则 |
| `daily-note` | 简单的每日日志 |
| `work-smart` | 让助手先规划再行动，避免浪费步骤 |

## 常见问题

**这是 Anthropic 的官方软件吗?**
不是。这是一个独立的入门套件。它通过调用 Anthropic 自己的官方安装程序来安装 Claude Code，再在其上添加插件。Claude Code 本身属于 Anthropic。

**安装脚本安全吗?**
安全 — 而且你不必盲目相信我们: 请亲自阅读 [`install/go.ps1`](install/go.ps1) 和 [`install/go.sh`](install/go.sh)。它们只做三件事: (1) 调用 Anthropic 官方安装程序，(2) 把本仓库注册为插件市场，(3) 安装插件。Windows SmartScreen 或杀毒软件可能会对任何来自互联网的脚本发出警告 — 对这种安装方式来说是正常现象。

**不小心运行了两次怎么办?**
完全没问题 — 脚本可以安全地重复运行，已安装的部分会自动跳过。

**以后能更换助手吗?**
可以。随时重新运行 `/onboard`。旧档案会先备份，永远不会被删除。

**它会收集我的数据吗?**
不会。访谈写入的所有内容都只保存在你自己电脑的 `~/.claude/` 目录里。

---

## 许可证

MIT — 见 [LICENSE](LICENSE)。Claude Code 本身是 Anthropic 的软件，通过其官方安装程序安装; 见 [NOTICE](NOTICE)。
