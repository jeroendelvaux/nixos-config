{ config, pkgs, pkgs-unstable, secrets, ... }:

{
  networking = {
    hostName = secrets.networking.hostName;
    networkmanager = {
      enable = true;
      settings.connectivity = {
        uri = "http://connectivity-check.ubuntu.com/";
        interval = 60; # seconds
        response = "Default";
      };
    };
  };
  users.users.${secrets.user.name}.extraGroups = [ "networkmanager" ];
}
