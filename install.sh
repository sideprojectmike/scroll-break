#!/bin/bash
# Installs scroll-break for Claude Code (macOS).
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DIR="$HOME/.claude/scroll-break"
mkdir -p "$DIR" "$HOME/.claude/skills/scroll-break"
cp "$SRC/open.sh" "$SRC/close.sh" "$DIR/"
[ -f "$DIR/config" ] || cp "$SRC/config" "$DIR/"
chmod +x "$DIR/open.sh" "$DIR/close.sh"
cp "$SRC/skill/SKILL.md" "$HOME/.claude/skills/scroll-break/SKILL.md"

SETTINGS="$HOME/.claude/settings.json"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"
cp "$SETTINGS" "$SETTINGS.bak"

python3 - "$SETTINGS" <<'PY'
import json, sys
path = sys.argv[1]
s = json.load(open(path))
hooks = s.setdefault("hooks", {})
def add(event, script):
    cmd = f'bash "$HOME/.claude/scroll-break/{script}"'
    groups = hooks.setdefault(event, [])
    if any(h.get("command") == cmd for g in groups for h in g.get("hooks", [])):
        return
    groups.append({"hooks": [{"type": "command", "command": cmd}]})
add("UserPromptSubmit", "open.sh")
add("Stop", "close.sh")
add("Notification", "close.sh")
json.dump(s, open(path, "w"), indent=2)
PY

echo "Installed. Backup of your old settings: $SETTINGS.bak"
echo "Next: run  bash ~/.claude/scroll-break/open.sh --now  and log in once."
