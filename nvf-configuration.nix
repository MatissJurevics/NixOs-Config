{ pkgs, lib, ... }: {
  vim = {
    # Theme configuration
    theme = {
      enable = true;
      name = "oxocarbon";
      style = "dark";
    };
    options = {
      shiftwidth = 2;
      tabstop = 2;
    };


    # Core features
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    mini.bracketed.enable = true;
    autopairs.nvim-autopairs.enable = true;

    languages = {
	enableLSP = true;
	enableTreesitter = true;
	nix.enable = true;
	ts.enable = true;
	python = {
          enable = true;
          lsp.enable = true;
          lsp.server = "pyright";
        };
        
    };
  };
}

