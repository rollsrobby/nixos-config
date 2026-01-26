{ config, pkgs, ... }:
{
  imports = [
    ./modules/cli.nix
    ./modules/tmux.nix
  ];
  home.username = "rms";
  home.homeDirectory = "/home/rms";

  home.stateVersion = "25.05";

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/rms/dotfiles/nvim";
    recursive = true;
  };

  xdg.configFile."ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/rms/dotfiles/ghostty";
    recursive = true;
  };
}
