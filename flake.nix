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

    nixosModules = {
       chorus = import ./modules/chorus.nix;
       nostr-rs-relay = {config, lib, pkgs, ...}: import ./modules/nostr-rs-relay.nix { inherit self nix-std pkgs lib config; } ;
    };
  };
}
