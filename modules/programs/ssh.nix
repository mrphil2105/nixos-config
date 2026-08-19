{ ... }: {
  flake.modules.homeManager.ssh = { ... }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*".addKeysToAgent = "yes";
    };
    services.ssh-agent.enable = true;
  };
}
