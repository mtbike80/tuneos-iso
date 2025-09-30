# local-packages/

## Purpose

The `config/local-packages/` directory is used to include custom `.deb` packages directly in your distro's ISO image.  
This provides a way to test or distribute packages **BEFORE they are uploaded to the distro's apt repository**.

Any `.deb` files placed here will be available inside the ISO and installed during the system setup.

---

## How It Works

When `live-build` constructs the ISO, it automatically detects `.deb` files inside:

```
config/local-packages/
```

and places them in the build environment. These packages are then installed into the final system just like normal apt packages.

---

## Common Uses - IMPORTANT!!

1. **Development Testing**
   - If you build a new package (e.g. a custom Audacity build), you can drop the `.deb` file here.  
   - This allows you to test it in a TuneOS build without needing to sign or publish it to the repo.

2. **Private/Restricted Packages**
   - If you have packages that will never be public (e.g. proprietary drivers, internal utilities), this is a way to bundle them with the ISO.

3. **Bootstrapping**
   - Before your TuneOS repository is fully set up, `local-packages/` is a quick way to get custom packages onto systems during early builds.

---

## Example

```
config/local-packages/
└── audacity_3.7.5-1_amd64.deb
```

Result:  
- The installer ISO will contain your custom `audacity` package.  
- On installation, Audacity will be available out of the box.

---

## Best Practices

1. **Keep It Minimal**  
   - Don’t overload this directory with lots of `.deb` files. It will bloat your ISO.

2. **Transition to the Repo**  
   - Once your distro's apt repository is set up, move packages there and install them via `package-lists/` instead.  
   - This ensures users get **updates** and not just a one-time installation from the ISO.

3. **Document Contents**  
   - If you add packages here, explain why in a README.  
   - Example: “Audacity is included here temporarily until it is pushed to the TuneOS repo.”

---

## Summary

- **Folder:** `config/local-packages/`  
- **Purpose:** Bundle `.deb` packages directly into the ISO.  
- **Best Use:** For development builds, private packages, or bootstrapping.  
- **Long-Term Strategy:** Migrate packages to the TuneOS apt repo and install them through `package-lists/`.

This folder is mainly a **temporary staging area** for packages that aren’t yet available through your repository.
