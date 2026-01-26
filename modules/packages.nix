{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    opencode
    networkmanager
    ghostty
    gcc
    git-spice
    lazydocker
    lua-language-server
    nil
    tmuxp
    yq
  ];
}
