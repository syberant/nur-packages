{
  callPackage
}:

let fetch = { url, sha256 }: callPackage ({ fetchurl }:
  fetchurl { inherit url; inherit sha256; }) {};

  pfetch = {
    # Pick name from pattern "dwm-nameofpatch-versionorgithash"
    name ? builtins.elemAt (builtins.split "-" patchName) 2,
    patchName, sha256
  }: callPackage ({ fetchpatch }:
    fetchpatch {
      name = "${name}.patch";
      url = "https://dwm.suckless.org/patches/${name}/${patchName}.diff";
      inherit sha256;
    }
  ) {};
in {
  swallow = fetch {
    url = "https://dwm.suckless.org/patches/swallow/dwm-swallow-20200707-8d1e703.diff";
    sha256 = "066q054rj84c5l6n17dv97ab7qw2fl315j4drawllv9idm7drnrs";
  };

  namedscratchpads = fetch {
    url = "https://dwm.suckless.org/patches/namedscratchpads/dwm-namedscratchpads-6.2.diff";
    sha256 = "0i8fph7fs2m8ig1kabrw3yq7hm389kdqjhqkqgql16z6mpbvi453";
  };

  keymodes = fetch {
    url = "https://dwm.suckless.org/patches/keymodes/dwm-keymodes-5.8.2.diff";
    sha256 = "0gklgi1wd8z5sir8zjcacddcs8k43cbiqhbnxwidbjdnwp7f6h5k";
  };

  floatrules = pfetch {
    patchName = "dwm-floatrules-6.2";
    sha256 = "0851c3hf6h3kr8x7lj28na3wl1p9wfqf5hl31qw67ibnhgll6y0x";
  };

  actualfullscreen = pfetch {
    patchName = "dwm-actualfullscreen-20191112-cb3f58a";
    sha256 = "05swkivarbcjkhhjd1l8kjgqh8dsqi0dr49xd2xayxinldh9ijj8";
  };

  cyclelayouts = pfetch {
    patchName = "dwm-cyclelayouts-20180524-6.2";
    sha256 = "1y87fgwfdgzycdbyqsmj737g89b2wf5illxpvp4pk4msn8i0w2l8";
  };
}
