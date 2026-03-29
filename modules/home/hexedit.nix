{ config, lib, pkgs, secrets, ... }:

{
  options.hexedit.enable = lib.mkEnableOption "Enable hexedit";

  config = lib.mkIf config.hexedit.enable {
    home.packages = with pkgs; [
      hexedit
    ];
  };
}
