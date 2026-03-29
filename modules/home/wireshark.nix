{ config, lib, pkgs, secrets, ... }:

{
  options.wireshark.enable = lib.mkEnableOption "Enable wireshark";

  config = lib.mkIf config.wireshark.enable {
    home.packages = with pkgs; [
      wireshark
    ];
  };
}
