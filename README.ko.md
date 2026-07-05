# Claude Code Easy Install — 클로드 코드 초간단 설치

[English](README.md) · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · **한국어** · [中文](README.zh.md)

**명령어 하나 → Claude Code 설치 완료 → 당신만의 개인 AI 어시스턴트가, 당신의 언어로.**

> 영어와 베트남어가 기본 지원 언어입니다. 태국어·한국어·중국어는 `/onboard`와 이 문서에서 완전히 지원되며, 그 외 언어도 인터뷰의 "기타" 옵션으로 사용할 수 있습니다.

> 📸 *스크린샷은 곧 추가됩니다*

---

## 이게 뭔가요?

대부분의 Claude Code 스타터 키트는 직접 수정해야 할 파일 뭉치를 던져 줍니다. 이 키트는 **당신을 인터뷰하고** 설정을 대신 작성해 줍니다:

1. **Anthropic 공식 설치 프로그램**으로 [Claude Code](https://code.claude.com)를 설치합니다 (우리는 Anthropic의 소프트웨어를 재배포하지 않습니다).
2. 이 저장소의 `nick-starter` 플러그인을 설치합니다.
3. `/onboard`를 입력하면 → 친근한 인터뷰가 당신의 이름, 하는 일, **목표**, 어시스턴트의 **이름**과 **성격**을 묻고 → 개인화된 프로필과 영구 메모리를 만들어 줍니다.
4. 그다음 — 완전히 자동으로 — **어시스턴트가 스스로 스킬을 만듭니다**: 당신의 직업과 목표로부터 맞춤 능력 3–5개를 벼려내(예: 사진작가라면 고객 문의 답변, 견적서 작성, 촬영 계획) 인사하기 전에 설치까지 끝냅니다.
5. **"두 번째 두뇌"**도 세팅합니다: `~/second-brain`에 바로 쓸 수 있는 노트 볼트가 만들어지며, 무료 [Obsidian](https://obsidian.md) 앱으로 열어 볼 수 있습니다 (설치 프로그램이 Obsidian 설치도 시도합니다).

기술적인 질문은 단 하나도 받지 않습니다 — 인터뷰는 오직 당신에 관한 것뿐입니다. 자동 추가 기능은 모두 선택 사항이라, 설치가 안 되면 친절한 한 줄과 함께 건너뛰고 나머지는 전부 정상 작동합니다.

Git도, 관리자 권한도 필요 없습니다. (Node.js는 설치 프로그램이 알아서 처리하는 선택적 추가 기능일 뿐입니다.)

## 설치 — Windows

**PowerShell**을 열고 (시작 버튼 → "PowerShell" 입력 → Enter) 붙여넣으세요:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
```

## 설치 — macOS / Linux

**터미널**을 열고 붙여넣으세요:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
```

## 그다음

1. `claude`를 입력하고 Enter를 누르세요.
2. 브라우저가 열리면 로그인하세요 — **유료 Claude 요금제(Pro 또는 Max)가 필요합니다**.
3. `/onboard`를 입력하고 언어를 선택한 뒤, 새 어시스턴트를 만나 보세요.

## 요구 사항

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+
- 인터넷 연결
- 유료 Claude 구독 (Pro, Max 또는 Team) — [claude.ai](https://claude.ai)
- **아직 Claude가 없나요?** 무료 7일 Pro 체험으로 시작하세요 → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(추천 링크 — 이 프로젝트를 후원합니다)*

## 플러그인에 들어 있는 것

| 스킬 | 하는 일 |
|---|---|
| `/onboard` | 개인화된 어시스턴트 + 메모리 + 맞춤 스킬 + 두 번째 두뇌를 만드는 인터뷰 — 영어, 베트남어, 태국어, 한국어, 중국어 또는 원하는 언어로 |
| `forge-skills` | **직업과 목표에 맞춘 스킬 3–5개를 자동 생성** — `/onboard` 마지막에 자동 실행; `/forge-skills` 또는 "목표가 바뀌었어"라고 말하면 언제든 재실행 |
| `create-skill` | 새 능력을 말로 설명하면 어시스턴트가 직접 스킬을 작성·설치 (forge와 동일한 품질 기준) |
| `remember` | 사실/선호를 어시스턴트의 장기 메모리에 저장 |
| `recall` | 예전에 말해 둔 것을 찾아 줌 |
| `learn-from-mistakes` | 당신의 교정을 영구 규칙으로 전환 |
| `daily-note` | 간단한 일일 저널 |
| `work-smart` | 행동 전에 계획하게 하고 낭비되는 단계를 줄임 |
| `personal` | 개인 어시스턴트 기본기: 일관된 페르소나, 기억 습관, 정직함, 안전 경계 |
| `leader` | 큰 작업용: 계획, 분해, 위임, 검증, 하나의 깔끔한 답변으로 보고 |
| `/setup-vault` | `~/second-brain`에 두 번째 두뇌 노트 볼트를 (재)생성 — Obsidian 호환 |
| `obsidian-markdown` · `obsidian-cli` | 노트를 제대로 쓰고 정리 (위키링크, 태그, 안전한 파일 작업) |

## 당신의 두 번째 두뇌

`/onboard`는 `~/second-brain`에 노트 볼트를 만듭니다 — 어시스턴트가 읽고 쓰는 평범한 마크다운 파일(일일 노트, 프로젝트, 사람, 아이디어)입니다. 무료 [Obsidian](https://obsidian.md) 앱에서 이 폴더를 열면("Open folder as vault") 시각적으로 볼 수 있습니다 — 설치 프로그램이 Obsidian 설치를 시도하며, 안 되더라도 모든 것이 일반 파일로 정상 작동합니다. 설치 프로그램은 선택적 "스마트 메모리" 업그레이드(오픈소스 [agentmemory](https://github.com/rohitg00/agentmemory) 플러그인)도 시도하는데, 실패하면 어시스턴트는 그대로 파일로 모든 것을 기억합니다.

## 자주 묻는 질문

**Anthropic의 공식 소프트웨어인가요?**
아닙니다. 이것은 독립적인 스타터 키트입니다. Anthropic의 공식 설치 프로그램을 호출해 Claude Code를 설치한 뒤, 그 위에 플러그인을 얹습니다. Claude Code 자체는 Anthropic의 소프트웨어입니다.

**설치 스크립트는 안전한가요?**
네 — 그리고 우리를 그냥 믿을 필요도 없습니다: [`install/go.ps1`](install/go.ps1)과 [`install/go.sh`](install/go.sh)를 직접 읽어 보세요. 스크립트는 (1) Anthropic 공식 설치 프로그램 호출, (2) 이 저장소를 플러그인 마켓플레이스로 등록, (3) 플러그인 설치만 합니다. Windows SmartScreen이나 백신이 인터넷에서 받은 스크립트에 경고를 띄울 수 있는데, 이 설치 방식에서는 정상적인 일입니다.

**실수로 두 번 실행했어요.**
전혀 문제없습니다 — 스크립트는 재실행해도 안전하며, 이미 설치된 부분은 건너뜁니다.

**나중에 어시스턴트를 바꿀 수 있나요?**
네. 언제든 `/onboard`를 다시 실행하세요. 이전 프로필은 먼저 백업되며, 절대 삭제되지 않습니다.

**내 데이터를 수집하나요?**
아니요. 인터뷰가 작성하는 모든 것은 당신 컴퓨터의 `~/.claude/`에만 저장됩니다.

---

## 라이선스

MIT — [LICENSE](LICENSE)를 참고하세요. Claude Code 자체는 Anthropic의 소프트웨어이며 공식 설치 프로그램을 통해 설치됩니다. [NOTICE](NOTICE)를 참고하세요.
