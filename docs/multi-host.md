# One look on Arch and Pop!_OS

Use one shared branch for the theme and application settings. Select a host profile once on each PC:

```bash
./bin/select-host pop   # work laptop
./bin/select-host arch  # Arch desktop
```

The selector writes `.local-host` and `i3/host.conf`. Both are ignored by Git. The tracked files under `hosts/` define the display layout, i3 workspace outputs, and preferred Polybar monitor for each PC. If a monitor name changes, edit that host's profile without changing the shared i3 or Polybar layout.

For a new checkout, preview the links with `./install_script.sh --dry-run pop` (or `arch`), then run the command without `--dry-run`. The installer refuses to replace regular files or directories; move those aside deliberately first. On a machine already linked to this repo, `bin/select-host` is enough.

While `sync/shared-look` is being tested, use that branch on both computers. On the Arch PC, an existing checkout with local changes can stay untouched:

```bash
git clone --branch sync/shared-look git@github.com:Eric-the-Geric/dotfiles.git ~/dotfiles-sync
cd ~/dotfiles-sync
./install_script.sh --dry-run arch
./install_script.sh arch
nvim --headless '+Lazy! restore' +qa
```

On the Pop PC, the shared checkout is `~/dotfiles-sync` and the Pop profile is already selected. To receive a committed shared change on either computer, run `git pull --ff-only` from that computer's `~/dotfiles-sync`. After changing shared files, commit and push from the same checkout. Reload i3 with `i3-msg reload` when you want the current desktop session to pick up i3 changes. Keep commands needed only by one computer in `~/.local/bin`; the installer makes `~/bin` point to the shared repository.

The shared palette lives in `i3/config`, `alacritty/colourme.toml`, and `polybar/config.ini`. The existing `colourme` command updates those files from the wallpaper. When i3 restarts, `polybar/launch.sh` derives Rofi's colors from the Polybar palette. Commit the changed shared theme files when you want the other PC to adopt that look.

Polybar uses the shared `config.ini` directly on 3.7 and newer. On older versions, `render-legacy.py` converts the same layout into a temporary config with the older text and tray settings. The Pop profile supplies its Wi-Fi interface; Ethernet is omitted when no interface is configured. The two machines therefore share the layout and colors while using the features their installed Polybar versions support.

Neovim chooses the Treesitter `master` setup on versions before 0.12 and the `main` setup on 0.12 and newer. Each has its own tracked Lazy lockfile (`lazy-lock-nvim11.json` and `lazy-lock.json`). The `main` setup also needs a working `tree-sitter` CLI. Keep other machine-only shell settings and API keys in `~/.config/dotfiles/local.bash`, which `.bashrc` sources and Git never tracks.

Keep local work committed or safely set aside before pulling. The host selection survives pulls because its files are ignored. Use the same branch on both PCs; the profiles hold the machine differences.
