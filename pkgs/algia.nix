{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "algia";
  version = "0.0.86";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = "algia";
    rev = "v" + version;
    sha256 = "sha256-dpvBlFI6xmQOwui7Ma1ewIoxgFctG9fK+pLhjK/71XI=";
  };

  vendorHash = "sha256-Yt95kSXAIBxHgX+VUefKrumg9thuvh3c+gnSu/2PSQY=";

  doCheck = false;

  meta = with lib; {
    description = "A cli application for nostr written in Go";
    homepage = "https://github.com/mattn/algia";
    license = licenses.mit;
  };
}

