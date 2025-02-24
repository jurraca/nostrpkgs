{ lib, packages, ... }:

with lib;
{
    enable = mkEnableOption "Nostr-rs-relay service";

    package = mkOption {
        type = types.package;
	default = packages.nostr-rs-relay;#self.packages.${pkgs.system}.nostr-rs-relay;
	description = "The package providing the nostr-rs-relay binary";
    };

    info = {
      relay_url = mkOption {
        type = types.str;
        default = "wss://nostr.example.com/";
        description = "The advertised URL for the Nostr websocket.";
      };

      name = mkOption {
        type = types.str;
        default = "nostr-rs-relay";
        description = "Relay information for clients.";
      };

      description = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = "A newly created nostr-rs-relay.";
        description = "Description of the relay.";
      };

      pubkey = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Administrative contact pubkey.";
      };

      contact = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Administrative contact URI.";
      };

      favicon = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Favicon location.";
      };

      relay_icon = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "URL of relay's icon.";
      };

      relay_page = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Path to custom relay html page.";
      };
    };

    diagnostics = {
      tracing = mkOption {
        type = types.bool;
        default = false;
        description = "Enable tokio tracing.";
      };
    };

    database = {
      engine = mkOption {
        type = types.str;
        default = "sqlite";
        description = "Database engine (sqlite/postgres).";
      };

      data_directory = mkOption {
        type = types.str;
        default = ".";
        description = "Directory for SQLite files.";
      };

      in_memory = mkOption {
        type = types.bool;
        default = false;
        description = "Use an in-memory database instead of 'nostr.db'.";
      };

      min_conn = mkOption {
        type = types.int;
        default = 4;
        description = "Minimum number of SQLite reader connections.";
      };

      max_conn = mkOption {
        type = types.int;
        default = 8;
        description = "Maximum number of SQLite reader connections.";
      };

      connection = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Database connection string for PostgreSQL, not used by Sqlite.";
      };

    };

    folder_path = mkOption {
      type = types.str;
      default = "./log";
      description = "Directory to store log files.";
    };

    file_prefix = mkOption {
      type = types.str;
      default = "nostr-relay";
      description = "Log file prefix.";
    };

    grpc = {
      event_admission_server = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "gRPC server URL for event authorization.";
      };
    };

    network = {
      address = mkOption {
        type = types.str;
        default = "0.0.0.0";
        description = "Network address to bind to.";
      };

      port = mkOption {
        type = types.port;
        default = 8080;
        description = "Port to listen on.";
      };

      remote_ip_header = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "HTTP header for logging client IP addresses.";
      };

      ping_interval = mkOption {
        type = types.int;
        default = 300;
        description = "WebSocket ping interval in seconds.";
      };
    };

    options = {
      reject_future_seconds = mkOption {
        type = types.int;
        default = 1800;
        description = "Reject events with timestamps greater than this many seconds in the future.";
      };
    };

    limits = {
      messages_per_sec = mkOption {
        type = types.int;
        default = 5;
        description = "Limit events created per second.";
      };

      subscriptions_per_min = mkOption {
        type = types.int;
        default = 0;
        description = "Limit client subscriptions created per minute.";
      };

      max_blocking_threads = mkOption {
        type = types.int;
        default = 16;
        description = "Limit blocking threads used for database connections.";
      };

      max_event_bytes = mkOption {
        type = types.int;
        default = 131072;
        description = "Limit the maximum size of an EVENT message.";
      };

      max_ws_message_bytes = mkOption {
        type = types.int;
        default = 131072;
        description = "Maximum WebSocket message size in bytes.";
      };

      max_ws_frame_bytes = mkOption {
        type = types.int;
        default = 131072;
        description = "Maximum WebSocket frame size in bytes.";
      };

      broadcast_buffer = mkOption {
        type = types.int;
        default = 16384;
        description = "Broadcast buffer size in number of events.";
      };

      event_persist_buffer = mkOption {
        type = types.int;
        default = 4096;
        description = "Event persistence buffer size in number of events.";
      };

      event_kind_blacklist = mkOption {
        type = types.listOf types.int;
        default = [ 4 ];
        description = "Event kind blacklist.";
      };

      event_kind_allowlist = mkOption {
        type = types.listOf types.int;
        default = [
          0
          1
          2
          3
          7
          40
          41
          42
          43
          44
          30023
        ];
        description = "Event kind allowlist.";
      };
    };

    authorization = {
      pubkey_whitelist = mkOption {
        type = types.nullOr (types.listOf types.str);
        default = [ ];
        description = "Pubkey addresses whitelisted for event publishing.";
      };

      nip42_auth = mkOption {
        type = types.bool;
        default = false;
        description = "Enable NIP-42 authentication.";
      };

      nip42_dms = mkOption {
        type = types.bool;
        default = false;
        description = "Send DMs and gift wraps only to authenticated recipients.";
      };
    };

    verified_users = {
      verified_users_mode = mkOption {
        type = types.str;
        default = "disabled";
        description = "NIP-05 verification mode.";
      };

      domain_blacklist = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Domain names prevented from publishing events.";
      };

      domain_whitelist = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Domain names allowed to publish events.";
      };

      verify_expiration = mkOption {
        type = types.str;
        default = "1 week";
        description = "Consider an pubkey verified within this time.";
      };

      verify_update_frequency = mkOption {
        type = types.str;
        default = "24 hours";
        description = "Wait time between verification attempts for an author.";
      };

      max_consecutive_failures = mkOption {
        type = types.int;
        default = 20;
        description = "Maximum consecutive failed verification checks.";
      };
    };

    pay_to_relay = {
      pay_to_relay_enabled = mkOption {
        type = types.bool;
        default = false;
        description = "Enable pay to relay.";
      };

      admission_cost = mkOption {
        type = types.int;
        default = 0;
        description = "The cost to be admitted to relay.";
      };

      cost_per_event = mkOption {
        type = types.int;
        default = 0;
        description = "The cost in sats per post.";
      };

      node_url = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "URL of node API.";
      };

      processor = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Node interface to use";
      };

      api_secret = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "LNBits API secret.";
      };

      rune_path = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Path to CLN rune.";
      };

      direct_message = mkOption {
        type = types.bool;
        default = false;
        description = "Send Nostr direct message on signup.";
      };

      terms_message = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Terms of service message.";
      };

      sign_ups = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to allow new sign ups.";
      };

      secret_key = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Optional secret key if direct_message is false.";
      };
    };
  }
