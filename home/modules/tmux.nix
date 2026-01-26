# tmux.nix (Home Manager module)
{ config, pkgs, lib, ... }:

let
  # If this plugin isn’t in pkgs.tmuxPlugins, fetch it.
  tokyoNightTmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night-tmux";
    version = "unstable-2026-01-21";
    src = pkgs.fetchFromGitHub {
      owner = "rollsrobby";
      repo = "tokyo-night-tmux";
      # Prefer pinning a commit SHA instead of main:
      rev = "master";
      sha256 = "sha256-NuxgECOmwRtGHpCP5J5TZDHjT3Pwyn2gf2zMu5tnwgI="; # replace after first build
    };
    rtpFilePath = "tokyo-night.tmux";
  };
in
{
  programs.tmux = {
    enable = true;

    prefix = "C-a";
    keyMode = "vi";

    # Better than `set -g default-terminal "${TERM}"`
    terminal = "tmux-256color";
    historyLimit = 1000000;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator
      {
        plugin = tokyoNightTmux;
        extraConfig = ''
          # tokyo-night-tmux settings
          set -g @tokyo-night-tmux_theme night
          set -g @tokyo-night-tmux_transparent 1
          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_window_id_style none
        '';
      }
    ];

    extraConfig = ''
      # 24-bit color
      set-option -ga terminal-overrides ",xterm-256color:RGB"

      set -g base-index 1
      set -g detach-on-destroy off
      set -g renumber-windows on
      set -g mouse on
      setw -g mode-keys vi

      set -g pane-active-border-style 'fg=#a6e3a1,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'

      set -g automatic-rename on

      # sesh
      bind-key "o" run-shell "sesh connect \"\$(
        sesh list --icons | fzf-tmux -p 55%,60% \
          --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      )\""

      bind -N "last-session (via sesh) " L run-shell "sesh last"

      # key bindings
      bind -N "⌘+g lazygit " g new-window -c "#{pane_current_path}" -n "🌳 git" "lazygit 2> /dev/null"
      bind | split-window -c '#{pane_current_path}' -h
      bind - split-window -c '#{pane_current_path}' -v
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind -r j resize-pane -D 2
      bind -r k resize-pane -U 2
      bind -r l resize-pane -R 2
      bind -r h resize-pane -L 2
      bind -r m resize-pane -Z

      bind -T copy-mode-vi v send -X begin-selection

      # Wayland clipboard (replace pbcopy)
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

      bind P paste-buffer
      bind x kill-pane
    '';
  };

  # Home Manager packages you referenced in the config
  home.packages = with pkgs; [
    sesh
    fzf
    fd
    lazygit
    gawk
    bc
    wl-clipboard # provides wl-copy / wl-paste
  ];
}
