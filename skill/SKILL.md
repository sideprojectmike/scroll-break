---
name: scroll-break
description: Control the scroll-break add-on that opens TikTok, Instagram Reels or YouTube Shorts while Claude works and closes it when Claude finishes. Use when the user says /scroll-break, or asks to switch platform, change the delay, turn it on/off, or log in.
---

# scroll-break

The add-on lives in `~/.claude/scroll-break/`. Hooks in `~/.claude/settings.json` run
`open.sh` on every prompt and `close.sh` when Claude stops or needs the user's attention.
All settings are in `~/.claude/scroll-break/config`.

Handle the user's request by editing that config file (keep its other lines unchanged):

- **Switch platform** ("tiktok", "reels", "shorts") → set `PLATFORM=`.
- **Off / on** → set `ENABLED=0` or `ENABLED=1`.
- **Delay** ("only open after 30s") → set `DELAY=` in seconds.
- **Browser** → set `BROWSER=` to the macOS app name of a Chromium browser.
- **Log in** → run `bash ~/.claude/scroll-break/open.sh --now`. The window uses its own
  browser profile, so the user signs in once there and stays signed in. Tell them to
  close it when done (or run `close.sh`).
- **Status** (no argument) → read the config and report platform, delay and on/off.

Changes take effect on the next prompt; no restart needed. Reply in one or two lines.
