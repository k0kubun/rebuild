#!/usr/bin/env osascript

-- Fist: Click Install Button
delay 0.4
tell application "System Events"
  set installer to "Install Command Line Developer Tools"
  click UI Element "Install" of window 1 of installer
end tell
