{ config, pkgs, ... }:
{
  imports = [
    ./modules/cli.nix
  ];
  home.username = "rms";
  home.homeDirectory = "/home/rms";

  home.packages = with pkgs; [
    fd
    jq
    htop
  ];

  home.stateVersion = "25.05";
}
