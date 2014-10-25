# Rebuild

Development environment bootstrap automation toolkit for OSX.

![](http://pic.k0kubun.com/EccWEeglRnobUo4.gif)

## What's this?

In clean-installed OSX, git is unavailable but gem is available.
Thus this gem provides a way to fetch GitHub repository archive and execute scripts in it.

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

## Supported OS

- 10.10 Yosemite
- 10.9 Marverics

Prior to 10.8 Mountain Lion, features except command line tools installation are still supported.

## TODO

- revision lock
- clone directory change option
- support script directory to put scripts

## License

MIT License
