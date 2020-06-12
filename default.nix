{ pkgs }:

rec {
	rofi-unwrapped-git = pkgs.callPackage ./pkgs/rofi-unwrapped-git {};
        powermenu = pkgs.callPackage ./pkgs/adi1090x/powermenu {
          inherit rofi-unwrapped-git;
        };
        launchers-git = pkgs.callPackage ./pkgs/adi1090x/launchers-git {
          inherit rofi-unwrapped-git;
        };
}
