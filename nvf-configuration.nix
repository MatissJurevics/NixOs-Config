{ pkgs, ... }: {
  config = {
    # Theme configuration
    theme = {
      enable = true;
      name = "nightfox";
      style = "nordfox";
    };

    # Core features
    lualine.enable = true;
    telescope.enable = true;
    treesitter.enable = true;

    # Language Server Protocol
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        rust-analyzer.enable = true;
      };
    };
  };
}

