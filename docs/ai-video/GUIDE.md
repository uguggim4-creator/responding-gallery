# AI 영상 제작 가이드 — Claude 스킬 + Higgsfield (Seedance 2.5)

출처 재생목록: [AI Filmmaking Masterclass (Seedance 2.5) — Higgsfield AI](https://www.youtube.com/playlist?list=PLaQe6ms8V2M6XXEbnKKG0Lw85CuXbls4L)

> **확인 범위.** 영상 목록·제목·길이는 재생목록에서 직접 확인했습니다. 영상 자막과 본문은
> 클라우드 세션에서 YouTube가 봇 확인을 요구해 읽지 못했습니다. 아래 단계별 내용은 영상 제목,
> 영상 설명에 연결된 Higgsfield 페이지, 그리고 Higgsfield 공식·커뮤니티 스킬 문서를 근거로
> 정리했습니다. 영상에서 쓰는 화면 수치나 프롬프트 원문은 각 영상 설명란의
> "All Prompts and Assets" 링크에서 확인하세요.

---

## 1. 최신 영상 7개와 사용할 스킬

재생목록 맨 위가 최신순입니다(검색 결과 기준: #1은 약 2일 전, #2는 약 10일 전, #5는 약 33일 전 게시).

| # | 영상 | 길이 | 핵심 주제 | 주로 쓰는 스킬 / 도구 |
|---|---|---|---|---|
| 1 | [You Will Stop Burning Your AI Credits After Watching This (3 Tips)](https://www.youtube.com/watch?v=sCukTWZEt7Q) | 17:14 | Claude와 Higgsfield로 크레딧 아끼기 | `higgsfield` → `higgsfield-assist`, `higgsfield-recall`, `higgsfield-troubleshoot` · MCP `balance`, `get_cost` |
| 2 | [I Spent 72 Hours Making a Commercial with AI (Full Workflow)](https://www.youtube.com/watch?v=ktGkJfxNN9M) | 27:55 | Claude로 만든 시네마틱 스포츠웨어 광고 | `higgsfield-shotlist-director`, `higgsfield-seedance-2-5`, `higgsfield-cinema`, `higgsfield-character-design` |
| 3 | [How I Make Realistic AI Short Films Using Seedance 2.5 - Full Guide](https://www.youtube.com/watch?v=wFbgrPmVXb0) | 21:26 | 실사형 숏필름 전체 과정 | `higgsfield-pipeline`, `higgsfield-seedance-2-5`, `higgsfield-soul`, `higgsfield-acting` |
| 4 | [5-Step Workflow: How to Make Viral AI Short Dramas (60M Views)](https://www.youtube.com/watch?v=cBxKZcalwkM) | 20:00 | 바이럴 숏드라마 5단계 | `higgsfield-scene-engine`, `higgsfield-acting`, `higgsfield-audio`, `higgsfield-repurpose`(Virality Predictor) |
| 5 | [I Made An AI Commercial For a Delivery Brand From Scratch (Full Tutorial)](https://www.youtube.com/watch?v=kFKpcCHkuPI) | 17:03 | 감독처럼 프롬프트 쓰기(Claude + Seedance 2.5) | `higgsfield-shotlist-director`, `higgsfield-marketing-studio`, `higgsfield-generate` |
| 6 | [GPT Astra 6 + Blender + Higgsfield Builds The Craziest Cinematic Scenes!](https://www.youtube.com/watch?v=vUYq38wC_xI) | 15:36 | Blender 3D 장면 → 영상 | `higgsfield-3d`(3D Jutsu / Scene Builder 3D), `higgsfield-gpt-image-2` · MCP `scene_builder_3d_*` |
| 7 | [How To Save AI Credits With Higgsfield + Blender (No One Talks About This Workflow)](https://www.youtube.com/watch?v=OiULPvTJ-0E) | 19:48 | Blender 블록아웃으로 재생성 줄이기 | `higgsfield-3d`, `higgsfield-seedance-2-5`(blockout → `omni_reference` video-to-video) |

---

## 2. 스킬 구성 (3개 레이어)

| 레이어 | 무엇 | 역할 |
|---|---|---|
| **프롬프트 디렉터** | [OSideMedia/higgsfield-ai-prompt-skill](https://github.com/OSideMedia/higgsfield-ai-prompt-skill) (스킬 이름 `higgsfield`, MIT) | 모델 선택, 카메라, Seedance 2.5 omni-reference 문법, 연기·씬 구조, Hell Grind 장편 파이프라인, 실패 진단. 루트 `SKILL.md`가 35개 하위 스킬로 안내합니다. |
| **실행 (공식)** | [higgsfield-ai/skills](https://github.com/higgsfield-ai/skills) (`higgsfield-generate` 등 9개, MIT) | `higgsfield` CLI로 실제 이미지·영상·오디오 생성, Marketing Studio, Soul ID 학습, Virality Predictor. |
| **실행 (커넥터)** | Higgsfield MCP 커넥터 (`https://mcp.higgsfield.ai/mcp`) | claude.ai·클라우드 세션용. 이 저장소의 클라우드 환경에는 이미 연결되어 있습니다(`mcp__higgsfield__*`). |

**규칙:** 프롬프트는 `higgsfield` 스킬로 쓰고, 생성은 MCP가 있으면 MCP로, 없으면 CLI(`higgsfield-generate`)로 실행합니다.

---

## 3. 설치

### A. 내 PC의 Claude Code (모든 프로젝트에 적용)

```bash
npx skills add higgsfield-ai/skills
```

```bash
git clone https://github.com/OSideMedia/higgsfield-ai-prompt-skill ~/.claude/skills/higgsfield
```

```bash
curl -fsSL https://raw.githubusercontent.com/higgsfield-ai/cli/main/install.sh | sh
```

```bash
higgsfield auth login
```

Claude Code 안에서 플러그인으로 설치하려면 `/plugin marketplace add higgsfield-ai/skills` 후 `/plugin install higgsfield@higgsfield`.

### B. claude.ai (웹·데스크톱 앱)

1. Settings → Connectors → Add custom connector → `https://mcp.higgsfield.ai/mcp` → 로그인.
2. Customize → Skills에서 `higgsfield-ai-prompt-skill` 저장소를 ZIP으로 올립니다(유료 플랜).

### C. Claude Code 클라우드 세션 (이 환경)

클라우드 컨테이너는 세션마다 새로 만들어지므로, 환경 설정의 **setup script**로 매번 설치해야 합니다.
아래 스크립트는 `scripts/install-ai-video-skills.sh`에 있습니다. 환경 설정에 넣으면 이 환경을 쓰는
모든 세션에서 스킬이 `~/.claude/skills/`에 설치되고, `~/.claude/CLAUDE.md`에 라우팅 규칙이 추가됩니다.
클라우드에서는 CLI 로그인 대신 이미 연결된 Higgsfield MCP를 사용합니다.

---

## 4. 표준 워크플로 (7개 영상 공통)

1. **기획** — 로그라인, 길이, 화면비(16:9 / 9:16), 예산(크레딧)을 먼저 정합니다.
   `higgsfield-character-design`, `higgsfield-scene-engine`(목표·장애물·전술·반전·가치 변화).
2. **캐릭터·로케이션 시트** — 회색 배경 캐릭터 시트, 얼굴 클로즈업 1장을 기준 이미지로 고정합니다.
   필요하면 Soul ID 학습(`higgsfield-soul`, `higgsfield-soul-id`).
3. **샷리스트** — 스타일 프리픽스 + @에셋 목록 + 씬별 프롬프트(1a, 1b, 2a…).
   `higgsfield-shotlist-director`.
4. **키프레임 이미지** — 영상 전에 이미지로 룩을 확정합니다(이미지는 영상보다 훨씬 쌉니다).
   GPT Image / Nano Banana / Soul.
5. **영상 생성 (Seedance 2.5)** — 모드 선택: `t2v` / `omni_reference`(이미지·영상·오디오 참조) /
   `video_edit` / `video_extension`. 참조마다 역할을 명시(`@Image1 = 캐릭터 얼굴만, 의상 제외`).
   `higgsfield-seedance-2-5`, 연기는 `higgsfield-acting`.
6. **오디오·편집** — 대사·효과음·음악(`higgsfield-audio`), 실제 촬영본과 합성은 `higgsfield-seedance-vfx`.
7. **검수** — Virality Predictor로 훅·이탈 구간 점검(`higgsfield-repurpose`), 실패 샷은 `higgsfield-troubleshoot`.

## 5. 크레딧 절약 규칙 (영상 1, 7)

- 생성 전에 항상 모델 스키마 확인(`models_explore`) → 비용 견적(`get_cost: true`) → 승인 후 제출.
- 룩은 이미지에서 확정하고, 영상은 확정된 키프레임에서만 돌립니다.
- 초안은 낮은 해상도·짧은 길이로, 확정 샷만 고해상도·업스케일.
- 같은 샷을 무작정 재생성하지 않습니다. 실패 원인을 진단하고 한 번에 한 변수만 바꿉니다.
- 카메라 동선·배치가 복잡한 샷은 Blender(3D Jutsu)로 블록아웃을 만든 뒤 video-to-video로 입힙니다.
- 실패와 해결책은 `higgsfield-recall` 메모리에 남겨 다음 프롬프트에 미리 반영합니다.

## 6. Claude에게 요청하는 예

- "9:16, 30초 배달 브랜드 광고. 샷리스트부터 만들고 샷별 크레딧 견적을 보여줘."
- "이 캐릭터 시트로 3씬짜리 숏드라마. 씬 엔진으로 구조 점검 후 Seedance 2.5 프롬프트로."
- "이 Blender 블록아웃 영상을 omni_reference로 시네마틱하게. 먼저 480p로 테스트."
