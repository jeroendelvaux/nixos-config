{ config, lib, pkgs, secrets, ... }:

{
  options.btop.enable = lib.mkEnableOption "Enable btop";

  config = lib.mkIf config.btop.enable {
    home.packages = with pkgs; [
      btop
    ];
  };
}
