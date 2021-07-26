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

`esy build` currently fails with `fontconfig/fontconfig.h file not found`

```
clude -std=c++11 -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Wnon-virtual-dtor -Wno-noexcept-type -Wno-abstract-vbase-init -Wno-weak-vtables -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-undefined-func-template -c ../../src/ports/SkFontConfigInterface_direct.cpp -o obj/src/ports/fontmgr_fontconfig.SkFontConfigInterface_direct.o
In file included from ../../src/ports/SkFontConfigInterface_direct.cpp:13:
../../src/ports/SkFontConfigInterface_direct.h:14:10: fatal error: 'fontconfig/fontconfig.h' file not found
#include <fontconfig/fontconfig.h>
         ^~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
[66/1230] compile ../../src/shaders/gradients/SkGradientShader.cpp
ninja: build stopped: subcommand failed.
error: command failed: 'bash' './esy/build.sh' 'linux' '/home/ragnar/.esy/3__________________________________________________________________/i/esy_libjpeg_turbo-e4385a3b' (exited with 255)
esy-build-package: exiting with errors above...
error: build failed with exit code: 1
  
esy: exiting due to errors above

```
