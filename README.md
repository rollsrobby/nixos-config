# NixOS Configuration

## Overview

This repository contains the NixOS configuration for a Framework 13 laptop, managed using Nix, Flakes, and Home Manager.

## Features

- NixOS configuration for Framework 13 (7040 AMD model)
- Uses Flakes for dependency management
- Integrated Home Manager configuration
- Disko configuration for disk partitioning

## Dependencies

- [Nix](https://nixos.org/)
- [NixOS Unstable](https://github.com/NixOS/nixpkgs/tree/nixos-unstable)
- [Disko](https://github.com/nix-community/disko)
- [Home Manager](https://github.com/nix-community/home-manager)
- [NixOS Hardware](https://github.com/NixOS/nixos-hardware)

## Structure

- `hosts/framework/`: Host-specific configurations
  - `configuration.nix`: Main NixOS system configuration
  - `disko-config.nix`: Disk partitioning configuration
  - `hardware-configuration.md`: Hardware-specific notes
- `home/`: User-specific configurations
  - `modules/`: Reusable home configuration modules
  - `rms.nix`: Home Manager configuration for user 'rms'
- `flake.nix`: Flake configuration defining inputs and system configuration

## Installation

1. Connect to the Internet
    ```
    nmutil
    ```
2. Partition Disk
    ```
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
      --mode destroy,format,mount \
      --flake github:rollsrobby/nix-config#framework
3. Install nixos
    ```
    sudo nixos-install --flake github:rollsrobby/nixos-config#framework
    ```
2. Clone this repository
3. Build the system configuration:
   ```
   sudo nixos-rebuild switch --flake .#framework
   ```

## Customization

Modify the configuration files in `hosts/framework/` and `home/` to suit your specific needs.

