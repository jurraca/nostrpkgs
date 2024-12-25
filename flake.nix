{
  description = "A collection of Nostr-related packages";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          algia = pkgs.callPackage ./pkgs/algia.nix {};
          nak = pkgs.callPackage ./pkgs/nak.nix {};
          nostr-rs-relay = pkgs.callPackage ./pkgs/nostr-rs-relay.nix { };
          nostream = pkgs.callPackage ./pkgs/nostream.nix {};
        };
      }
    );
}

