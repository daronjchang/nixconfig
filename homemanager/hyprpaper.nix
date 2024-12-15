{ ...}:
let
  dirContents = builtins.readDir ./wallpapers;
      # Filter out "creds.nix" and non-files (directories)
  filteredFiles = builtins.filter (name:
    let 
      isFile = dirContents.${name} == "regular";
      isImage = builtins.match ".*\.(png|jpg)$" name != null;
    in
      isFile && isImage
  ) (builtins.attrNames dirContents);
in 
{
  programs.hyperpaper = {
    enable = true;
    ipc = true;
    slash = false;
    preload = builtins.map (name: ./wallpapers + "/${name}") filteredFiles;
    wallpapers = [
      {
      path = builtins.head (builtins.map (name: ./wallpapers + "/${name}") filteredFiles);
      monitor = "";
      }
    ];
  };
}




