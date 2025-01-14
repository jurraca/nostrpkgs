{ lib, buildNpmPackage, fetchFromGitHub, makeWrapper, nodejs, postgresql, redis }:

buildNpmPackage rec {
  name = "nostream";
  src = fetchFromGitHub {
    owner = "cameri";
    repo = "nostream";
    rev = "v2.0.0";
    sha256 = "sha256-QO1sV2AJWtabJobYdSg1xAPHOD6oaxh1tAU9QQM9mi0=";
  };

  packageJSON = "${src}/package.json";

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ postgresql redis ];

  npmDepsHash = "sha256-amJjzNjkJr5jKdoWZdhpH3lxBUmfPOKjuQlws1Cjmmo=";

  buildPhase = ''
    runHook preBuild
    npm install
    npm run build
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p $out/libexec/nostream/dist
    cp -r dist node_modules src $out/libexec/nostream/

    mkdir -p $out/scripts
    cp -r scripts/* $out/scripts

    runHook postInstall
  '';
  postInstall = ''
    makeWrapper ${nodejs}/bin/node "$out/bin/nostream" \
      --add-flags "$out/libexec/nostream/dist/src/index.js"
  '';

  meta = with lib; {
    description = "A Nostr Relay written in TypeScript";
    homepage = "https://github.com/cameri/nostream";
    license = licenses.mit;
  };
}

