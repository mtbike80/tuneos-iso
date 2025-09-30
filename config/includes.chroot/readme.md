# config/includes.chroot/

## Purpose

The `config/includes.chroot/` directory in a Debian *live-build* project lets you place files that will be **copied directly into the target system** (the filesystem inside the ISO and the installed OS).

This is the  **default configuration and branding layer**. Anything you put here shows up in the final TuneOS installation exactly where you place it.

---

## How It Works

During the build, `live-build` takes the contents of `config/includes.chroot/` and merges them into the root of the chroot environment. When the ISO installs, these files end up in the user’s system.

Example:
- `config/includes.chroot/etc/skel/.bashrc` → becomes `/etc/skel/.bashrc` in the installed system.

---

## Common Uses

### 1. **APT Repo Configuration**
- `etc/apt/sources.list.d/tuneos.list` → Adds your repo into to the system.
- `usr/share/keyrings/tuneos.gpg` → Public GPG key so apt trusts your repo.

This ensures that TuneOS systems can install updates and new packages from your signed repo.

---

### 2. **Default User Environment (`/etc/skel/`)**
The `/etc/skel/` directory is used as a template for new user accounts. Anything you place here will appear in **every new user’s home directory**.

Examples:
- `.bashrc` → Define prompt, aliases (`ll`, `la`, `l`), colors.
- `.profile` → Environment variables and login shell configuration.
- `.config/plasma/` → KDE Plasma defaults (themes, icons, panel layout, wallpaper).

This is how you give users a **branded desktop experience** out of the box.

---

### 3. **System-Wide Defaults**
- `etc/security/limits.d/99-mydistroname.conf` → Since the distro is geared towards audio production, put realtime/audio priority tweaks for audio and latency-sensitive applications here.
- `usr/share/backgrounds/` → Default wallpapers.
- `usr/share/plymouth/themes/` → Boot splash branding.
- `usr/share/grub/themes/` → GRUB bootloader artwork.

These affect all users and system components, not just new ones.

---

## Example Structure

```
config/includes.chroot/
├── etc/
│   ├── apt/sources.list.d/tuneos.list
│   ├── skel/
│   │   ├── .bashrc
│   │   ├── .profile
│   │   └── .config/plasma/
│   │       ├── kdeglobals
│   │       ├── plasmarc
│   │       └── plasma-org.kde.plasma.desktop-appletsrc
│   └── security/limits.d/99-tuneos.conf
├── usr/
│   └── share/
│       ├── keyrings/tuneos.gpg
│       ├── backgrounds/tuneos-wallpaper.png
│       ├── plymouth/themes/tuneos/
│       └── grub/themes/tuneos/
```

---

## Best Practices

1. **Keep configs clean** – Avoid clutter; only include files you actually want to override.  
2. **Use `/etc/skel/`** – This ensures new users inherit your KDE, bash, and other defaults automatically.  
3. **System tweaks in proper locations** – Place realtime and security configs under `/etc/security/limits.d/`.  
4. **Branding** – Wallpapers, GRUB, and Plymouth artwork should be packaged in `tuneos-artwork`, but you can also test them here first.  
5. **Document everything** – Comment your configs and explain *why* a setting is included, so others can learn from your build.  

---

## Summary

- `config/includes.chroot/` is how you add your distro's **identity and defaults**.  
- `/etc/skel/` → KDE + bash user defaults.  
- `/etc/security/limits.d/` → System tweaks.  
- `/usr/share/...` → Artwork and branding.  
- `etc/apt/...` and `usr/share/keyrings/...` → repo and key setup.  

Together with `config/package-lists/`, this folder defines how your distro looks and feels once installed.
