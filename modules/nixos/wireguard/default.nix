{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.wireguard;
in
{
  options.wireguard = {
    enable = lib.mkEnableOption "Enable wireguard";
    address = lib.mkOption {
      type = lib.types.str;
      default = "10.100.0.2/32";
      description = "The WireGuard IP address for this client.";
    };
  };

  config = lib.mkIf cfg.enable {
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
      address = [ cfg.address ];
      mtu = 1280;
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
        name = "mtu-check";
        runtimeInputs = [ pkgs.systemd ];
        text = builtins.readFile ./mtu-check.sh;
      })
      (pkgs.writeShellApplication {
        name = "wg-connect";
        runtimeInputs = [ pkgs.systemd ];
        text = builtins.readFile ./wg-connect.sh;
      })
      (pkgs.writeShellApplication {
        name = "wg-disconnect";
        runtimeInputs = [ pkgs.systemd ];
        text = builtins.readFile ./wg-disconnect.sh;
      })
      (pkgs.writeShellApplication {
        name = "wg-status";
        runtimeInputs = [ pkgs.systemd ];
        text = builtins.readFile ./wg-status.sh;
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
          ${builtins.readFile ./wg-gen-peer.sh}
        '';
      })
    ];

    security.polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units" &&
            action.lookup("unit") == "wg-quick-wg0.service" &&
            subject.user == "${secrets.hosts.tiger.owner.username}") {
            var verb = action.lookup("verb");
            if (verb == "start" || verb == "stop" || verb == "restart") {
              return polkit.Result.YES;
            }
          }
        });
      '';
    };
  };
}
