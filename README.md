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
├── install_scripts/
│   ├── check_homebrew.sh
│   ├── install_packages.sh
│   ├── setup_config.sh
│   ├── setup_permissions.sh
│   └── start_aerospace.sh
│
└── .config/
    ├── aerospace/
    │   ├── aerospace.toml
    │   ├── vscode-workspace.log
    │   └── scripts/
    │       └── vscode-workspace.sh
    │
    └── other-configs/
```

---

# What Each File Does

## Root Scripts

| File | Purpose |
|---|---|
| `install.sh` | Main installer entry point |
| `install_scripts/check_homebrew.sh` | Verifies Homebrew installation |
| `install_scripts/install_packages.sh` | Installs AeroSpace + Borders |
| `install_scripts/setup_config.sh` | Handles symlink/copy setup |
| `install_scripts/setup_permissions.sh` | Makes scripts executable |
| `install_scripts/start_aerospace.sh` | Starts AeroSpace after setup |

---

## AeroSpace Config Files

| File | Purpose |
|---|---|
| `.config/aerospace/aerospace.toml` | Main AeroSpace configuration |
| `.config/aerospace/scripts/vscode-workspace.sh` | VSCode workspace helper script |
| `.config/aerospace/vscode-workspace.log` | Debug logs for VSCode script |

---

# Setup Methods

You can configure this setup in two ways:

1. Automatic setup using `install.sh`
2. Manual setup using symlinks

---

# Method 1 — Automatic Setup (Recommended)

Run:

```bash
chmod +x install.sh
./install.sh
```

The installer will:

- Install AeroSpace
- Install Borders
- Create `~/.config`
- Setup symlinks OR copy configs
- Make scripts executable
- Optionally start AeroSpace

---

# Symlink vs Copy Mode

During installation you can choose:

## 1) Symlink Mode (Recommended)

Creates symlinks for everything inside:

```text
dotfiles/.config/
```

This means:

```text
~/.config/aerospace
```

points directly to:

```text
dotfiles/.config/aerospace
```

Benefits:

- Changes sync instantly
- Easy GitHub workflow
- Future files automatically work
- Best for dotfiles management

---

## 2) Copy Mode

Copies all config files into:

```text
~/.config
```

Benefits:

- Independent configs
- Safer for experimentation
- Repo and system configs separated

Drawback:

- Future repo changes do NOT sync automatically

---

# Method 2 — Manual Setup

Create config directory:

```bash
mkdir -p ~/.config
```

Remove old config (optional):

```bash
rm -rf ~/.config/aerospace
```

Create symlink:

```bash
ln -s \
<path_to_repo>/dotfiles/.config/aerospace \
~/.config/aerospace
```

Example:

```bash
ln -s \
~/Projects/dotfiles/.config/aerospace \
~/.config/aerospace
```

---

# Important Symlink Notes

Symlinks DO NOT duplicate files.

Both paths point to the SAME location.

Example:

```text
~/.config/aerospace
```

and

```text
~/Projects/dotfiles/.config/aerospace
```

are literally the same folder.

---

# Symlink Consequences

## Editing either path edits both

Editing:

```text
~/.config/aerospace/aerospace.toml
```

also edits:

```text
~/Projects/dotfiles/.config/aerospace/aerospace.toml
```

---

## Deleting repo files breaks the symlink

If you delete:

```bash
rm -rf ~/Projects/dotfiles/.config/aerospace
```

then:

```text
~/.config/aerospace
```

becomes broken.

---

## Deleting symlink DOES NOT delete repo

If you delete:

```bash
rm -rf ~/.config/aerospace
```

only the symlink is removed.

The original repo files remain safe.

---

# Reload AeroSpace

Reload config manually:

```bash
aerospace reload-config
```

Or use the configured shortcut:

```text
alt + shift + ;
then press r
```

---

# Workspace Layout

## Main Monitor

- 1
- 2
- 3
- 4
- 5

## Secondary Monitor

- 6
- 7
- 8
- 9
- V
- P

If the secondary monitor disconnects,
workspaces automatically move back to the main monitor.

---

# Key Features

- Dynamic workspace monitor assignment
- Vim-style navigation
- Automatic app routing
- Borders integration
- Multi-monitor aware layout
- Tiling + accordion layouts
- Workspace switching
- Floating window support
- Service mode utilities
- VSCode workspace helper scripts

---

# VSCode Workspace Helper

A custom service mode command exists for handling multiple VSCode windows.

Service mode shortcut:

```text
alt + shift + ;
```

Then press:

```text
v
```

Behavior:

- Detects multiple VSCode windows
- Moves the focused VSCode window to workspace `B`
- Keeps primary VSCode window in workspace `V`

Logs are written to:

```text
~/.config/aerospace/vscode-workspace.log
```

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
| Docker Desktop | D |

---

# Executable Permission Setup

The installer automatically detects executable files inside:

```text
.config/
```

Supported file types:

- `.sh`
- `.py`

The installer:

1. Shows all executable candidates
2. Asks for confirmation
3. Applies executable permissions

---

# Current Technologies

- AeroSpace
- Borders
- Warp
- Visual Studio Code
- PyCharm

---

# Future Plans

- Borders theme configs
- Neovim setup
- tmux setup
- zsh setup
- Ghostty terminal configs
- SketchyBar configs
- Shared install profiles
- Auto monitor profiles
- Dynamic workspace balancing