{ config, lib, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      ttf_bitstream_vera
      emojione
      noto-fonts
      noto-fonts-emoji
      roboto
      font-awesome-ttf
    ];
    fontconfig = {
      defaultFonts = {
        serif =     [ "Bitstream Vera Sans"      "EmojiOne Color"  "Font Awesome 5 Free"];
        sansSerif = [ "Bitstream Vera Serif"     "EmojiOne Color"  "Font Awesome 5 Free"];
        monospace = [ "Bitstream Vera Sans Mono" "EmojiOne Color"  "Font Awesome 5 Free"];
      };
    };
  };

  console.font = "Lat2-Terminus16";
}
