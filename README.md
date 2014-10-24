# Rebuild

Development environment rebuild toolkit

## What's this?

In clean-installed OSX, git is unavailable but ruby and gem are available.
Thus this gem provides a way to fetch GitHub repository archive and execute scripts in it.

## Usage

```bash
$ sudo gem install rebuild
$ rebuild k0kubun/dotfiles
```

The archive of [repository](https://github.com/k0kubun/dotfiles) is unzipped to `/tmp/dotfiles-master`.
Then executes all of `/tmp/dotfiles-master/rebuild/*.sh`.

### Resolve dependency

```bash
rebuild k0kubun/dotfiles <<-EOS
  command_line_tools.sh
  brew.sh
EOS
```

## License

MIT License
