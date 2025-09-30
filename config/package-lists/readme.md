# config/package-lists/

## Purpose

The `config/package-lists/` directory in a Debian *live-build* project tells the build system **which packages to install into the ISO image and the final installed system**.

Every file in this directory with a `.list.chroot` extension is treated as a **list of Debian package names** to install inside the chroot environment (the filesystem that becomes the installed OS).

---

## File Types

- `*.list.chroot`  
  Packages installed into the **target system** (the ISO and installed OS).

- `*.list.binary`  
  (Advanced) Packages installed into the **binary image only**, not the chroot. Rarely needed.

For this distro, we'll only use `.list.chroot` files.

---

## Syntax

- Each line = one package name (exactly as it appears in `apt`).  
- Empty lines are ignored.  
- `#` starts a comment.  

Example (`tuneos.list.chroot`):

```text
## Kernel and modules
linux-image-rt-amd64
linux-headers-rt-amd64

## Miscellaneous - Graphical
papirus-icon-theme

## Multimedia
audacity
pavucontrol
tuxguitar
```

---

## Organization

You can create multiple `.list.chroot` files if you want to group packages by category. For example:

- `desktop.list.chroot` → KDE, utilities.  
- `audio.list.chroot` → Ardour, JACK, plugins.  
- `distroname.list.chroot` → custom packages (`distroname-artwork`, `distroname-defaults`).  

Live-build automatically merges all `.list.chroot` files when building the ISO.

---

## When to Use Package Lists vs. Hooks

- Use **package lists** for software that exists in APT repos (Debian’s or yours).  
- Use **hooks** only if something special must happen during build (e.g., running a command).  

---

## Best Practices

1. Keep related packages grouped together with comments.  
2. Only list packages by their **official names** (as in `apt show packagename`).  
3. Prefer putting your custom `.deb` files into an APT repo, then list them here — instead of committing `.deb` binaries.  
4. Document your choices with comments, so others know why a package is included.  

---

## Summary

- `config/package-lists/` = your **default software selection**.  
- `.list.chroot` = packages that end up in the installed system.  
- Use comments to explain your choices.  
- Split into multiple files if you want modularity.  

This folder defines *what* gets installed. Other folders (like `includes.chroot/`) define *how it’s configured*.
