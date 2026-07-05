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
3. 你输入 `/onboard` → 一场轻松友好的访谈会询问你的名字、你的职业、你的**目标**、助手的**名字**和**性格** → 然后自动写出个性化档案并建立持久记忆。
4. 接着 — 全自动地 — **助手会为自己打造技能**: 根据你的职业和目标锻造 3–5 项专属能力（例如摄影师会得到客户询价回复、报价单撰写、拍摄计划等技能），并在向你问好之前安装完毕。
5. 它还会搭好一个**"第二大脑"**: 位于 `~/second-brain` 的现成笔记库，可用免费的 [Obsidian](https://obsidian.md) 应用打开浏览（安装程序也会尝试帮你装好 Obsidian）。

你永远不会被问到任何技术问题 — 访谈只关于你自己。所有自动附加项都是可选的: 装不上就跳过并给出一句友好提示，其余一切照常工作。

不需要 Git，不需要管理员权限。（Node.js 只是安装程序自行处理的可选附加项。）

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
- **还没有 Claude?** 从免费 7 天 Pro 试用开始 → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *（推荐链接 — 支持本项目）*

## 插件里有什么

| 技能 | 作用 |
|---|---|
| `/onboard` | 创建个性化助手 + 记忆 + 专属技能 + 第二大脑的访谈 — 支持英语、越南语、泰语、韩语、中文，或你自己的语言 |
| `forge-skills` | **根据你的职业和目标自动打造 3–5 项专属技能** — 在 `/onboard` 结束时自动运行; 随时可用 `/forge-skills` 或说"我的目标变了"重新运行 |
| `create-skill` | 用语言描述一项新能力，助手就会亲自编写并安装该技能（与 forge 同一质量标准） |
| `remember` | 把事实/偏好存入助手的长期记忆 |
| `recall` | 找回你以前告诉过它的内容 |
| `learn-from-mistakes` | 把你的纠正变成永久规则 |
| `daily-note` | 简单的每日日志 |
| `work-smart` | 让助手先规划再行动，避免浪费步骤 |
| `personal` | 个人助手基本功: 一致的人格、记忆习惯、诚实、安全边界 |
| `leader` | 应对大任务: 规划、拆解、委派、验证、汇报一个清晰的答案 |
| `/setup-vault` | 在 `~/second-brain` (重新)创建第二大脑笔记库 — 兼容 Obsidian |
| `obsidian-markdown` · `obsidian-cli` | 规范地书写和整理笔记（wiki 链接、标签、安全的文件操作） |

## 你的第二大脑

`/onboard` 会在 `~/second-brain` 创建一个笔记库 — 助手可以读写的纯 markdown 文件（每日笔记、项目、人脉、想法）。用免费的 [Obsidian](https://obsidian.md) 应用打开该文件夹（"Open folder as vault"）即可可视化浏览 — 安装程序会尝试帮你安装 Obsidian，装不上的话一切也照常以纯文件形式工作。安装程序还会尝试可选的"智能记忆"升级（开源 [agentmemory](https://github.com/rohitg00/agentmemory) 插件）; 如果失败，助手依然通过文件记住一切。

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
