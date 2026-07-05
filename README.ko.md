# SoulDrop

[English](README.md) · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · **한국어** · [中文](README.zh.md)

**어떤 컴퓨터에든 영혼을 떨어뜨리세요 — 당신만의 개인 AI 어시스턴트, 완전 자동.**
*Drop a soul into any machine — your personal AI assistant, fully automatic.*

명령어 하나. 친근한 인터뷰(기술 질문은 절대 없음). 결과는 자기만의 이름, 성격, 장기 기억, "두 번째 뇌"를 가진 어시스턴트 — 당신에게 맞는 엔진에서 실행됩니다. **유료든, 100% 무료든.**

> 영어와 베트남어가 기본 지원 언어입니다. 태국어·한국어·중국어는 완전히 지원되며, 그 외 언어도 "기타" 옵션으로 사용할 수 있습니다.

> 📸 *스크린샷은 곧 추가됩니다*

---

## 엔진을 선택하세요

SoulDrop은 **뇌**(어시스턴트가 누구인지 — 당신 소유의 일반 마크다운 파일)와 **엔진**(그것을 실행하는 것)을 분리합니다. 같은 영혼, 어떤 엔진이든:

| 엔진 | 비용 | 제공 내용 |
|---|---|---|
| **Pro — [Claude Code](https://code.claude.com)** | 유료 Claude 요금제 (Pro/Max) | 가장 똑똑한 티어: 전체 스킬, **자동 스킬 단조**(직업에 맞는 커스텀 능력 자동 생성), 서브에이전트 |
| **무료 — [Ollama](https://ollama.com) (로컬)** | **0원, 계정 불필요** | 당신 컴퓨터에서 100% 실행되는 진짜 어시스턴트: 페르소나, 기억, "기억해...", 두 번째 뇌. 기본적으로 프라이빗 |
| Codex · Antigravity · OpenClaw | — | 🔜 v0.5 예정 |

기술적인 선택은 필요 없습니다 — 설치 프로그램이 **Claude Code를 자동 감지**하고, 없으면 딱 한 가지만 묻습니다: *무료 또는 Pro?*

## 설치 — Windows

**PowerShell**을 열고(시작 버튼 → "PowerShell" 입력 → Enter) 붙여넣기:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.ps1 | iex
```

## 설치 — macOS / Linux

**터미널**을 열고 붙여넣기:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.sh | bash
```

## 그다음

**Pro 엔진 (Claude):**
1. `claude`를 입력하고 Enter, 브라우저가 열리면 로그인하세요 (유료 요금제 필요).
2. `/onboard`를 입력하고 언어를 선택하면 새 어시스턴트를 만납니다 — 인사하기 전에 직업에 맞는 커스텀 스킬 3–5개까지 만들어 둡니다.

**무료 엔진 (로컬):**
1. 바탕화면의 **SoulDrop**을 더블클릭(Windows)하거나 새 터미널에서 `souldrop`을 입력하세요.
2. 친근한 질문 6개(이름, 하는 일, 목표, 어시스턴트 이름...)에 답하면 끝. 모든 것이 당신 컴퓨터에서 실행되고, 아무것도 밖으로 나가지 않습니다.

## 요구 사항

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+, 설치 시 인터넷
- **무료 엔진:** 그 외 아무것도 필요 없음. AI 모델용 디스크 ~2–5 GB (RAM에 맞게 자동 선택)
- **Pro 엔진:** 유료 Claude 구독 (Pro, Max, Team) — [claude.ai](https://claude.ai)
- **아직 Claude가 없나요?** 7일 무료 Pro 체험으로 시작 → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(추천 링크 — 이 프로젝트를 후원합니다)*

## 하나의 뇌, 여러 엔진

뇌는 **일반 마크다운 — 엔진은 교체 가능**합니다: 페르소나 파일(어시스턴트의 정체), 기억 은행(언제든 *"기억해..."*라고 말하면 저장), 그리고 모든 엔진이 공유하는 `~/second-brain` 노트 볼트. 모든 파일을 직접 읽고, 수정하고, 백업하고, 새 컴퓨터로 옮길 수 있습니다. 명세: [`brain/`](brain/README.md) · 새 엔진용 어댑터 계약: [`adapters/`](adapters/README.md).

## Pro 플러그인 구성

| 스킬 | 기능 |
|---|---|
| `/onboard` | 개인화된 어시스턴트 + 기억 + 커스텀 스킬 + 두 번째 뇌를 만드는 인터뷰 — 영어, 베트남어, 태국어, 한국어, 중국어 또는 원하는 언어로 |
| `forge-skills` | **직업과 목표에 맞는 커스텀 스킬 3–5개를 자동 생성** — `/onboard` 끝에 자동 실행, 언제든 재실행 가능 |
| `create-skill` | 설명만 하면 어시스턴트가 새 능력을 직접 작성·설치 (단조와 같은 품질 기준) |
| `remember` | 사실/선호를 장기 기억에 저장 |
| `recall` | 이전에 말한 내용 검색 |
| `learn-from-mistakes` | 당신의 수정 사항을 영구 규칙으로 전환 |
| `daily-note` | 간단한 일일 일기 |
| `work-smart` | 행동 전에 계획하고 낭비 단계를 피하게 함 |
| `personal` | 개인 비서 기본기: 일관된 페르소나, 기억 습관, 정직함, 안전 경계 |
| `leader` | 큰 작업용: 계획, 분해, 위임, 검증, 하나의 깔끔한 답변으로 보고 |
| `/setup-vault` | `~/second-brain`에 두 번째 뇌 노트 볼트 (재)생성 — Obsidian 지원 |
| `obsidian-markdown` · `obsidian-cli` | 볼트 노트를 올바르게 작성·정리 (위키링크, 태그, 안전한 파일 작업) |

## 무료 엔진이 주는 것

`souldrop` 채팅 런처(바탕화면 바로가기 / 터미널 명령): 어시스턴트의 영혼을 로드하고, 컴퓨터에 맞게 선택된 로컬 모델에서 스트리밍으로 응답하며(RAM 16 GB+ → 8B 모델, 8–16 GB → 3B, 8 GB 미만 → 1B + "기본 수준"이라는 솔직한 안내), *"기억해..."*라고 말하면 사실을 저장하고, Pro 티어와 같은 두 번째 뇌를 씁니다. 이 티어에는 스킬 단조가 없습니다 — 작은 로컬 모델은 스킬 작성을 신뢰하기 어려워, SoulDrop 핵심 스킬의 내용을 페르소나에 직접 접어 넣었습니다. 언제든 설치 프로그램을 다시 실행해 Pro로 업그레이드하세요. 뇌는 함께 갑니다.

## 당신의 두 번째 뇌

온보딩은 `~/second-brain`에 노트 볼트를 만듭니다 — 어시스턴트가 읽고 쓰는 일반 마크다운 파일(일일 노트, 프로젝트, 사람, 아이디어). 무료 [Obsidian](https://obsidian.md) 앱에서 이 폴더를 열면("Open folder as vault") 시각적으로 볼 수 있습니다 — Pro 설치 프로그램은 Obsidian 설치까지 시도하며, 안 되더라도 모든 것이 일반 파일로 작동합니다. Pro 설치 프로그램은 선택적 "스마트 메모리" 업그레이드(오픈소스 [agentmemory](https://github.com/rohitg00/agentmemory) 플러그인)도 시도합니다. 실패해도 어시스턴트는 파일로 모든 것을 기억합니다.

## FAQ

**Anthropic이나 Ollama의 공식 소프트웨어인가요?**
아니요. SoulDrop은 독립 스타터 키트입니다. Claude Code와 Ollama를 각자의 공식 설치 프로그램으로만 설치하고, 그 위에 SoulDrop 뇌를 얹습니다. [NOTICE](NOTICE) 참조.

**무료 버전은 정말 무료인가요?**
네. 로컬 엔진(Ollama)과 모델은 오픈소스이며 전부 당신 컴퓨터에서 실행됩니다. 계정도, 구독도, 숨은 비용도 없습니다 — 디스크 공간과 하드웨어만 쓰면 됩니다.

**설치 스크립트는 안전한가요?**
네 — 그리고 우리를 그냥 믿을 필요도 없습니다: [`install/go.ps1`](install/go.ps1)과 [`install/go.sh`](install/go.sh)를 직접 읽어 보세요. 공식 설치 프로그램 호출, 이 저장소를 플러그인 마켓플레이스로 등록, 런처 설치만 합니다. Windows SmartScreen이나 백신이 인터넷 스크립트에 경고를 띄울 수 있지만 이 설치 방식에서는 정상입니다.

**실수로 두 번 실행했어요.**
괜찮습니다 — 스크립트는 재실행해도 안전하며, 이미 설치된 부분은 건너뜁니다.

**나중에 어시스턴트를 바꿀 수 있나요?**
네. 언제든 `/onboard`(Pro) 또는 `souldrop -Reset` / `souldrop --reset`(무료)을 다시 실행하세요. 이전 프로필은 항상 먼저 백업되며 절대 삭제되지 않습니다.

**내 데이터를 수집하나요?**
아니요. 모든 것이 당신 컴퓨터에만 있습니다 — Pro는 `~/.claude/`, 무료는 `~/souldrop-brain/`. 무료 티어에서는 AI조차 컴퓨터 밖으로 나가지 않습니다.

**예전 링크에 `claude-easy-install`이라고 되어 있어요?**
같은 프로젝트입니다 — v0.4.0부터 SoulDrop이 새 이름입니다. 이전 GitHub URL은 자동으로 리디렉션됩니다.

---

## 라이선스

MIT — [LICENSE](LICENSE) 참조. Claude Code는 Anthropic의, Ollama는 Ollama의 소프트웨어이며 각자의 공식 설치 프로그램으로 설치됩니다. [NOTICE](NOTICE) 참조.
