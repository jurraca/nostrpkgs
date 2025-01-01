{ lib, pkgs, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "chorus";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "mikedilger";
    repo = "chorus";
    rev = "v" + version;
    sha256 = "sha256-khuJjMng4wuSB0omLvnQo9wKrpJBeT3XxF7uwGkJXws=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "pocket-db-0.1.0" = "sha256-cvIHuy5UinDOCwyr2dEcKRFuzWCFUlmazTt0bYIYl7Q=";
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
