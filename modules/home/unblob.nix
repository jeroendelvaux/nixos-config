{ config, lib, pkgs, secrets, ... }:

{
  options.unblob.enable = lib.mkEnableOption "Enable unblob";

  config = lib.mkIf config.unblob.enable {
    home.packages = with pkgs; [
      unblob
    ];
  };
}
