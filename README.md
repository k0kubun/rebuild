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
rebuild <<-EOS
  command_line_tools.sh
  brew.sh
EOS
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rebuild/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
