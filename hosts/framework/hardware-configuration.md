# Disko
Runt this after disko mounds everything to `/mnt`:
```bash
# After disko has mounted to /mnt
nixos-generate-config --no-filesystems --root /mnt
```

Copy to repo:
```bash
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/rms/nixos-config/hosts/framework/
```
