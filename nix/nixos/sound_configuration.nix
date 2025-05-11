{
  services.pipewire = {
    enable = true;
    # without this setting, OBS had no audio input, pavucontrol did not work
    # and videos in firefox did not have sound
    pulse = {
      enable = true;
    };
    audio = {
      enable = true;
    };
  };
}
