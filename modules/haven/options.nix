{lib}:
with lib; {
  enable = mkEnableOption "HAVEN service";

  package = mkOption {
      type = types.package;
      default = packages.haven;
      description = "The package providing the HAVEN binary";
  };

  owner = {
    npub = mkOption {
      type = types.str;
      description = "Owner's npub key";
    };
  };

  relay = {
    url = mkOption {
      type = types.str;
      description = "Relay URL";
    };

    port = mkOption {
      type = types.port;
      description = "Relay port number";
    };

    bindAddress = mkOption {
      type = types.str;
      description = "IP address to bind to (IP4 or IP6)";
    };
  };

  database = {
    engine = mkOption {
      type = types.enum ["badger" "lmdb"];
      description = "Database engine to use";
      default = "badger";
    };

    lmdbMapSize = mkOption {
      type = types.int;
      description = "LMDB mapsize in bytes (0 for default ~273GB)";
      default = 0;
    };
  };

  blossom = {
    path = mkOption {
      type = types.str;
      description = "Path to Blossom directory";
      default = "blossom/";
    };
  };

  privateRelay = {
    name = mkOption {
      type = types.str;
      description = "Private relay name";
    };

    npub = mkOption {
      type = types.str;
      description = "Private relay npub key";
    };

    description = mkOption {
      type = types.str;
      description = "Private relay description";
    };

    icon = mkOption {
      type = types.str;
      description = "Private relay icon URL";
    };

    rateLimits = {
      eventIp = {
        tokensPerInterval = mkOption {
          type = types.int;
          description = "Tokens per interval for event IP limiter";
          default = 50;
        };

        interval = mkOption {
          type = types.int;
          description = "Interval in seconds for event IP limiter";
          default = 1;
        };

        maxTokens = mkOption {
          type = types.int;
          description = "Maximum tokens for event IP limiter";
          default = 100;
        };
      };

      allowEmptyFilters = mkOption {
        type = types.bool;
        description = "Allow empty filters";
        default = false;
      };

      allowComplexFilters = mkOption {
        type = types.bool;
        description = "Allow complex filters";
        default = false;
      };

      connection = {
        tokensPerInterval = mkOption {
          type = types.int;
          description = "Tokens per interval for connection rate limiter";
          default = 3;
        };

        interval = mkOption {
          type = types.int;
          description = "Interval in seconds for connection rate limiter";
          default = 3;
        };

        maxTokens = mkOption {
          type = types.int;
          description = "Maximum tokens for connection rate limiter";
          default = 9;
        };
      };
    };
  };

  import = {
    startDate = mkOption {
      type = types.str;
      description = "Start date for imports";
    };

    queryInterval = mkOption {
      type = types.int;
      description = "Query interval in seconds";
    };

    seedRelaysFile = mkOption {
      type = types.str;
      description = "Path to import relays JSON file";
    };
  };

  backup = {
    provider = mkOption {
      type = types.enum ["none" "s3"];
      description = "Backup provider";
    };

    intervalHours = mkOption {
      type = types.int;
      description = "Backup interval in hours";
    };

    s3 = {
      accessKeyId = mkOption {
        type = types.str;
        description = "S3 access key ID";
      };

      secretKey = mkOption {
        type = types.str;
        description = "S3 secret key";
      };

      endpoint = mkOption {
        type = types.str;
        description = "S3 endpoint";
      };

      region = mkOption {
        type = types.str;
        description = "S3 region";
      };

      bucketName = mkOption {
        type = types.str;
        description = "S3 bucket name";
      };
    };
  };

  blastr = {
    relaysFile = mkOption {
      type = types.str;
      description = "Path to blastr relays JSON file";
    };
  };
}
