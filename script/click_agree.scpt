#!/usr/bin/env osascript

-- Second: Click Agree Button
tell application "System Events"
  set installer to "Install Command Line Developer Tools"
  click UI Element "Agree" of window 1 of installer
end tell
