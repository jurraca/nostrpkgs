{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "algia";
  version = "0.0.82";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = "algia";
    rev = "v" + version;
    sha256 = "sha256-4ng4Vlu4XSzROtfvb9CljvpKBrTGtC2rYtx7eFbb/Iw=";
  };

  vendorHash = "sha256-fko9WC/Rh5fmoypqBuFKiuIuIJYMbKV+1uQKf5tFil0=";

  doCheck = false;

  meta = with lib; {
    description = "A cli application for nostr written in Go";
    homepage = "https://github.com/mattn/algia";
    license = licenses.mit;
    maintainers = with maintainers; [ jurraca ];
  };
}

