{ config, lib, pkgs, secrets, ... }:

{
  options.tcpdump.enable = lib.mkEnableOption "Enable tcpdump";

  config = lib.mkIf config.tcpdump.enable {
    home.packages = with pkgs; [
      tcpdump
    ];
  };
}
