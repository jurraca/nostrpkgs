{
  config,
  pkgs,
  lib,
  packages,
  ...
}:
with lib; let
  options.services.haven = pkgs.callPackage ./options.nix { inherit packages; };
  cfg = config.services.haven;

  configFile = builtins.toFile ".env" ''
    "OWNER_NPUB=${cfg.owner.npub}"
    "RELAY_URL=${cfg.relay.url}"
    "RELAY_PORT=${toString cfg.relay.port}"
    "RELAY_BIND_ADDRESS=${cfg.relay.bindAddress}"
    "DB_ENGINE=${cfg.database.engine}"
    ${optionalString (cfg.database.lmdbMapsize != null) "LMDB_MAPSIZE=${toString cfg.database.lmdbMapsize}"}
    "BLOSSOM_PATH=${cfg.blossom.path}"

    ${optionalString (cfg.privateRelay.name != null) "PRIVATE_RELAY_NAME=${cfg.privateRelay.name}"}
    ${optionalString (cfg.privateRelay.npub != null) "PRIVATE_RELAY_NPUB=${cfg.privateRelay.npub}"}
    ${optionalString (cfg.privateRelay.description != null) "PRIVATE_RELAY_DESCRIPTION=${cfg.privateRelay.description}"}
    ${optionalString (cfg.privateRelay.icon != null) "PRIVATE_RELAY_ICON=${cfg.privateRelay.icon}"}

    ${optionalString (cfg.privateRelay.rateLimits.eventIp.tokensPerInterval != null) "PRIVATE_RELAY_EVENT_IP_LIMITER_TOKENS_PER_INTERVAL=${toString cfg.privateRelay.rateLimits.eventIp.tokensPerInterval}"}
    ${optionalString (cfg.privateRelay.rateLimits.eventIp.interval != null) "PRIVATE_RELAY_EVENT_IP_LIMITER_INTERVAL=${toString cfg.privateRelay.rateLimits.eventIp.interval}"}
    ${optionalString (cfg.privateRelay.rateLimits.eventIp.maxTokens != null) "PRIVATE_RELAY_EVENT_IP_LIMITER_MAX_TOKENS=${toString cfg.privateRelay.rateLimits.eventIp.maxTokens}"}
    ${optionalString (cfg.privateRelay.rateLimits.allowEmptyFilters != null) "PRIVATE_RELAY_ALLOW_EMPTY_FILTERS=${cfg.privateRelay.rateLimits.allowEmptyFilters}"}
    ${optionalString (cfg.privateRelay.rateLimits.allowComplexFilters != null) "PRIVATE_RELAY_ALLOW_COMPLEX_FILTERS=${cfg.privateRelay.rateLimits.allowComplexFilters}"}
    ${optionalString (cfg.privateRelay.rateLimits.connection.tokensPerInterval != null) "PRIVATE_RELAY_CONNECTION_RATE_LIMITER_TOKENS_PER_INTERVAL=${toString cfg.privateRelay.rateLimits.connection.tokensPerInterval}"}
    ${optionalString (cfg.privateRelay.rateLimits.connection.interval != null) "PRIVATE_RELAY_CONNECTION_RATE_LIMITER_INTERVAL=${toString cfg.privateRelay.rateLimits.connection.interval}"}
    ${optionalString (cfg.privateRelay.rateLimits.connection.maxTokens != null) "PRIVATE_RELAY_CONNECTION_RATE_LIMITER_MAX_TOKENS=${toString cfg.privateRelay.rateLimits.connection.maxTokens}"}

    ${optionalString (cfg.import.startDate != null) "IMPORT_START_DATE=${cfg.import.startDate}"}
    ${optionalString (cfg.import.queryInterval != null) "IMPORT_QUERY_INTERVAL_SECONDS=${toString cfg.import.queryInterval}"}
    ${optionalString (cfg.import.seedRelaysFile != null) "IMPORT_SEED_RELAYS_FILE=${cfg.import.seedRelaysFile}"}

    ${optionalString (cfg.backup.provider != null) "BACKUP_PROVIDER=${cfg.backup.provider}"}
    ${optionalString (cfg.backup.intervalHours != null) "BACKUP_INTERVAL_HOURS=${toString cfg.backup.intervalHours}"}

    ${optionalString (cfg.backup.s3.accessKeyId != null) "S3_ACCESS_KEY_ID=${cfg.backup.s3.accessKeyId}"}
    ${optionalString (cfg.backup.s3.secretKey != null) "S3_SECRET_KEY=${cfg.backup.s3.secretKey}"}
    ${optionalString (cfg.backup.s3.endpoint != null) "S3_ENDPOINT=${cfg.backup.s3.endpoint}"}
    ${optionalString (cfg.backup.s3.region != null) "S3_REGION=${cfg.backup.s3.region}"}
    ${optionalString (cfg.backup.s3.bucketName != null) "S3_BUCKET_NAME=${cfg.backup.s3.bucketName}"}

    ${optionalString (cfg.blastr.relaysFile != null) "BLASTR_RELAYS_FILE=${cfg.blastr.relaysFile}"}
  '';
in {
  inherit options;
  config = mkIf cfg.enable {
    systemd.services.haven-relay = {
      description = "HAVEN Relay";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/haven";
        WorkingDirectory = "/var/src/haven";
        MemoryLimit = "1000M";
        Restart = "always";
        EnvironmentFile = ".env";
      };
    };
  };
}
