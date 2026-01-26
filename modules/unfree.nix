{ pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "1password"
      "1password-cli"
      "libfprint-2-tod1-goodix"
      "ngrok"
      "proton-pass"
    ];

  environment.systemPackages = with pkgs; [
    _1password-cli
    _1password-gui
    ngrok
    proton-pass
  ];
}
