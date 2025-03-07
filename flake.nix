{
  description = "A collection of Nostr-powered packages";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nix-std.url = "github:chessai/nix-std";
  };

  outputs = {
    self,
    nixpkgs,
    nix-std
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
    nixpkgsFor = system: import nixpkgs {inherit system;};
    toTOML = nix-std.lib.serde.toTOML;
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgsFor system;
    in {
      algia = pkgs.callPackage ./pkgs/algia.nix {};
      chorus = pkgs.callPackage ./pkgs/chorus.nix {};
      gitstr = pkgs.callPackage ./pkgs/gitstr.nix {};
      haven = pkgs.callPackage ./pkgs/haven.nix {};
      nak = pkgs.callPackage ./pkgs/nak.nix {};
      narr = pkgs.callPackage ./pkgs/narr.nix {};
      nostr-rs-relay = pkgs.callPackage ./pkgs/nostr-rs-relay.nix {};
      nostream = pkgs.callPackage ./pkgs/nostream.nix {};
    });

    nixosModules = let
      packages = self.packages.x86_64-linux;
    in {
      chorus = {config, lib, pkgs, ... }: import ./modules/chorus/service.nix { inherit pkgs lib config toTOML packages; } ;
      nostr-rs-relay = {config, lib, pkgs, ...}: import ./modules/nostr-rs-relay/service.nix { inherit pkgs lib config toTOML packages ; } ;
      haven = {config, lib, pkgs, ...}: import ./modules/haven/service.nix { inherit pkgs lib config packages; } ;
    };

    options = let
      pkgs = nixpkgsFor "x86_64-linux";
      lib = nixpkgs.lib;
      packages = self.packages.x86_64-linux;
    in {
      chorus = pkgs.callPackage ./print-options.nix { inherit packages; moduleName = "chorus";};
      haven = pkgs.callPackage ./print-options.nix { inherit packages; moduleName = "haven";};
      nostr-rs-relay = pkgs.callPackage ./print-options.nix { inherit packages; moduleName = "nostr-rs-relay";};
    };
  };
}
