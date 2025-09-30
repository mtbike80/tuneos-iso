# TuneOS Build Guide: `/etc/skel/`

## Purpose

The `/etc/skel/` directory is a **skeleton home directory**. When a new user account is created, the contents of `/etc/skel/` are copied into that user’s home directory.

In a *live-build* project, you can customize `/etc/skel/` by placing files under:

```
config/includes.chroot/etc/skel/
```

This allows you to define the **default user environment** for TuneOS — shell behavior, desktop configuration, and application preferences.

---

## How It Works

1. User `adduser newuser` is run during installation.  
2. The system copies all files from `/etc/skel/` into `/home/newuser/`.  
3. The user can then modify these files, but your defaults are applied at first login.  

This ensures that every new TuneOS installation provides the same initial experience.

---

## Common Uses in TuneOS

### 1. **Bash and Shell Defaults**
- `.bashrc` → Sets the command prompt, aliases, colors, and functions.  
- `.profile` → Defines environment variables, sets PATH, and loads `.bashrc` for login shells.

Example `.bashrc`:
```bash
# TuneOS bash defaults
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Color prompt
export PS1="\[\e[32m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[m\]\$ "
```

---

### 2. **KDE Plasma Defaults**
- `.config/plasma/` → Plasma desktop settings.  
  - `kdeglobals` → Global color scheme, icon theme.  
  - `plasmarc` → Plasma theme.  
  - `plasma-org.kde.plasma.desktop-appletsrc` → Panel layout, widgets, wallpapers.

Example `kdeglobals`:
```ini
[General]
ColorScheme=Oxygen
IconTheme=Breeze
```

By exporting KDE settings from a configured session and placing them here, you ensure every new TuneOS user starts with the same branded KDE desktop.

---

### 3. **Other Defaults**
You can add other configuration files here as well:
- `.vimrc` → Default Vim settings.  
- `.nanorc` → Nano editor defaults.  
- `.gitconfig` → Git defaults.  

Anything you add to `/etc/skel/` becomes part of every user’s environment.

---

## Example Directory Layout

```
config/includes.chroot/etc/skel/
├── .bashrc
├── .profile
└── .config/
    └── plasma/
        ├── kdeglobals
        ├── plasmarc
        └── plasma-org.kde.plasma.desktop-appletsrc
```

---

## Best Practices

1. **Keep it minimal** – Only add files that truly improve the out-of-box experience.  
2. **Comment configs** – Make `.bashrc` and other files self-explanatory for users.  
3. **Match branding** – Ensure KDE defaults align with TuneOS wallpapers, icons, and colors.  
4. **Test defaults** – Install TuneOS in a VM, create a new user, and confirm defaults apply correctly.  

---

## Summary

- `/etc/skel/` defines the **default home directory** for all new users.  
- Place files in `config/includes.chroot/etc/skel/` to customize TuneOS.  
- Use it for bash prompts, aliases, environment variables, KDE Plasma defaults, and other configs.  
- This folder is key to giving TuneOS its **out-of-the-box identity** for end users.
