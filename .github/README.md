<div align="center">

<samp>

# dotfiles

**My personal dotfiles for OS X**

</samp>

</div>

## Usage

```
$ curl -fsSL https://raw.githubusercontent.com/ryuma017/dotfiles/main/install.sh | sh
```

[!WARNING]

This command overwrites these files in `$HOME` on your machine;

- `.zshenv`
- configuration files in `$XDG_CONFIG_HOME` that maintained by this repository (see [`.config/`](.config/) or [`Makefile`](Makefile) for details)

Back up these files before installation if you want to keep them.
