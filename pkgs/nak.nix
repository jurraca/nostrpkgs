{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nak";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "fiatjaf";
    repo = "nak";
    rev = "v" + version;
    sha256 = "sha256-tqdTiXLw3EC5/v6fPbsVTJudGplcU6LG6LFFzlzoPjs=";
  };

  vendorHash = "sha256-80jO8u/BdR4JIAmTIoaT2C0ztOkJp/62TGHQtT2Jl3w=";

  doCheck = false;

  meta = with lib; {
    description = "a command line tool for doing all things nostr";
    homepage = "https://github.com/fiatjaf/nak";
    license = licenses.mit;
  };
}

