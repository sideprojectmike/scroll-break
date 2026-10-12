#!/bin/bash
# Fired by the Stop and Notification hooks. Closes the window immediately.
DIR="$HOME/.claude/scroll-break"
cat >/dev/null 2>&1
rm -f "$DIR/.pending"
pkill -f "user-data-dir=$DIR/browser-profile" 2>/dev/null
exit 0
