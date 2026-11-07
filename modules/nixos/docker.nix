{ config, lib, ... }:

let
  cfg = config.modules.nixos.docker;
in
{
  options.modules.nixos.docker = {
    enable = lib.mkEnableOption "Docker";
    user = lib.mkOption {
      type = lib.types.str;
      description = "The username to grant Docker group access to.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${cfg.user}.extraGroups = [ "docker" ];
  };
}
