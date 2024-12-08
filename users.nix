{lib, 
...}:
{
    
    home-manager.useGlobalPkgs = true;
    home-manager.backupFileExtension = "mback";
    home-manager.useUserPackages = true;

    # home-manager imports
    # handle sub-directories
    home-manager.users.cdaron = ({...}:{
        imports = let 
            dirC = (builtins.readDir ./homemanager);
            mappedList = builtins.map (x: {
                name = x;
                type = (builtins.getAttr x dirC);
            }) (builtins.attrNames dirC);
            filteredList = builtins.filter 
                (x: x.name != "creds.nix" && x.type != "directory" )
                mappedList;
            allImps = builtins.map
                (x: (import ./homemanager/${x.name}))
                filteredList;   
    });
}