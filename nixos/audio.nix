{ ... }:

{
  # realtime audio priority
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
