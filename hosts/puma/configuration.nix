{ config, lib, pkgs, secrets, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  environment.defaultPackages = [ ]; 

  nix.settings = {
    max-jobs = 1;
    cores = 1;
    trusted-users = [ "root" secrets.hosts.puma.owner.username ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  documentation = {
    enable = false;
    nixos.enable = false;
    man.enable = false;
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      # Disallow legacy ciphers:
      HostKeyAlgorithms = "ssh-ed25519";
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
      ];
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
      ];
    };
    ports = [ 22 ];
  };

  services.fail2ban = {
    enable = true;
    maxretry = 10;
    bantime = "24h";
    jails.sshd.settings.findtime = "10m";
  };

  services.udisks2.enable = false;
  programs.command-not-found.enable = false;
  services.journald.extraConfig = "SystemMaxUse=100M";
  systemd.coredump.enable = false;
  security.polkit.enable = false;

  sops = {
    defaultSopsFile = "${secrets}/keys/puma/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ 
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    secrets."wireguard" = {
      mode = "0400";
      owner = "root";
    };
  };

  boot.kernel.sysctl = {
    # Enable IP forwarding:
    "net.ipv4.ip_forward" = 1;
    # Enable BBR congestion control:
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    # Optimize network buffers for higher throughput:
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    # Reverse Path Filtering:
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    # Ignore ICMP redirects:
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    # Disabling IP source routing:
    "net.ipv4.conf.all.accept_source_route" = false;
    "net.ipv6.conf.all.accept_source_route" = false;
    "net.ipv6.conf.default.accept_source_route" = false;
    # Ignore broadcast ICMP echo requests:
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    # Prevent SYN flood attacks:
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_synack_retries" = 2;
    # Kernel pointer hardening:
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    # Maximize zram efficiency:
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  boot.blacklistedKernelModules = [
    "ax25" "netrom" "rose" "sctp" "rds" "tipc" "bluetooth"
  ];

  networking.hostName = secrets.hosts.puma.hostName;

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.sops.secrets."wireguard".path;
    peers = [
      {
        publicKey = secrets.hosts.tiger.wireguardPublicKey;
        allowedIPs = [ "10.100.0.2/32" ];
      }
    ];
  };

  networking.nftables = {
    enable = true;
    tables = {
      nat = {
        family = "ip";
        content = ''
          chain postrouting {
            type nat hook postrouting priority 100; policy accept;
            oifname "enp1s0" ip saddr 10.100.0.0/24 masquerade
          }
        '';
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 51820 ];
    extraInputRules = ''
      iifname "wg0" accept
    '';
    extraForwardRules = ''
      iifname "wg0" oifname "enp1s0" accept
      iifname "enp1s0" oifname "wg0" ct state established,related accept
    '';
  };

  users = {
    mutableUsers = false;
    users = {
      ${secrets.hosts.puma.owner.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = secrets.hosts.puma.owner.hashedPassword;
        openssh.authorizedKeys.keys = [
          secrets.hosts.tiger.owner.sshPublicKey
        ];
      };
      root = {
        hashedPassword = secrets.hosts.puma.root.hashedPassword;
      };
    };
  };

  security.sudo = {
    wheelNeedsPassword = true;
    extraConfig = "Defaults timestamp_timeout=5";
  };

  system.stateVersion = "26.05";
}
