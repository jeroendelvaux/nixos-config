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
      autostart = false;
      address = [ "10.100.0.2/32" ];
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

    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "wg-connect";
        runtimeInputs = [ pkgs.systemd ];
        text = ''
          exec sudo systemctl start wg-quick-wg0.service
        '';
      })
      (pkgs.writeShellApplication {
        name = "wg-disconnect";
        runtimeInputs = [ pkgs.systemd ];
        text = ''
          exec sudo systemctl stop wg-quick-wg0.service
        '';
      })
      (pkgs.writeShellApplication {
        name = "wg-gen-peer";
        runtimeInputs = [
          pkgs.wireguard-tools
          pkgs.qrencode
        ];
        text = ''
          export SERVER_PUBKEY="${secrets.hosts.puma.wireguardPublicKey}"
          export SERVER_ENDPOINT="${secrets.hosts.puma.ip}:51820"
          ${builtins.readFile ../scripts/wg-gen-peer.sh}
        '';
      })
    ];
  };
}
