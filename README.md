# Just

Since there are numerous package managers for node now. And if you work with multiple projects on daily basis with various package managers for each of the projects, this short bash script might just help you.

#### TLDR;
Replaces `yarn` / `npm` / `pnpm` command with `just`

## How to set it up?

```bash
cd && git clone https://github.com/kunalpanchal/just.git .just && chmod +x ~/.just/just
# Preferably add this alias to your .bashrc/.zshrc
alias just="~/.just/just"
```

## How to use it?

- `just setup` or `just install-node-modules`
- `just run <any-custom-scripts-in-package-json>`
- `just add <package-name(s)>`
- `just remove/rm/uninstall/un <package-name(s)>`
- `just update/upgrade/up <package-name(s)>`
- `just outdated <package-name(s)>`
- `just list/ls`
- `just init/new`
- `just list-scripts`

## Other suggested alias

- `alias alexa="~/.just/just"`
- `alias please="~/.just/just"`

## known shortcomings

- The command only works from the root of the project but not within sub-directories.