{ config, lib, pkgs, pkgs-unstable, ... }:

{
  options.openvpn.enable = lib.mkEnableOption "Enable openvpn";

  config = lib.mkIf config.openvpn.enable {
    services.openvpn.servers = {
      myvpn = {
        config = '' config ${config.sops.secrets.openvpn.path} '';
        autoStart = false;
      };
    };
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "openvpn-connect" ''
        #!${bash}/bin/bash
        sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
        systemctl start openvpn-myvpn.service
      '')
      (writeShellScriptBin "openvpn-disconnect" ''
        #!${bash}/bin/bash
        sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
        systemctl stop openvpn-myvpn.service
      '')
    ];
  };
}
