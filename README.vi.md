# SoulDrop

[English](README.md) · **Tiếng Việt** · [ไทย](README.th.md) · [한국어](README.ko.md) · [中文](README.zh.md)

**Thả một linh hồn vào bất kỳ máy nào — trợ lý AI cá nhân của bạn, tự động hoàn toàn.**
*Drop a soul into any machine — your personal AI assistant, fully automatic.*

Một lệnh duy nhất. Một cuộc phỏng vấn thân thiện (không bao giờ hỏi câu kỹ thuật). Kết quả: một trợ lý có tên riêng, tính cách riêng, bộ nhớ dài hạn và "bộ não thứ hai" — chạy trên động cơ AI phù hợp với bạn, **trả phí hoặc miễn phí 100%**.

> Tiếng Anh và Tiếng Việt là hai ngôn ngữ được hỗ trợ chính. Tiếng Thái, Hàn, Trung được hỗ trợ đầy đủ; các ngôn ngữ khác vẫn dùng được qua lựa chọn "Khác".

> 📸 *Ảnh minh họa sẽ được bổ sung*

---

## Chọn động cơ của bạn

SoulDrop tách **bộ não** (trợ lý của bạn là ai — các file markdown thuần thuộc về bạn) khỏi **động cơ** (thứ chạy nó). Cùng một linh hồn, động cơ nào cũng được:

| Động cơ | Chi phí | Bạn nhận được gì |
|---|---|---|
| **Pro — [Claude Code](https://code.claude.com)** | Tài khoản Claude trả phí (Pro/Max) | Bậc thông minh nhất: đủ bộ kỹ năng, **tự rèn kỹ năng riêng** cho nghề của bạn, subagent |
| **Miễn phí — [Ollama](https://ollama.com) (chạy tại máy)** | **0đ, không cần tài khoản** | Trợ lý thật sự chạy 100% trên máy của bạn: tính cách, bộ nhớ, "nhớ ...", bộ não thứ hai. Riêng tư mặc định |
| Codex · Antigravity · OpenClaw | — | 🔜 sẽ có ở v0.5 |

Bạn không phải chọn gì mang tính kỹ thuật — trình cài đặt **tự phát hiện Claude Code**, nếu chưa có thì chỉ hỏi đúng một câu: *Miễn phí hay Pro?*

## Cài đặt — Windows

Mở **PowerShell** (bấm Start, gõ "PowerShell", Enter) rồi dán:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.ps1 | iex
```

## Cài đặt — macOS / Linux

Mở **Terminal** rồi dán:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.sh | bash
```

## Sau đó

**Động cơ Pro (Claude):**
1. Gõ `claude` rồi nhấn Enter, đăng nhập khi trình duyệt mở ra (cần tài khoản trả phí).
2. Gõ `/onboard`, chọn ngôn ngữ, và gặp trợ lý mới — nó còn tự rèn 3–5 kỹ năng riêng cho nghề của bạn trước khi chào bạn.

**Động cơ Miễn phí (tại máy):**
1. Nhấn đúp **SoulDrop** ngoài màn hình (Windows) hoặc gõ `souldrop` trong terminal mới.
2. Trả lời sáu câu hỏi thân thiện (tên bạn, công việc, mục tiêu, tên trợ lý...) — xong. Mọi thứ chạy trên máy bạn; không có gì rời khỏi máy.

## Yêu cầu

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+, có internet lúc cài
- **Bản Miễn phí:** không cần gì thêm. Khoảng 2–5 GB ổ đĩa cho model AI (tự chọn vừa với RAM của máy)
- **Bản Pro:** tài khoản Claude trả phí (Pro, Max hoặc Team) — [claude.ai](https://claude.ai)
- **Chưa có Claude?** Dùng thử Pro 7 ngày miễn phí → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(link giới thiệu — ủng hộ dự án này)*

## Một bộ não, nhiều động cơ

Bộ não là **markdown thuần — động cơ nào cũng thay được**: file tính cách (trợ lý của bạn là ai), ngân hàng bộ nhớ (nói *"nhớ ..."* bất cứ lúc nào để lưu), và kho ghi chú "bộ não thứ hai" tại `~/second-brain` dùng chung cho mọi động cơ. Bạn tự đọc, sửa, sao lưu hoặc chuyển máy mọi file. Chi tiết: [`brain/`](brain/README.md) · chuẩn adapter cho động cơ mới: [`adapters/`](adapters/README.md).

## Bên trong plugin Pro có gì

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

## Bản Miễn phí cho bạn những gì

Trình chat `souldrop` (shortcut ngoài màn hình / lệnh terminal): nạp "linh hồn" của trợ lý, trả lời trực tiếp từ model chạy tại máy được chọn vừa sức máy bạn (RAM 16 GB+ → model 8B, 8–16 GB → 3B, dưới 8 GB → 1B kèm ghi chú thẳng thắn "chỉ ở mức cơ bản"), lưu thông tin khi bạn nói *"nhớ ..."*, và ghi cùng một bộ não thứ hai như bản Pro. Bậc này không có forge kỹ năng — model nhỏ chưa đủ tin cậy để tự viết kỹ năng, nên nội dung các kỹ năng cốt lõi của SoulDrop được gói thẳng vào tính cách trợ lý. Muốn nâng lên Pro lúc nào cũng được: chạy lại trình cài đặt; bộ não đi theo bạn.

## Bộ não thứ hai của bạn

Quá trình khởi tạo tạo kho ghi chú tại `~/second-brain` — các file markdown thuần mà trợ lý đọc và ghi (nhật ký, dự án, người quen, ý tưởng). Mở thư mục này trong ứng dụng miễn phí [Obsidian](https://obsidian.md) ("Open folder as vault") để xem trực quan — bản Pro còn tự cài Obsidian giúp bạn, không được thì mọi thứ vẫn hoạt động dạng file thuần. Bản Pro cũng thử nâng cấp "bộ nhớ thông minh" tùy chọn (plugin mã nguồn mở [agentmemory](https://github.com/rohitg00/agentmemory)); nếu không cài được, trợ lý vẫn ghi nhớ đầy đủ bằng file.

## Câu hỏi thường gặp

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

---

## Giấy phép

MIT — xem [LICENSE](LICENSE). Claude Code là phần mềm của Anthropic, Ollama là của Ollama, mỗi cái được cài qua trình cài đặt chính thức của họ; xem [NOTICE](NOTICE).
