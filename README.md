# Rebuild

Development environment bootstrap automation toolkit for OSX

![](http://i.gyazo.com/b4e7f4482c96d180d6c09100e8f89ff8.gif)

## What's this?

`rebuild` allows you to achieve mouse-free command line tools installation in OSX Yosemite.  
And `rebuild` clones your GitHub repository and runs all of your bootstrap scripts.  
  
You can setup or synchronize your environment by executing `rebuild [username]/[repository]`.

## Installation

```bash
$ gem install rebuild
```

## Usage

### Clean-installed bootstrap

```bash
# For example: rebuild k0kubun/dotfiles
$ rebuild [username]/[repository]
```

**No need to touch your mouse.** Rebuild will click buttons for you in command line tools installation.
Just typing the command allows you to reproduce your development environment.

Your repository will be available at `~/[repository]`.

### Sync multiple environments

```bash
# force update repository by `-f`
$ rebuild -f k0kubun/dotfiles
```

If you manage your development environment on GitHub repository,
you can use this gem to synchronize multiple environments.

## Options

```bash
# By default, git pull is not executed.
# If you want to synchronize repository before running scripts, add -f.
$ rebuild -f

# Repository will be cloned to ~/src/github.com/k0kubun/dotfiles
$ rebuild -d ~/src/github.com/k0kubun/dotfiles

# Run ~/dotfiles/script/*.sh instead of ~/dotfiles/*.sh
$ rebuild -s script

# You can choose which script to run first by shell pipeline
rebuild <<-EOS
  first.sh
  second.sh
EOS
```

## Config

![](http://i.gyazo.com/cfd38dfcd8384116dac9677ae638bd56.gif)

You can skip choosing option by ~/.gitconfig

```conf
# ~/.gitconfig
# You can append config template by `rebuild config`

[rebuild]
  # if true, everytime git pull
  update = false

  # you can change script run directory
  scriptdir = script

  # if present, you can `rebuild` without argument
  repo = k0kubun/dotfiles

  # cloned directory path
  directory = ~/src/github.com/k0kubun/dotfiles

  # selected scripts are executed primarily in this order
  dependency = brew.sh ruby.sh
```

## Supported OS

- 10.10 Yosemite
- 10.9 Maverics

Prior to 10.8 Mountain Lion, features except command line tools installation are still supported.

## License

MIT License
