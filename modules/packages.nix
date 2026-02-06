{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    # chromium
    opencode
    banana-cursor
    networkmanager
    ghostty
    gcc
    git-spice
    lazydocker
    lua-language-server
    nemo
    nil
    speedtest-cli
    tmuxp
    wl-clipboard
    yq
    wireplumber
    brightnessctl
  ];
}
