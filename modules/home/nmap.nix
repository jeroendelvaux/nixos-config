{ config, lib, pkgs, secrets, ... }:

{
  options.nmap.enable = lib.mkEnableOption "Enable nmap";

  config = lib.mkIf config.nmap.enable {
    home.packages = with pkgs; [
      nmap
    ];
  };
}
