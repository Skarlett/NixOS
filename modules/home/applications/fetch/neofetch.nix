{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.kalyx.neofetch;
in
{
  options.kalyx.neofetch = {
    enable = mkEnableOption "neofetch";
  };

  config = mkIf cfg.enable {
    home.file.".config/neofetch/config.conf".text = ''
      print_info() {
        info title
        info underline

        distro="Kalyx [NixOS] x86_64"
        info "OS" distro
        info "Host" model
        info "Kernel" kernel
        info "Uptime" uptime
        info "Packages" packages
        info "Shell" shell
        info "Resolution" resolution
        info "DE" de
        info "WM" wm
        info "WM Theme" wm_theme
        info "Theme" theme
        info "Icons" icons
        info "Terminal" term
        info "Terminal Font" term_font
        info "CPU" cpu
        info "GPU" gpu
        info "Memory" memory

        # info "GPU Driver" gpu_driver  # Linux/macOS only
        # info "Disk" disk
        # info "Battery" battery
        # info "Font" font
        # info "Song" song
        # [[ "$player" ]] && prin "Music Player" "$player"
        # info "Local IP" local_ip
        # info "Public IP" public_ip
        # info "Users" users
        # info "Locale" locale  # This only works on glibc systems.

        info cols
      }

      ascii_colors=(11 3 10 2)
      image_source="${./kalyx-ansii}"
    '';
  };
}
