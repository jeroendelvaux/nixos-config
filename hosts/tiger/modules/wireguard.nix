{ config, lib, pkgs, secrets, ... }:

{
  options.wireguard.enable = lib.mkEnableOption "Enable wireguard";

  config = lib.mkIf config.wireguard.enable {
    sops = {
      defaultSopsFile = "${secrets}/keys/tiger/secrets.yaml";
      defaultSopsFormat = "yaml";
      age = {
        keyFile = "/home/${secrets.hosts.tiger.owner.username}/.config/age/keys.txt";
      };
      secrets."wireguard" = {
        mode = "0400";
        owner = "root";
      };
    };

networking.wg-quick.interfaces.wg0 = {
  autostart = false; # Set true when tested
  address = [ "10.100.0.2/24" ];
  dns = [ "1.1.1.1" ];
  privateKeyFile = config.sops.secrets."wireguard".path;

  peers = [
    {
      publicKey = secrets.hosts.puma.wireguardPublicKey;
      endpoint = "${secrets.hosts.puma.ip}:51820";
      allowedIPs = [ "0.0.0.0/0" ];
      persistentKeepalive = 25;
    }
  ];
};


  };
}
