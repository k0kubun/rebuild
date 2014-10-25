#!/usr/bin/env osascript

-- Magic script to enable GUI scripting.
-- Without this, click action will raise: "An error of type -10810 has occurred."

tell application "System Preferences"
  reveal anchor "keyboardTab" of pane "com.apple.preference.keyboard"
end tell

tell application "System Events" to tell process "System Preferences"
  -- This line somehow prevents GUI scripting error
  click checkbox 1 of tab group 1 of window 1
  click checkbox 1 of tab group 1 of window 1
end tell
