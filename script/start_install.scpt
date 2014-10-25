#!/usr/bin/env osascript

-- Fist: Click Install Button
set timeoutSeconds to 1.0

my doWithTimeout("click UI Element \"Install\" of window 1 of application process \"Install Command Line Developer Tools\"", timeoutSeconds)
my doWithTimeout("click UI Element \"Agree\" of window 1 of application process \"Install Command Line Developer Tools\"", timeoutSeconds)

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
        error errorMessage & "; Can not " & uiScript
      end if
    end try
  end repeat
end doWithTimeout
