{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mattn";
  version = "0.0.82"; # You can set the appropriate version

  src = fetchFromGitHub {
    owner = "mattn"; # Replace with the actual GitHub username
    repo = "algia";
    rev = "v" + version; # The specific version or commit to fetch
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

