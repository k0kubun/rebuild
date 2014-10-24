#!/usr/bin/env osascript

-- Fist: Click Install Button
delay 2.0

set timeoutSeconds to 2.0
set uiScript to "click UI Element 4 of window 1 of application process \"Install Command Line Developer Tools\""
my doWithTimeout(uiScript, timeoutSeconds)

on doWithTimeout(uiScript, timeoutSeconds)
  set endDate to (current date) + timeoutSeconds
  repeat
    try
      run script "tell application \"System Events\"
" & uiScript & "
end tell"
      exit repeat
    on error errorMessage
      if ((current date) > endDate) then
        error "Can not " & uiScript
      end if
    end try
  end repeat
end doWithTimeout
