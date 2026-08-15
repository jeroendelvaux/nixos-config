{ config, pkgs, pkgs-unstable, ... }:

{
  services.hardware.openrgb.enable = true;

  # To avoid build error:
  #nixpkgs.config.permittedInsecurePackages = [
  #  "mbedtls-2.28.10"
  #];
}
