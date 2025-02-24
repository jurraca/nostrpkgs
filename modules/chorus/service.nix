{
  config,
  pkgs,
  lib,
  packages,
  toTOML,
  ...
}:
with lib; let
  options.services.chorus = pkgs.callPackage ./options.nix {inherit packages; };

  cfg = config.services.chorus;

  configToml = pkgs.writeText "config.toml" (toTOML cfg);
in {
  inherit options;
  config = mkIf cfg.enable {
    systemd.services.chorus = rec {
      wants = ["network-online.target"];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/chorus ${configToml}";
      };
    };
  };
}
