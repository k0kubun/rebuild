# Rebuild

Development environment bootstrap automation toolkit for OSX

![](http://pic.k0kubun.com/174syGrQYpdTo0N.gif)

## What's this?

`rebuild` allows you to achieve mouse-free command line tools installation in OSX Yosemite.  
And `rebuild` clones your GitHub repository and runs all of your bootstrap scripts.  
  
You can setup or synchronize your environment by just executing `rebuild <username>/<project>`

## Installation

```bash
$ gem install rebuild
```

## Usage

### Clean-installed bootstrap

```
# For example: rebuild k0kubun/dotfiles
$ rebuild [username]/[repository]
```

Just typing the command allows you to reproduce your development environment.

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

# Run /tmp/k0kubun/dotfiles/script/*.sh instead of /tmp/k0kubun/dotfiles/*.sh
$ rebuild -s script

# You can choose which script to run first by shell pipeline
echo "first.sh second.sh" | rebuild
rebuild <<-EOS
  first.sh
  second.sh
EOS
```

## Supported OS

- 10.10 Yosemite
- 10.9 Maverics

Prior to 10.8 Mountain Lion, features except command line tools installation are still supported.

## License

MIT License
