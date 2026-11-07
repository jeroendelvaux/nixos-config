{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.python;
in
{
  options.modules.home.python.enable = lib.mkEnableOption "Python";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (python313.withPackages (ps: with ps; [
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
  };
}
