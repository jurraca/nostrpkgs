{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "algia";
  version = "0.0.84";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = "algia";
    rev = "v" + version;
    sha256 = "sha256-i7rSmLFtUFSA1pW5IShYnTxjtwZ5z31OP4kVcMQgMxA=";
  };

  vendorHash = "sha256-8zAGkz17U7j0WWh8ayLowVhNZQvbIlA2YgXMgVIHuFg=";

  doCheck = false;

  meta = with lib; {
    description = "A cli application for nostr written in Go";
    homepage = "https://github.com/mattn/algia";
    license = licenses.mit;
  };
}

