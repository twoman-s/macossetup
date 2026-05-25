# Mac Tiling Window Manager Dotfiles

Personal macOS setup using:

- AeroSpace
- Borders
- gh-dash
- delta

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
│   ├── aerospace/
│   │   └── install.sh
│   └── gh-dash/
│       └── install.sh
│
└── .config/
    ├── aerospace/
    │   ├── aerospace.toml
    │   ├── vscode-workspace.log
    │   └── scripts/
    │       └── vscode-workspace.sh
    │
    └── gh-dash/
        └── config.yml
```

---

# What Each File Does

## Installer Scripts

| File | Purpose |
|---|---|
| `install.sh` | Main entry point — discovers configs and prompts for selection |
| `install_scripts/check_homebrew.sh` | Verifies Homebrew is installed |
| `install_scripts/aerospace/install.sh` | Installs AeroSpace + Borders, sets up config, starts app |
| `install_scripts/gh-dash/install.sh` | Installs gh + delta + gh-dash, handles GitHub auth, sets up config |

---

## AeroSpace Config Files

| File | Purpose |
|---|---|
| `.config/aerospace/aerospace.toml` | Main AeroSpace configuration |
| `.config/aerospace/scripts/vscode-workspace.sh` | VSCode workspace helper script |
| `.config/aerospace/vscode-workspace.log` | Debug logs for VSCode script |

---

## gh-dash Config Files

| File | Purpose |
|---|---|
| `.config/gh-dash/config.yml` | gh-dash dashboard configuration |

---

# Setup

Run:

```bash
chmod +x install.sh
./install.sh
```

The installer will:

1. Check that Homebrew is installed
2. Scan the `.config/` folder and list all available configurations
3. Prompt you to select which ones to install
4. Run only the selected installers

---

# Adding a New Configuration

The installer is fully dynamic — it reads the `.config/` folder at runtime.

To add a new configuration:

1. Create `.config/<name>/` with your config files
2. Create `install_scripts/<name>/install.sh` with the install logic

It will automatically appear as an option next time you run `install.sh`.

---

# Configurations

## AeroSpace

Installs:

- [AeroSpace](https://github.com/nikitabobko/AeroSpace) — tiling window manager
- [Borders](https://github.com/FelixKratz/JankyBorders) — window border highlight

After installation, optionally starts AeroSpace immediately.

---

## gh-dash

Installs:

- [gh](https://cli.github.com) — GitHub CLI
- [delta](https://github.com/dandavison/delta) — syntax-highlighting pager for git diffs
- [gh-dash](https://github.com/dlvhdr/gh-dash) — terminal GitHub dashboard

Prompts for `gh auth login` during setup.

> **Note:** After installation, also run manually:
> ```bash
> gh extension install dlvhdr/gh-dash
> ```

---

# Symlink vs Copy Mode

During each configuration install you can choose:

## 1) Symlink Mode (Recommended)

Creates a symlink pointing `~/.config/<name>` directly to the repo:

```text
~/.config/aerospace  →  dotfiles/.config/aerospace
~/.config/gh-dash    →  dotfiles/.config/gh-dash
```

Benefits:

- Changes in the repo reflect immediately
- Easy to manage via Git
- Best for dotfiles management

---

## 2) Copy Mode

Copies config files into `~/.config/<name>`.

Benefits:

- Independent from the repo
- Safer for experimentation

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