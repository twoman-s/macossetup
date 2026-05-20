# Mac Tiling Window Manager Dotfiles

Personal macOS tiling window manager setup using:

- AeroSpace
- Borders

---

# Requirements

Install the following manually before setup:

- Homebrew


## Homebrew

https://brew.sh

---


# Folder Structure

```text
dotfiles/
├── install.sh
└── .config/
    └── aerospace/
        └── aerospace.toml
```

---

# Setup Methods

You can configure this setup in two ways:

1. Automatic setup using `install.sh`
2. Manual setup using symlinks

---

# Method 1 — Automatic Setup (Recommended)

Run the installer:

```bash
chmod +x install.sh
./install.sh
```

The installer will:

- Install AeroSpace
- Install Borders
- Create required config directories
- Copy/symlink configs automatically

---

# Method 2 — Manual Setup

Create the AeroSpace config directory:

```bash
mkdir -p ~/.config/aerospace
```

Remove existing config file (if needed):

```bash
rm ~/.config/aerospace/aerospace.toml
```

Create symlink:

```bash
ln -s \
<path_where_your_repo_is>/dotfiles/.config/aerospace/aerospace.toml \
~/.config/aerospace/aerospace.toml
```

Example:

```bash
ln -s \
~/Projects/dotfiles/.config/aerospace/aerospace.toml \
~/.config/aerospace/aerospace.toml
```

---

# Why Use Symlinks?

Using a symlink keeps the actual configuration file inside the GitHub repository.

This means:

- Editing `~/.config/aerospace/aerospace.toml`
  automatically updates:

```text
<path_where_your_repo_is>/dotfiles/.config/aerospace/aerospace.toml
```

So you can:

```bash
git add .
git commit -m "Updated aerospace config"
git push
```

without manually copying files.

---

# Important Warning About Symlinks

The file is NOT duplicated.

Both paths point to the SAME file.

So:

```text
~/.config/aerospace/aerospace.toml
```

and

```text
<path_where_your_repo_is>/dotfiles/.config/aerospace/aerospace.toml
```

are literally the same file.

## Important Consequences

### Editing either file edits both

### Deleting the REAL repo file deletes the config

If you delete:

```bash
rm <path_where_your_repo_is>/dotfiles/.config/aerospace/aerospace.toml
```

the symlink becomes broken.

### Deleting the symlink DOES NOT delete the repo file

If you delete:

```bash
rm ~/.config/aerospace/aerospace.toml
```

only the symlink is removed.

The actual repo file remains safe.

---

# Reload AeroSpace

```bash
aerospace reload-config
```

Or using the configured shortcut:

```text
alt + shift + ;
then press r
```

---

# Workspace Layout

Main monitor:

- 1
- 2
- 3
- 4
- 5

Secondary monitor:

- 6
- 7
- 8
- 9
- V
- P

If the secondary monitor is disconnected,
those workspaces automatically fall back to the main monitor.

---

# Features

- Dynamic workspace monitor assignment
- Vim-style navigation
- Automatic app-to-workspace routing
- Borders integration
- Multi-monitor aware setup
- Tiling + accordion layouts
- Fast workspace switching

---

# Applications Auto Assignment

| Application | Workspace |
|---|---|
| Browser | 1 |
| Warp | 2 |
| Notes | 2 |
| WhatsApp | 3 |
| Telegram | 3 |
| VSCode | V |
| PyCharm | P |

---

# Future Plans

- Borders configs
- Neovim setup
- tmux setup
- zsh setup
- Ghostty/Kitty terminal configs