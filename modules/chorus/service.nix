{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  options.services.chorus = import ./options.nix;

  cfg = config.services.chorus;

  configFile = builtins.toFile "config.toml" ''

  '';
in {
  inherit options;
  config = mkIf cfg.enable {
    systemd.services.chorus = rec {
      wants = ["network-online.target"];
    };
    serviceConfig = {
      ExecStart = "${cfg.package}/bin/chorus ${configFile}";
    };
  };
}
