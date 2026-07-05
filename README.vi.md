# Claude Code Easy Install — Cài Claude Code siêu dễ

[English](README.md) · **Tiếng Việt** · [ไทย](README.th.md) · [한국어](README.ko.md) · [中文](README.zh.md)

**Một lệnh duy nhất → cài xong Claude Code → có ngay trợ lý AI cá nhân của riêng bạn, bằng ngôn ngữ của bạn.**

> Tiếng Anh và Tiếng Việt là hai ngôn ngữ được hỗ trợ chính. Tiếng Thái, Hàn, Trung được hỗ trợ đầy đủ trong `/onboard` và tài liệu này; các ngôn ngữ khác vẫn dùng được qua lựa chọn "Khác" trong cuộc phỏng vấn.

> 📸 *Ảnh minh họa sẽ được bổ sung*

---

## Đây là gì?

Các bộ cài Claude Code khác đưa bạn một đống file để tự sửa. Bộ này **phỏng vấn bạn** rồi tự viết cấu hình cho bạn:

1. Cài [Claude Code](https://code.claude.com) bằng **trình cài đặt chính thức của Anthropic** (chúng tôi không đóng gói lại phần mềm của họ).
2. Cài plugin `nick-starter` từ repo này.
3. Bạn gõ `/onboard` → một cuộc phỏng vấn thân thiện hỏi tên bạn, bạn cần giúp gì, **tên** và **tính cách** trợ lý của bạn → nó tự viết hồ sơ cá nhân hóa và tạo bộ nhớ dài hạn ("bộ não thứ hai") cho trợ lý.

Không cần Node.js, không cần Git, không cần quyền admin.

## Cài đặt — Windows

Mở **PowerShell** (bấm Start, gõ "PowerShell", Enter) rồi dán:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
```

## Cài đặt — macOS / Linux

Mở **Terminal** rồi dán:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
```

## Sau đó

1. Gõ `claude` rồi nhấn Enter.
2. Đăng nhập khi trình duyệt mở ra — **cần tài khoản Claude trả phí (Pro hoặc Max)**.
3. Gõ `/onboard`, chọn ngôn ngữ, và gặp trợ lý mới của bạn.

## Yêu cầu

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+
- Kết nối internet
- Tài khoản Claude trả phí (Pro, Max hoặc Team) — [claude.ai](https://claude.ai)

## Bên trong plugin có gì

| Kỹ năng | Công dụng |
|---|---|
| `/onboard` | Cuộc phỏng vấn tạo trợ lý cá nhân hóa + bộ nhớ — bằng tiếng Anh, Việt, Thái, Hàn, Trung, hoặc ngôn ngữ của riêng bạn |
| `remember` | Lưu thông tin/sở thích vào bộ nhớ dài hạn của trợ lý |
| `recall` | Tìm lại những gì bạn từng nói với nó |
| `learn-from-mistakes` | Biến những lần bạn sửa lỗi thành quy tắc vĩnh viễn |
| `daily-note` | Nhật ký đơn giản mỗi ngày |
| `work-smart` | Bắt trợ lý lên kế hoạch trước khi làm, tránh bước thừa |

## Câu hỏi thường gặp

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

## Giấy phép

MIT — xem [LICENSE](LICENSE). Bản thân Claude Code là phần mềm của Anthropic, được cài qua trình cài đặt chính thức của họ; xem [NOTICE](NOTICE).
