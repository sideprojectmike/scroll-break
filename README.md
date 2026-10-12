# scroll-break

Opens TikTok / Reels / Shorts in a small window while Claude Code works,
and closes it the instant Claude finishes (or stops to ask you something).

## Install (macOS, needs Chrome or another Chromium browser)
    bash install.sh
    bash ~/.claude/scroll-break/open.sh --now   # log in once, then close it

## Use
Just use Claude Code. If a task runs longer than 5s, the window pops up;
when Claude is done, it's gone.

In Claude Code:
- `/scroll-break reels` (or tiktok / shorts) to switch
- `/scroll-break off` / `on`
- `/scroll-break delay 30`

## How it works
- UserPromptSubmit hook → open.sh waits DELAY seconds, opens the window if Claude is still busy
- Stop + Notification hooks → close.sh kills that window
- The window runs in its own browser profile, so it never touches your normal Chrome tabs

## Uninstall
Remove the three scroll-break entries from ~/.claude/settings.json (or restore
settings.json.bak) and delete ~/.claude/scroll-break and ~/.claude/skills/scroll-break.
