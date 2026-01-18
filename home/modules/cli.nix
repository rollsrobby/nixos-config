{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-cli
    azurite
    cargo
    colima
    docker
    git-spice
    graphite-cli
    lazydocker
    lua-language-server
    ngrok
    nil
    nix-search-tv
    procps
    sesh
    tmuxp
    typescript
    yq
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        n = "nvim";
        "n." = "nvim .";
        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
        e = "exit";
        c = "clear";
        p = "pnpm";
        b = "bun";
        k = "kubectl";
        d = "docker";
        azs = "azurite -l $TMPDIR/azurite -s";
        ".." = "cd ..";
        "...." = "cd ../..";
        "......" = "cd ../../..";
        grep = "grep --color=auto";
        cat = "bat";
        ll = "eza --icons --git --long --all";
        ls = "eza --icons --git --long";
        oc = "opencode .";
        sml = "tmuxp load ~/.tmuxp/sml.yaml -a";
        tks = "tmux kill-server";
      };

      initContent = ''
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
          function sesh-sessions() {
            {
              exec </dev/tty
                exec <&1
                local session
                session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
                zle reset-prompt > /dev/null 2>&1 || true
                [[ -z "$session" ]] && return
                sesh connect $session
            }
          }

        zle     -N             sesh-sessions
          bindkey -M emacs '\es' sesh-sessions
          bindkey -M vicmd '\es' sesh-sessions
          bindkey -M viins '\es' sesh-sessions    
      '';

      sessionVariables = {
        EDITOR = "nvim";
        PAGER = "less -FirSwX";
      };

    };

    programs.git = {
      enable = true;
      userName = "rollsrobby";
      userEmail = "rms@gitignore.dev";
    };

    neovim.enable = true;
    tmux.enable = true;
    lazygit.enable = true;

    bat.enable = true;
    btop.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    fd.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
    };

    gh.enable = true;
    gh-dash.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    starship.enable = true;

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cx"
      ];
    };
  };
}
