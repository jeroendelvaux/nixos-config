{ config, pkgs, pkgs-unstable, secrets, ... }:

{
  networking = {
    hostName = secrets.hosts.tiger.hostName;
    networkmanager = {
      enable = true;
      settings.connectivity = {
        uri = "http://connectivity-check.ubuntu.com/";
        interval = 60; # seconds
        response = "Default";
      };
    };
  };
  users.users.${secrets.hosts.tiger.owner.username}.extraGroups = [ "networkmanager" ];
}
