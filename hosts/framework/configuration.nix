{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  zramSwap = {
    enable = true;
    memoryMax = 10 * 1024 * 1024 * 1024;
  };

  networking.hostName = "rms-fw";

  # AMD-specific (from nixos-hardware, but explicit if needed)
  services.power-profiles-daemon.enable = true;

  # Firmware updates
  services.fwupd.enable = true;

  users.users.rms = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  system.stateVersion = "25.05";
}
