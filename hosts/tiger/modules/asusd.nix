{ config, lib, ... }:

let
  cfg = config.modules.nixos.asusd;
in
{
  options.modules.nixos.asusd = {
    enable = lib.mkEnableOption "asusd";
  };

  config = lib.mkIf cfg.enable {
    services.asusd.enable = true;
    system.activationScripts.asusd-etc = ''
      mkdir -p /etc/asusd
      chown root:root /etc/asusd
      chmod 0755 /etc/asusd
    '';
  };
}
