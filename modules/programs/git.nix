{ ... }: {
  flake.modules.homeManager.git = { ... }: {
    programs.git = {
      enable = true;
      settings = {
        user.name = "Philip Mørch";
        user.email = "mrphil2105@gmail.com";
        init.defaultBranch = "main";
        pull.rebase = true;
        merge.ff = false;
      };
    };
    programs.lazygit = {
      enable = true;
      settings = {
        git.autoForwardBranches = "none";
        git.autoFetch = false;
        git.autoStageResolvedConflicts = false;
      };
    };
  };
}
