{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    chromium
    opencode
    networkmanager
    ghostty
    gcc
    git-spice
    lazydocker
    lua-language-server
    nil
    speedtest-cli
    tmuxp
    yq
  ];
}
