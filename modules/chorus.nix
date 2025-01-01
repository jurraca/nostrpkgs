{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  options.services.chorus = {
    enable = mkEnableOption "Chorus relay";

    package = mkOption {
      type = types.package;
      default = config.nostrpkgs.pkgs.chorus;
    };

    dataDirectory = mkOption {
      type = types.str;
      default = "/opt/chorus/var/chorus";
      description = "Directory where chorus stores data";
    };

    ipAddress = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "IP address that chorus listens on";
    };

    port = mkOption {
      type = types.port;
      default = 443;
      description = "Port that chorus listens on";
    };

    hostname = mkOption {
      type = types.str;
      default = "localhost";
      description = "DNS hostname of your relay";
    };

    isBehindProxy = mkOption {
      type = types.bool;
      default = false;
      description = "Whether chorus is behind a proxy like nginx";
    };

    baseUrl = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Internet-visible URL when behind proxy";
    };

    useTls = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to handle TLS/HTTPS";
    };

    certchainPemPath = mkOption {
      type = types.str;
      default = "/opt/chorus/etc/tls/fullchain.pem";
      description = "Path to TLS certificate chain file";
    };

    keyPemPath = mkOption {
      type = types.str;
      default = "/opt/chorus/etc/tls/privkey.pem";
      description = "Path to TLS private key file";
    };

    name = mkOption {
      type = types.str;
      default = "Chorus Default";
      description = "Name for your relay in NIP-11 response";
    };

    description = mkOption {
      type = types.str;
      default = "A default config of the Chorus relay";
      description = "Description for your relay in NIP-11 response";
    };

    iconUrl = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "URL for relay icon in NIP-11 response";
    };

    contact = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Contact information in NIP-11 response";
    };

    publicKeyHex = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Public key (hex) in NIP-11 response";
    };

    openRelay = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to operate as an open public relay";
    };

    userHexKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Public keys of authorized relay users";
    };

    moderatorHexKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Public keys of relay moderators";
    };

    verifyEvents = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to verify incoming events";
    };

    allowScraping = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to allow data scraping";
    };

    allowScrapeIfLimitedTo = mkOption {
      type = types.int;
      default = 100;
      description = "Event limit under which scraping is allowed";
    };

    allowScrapeIfMaxSeconds = mkOption {
      type = types.int;
      default = 7200;
      description = "Time range under which scraping is allowed";
    };

    maxSubscriptions = mkOption {
      type = types.int;
      default = 128;
      description = "Maximum number of subscriptions per connection";
    };

    serveEphemeral = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to serve ephemeral events";
    };

    serveRelayLists = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to serve relay list metadata";
    };

    serverLogLevel = mkOption {
      type = types.enum ["Trace" "Debug" "Info" "Warn" "Error"];
      default = "Info";
      description = "Log level for server code";
    };

    libraryLogLevel = mkOption {
      type = types.enum ["Trace" "Debug" "Info" "Warn" "Error"];
      default = "Info";
      description = "Log level for library code";
    };

    clientLogLevel = mkOption {
      type = types.enum ["Trace" "Debug" "Info" "Warn" "Error"];
      default = "Info";
      description = "Log level for client requests";
    };

    enableIpBlocking = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to block IPs based on behavior";
    };

    minimumBanSeconds = mkOption {
      type = types.int;
      default = 1;
      description = "Minimum IP ban duration in seconds";
    };

    timeoutSeconds = mkOption {
      type = types.int;
      default = 60;
      description = "Client timeout without subscriptions";
    };

    maxConnectionsPerIp = mkOption {
      type = types.int;
      default = 5;
      description = "Maximum websocket connections per IP";
    };

    throttlingBytesPerSecond = mkOption {
      type = types.int;
      default = 1024576;
      description = "Maximum data rate per connection";
    };

    throttlingBurst = mkOption {
      type = types.int;
      default = 16777216;
      description = "Allowable burst size in bytes";
    };

    blossomDirectory = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Directory for Blossom file storage";
    };
  };

  cfg = config.services.chorus;

  configFile = builtins.toFile "config.toml" ''

  '';
in {
  config = mkIf cfg.enable {
    systemd.services.chorus = rec {
      wants = ["network-online.target"];
    };
    serviceConfig = {
      ExecStart = "${cfg.package}/bin/chorus ${configFile}";
    };
  };
}
