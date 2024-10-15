{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = false;
    disableConfirmationPrompt = false;
    escapeTime = 0; # Time in milliseconds for which tmux waits after an escape is input.
    keyMode = "vi";
    mouse = false;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g status-position top
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @shell_mode 'vi'
          set -g @yank_selection 'clipboard'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-command 'tmux set-buffer -- {} && wl-copy {} && tmux display-message \"Copied {}\"'
          set -g @thumbs-upcase-command 'tmux set-buffer -- {} && wl-copy {} && tmx paste-buffer && tmux display-message \"Copied {}\"'
        '';
      }
    ];
    shortcut = "a"; # prefix
    sensibleOnTop = false;
    shell = null;
    terminal = "screen-256color";
    tmuxinator.enable = false;
    newSession = false; # Automatically spawn a session if trying to attach and none are running.
    extraConfig = ''
      set -g display-time 2000
      set -g renumber-windows on
      set -g set-clipboard on
      unbind-key -T copy-mode-vi Space
      unbind-key -T copy-mode-vi 'v'
      bind -T copy-mode-vi v send -X begin-selection
    '';
  };
}
