# TuneOS Build Guide: `99-tuneos.conf`

## Purpose

The file `99-tuneos.conf` is a configuration file placed under:

```
/etc/security/limits.d/99-tuneos.conf
```

Its purpose is to grant members of the `audio` group the necessary privileges for **low-latency audio** and **software-defined radio (SDR)** applications. Without this file, normal users cannot use realtime scheduling or lock memory, which are essential for professional audio production and SDR performance.

---

## Contents

```text
@audio   -  rtprio     95
@audio   -  memlock    unlimited
```

### Explanation:

1. **`@audio   -  rtprio 95`**  
   - Allows any user in the `audio` group to run processes with **realtime scheduling priority** up to 95 (the Linux kernel allows 0–99).  
   - Realtime priority means audio threads can preempt nearly everything else, reducing the risk of audio dropouts (XRUNs).  

2. **`@audio   -  memlock unlimited`**  
   - Lets `audio` users lock memory into RAM so it cannot be swapped out to disk.  
   - Prevents audio buffers from being paged to disk, which would cause latency spikes or interruptions.  

---

## Why It Matters for TuneOS

- Debian and most general-purpose distros **do not grant realtime privileges to regular users by default**.  
- Professional audio applications (like JACK, Ardour, and LV2 plugins) and SDR software need these privileges for **stable, low-latency operation**.  
- By including this file, TuneOS ensures that joining the `audio` group is enough for a user to have a **ready-to-go realtime audio environment**.  

This file is one of the key differences that make TuneOS an **audio-focused distribution** instead of just a stock Debian system.

---

## Why `99-` in the filename?

Files in `/etc/security/limits.d/` are applied in lexical order. Using a high prefix like `99-` ensures this file is loaded **last**, overriding other defaults if necessary.

---

## Best Practices

- Only grant these privileges to the `audio` group, not all users.  
- Document for users that they should be a member of the `audio` group to benefit:  

```bash
sudo usermod -aG audio <username>
```

- Keep `rtprio` below 99 to leave headroom for kernel-level tasks.  
- Use `unlimited` for `memlock` to simplify configuration for most audio workflows.

---

## Summary

- **File:** `/etc/security/limits.d/99-tuneos.conf`  
- **Purpose:** Enable realtime scheduling and locked memory for `audio` group.  
- **Impact:** Eliminates audio glitches (XRUNs), improves SDR and DAW stability.  
- **Why 99?** Ensures it overrides other PAM limits.  

This small config is a cornerstone of TuneOS’s identity as a **realtime-ready audio/SDR distribution**.
