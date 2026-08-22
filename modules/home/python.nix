{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.python;
in
{
  options.modules.python.enable = lib.mkEnableOption "Enable python";

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
