{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "algia";
  version = "0.0.131";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = "algia";
    rev = "v" + version;
    sha256 = "sha256-ywpaMeJ7vyf4uwoUHyZf7kK3/em7vj86AvfdC2T/UwQ=";
  };

  vendorHash = "sha256-mim8EImPFHF2vf1vCi9jgECbVAOB32oXxsPMgUwYDBA=";

  doCheck = false;

  meta = with lib; {
    description = "A cli application for nostr written in Go";
    homepage = "https://github.com/mattn/algia";
    license = licenses.mit;
  };
}

