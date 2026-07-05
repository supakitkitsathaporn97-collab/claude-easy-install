<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/logo-light.svg">
  <img src="assets/logo.svg" alt="SoulDrop — giọt nước mang tia sáng bên trong" width="110">
</picture>

# SoulDrop

**Thả một linh hồn vào bất kỳ máy nào — trợ lý AI cá nhân của bạn, tự động hoàn toàn.**
<br>
<sub><i>Drop a soul into any machine — your personal AI assistant, fully automatic.</i></sub>

<br>
<br>

[![CI](https://img.shields.io/github/actions/workflow/status/supakitkitsathaporn97-collab/souldrop/validate.yml?branch=main&style=flat-square&label=CI&labelColor=20242C)](https://github.com/supakitkitsathaporn97-collab/souldrop/actions/workflows/validate.yml)
[![Version](https://img.shields.io/badge/version-0.5.0-E8B04B?style=flat-square&labelColor=20242C)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/license-MIT-2FD6C3?style=flat-square&labelColor=20242C)](LICENSE)
![Platform](https://img.shields.io/badge/platform-Windows%20%C2%B7%20macOS%20%C2%B7%20Linux-4A5568?style=flat-square&labelColor=20242C)
![Languages](https://img.shields.io/badge/languages-EN%20%C2%B7%20VI%20%C2%B7%20TH%20%C2%B7%20KO%20%C2%B7%20ZH-E8B04B?style=flat-square&labelColor=20242C)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-2FD6C3?style=flat-square&labelColor=20242C)](https://github.com/supakitkitsathaporn97-collab/souldrop/pulls)

<br>

[English](README.md) · **Tiếng Việt** · [ไทย](README.th.md) · [한국어](README.ko.md) · [中文](README.zh.md)

<br>

<img src="assets/demo.svg" alt="Demo động — một lệnh cài SoulDrop, cuộc phỏng vấn /onboard chạy, và một trợ lý cá nhân với 4 kỹ năng riêng sẵn sàng" width="780">

</div>

Một lệnh duy nhất. Một cuộc phỏng vấn thân thiện (không bao giờ hỏi câu kỹ thuật). Kết quả: một trợ lý có tên riêng, tính cách riêng, bộ nhớ dài hạn và "bộ não thứ hai" — chạy trên động cơ AI phù hợp với bạn, **trả phí hoặc miễn phí 100%**.

> Tiếng Anh và Tiếng Việt là hai ngôn ngữ được hỗ trợ chính. Tiếng Thái, Hàn, Trung được hỗ trợ đầy đủ; các ngôn ngữ khác vẫn dùng được qua lựa chọn "Khác".

---

## 🚀 Cài đặt

Trình cài đặt tự lo **tất cả** — kể cả các công cụ phụ nó cần (git, Node...). Bạn không phải tự cài bất cứ thứ gì trước.

### 🖱️ Cách dễ nhất (Windows) — tải 1 file, nháy đúp

1. **[Tải file cài đặt tại đây](https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/SoulDrop-Installer.bat)** — nhấn **chuột phải** vào link → chọn **"Save link as..." / "Lưu liên kết thành..."** → lưu ra Desktop.
2. **Nháy đúp** file `SoulDrop-Installer.bat` vừa tải. Xong — trình cài đặt tự chạy.
3. Nếu Windows hiện cảnh báo xanh (SmartScreen): bấm **"More info"** → **"Run anyway"**. Nói thật: cảnh báo này hiện với *mọi* file tải từ internet chưa có chữ ký số — file này chỉ gọi đúng script cài đặt chính thức bên dưới, và bạn có thể mở nó bằng Notepad để tự đọc.

*Dùng Mac? File trên chỉ dành cho Windows — cách dễ nhất cho bạn là lệnh một-dòng ngay bên dưới: copy, dán một lần là xong.*

### ⌨️ Cách một-lệnh (cho ai quen PowerShell / Terminal)

**Windows** — mở **PowerShell** (chưa biết mở? [xem hướng dẫn có hình bên dưới](#-hướng-dẫn-từng-bước-cho-người-mới-hoàn-toàn)) rồi dán:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.ps1 | iex
```

**macOS / Linux** — mở **Terminal** (chưa biết mở? [xem hướng dẫn có hình bên dưới](#-hướng-dẫn-từng-bước-cho-người-mới-hoàn-toàn)) rồi dán:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.sh | bash
```

### Sau đó

**Động cơ Pro (Claude):**
1. Gõ `claude` rồi nhấn Enter, đăng nhập khi trình duyệt mở ra (cần tài khoản trả phí).
2. Gõ `/onboard`, chọn ngôn ngữ, và gặp trợ lý mới — nó còn tự rèn 3–5 kỹ năng riêng cho nghề của bạn trước khi chào bạn.

**Động cơ Miễn phí (tại máy):**
1. Nhấn đúp **SoulDrop** ngoài màn hình (Windows) hoặc gõ `souldrop` trong terminal mới.
2. Trả lời sáu câu hỏi thân thiện (tên bạn, công việc, mục tiêu, tên trợ lý...) — xong. Mọi thứ chạy trên máy bạn; không có gì rời khỏi máy.

## 🧭 Hướng dẫn từng bước cho người mới hoàn toàn

> Chưa từng dùng "dòng lệnh"? Không sao cả — mục này cầm tay chỉ việc từng bước một, có hình minh họa. Cứ làm theo, chậm cũng được. Chọn đúng hệ máy của bạn: 🪟 Windows · 🍎 macOS · 🐧 Linux.

### 🪟 Cách mở PowerShell (Windows)

<img src="assets/guide/open-powershell-1.svg" alt="Bước 1 — bấm phím Windows (phím 4 ô vuông, góc dưới trái bàn phím)" width="740">
<img src="assets/guide/open-powershell-2.svg" alt="Bước 2 — gõ chữ PowerShell, ô tìm kiếm tự mở ra" width="740">
<img src="assets/guide/open-powershell-3.svg" alt="Bước 3 — nhấn Enter, cửa sổ xanh đậm mở ra: đó là PowerShell" width="740">
<img src="assets/guide/open-powershell-4.svg" alt="Bước 4 — dán lệnh cài đặt (chuột phải = dán) rồi nhấn Enter" width="740">

Mẹo nhỏ: trong PowerShell, **chuột phải = dán**. Sao chép lệnh cài đặt ở trên bằng nút 📋 (góc phải khối lệnh), rồi chuột phải vào cửa sổ xanh, nhấn Enter — thế là xong.

### 🍎 Cách mở Terminal trên Mac

<img src="assets/guide/open-terminal-mac-1.svg" alt="Bước 1 — bấm Cmd ⌘ + Space cùng lúc để mở Spotlight" width="740">
<img src="assets/guide/open-terminal-mac-2.svg" alt="Bước 2 — gõ chữ Terminal vào thanh Spotlight" width="740">
<img src="assets/guide/open-terminal-mac-3.svg" alt="Bước 3 — nhấn Enter, cửa sổ Terminal mở ra" width="740">
<img src="assets/guide/open-terminal-mac-4.svg" alt="Bước 4 — dán lệnh cài đặt bằng Cmd + V rồi nhấn Enter" width="740">

Lệnh cần dán trên Mac (copy bằng nút 📋 ở góc phải khối lệnh):

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.sh | bash
```

Mẹo nhỏ: trên Mac, **dán = Cmd ⌘ + V** (không phải Ctrl+V). Nếu Mac hiện hộp thoại hỏi cài **"command line developer tools"**, cứ bấm **Install** — đó là bộ công cụ chính thức của Apple mà trình cài đặt cần; cài xong chạy lại lệnh trên là được.

### 🐧 Mở terminal trên Linux

<img src="assets/guide/open-terminal-linux-1.svg" alt="Bước 1 — bấm Ctrl + Alt + T để mở terminal" width="740">
<img src="assets/guide/open-terminal-linux-2.svg" alt="Bước 2 — dán lệnh cài đặt bằng Ctrl + Shift + V rồi nhấn Enter" width="740">

Bấm **Ctrl + Alt + T** (đa số bản Linux: Ubuntu, Mint...) — hoặc tìm "Terminal" trong menu ứng dụng. Dán lệnh này rồi nhấn Enter (**dán trong terminal = Ctrl + Shift + V**, không phải Ctrl+V):

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.sh | bash
```

Nói thật: trình cài đặt **không bao giờ tự chạy sudo**. Nếu máy thiếu git, nó chỉ in đúng dòng lệnh `sudo apt-get install -y git` để **bạn tự chạy**, rồi bạn chạy lại lệnh trên — minh bạch, không tự ý đụng vào quyền hệ thống.

### Hai cách dùng Claude — chọn cách hợp với bạn

Bạn **đã chat với Claude qua app Claude Desktop rồi**? Vậy bạn có thể dùng SoulDrop **ngay trong app** — không cần đụng tới terminal.

| | 🖥️ Claude Desktop — *dễ nhất* | ⚡ Claude CLI — *bản "xịn"* |
|---|---|---|
| Dành cho | Người mới, đã quen chat với Claude | Ai muốn full sức mạnh |
| Cần terminal? | **Không** | Có (PowerShell / Terminal) |
| Cách mở | Mở app Claude → bấm tab **Code** | Gõ `claude` trong terminal |
| Sức mạnh | Đầy đủ kỹ năng SoulDrop | Đầy đủ + tự động hóa sâu hơn |

**Cách A — Claude Desktop (không cần terminal):**
1. Tải app tại [claude.com/download](https://claude.com/download) và đăng nhập (cần gói Pro/Max).
2. Bấm tab **Code** trên thanh trên cùng của app, chọn **Local**.
3. Gõ lần lượt hai lệnh này vào ô chat (copy từng dòng, dán, Enter):
   ```
   /plugin marketplace add supakitkitsathaporn97-collab/souldrop
   /plugin install souldrop@souldrop
   ```
4. Gõ `/onboard` — chọn ngôn ngữ, và gặp trợ lý của riêng bạn. Hết!

**Cách B — Claude CLI (mạnh hơn cho việc dài hơi):** làm theo mục Cài đặt ở trên → mở terminal → gõ `claude` → gõ `/onboard`.

### Cài Ollama thủ công (bản Miễn phí — tùy chọn)

Trình cài đặt SoulDrop **đã tự cài Ollama giúp bạn** — mục này chỉ dành cho ai muốn tự tay làm:

1. Vào [ollama.com/download](https://ollama.com/download) → tải bản Windows / Mac → cài như một ứng dụng bình thường (Next, Next, Finish).
2. Mở PowerShell / Terminal ([hướng dẫn có hình ở trên](#-cách-mở-powershell-windows)) và gõ lệnh tải model theo RAM của máy:

   | RAM máy bạn | Gõ lệnh này | Tải về |
   |---|---|---|
   | 16 GB trở lên | `ollama pull llama3.1:8b` | ~4.9 GB |
   | 8–16 GB | `ollama pull llama3.2:3b` | ~2 GB |
   | Dưới 8 GB | `ollama pull llama3.2:1b` | ~1.3 GB |

   *Không biết máy có bao nhiêu RAM?* Bấm phím Windows → gõ `about` → Enter → xem dòng **"Installed RAM"**.
3. Chạy lại trình cài đặt SoulDrop ở trên — nó thấy Ollama có sẵn và tự đi tiếp các bước còn lại.

### 🎬 Video hướng dẫn

<!-- TODO(Nick): drag the final .mp4 files into the GitHub web editor and paste
     the generated https://github.com/user-attachments/assets/... URLs on their
     own lines right below this comment — that is the ONLY form GitHub renders
     as an inline video player (repo-committed .mp4 files do NOT render).
     Masters + preview GIFs go in assets/media/ (see assets/media/README.md). -->

*Video hướng dẫn tiếng Việt (có thuyết minh) đang trên đường tới — sẽ xuất hiện ngay tại đây. Trong lúc chờ, các hình minh họa ở trên đủ để bạn cài từ đầu đến cuối.*

## 🧠 Chọn động cơ của bạn

<p align="center">
  <img src="assets/engines.svg" alt="Một bộ não nuôi nhiều động cơ — Claude Code (Pro), Ollama (Miễn phí, tại máy), và nhiều hơn ở v0.6" width="780">
</p>

SoulDrop tách **bộ não** (trợ lý của bạn là ai — các file markdown thuần thuộc về bạn) khỏi **động cơ** (thứ chạy nó). Cùng một linh hồn, động cơ nào cũng được:

| Động cơ | Chi phí | Bạn nhận được gì |
|---|---|---|
| **Pro — [Claude Code](https://code.claude.com)** | Tài khoản Claude trả phí (Pro/Max) | Bậc thông minh nhất: đủ bộ kỹ năng, **tự rèn kỹ năng riêng** cho nghề của bạn, subagent |
| **Miễn phí — [Ollama](https://ollama.com) (chạy tại máy)** | **0đ, không cần tài khoản** | Trợ lý thật sự chạy 100% trên máy của bạn: tính cách, bộ nhớ, "nhớ ...", bộ não thứ hai. Riêng tư mặc định |
| Codex · Antigravity · OpenClaw | — | 🔜 sẽ có ở v0.6 |

Bạn không phải chọn gì mang tính kỹ thuật — trình cài đặt **tự phát hiện Claude Code**, nếu chưa có thì chỉ hỏi đúng một câu: *Miễn phí hay Pro?*

## 📦 Yêu cầu

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+, có internet lúc cài
- **Bản Miễn phí:** không cần gì thêm. Khoảng 2–5 GB ổ đĩa cho model AI (tự chọn vừa với RAM của máy)
- **Bản Pro:** tài khoản Claude trả phí (Pro, Max hoặc Team) — [claude.ai](https://claude.ai)
- **Chưa có Claude?** Dùng thử Pro 7 ngày miễn phí → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(link giới thiệu — ủng hộ dự án này)*

## 🔁 Một bộ não, nhiều động cơ

Bộ não là **markdown thuần — động cơ nào cũng thay được**: file tính cách (trợ lý của bạn là ai), ngân hàng bộ nhớ (nói *"nhớ ..."* bất cứ lúc nào để lưu), và kho ghi chú "bộ não thứ hai" tại `~/second-brain` dùng chung cho mọi động cơ. Bạn tự đọc, sửa, sao lưu hoặc chuyển máy mọi file. Chi tiết: [`brain/`](brain/README.md) · chuẩn adapter cho động cơ mới: [`adapters/`](adapters/README.md).

## 🧩 Bên trong plugin Pro có gì

| Kỹ năng | Công dụng |
|---|---|
| `/onboard` | Cuộc phỏng vấn tạo trợ lý cá nhân hóa + bộ nhớ + kỹ năng riêng + bộ não thứ hai — bằng tiếng Anh, Việt, Thái, Hàn, Trung, hoặc ngôn ngữ của riêng bạn |
| `forge-skills` | **Tự động tạo 3–5 kỹ năng riêng cho nghề nghiệp và mục tiêu của bạn** — chạy tự động cuối `/onboard`; chạy lại bất cứ lúc nào bằng `/forge-skills` |
| `create-skill` | Dạy trợ lý một khả năng mới bằng cách mô tả nó — trợ lý tự viết và cài kỹ năng (cùng tiêu chuẩn chất lượng với forge) |
| `remember` | Lưu thông tin/sở thích vào bộ nhớ dài hạn của trợ lý |
| `recall` | Tìm lại những gì bạn từng nói với nó |
| `learn-from-mistakes` | Biến những lần bạn sửa lỗi thành quy tắc vĩnh viễn |
| `daily-note` | Nhật ký đơn giản mỗi ngày |
| `work-smart` | Bắt trợ lý lên kế hoạch trước khi làm, tránh bước thừa |
| `personal` | Nền tảng trợ lý cá nhân: tính cách nhất quán, thói quen ghi nhớ, trung thực, ranh giới an toàn |
| `leader` | Cho việc lớn: lên kế hoạch, chia nhỏ, giao việc, kiểm tra, báo cáo một câu trả lời gọn |
| `/setup-vault` | Tạo (lại) kho ghi chú "bộ não thứ hai" tại `~/second-brain` — sẵn sàng cho Obsidian |
| `obsidian-markdown` · `obsidian-cli` | Viết và sắp xếp ghi chú đúng chuẩn (wikilink, tag, thao tác file an toàn) |

## 🆓 Bản Miễn phí cho bạn những gì

Trình chat `souldrop` (shortcut ngoài màn hình / lệnh terminal): nạp "linh hồn" của trợ lý, trả lời trực tiếp từ model chạy tại máy được chọn vừa sức máy bạn (RAM 16 GB+ → model 8B, 8–16 GB → 3B, dưới 8 GB → 1B kèm ghi chú thẳng thắn "chỉ ở mức cơ bản"), lưu thông tin khi bạn nói *"nhớ ..."*, và ghi cùng một bộ não thứ hai như bản Pro. Bậc này không có forge kỹ năng — model nhỏ chưa đủ tin cậy để tự viết kỹ năng, nên nội dung các kỹ năng cốt lõi của SoulDrop được gói thẳng vào tính cách trợ lý. Muốn nâng lên Pro lúc nào cũng được: chạy lại trình cài đặt; bộ não đi theo bạn.

## 📔 Bộ não thứ hai của bạn

Quá trình khởi tạo tạo kho ghi chú tại `~/second-brain` — các file markdown thuần mà trợ lý đọc và ghi (nhật ký, dự án, người quen, ý tưởng). Mở thư mục này trong ứng dụng miễn phí [Obsidian](https://obsidian.md) ("Open folder as vault") để xem trực quan — bản Pro còn tự cài Obsidian giúp bạn, không được thì mọi thứ vẫn hoạt động dạng file thuần. Bản Pro cũng thử nâng cấp "bộ nhớ thông minh" tùy chọn (plugin mã nguồn mở [agentmemory](https://github.com/rohitg00/agentmemory)); nếu không cài được, trợ lý vẫn ghi nhớ đầy đủ bằng file.

## ❓ Câu hỏi thường gặp

**Đây có phải phần mềm chính thức của Anthropic hay Ollama không?**
Không. SoulDrop là bộ khởi động độc lập. Nó cài Claude Code và Ollama chỉ bằng trình cài đặt chính thức của chính họ, rồi thêm bộ não SoulDrop lên trên. Xem [NOTICE](NOTICE).

**Bản miễn phí có thật sự miễn phí không?**
Có. Động cơ chạy tại máy (Ollama) và các model đều là mã nguồn mở, chạy hoàn toàn trên máy của bạn. Không tài khoản, không thuê bao, không phí ẩn — chỉ tốn dung lượng ổ đĩa và phần cứng của chính bạn.

**Script cài đặt có an toàn không?**
Có — và bạn không cần tin suông: hãy tự đọc [`install/go.ps1`](install/go.ps1) và [`install/go.sh`](install/go.sh). Chúng chỉ gọi trình cài đặt chính thức, đăng ký repo này làm kho plugin, và cài trình khởi động. Windows SmartScreen hoặc phần mềm diệt virus có thể cảnh báo với mọi script tải từ internet — điều đó bình thường với cách cài này.

**Lỡ chạy 2 lần thì sao?**
Không sao cả — script chạy lại an toàn, phần nào cài rồi sẽ tự bỏ qua.

**Đổi trợ lý sau này được không?**
Được. Chạy `/onboard` lại (Pro) hoặc `souldrop -Reset` / `souldrop --reset` (Miễn phí) bất cứ lúc nào. Hồ sơ cũ luôn được sao lưu trước, không bao giờ bị xóa.

**Có thu thập dữ liệu của tôi không?**
Không. Mọi thứ nằm trên máy của chính bạn — `~/.claude/` với bản Pro, `~/souldrop-brain/` với bản Miễn phí. Ở bản Miễn phí, đến cả AI cũng không rời khỏi máy bạn.

**Link cũ ghi `claude-easy-install`?**
Cùng một dự án — SoulDrop là tên mới từ v0.4.0. Các URL GitHub cũ tự chuyển hướng.

## 📄 Giấy phép

MIT — xem [LICENSE](LICENSE). Claude Code là phần mềm của Anthropic, Ollama là của Ollama, mỗi cái được cài qua trình cài đặt chính thức của họ; xem [NOTICE](NOTICE).

---

<div align="center">

<img src="assets/logo.svg" alt="" width="44">

**SoulDrop** — một bộ não, mọi động cơ.

<sub>MIT © SK Production · <a href="LICENSE">LICENSE</a> · <a href="NOTICE">NOTICE</a></sub>

</div>
