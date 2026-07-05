# Claude Code Easy Install

**One command → Claude Code installed → your own personal AI assistant, in Vietnamese or English.**

**Một lệnh duy nhất → cài xong Claude Code → có ngay trợ lý AI cá nhân của riêng bạn, bằng tiếng Việt hoặc tiếng Anh.**

> 📸 *Screenshots coming soon / Ảnh minh họa sẽ được bổ sung*

---

## 🇬🇧 English

### What is this?

Most Claude Code starter kits give you files to edit by hand. This one **interviews you** and writes your setup for you:

1. Installs [Claude Code](https://code.claude.com) using **Anthropic's official installer** (we never re-host their software).
2. Installs the `nick-starter` plugin from this repo.
3. You type `/onboard` → a friendly interview asks your name, what you need help with, your assistant's **name** and **personality** → it writes a personalized profile and sets up a persistent memory ("second brain") for your assistant.

No Node.js, no Git, no admin rights required.

### Install — Windows

Open **PowerShell** (press Start, type "PowerShell", Enter) and paste:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
```

### Install — macOS / Linux

Open **Terminal** and paste:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
```

### Then

1. Type `claude` and press Enter.
2. Log in when the browser opens — **a paid Claude plan (Pro or Max) is required**.
3. Type `/onboard` and meet your new assistant.

### Requirements

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+
- Internet connection
- A paid Claude subscription (Pro, Max, or Team) — [claude.ai](https://claude.ai)

### What's inside the plugin

| Skill | What it does |
|---|---|
| `/onboard` | The interview that creates your personalized assistant + memory |
| `remember` | Saves facts/preferences to your assistant's long-term memory |
| `recall` | Finds things you told it before |
| `learn-from-mistakes` | Turns your corrections into permanent rules |
| `daily-note` | Simple daily journal |
| `work-smart` | Makes the assistant plan before acting and avoid wasted steps |

### FAQ

**Is this official Anthropic software?**
No. This is an independent starter kit. It installs Claude Code by calling Anthropic's own official installer, then adds a plugin on top. Claude Code itself belongs to Anthropic.

**Is the install script safe?**
Yes — and you don't have to trust us: [read `install/go.ps1`](install/go.ps1) and [`install/go.sh`](install/go.sh) yourself. They only (1) call Anthropic's official installer, (2) register this repo as a plugin marketplace, (3) install the plugin. Windows SmartScreen or antivirus may show a warning for any script from the internet — that's normal for this install method.

**I ran it twice by accident.**
Totally fine — the script is safe to re-run. It skips whatever is already installed.

**Can I change my assistant later?**
Yes. Run `/onboard` again anytime. Your old profile is backed up first, never deleted.

**Does it collect my data?**
No. Everything the interview writes stays in `~/.claude/` on your own machine.

---

## 🇻🇳 Tiếng Việt

### Đây là gì?

Các bộ cài Claude Code khác đưa bạn một đống file để tự sửa. Bộ này **phỏng vấn bạn** rồi tự viết cấu hình cho bạn:

1. Cài [Claude Code](https://code.claude.com) bằng **trình cài đặt chính thức của Anthropic** (chúng tôi không đóng gói lại phần mềm của họ).
2. Cài plugin `nick-starter` từ repo này.
3. Bạn gõ `/onboard` → một cuộc phỏng vấn thân thiện hỏi tên bạn, bạn cần giúp gì, **tên** và **tính cách** trợ lý của bạn → nó tự viết hồ sơ cá nhân hóa và tạo bộ nhớ dài hạn ("bộ não thứ hai") cho trợ lý.

Không cần Node.js, không cần Git, không cần quyền admin.

### Cài đặt — Windows

Mở **PowerShell** (bấm Start, gõ "PowerShell", Enter) rồi dán:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
```

### Cài đặt — macOS / Linux

Mở **Terminal** rồi dán:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
```

### Sau đó

1. Gõ `claude` rồi nhấn Enter.
2. Đăng nhập khi trình duyệt mở ra — **cần tài khoản Claude trả phí (Pro hoặc Max)**.
3. Gõ `/onboard` và gặp trợ lý mới của bạn.

### Yêu cầu

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+
- Kết nối internet
- Tài khoản Claude trả phí (Pro, Max hoặc Team) — [claude.ai](https://claude.ai)

### Câu hỏi thường gặp

**Đây có phải phần mềm chính thức của Anthropic không?**
Không. Đây là bộ khởi động độc lập. Nó cài Claude Code bằng chính trình cài đặt chính thức của Anthropic, rồi thêm plugin lên trên. Claude Code thuộc về Anthropic.

**Script cài đặt có an toàn không?**
Có — và bạn không cần tin suông: hãy tự đọc [`install/go.ps1`](install/go.ps1) và [`install/go.sh`](install/go.sh). Chúng chỉ (1) gọi trình cài đặt chính thức của Anthropic, (2) đăng ký repo này làm kho plugin, (3) cài plugin. Windows SmartScreen hoặc phần mềm diệt virus có thể cảnh báo với mọi script tải từ internet — điều đó bình thường với cách cài này.

**Lỡ chạy 2 lần thì sao?**
Không sao cả — script chạy lại an toàn, phần nào cài rồi sẽ tự bỏ qua.

**Đổi trợ lý sau này được không?**
Được. Chạy `/onboard` lại bất cứ lúc nào. Hồ sơ cũ luôn được sao lưu trước, không bao giờ bị xóa.

**Có thu thập dữ liệu của tôi không?**
Không. Mọi thứ cuộc phỏng vấn ghi ra đều nằm trong `~/.claude/` trên máy của chính bạn.

---

## License

MIT — see [LICENSE](LICENSE). Claude Code itself is Anthropic's software, installed via their official installer; see [NOTICE](NOTICE).
