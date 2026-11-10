# responding-gallery

AI 영상 컷(이미지 버전) 비교 갤러리. `index.html` + `images/`.

## AI 영상 제작 규칙

이 저장소의 작업은 Higgsfield(Seedance 2.5) 기반 AI 영상 제작입니다. 전체 가이드: `docs/ai-video/GUIDE.md`.

- 영상·이미지·광고·숏필름·숏드라마 요청이면 `higgsfield` 스킬(프롬프트 디렉터)을 먼저 엽니다.
  스킬이 설치되어 있지 않으면 `scripts/install-ai-video-skills.sh`로 설치하자고 사용자에게 제안합니다.
- 실제 생성은 Higgsfield MCP(`mcp__higgsfield__*`)로 합니다. MCP가 없을 때만 `higgsfield-generate`(CLI).
- 생성 제출 전에 반드시: 모델 스키마 확인(`models_explore`) → 크레딧 견적(`get_cost: true`) → 사용자 승인.
- 룩은 키프레임 이미지로 먼저 확정하고, 영상은 확정된 이미지에서만 생성합니다. 초안은 저해상도·짧게.
- 작업별 하위 스킬:
  - 기획·캐릭터: `higgsfield-character-design`, `higgsfield-scene-engine`
  - 샷리스트: `higgsfield-shotlist-director`
  - Seedance 2.5 프롬프트: `higgsfield-seedance-2-5` (연기: `higgsfield-acting`)
  - 광고: `higgsfield-marketing-studio`
  - Blender / 3D 블록아웃: `higgsfield-3d`
  - 실사 합성 VFX: `higgsfield-seedance-vfx`
  - 실패 진단: `higgsfield-troubleshoot`, 바이럴 점검: `higgsfield-repurpose`
- 새 컷 결과물은 `images/`에 추가하고 `index.html` 갤러리에 버전으로 등록합니다.
