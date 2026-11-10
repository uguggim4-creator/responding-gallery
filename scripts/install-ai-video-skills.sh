#!/bin/bash
# Installs the AI video skills (Higgsfield) into ~/.claude/skills.
# Intended as a Claude Code cloud environment setup script, or to run once on a local machine.
# Idempotent: re-running updates the clones and keeps the links.
set -u
SRC="${AI_VIDEO_SKILLS_DIR:-$HOME/.ai-video-skills}"
SK="$HOME/.claude/skills"
mkdir -p "$SRC" "$SK"

for r in higgsfield-ai/skills OSideMedia/higgsfield-ai-prompt-skill; do
  d="$SRC/${r#*/}"
  if [ -d "$d/.git" ]; then git -C "$d" pull -q --ff-only || true
  else git clone -q --depth 1 "https://github.com/$r.git" "$d" || true; fi
done

# Official execution skills: higgsfield-generate, higgsfield-soul-id, ...
for s in "$SRC"/skills/higgsfield-*/; do
  [ -f "$s/SKILL.md" ] && ln -sfn "${s%/}" "$SK/$(basename "$s")"
done
# Prompt-director skill, registered as "higgsfield"
[ -f "$SRC/higgsfield-ai-prompt-skill/SKILL.md" ] && ln -sfn "$SRC/higgsfield-ai-prompt-skill" "$SK/higgsfield"

# Global routing rule, added once
M="$HOME/.claude/CLAUDE.md"; touch "$M"
if ! grep -q 'AI-VIDEO-SKILLS' "$M"; then cat >> "$M" <<'MD'

<!-- AI-VIDEO-SKILLS -->
## AI 영상 제작 (Higgsfield + Seedance 2.5)
- AI 영상·이미지·광고·숏필름·숏드라마 요청이면 먼저 `higgsfield` 스킬(프롬프트 디렉터)을 연다.
- 생성은 Higgsfield MCP(`mcp__higgsfield__*`)가 있으면 MCP로, 없으면 `higgsfield-generate`(CLI)로.
- 제출 전: 모델 스키마 확인 → 크레딧 견적(get_cost) → 사용자 승인. 룩은 이미지로 먼저 확정.
- 상세: 작업 저장소에 `docs/ai-video/GUIDE.md`가 있으면 따른다.
MD
fi
echo "AI video skills installed in $SK"
