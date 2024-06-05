{ inputs, pkgs, self, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-unstable = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    vesktop-unstable = vesktop.legacyPackages.${system}.vesktop;
  };


  overlay-sketti = final: prev: {
    sketti = self.packages.${system};
    neovim = neovim.packages.${system}.default;
  };

  overlay-hyprland = final: prev: {
    hyprland-git = hyprland.packages.${system}.hyprland;
    hyprpicker-git = hyprpicker.packages.${system}.default;
  };

in
{
  nixpkgs.overlays = [
    overlay-unstable
    overlay-sketti
    overlay-hyprland
  ];
}
