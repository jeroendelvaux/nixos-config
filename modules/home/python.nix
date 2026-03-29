{ config, lib, pkgs, secrets, ... }:

{
  options.python.enable = lib.mkEnableOption "Enable python";

  config = lib.mkIf config.python.enable {
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
