{ lib,
  ...}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "hm.bk";
  home-manager.useUserPackages = true;

  # home-manager user config for 'bob'
  home-manager.users.cdaron = { ... }: let
    # Read the directory contents
    dirContents = builtins.readDir ./homemanager;

    # Filter out "creds.nix" and non-files (directories)
    filteredFiles = builtins.filter
      (name: name != "creds.nix" && dirContents.${name} == "regular")
      (builtins.attrNames dirContents);

    # Import all valid files
    allImports = builtins.map (name: import ./homemanager/${name}) filteredFiles;
  in {
    imports = allImports;
  };
}
