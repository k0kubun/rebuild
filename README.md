# Rebuild

Development environment bootstrap automation toolkit for OSX

![](http://pic.k0kubun.com/EccWEeglRnobUo4.gif)

## What's this?

`rebuild` allows you to achieve mouse-free command line tools installation in OSX Yosemite.  
Then `rebuild` clones your GitHub repository and runs all of your bootstrap scripts.  
  
You can setup or synchronize your environment by just executing `rebuild <username>/<project>`

## Usage

### Full automated command line tools installation

```bash
$ sudo gem install rebuild
$ rebuild
```

You can install command line tools to clean-installed Yosemite only by typing `rebuild`.

### Environment Bootstrap

```bash
$ sudo gem install rebuild
$ rebuild k0kubun/dotfiles
```

After installing command line tools, the archive of [repository](https://github.com/k0kubun/dotfiles) is unzipped to `/tmp/k0kubun/dotfiles`.
Then executes all of `/tmp/k0kubun/dotfiles/*.sh`.

## Options

```bash
# By default, git pull is not executed.
# If you want to synchronize repository before running scripts, add -f.
$ rebuild -f

# Repository will be cloned to ~/src/github.com/k0kubun/dotfiles
$ rebuild -d ~/src/github.com/k0kubun/dotfiles

# Run /tmp/k0kubun/dotfiles/script/*.sh instead of /tmp/k0kubun/dotfiles/*.sh
$ rebuild -s script
```

## Supported OS

- 10.10 Yosemite
- 10.9 Maverics

Prior to 10.8 Mountain Lion, features except command line tools installation are still supported.

## TODO

- revision lock
- support script directory to put scripts
- more flexible upstream pull

## License

MIT License
