{ config, lib, pkgs, self, nix-std, ... }:

with lib;

let
  toTOML = nix-std.lib.serde.toTOML;
  options.services.nostr-rs-relay = import ./options.nix;

  cfg = config.services.nostr-rs-relay;

  tomlConfig = {
    info = cfg.info;
    diagnostics = cfg.diagnostics;
    database = cfg.database;
    network = cfg.network;
    options = cfg.options;
    limits = cfg.limits;
    authorization = cfg.authorization;
    verified_users = cfg.verified_users;
    pay_to_relay = cfg.pay_to_relay;
  };

  configToml = pkgs.writeText "config.toml" (toTOML tomlConfig);

in
{
  inherit options;
  config = mkIf cfg.enable {
    systemd.services.nostr-rs-relay = {
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/nostr-rs-relay --config ${configToml}";
        Environment = "RUST_LOG=warn,nostr_rs_relay=info";
        KillMode = "process";
        TimeoutStopSec = "10";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };
  };
}
