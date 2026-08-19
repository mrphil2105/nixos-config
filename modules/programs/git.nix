{ ... }: {
  flake.modules.homeManager.git =
    { lib, ... }:
    let
      deltaCommand = lib.concatStringsSep " " [
        "delta"
        "--dark"
        "--paging=never"
        "--line-numbers"
        "--hyperlinks"
        ''--hyperlinks-file-link-format="lazygit-edit://{path}:{line}"''
      ];
    in
    {
      programs = {
        git = {
          enable = true;
          settings = {
            user = {
              name = "Philip Mørch";
              email = "mrphil2105@gmail.com";
            };
            init.defaultBranch = "main";
            pull.rebase = true;
            merge.ff = false;
          };
        };
        lazygit = {
          enable = true;
          settings.git = {
            autoForwardBranches = "none";
            autoFetch = false;
            autoStageResolvedConflicts = false;
            diffRenderers = [
              {
                command = deltaCommand;
              }
            ];
          };
        };
        delta = {
          enable = true;
          enableGitIntegration = true;
          options.line-numbers = true;
        };
      };
    };
}
