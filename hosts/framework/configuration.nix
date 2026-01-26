{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  zramSwap = {
    enable = true;
    memoryMax = 10 * 1024 * 1024 * 1024;
  };

  time.timeZone = "Europe/Zurich";

  networking.hostName = "rms-fw";
  networking.networkmanager.enable = true;

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

  # Firmware updates
  services.fwupd.enable = true;

  # nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;

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
      config = ''
        (defsrc
         caps)

        (deflayermap (default-layer)
         ;; tap caps lock as caps lock, hold caps lock as left control
         caps (tap-hold 150 120 esc lctl))
        '';
        };
  };

  users.users.rms = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
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
