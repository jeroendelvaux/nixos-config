{ config, pkgs, pkgs-unstable, secrets, ... }:

{
  networking = {
    hostName = secrets.hosts.tiger.hostName;
    networkmanager = {
      enable = true;
      wifi.scanRandMacAddress = true;
      settings = {
        connection = {
          "wifi.cloned-mac-address" = "stable";
        };
        connectivity = {
          uri = "http://connectivity-check.ubuntu.com/";
          interval = 60; # seconds
          response = "Default";
        };
      };
      dns = "systemd-resolved";
    };
  };

  users.users.${secrets.hosts.tiger.owner.username}.extraGroups = [
    "networkmanager"
  ];

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "9.9.9.9#dns.quad9.net"
        "1.1.1.1#one.one.one.one"
      ];
      DNSOverTLS = "opportunistic";
      DNSSEC = true;
      Domains = [ "~." ];
      FallbackDNS = [];
    };
  };

  # To support captive portals, temporarily override global DNS-over-TLS with
  # local DHCP DNS:
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "captive-dns-on"
      (builtins.readFile ./captive-dns-on.sh))
    (pkgs.writeShellScriptBin "captive-dns-off"
      (builtins.readFile ./captive-dns-off.sh))
  ];
}
