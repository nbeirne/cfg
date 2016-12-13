function fish_user_key_bindings
  #fish_vi_mode 
  fish_vi_key_bindings

  # escape in default mode goes to insert
  bind -m insert \e cancel force-repaint

  # CTRL-D
  bind -M insert \cd kill-whole-line
  bind \cd kill-whole-line

  # home / end
  bind -k home beginning-of-line force-repaint
  bind -k end end-of-line force-repaint

  # accidental caps :]
  bind :Q exit
end
