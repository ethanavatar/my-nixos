{ inputs, lib, config, pkgs, ...}:
let
  sessionVariables = {
    BROWSER = "firefox";
    MOZ_USE_XINPUT2 = "1";
  };
in {
  home.sessionVariables = sessionVariables;
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      }; 
      DisablePocket = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
    };
  };
}
