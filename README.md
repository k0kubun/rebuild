# Rebuild

Development environment bootstrap automator

## What's this?

In clean-installed OSX, git is unavailable but gem is available.
Thus this gem provides a way to fetch GitHub repository archive and execute scripts in it.

## Usage

```bash
$ sudo gem install rebuild
$ rebuild k0kubun/dotfiles
```

The archive of [repository](https://github.com/k0kubun/dotfiles) is unzipped to `/tmp/dotfiles`.
Then executes all of `/tmp/dotfiles/*.sh`.

## License

MIT License
