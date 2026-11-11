{
  description = "Horizon, a rice for the Shady compositor";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in {
      # share/shady/rices/horizon: on XDG_DATA_DIRS (a NixOS system package, or
      # programs.shady.rices) with Afterglow's, SHADY_RICE=horizon picks it.
      packages = forAllSystems (pkgs: rec {
        horizon = pkgs.runCommand "shady-rice-horizon" {
          meta.description = "Horizon: shady-shell living in Afterglow's sky";
        } ''
          dest=$out/share/shady/rices/horizon
          mkdir -p $dest
          cd ${self}
          cp -r config.lua init.lua shell.lua theme.sh fonts README.md $dest/
        '';
        default = horizon;
      });
    };
}
