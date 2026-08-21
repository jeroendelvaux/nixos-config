{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.python;
in
{
  options.python.enable = lib.mkEnableOption "Enable python";

  config.home.packages = lib.mkIf cfg.enable [
    (pkgs.python313.withPackages (ps: with ps; [
      h5py
      matplotlib
      numpy
      pandas
      pycryptodome
      requests
      scipy
      tqdm
    ]))
  ];
}
