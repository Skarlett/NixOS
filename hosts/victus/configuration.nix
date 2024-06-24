{ config, lib, pkgs,  ... }:
let
  monitors = builtins.foldl' (acc: attrs: acc // attrs) {} config.shit.hardware.monitors;
  internalMonitor = if monitors.primary then monitors.displayPort else "";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  roles = {
    desktop.enable = true;
    gaming.enable = true;
    workstation.enable = true;
  };

  shit.users.skettisouls = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "victus"; # Define your hostname.
  # TODO: See if wpa_supplicant is required for declaring wifi connections.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  programs = {
    # Required for xwayland to work, despite being enabled by hyprland.
    xwayland.enable = true;
  };

  # TODO: Research
  # hardware = {
  #   enableRedistributableFirmware = true;
  # };

  shit = {
    # TODO: Add to luni-net.
    wireguard.enable = lib.mkForce false;
  };

  home-manager.sharedModules = [{
    # Set default system wallpaper and monitor settings.
    # TODO: Move to hyprland or monitors home-manager module.
    shit = {
      hyprland = lib.mkDefault {
        monitors.${internalMonitor}.refreshRate = monitors.refreshRate;
        wallpapers = {
          nixos = {
            monitors = [ internalMonitor ];
            source = "/etc/nixos/shit/images/wallpapers/nixos-frappe.png";
          };
        };
      };
    };
  }];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
