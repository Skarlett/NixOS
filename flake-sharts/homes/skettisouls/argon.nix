{ config, lib, pkgs, ... }:

{
  # TODO: Include home modules by default.
  imports = [
    ../../../modules/home
  ];

  home.packages = with pkgs;[
    rofi
  ];

  shit = {
    audio = {
      bluetooth.enable = true;
    };

    fetch = {
      trollOS.enable = true;
    };

    hyprland.wallpapers = {
      suncat.source = "/etc/nixos/shit/images/wallpapers/suncat.jpg";
    };

    browsers = {
      default = "brave";
      brave.enable = true;
      qutebrowser.enable = true;
      schizofox.enable = true;
    };
  };
}
