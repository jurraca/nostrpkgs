{ lib, pkgs, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "chorus";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "mikedilger";
    repo = "chorus";
    rev = "v" + version;
    sha256 = "sha256-KNPtCvXOudwQoDXn3+P306RPnZFimT1tz+60/hFTEJc=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "pocket-db-0.1.0" = "sha256-tAygH3nPpjKKcMxU4GXTlmD9irbpe7bB38WQJum4rUk=";
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
