{ lib, pkgs, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "chorus";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "mikedilger";
    repo = "chorus";
    rev = "v" + version;
    sha256 = "sha256-1zDWYAPlIDVjm4J/fgcoCgCwSO83Y8CgoTyFz9yImFc=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "pocket-db-0.1.0" = "sha256-ei3YGVo0f5PAAJC8zzeO7IOfRo4m/wj6dbKgea0TgrI=";
    };
  };

  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.cmake
  ];

  buildInputs = [
    pkgs.openssl
  ];

  meta = with lib; {
    description = "A personal relay for nostr";
    homepage = "https://github.com/mikedilger/chorus";
    license = licenses.mit;
  };
}
