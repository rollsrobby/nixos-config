{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = "options mt7921e disable_aspm=1";

  zramSwap = {
    enable = true;
    memoryMax = 10 * 1024 * 1024 * 1024;
  };

  time.timeZone = "Europe/Zurich";

  networking.hostName = "rms-fw";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;


  # environment.systemPackages = with pkgs; [
  #   networkmanager
  #   ghostty
  #   foot
  #   rofi
  #   gcc
  # ];

#  services.xserver.enable = true;

  # AMD-specific (from nixos-hardware, but explicit if needed)
  services.power-profiles-daemon.enable = true;

  # Battery monitoring
  services.upower.enable = true;
  systemd.services.upower.wantedBy = [ "multi-user.target" ];

  # Firmware updates
  services.fwupd.enable = true;

  # nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;

  environment.variables = {
    XCURSOR_THEME = "Banana";
    XCURSOR_SIZE = "32";
  };

  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
    polkit-1.fprintAuth = true;
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  services.kanata = {
    enable = true;
    keyboards.default = {
      devices = ["/dev/input/event1"];
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc caps)

        (deflayermap (default-layer)
         ;; tap caps lock as esc, hold caps lock as left control
         ;; 0 = no quick-tap (like QMK QUICK_TAP_TERM 0)
         ;; 200 = hold timeout (like QMK TAPPING_TERM 200)
         ;; tap-hold-press = hold on other key press (like QMK HOLD_ON_OTHER_KEY_PRESS)
         caps (tap-hold-press 0 200 esc lctl))
      '';
    };
  };

   users.users.rms = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [
       "wheel"
       "networkmanager"
       "bluetooth"
       "video"
     ];
   };

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.zsh.enable = true;
  programs.mango.enable = true;
  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;
    };

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    greeter = {
      enable = true;
      compositor.name = "niri";
    };
  };
}
