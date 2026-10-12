#!/bin/bash
# Fired by the UserPromptSubmit hook. Opens a short-form video window
# if Claude is still working after $DELAY seconds.
DIR="$HOME/.claude/scroll-break"
PROFILE="$DIR/browser-profile"
source "$DIR/config"
cat >/dev/null 2>&1   # drain hook JSON on stdin

case "$PLATFORM" in
  reels)  URL="https://www.instagram.com/reels/" ;;
  shorts) URL="https://www.youtube.com/shorts/" ;;
  *)      URL="https://www.tiktok.com/foryou" ;;
esac

launch() {
  pgrep -f "user-data-dir=$PROFILE" >/dev/null && return
  open -na "$BROWSER" --args --user-data-dir="$PROFILE" --app="$URL" \
    --window-size=430,880 --no-first-run --no-default-browser-check
}

# "open.sh --now" opens immediately (use it once to log in).
if [ "$1" = "--now" ]; then launch; exit 0; fi
[ "$ENABLED" = "1" ] || exit 0

token="$$-$RANDOM"
echo "$token" > "$DIR/.pending"
(
  sleep "$DELAY"
  # Only open if Claude hasn't finished (close.sh deletes .pending).
  [ "$(cat "$DIR/.pending" 2>/dev/null)" = "$token" ] && launch
) >/dev/null 2>&1 </dev/null &
disown
exit 0
