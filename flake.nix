{
  description = "A collection of Nostr-powered packages";
  inputs.nixpkgs.url = "nixpkgs/nixos-24.11";

  outputs = {
    self,
    nixpkgs,
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
      nak = pkgs.callPackage ./pkgs/nak.nix {};
      narr = pkgs.callPackage ./pkgs/narr.nix {};
      nostr-rs-relay = pkgs.callPackage ./pkgs/nostr-rs-relay.nix {};
      nostream = pkgs.callPackage ./pkgs/nostream.nix {};
    });
  };
}
