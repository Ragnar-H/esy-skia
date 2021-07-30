[![Build Status](https://dev.azure.com/revery-ui/revery/_apis/build/status/revery-ui.esy-skia?branchName=master)](https://dev.azure.com/revery-ui/revery/_build/latest?definitionId=13&branchName=master)

Skia is a complete 2D graphic library for drawing Text, Geometries, and Images.

See full details, and build instructions, at https://skia.org.


# Running with nixos

rust-skia has solved this. Let's copy [their approach](https://github.com/rust-skia/rust-skia/blob/0f84ea69ac560cbf141a0b94297c59a2d597f774/skia-bindings/README.md#changing-the-executable-used-as-ninja-and-gn) for changing `gn` and `ninja` executables.

1. Enable [Flakes](https://nixos.wiki/wiki/Flakes)
1. Gnarly [workaround for /bin/bash](https://discourse.nixos.org/t/add-bin-bash-to-avoid-unnecessary-pain/5673) - `sudo ln -s /run/current-system/sw/bin/bash /bin/bash`
1. `nix develop`
1. `esy install --global-path=PATH` # add --global-path since esy sometimes does direct lookup of expected locations
1. `esy build --global-path=PATH -v` # add --global-path for same reason as above. Add -v for verbose error message
1. We can get a build going by calling the commands from `build.sh` ourselves.
```
$ $PYTHON_BINARY tools/git-sync-deps
$ ln -s third_party/externals/gyp tools/gyp
$ gn gen out/Static --script-executable=python --cc="clang" --cxx="clang++" --skia_use_system_libjpeg_turbo=true --esy_skia_enable_svg=true --is_debug=false
Done. Made 45 targets from 27 files in 410ms

$ ninja -C out/Static/
ninja: Entering directory `out/Static/'
[1253/1253] link libskia.a

```
1. This is probably because when [nix builds C](https://nixos.wiki/wiki/C) source code the include paths are added via shell scripts and environment variables while Esy strips environment variables during build phase to have consistant builds
1. Need to figure out a way to pass variables and packages to esy. Might need something [like this issue suggests](https://github.com/esy/esy/issues/731)