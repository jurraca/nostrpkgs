{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nak";
  version = "0.15.3";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-PSg+27uTpPIrKlYArWOv92l5muQRQiFZ6Vvu7hDLt5s=";
  };

  vendorHash = "sha256-qwi3awU1DHjT/4scGUrhsdlmXJYwq0g/t4LaZ8FGYB0=";

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
  };
}

