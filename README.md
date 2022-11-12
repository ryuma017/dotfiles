<div align="center">

<samp>

# dotfiles

**My personal dotfiles for OS X**

</samp>

</div>

## Usage

```
$ git clone https://github.com/ryuma017/dotfiles.git
$ cd dotfiles
$ make
```

**⚠️ Worning**

This `make` command overwrites these files in `$HOME` on your machine;

- `.zshenv`
- `.config/**` (check [`.config/`](.config/) in this repository)

and also run `brew bundle` in its process.
Back up these files before running `make` if you need.
