{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "haven";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "barrydeen";
    repo = "haven";
    rev = "v" + version;
    sha256 = "sha256-gpfTgaO3VK65GBy/W/rR8181yHlvgTx9UyWReo7s2gQ=";
  };

  vendorHash = "sha256-VXx6uoOUKk/BkjDS3Ykf/0Xc2mUPm8dgyRArIb2I8X4=";

  doCheck = false;

  meta = with lib; {
    description = "High Availability Vault for Events on Nostr";
    homepage = "https://github.com/bitvora/haven";
    license = licenses.mit;
  };
}

