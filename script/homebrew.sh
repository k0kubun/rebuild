#!/usr/bin/env bash

install_url=https://raw.githubusercontent.com/Homebrew/install/master/install
temp_script=/tmp/brew_installer
curl -fsSL $install_url > $temp_script

expect -c '
set timeout -1
spawn ruby /tmp/brew_installer

expect {
  "Press RETURN to continue or any other key to abort"
  {
    send "\r"
    exp_continue
  }
}
'

rm $temp_script
