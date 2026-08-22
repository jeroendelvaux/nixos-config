{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.nvim;
in
{
  options.modules.nvim.enable = lib.mkEnableOption "Enable nvim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      opts = {
        number = true; # Show line numbers.
        shiftwidth = 4;
        softtabstop = -1;
        # Select text with Shift+Arrow keys:
        selectmode = "mouse,key";
        keymodel = "startsel,stopsel";
      };
      # Unlike X (Primary and Clipboard), Wayland has only one clipboard:
      clipboard.register = "unnamedplus";
      keymaps = [
        # Ctrl+a to select all text:
        { key = "<C-a>"; action = "ggVG"; mode = "n"; }
        { key = "<C-a>"; action = "<Esc>ggVG"; mode = "i"; }
        # Ctrl+c to copy:
        { key = "<C-c>"; action = "\"+y"; }
        # Ctrl+x to cut:
        { key = "<C-x>"; action = "\"+x"; }
        # Ctrl+v to paste:
        { key = "<C-v>"; action = "\"+p"; }
        # Ctrl+z to undo:
        { key = "<C-z>"; action = "u"; mode = "n";}
        { key = "<C-z>"; action = "<Esc>ua"; mode = "i";}
        # Backspace to delete selected text:
        { key = "<BS>"; action = "d"; }
        # Tab to indent selected text:
        { key = "<Tab>"; action = ">gv"; }
        # Shift+Tab to unindent selected text:
        { key = "<S-Tab>"; action = "<gv"; }
      ];
      colorschemes.catppuccin.enable = true;
      plugins = {
        # Syntax highlighting for all languages:
        treesitter = {
          enable = true;
          settings.highlight.enable = true;
        };
        # Highlight color names and codes:
        colorizer = {
          enable = true;
        };
        # Language Server Protocol (LSP):
        lsp = {
          enable = true;
          servers = {
            clangd.enable = true; # C
            jsonls.enable = true; # JSON
            texlab.enable = true; # LaTeX
            nixd.enable = true; # Nix
            pylsp.enable = true; # Python
          };
        };
        # Code completion with support for LSPs
        blink-cmp = {
          enable = true;
          settings = {
            completion = {
              accept.auto_brackets.enabled = true;
              documentation.auto_show = true;
            };
          };
        };
        # File navigation and search:
        web-devicons.enable = true; 
        telescope ={
          enable = true;
          keymaps = {
            "<C-f>" = "find_files"; # Ctrl+f
            "<C-g>" = "live_grep"; # Ctrl+g
          };
        };
        # Insert matching parentheses, etc.
        nvim-autopairs.enable = true;
        # Automatically detect indent (tabs or spaces):
        sleuth.enable = true;
      };
      extraConfigVim = ''
        set list
        set listchars=tab:→\ ,space:·
      '';
    };

    programs.ripgrep.enable = true;

    home.sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };
}
