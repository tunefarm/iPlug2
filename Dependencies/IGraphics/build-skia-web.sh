
DEPOT_TOOLS_PATH=../Build/tmp/depot_tools

if [ ! -d $DEPOT_TOOLS_PATH ]; then
  echo "checking out Depot Tools..."
  git clone 'https://chromium.googlesource.com/chromium/tools/depot_tools.git' $DEPOT_TOOLS_PATH
  export PATH="${PWD}/$DEPOT_TOOLS_PATH:${PATH}"
fi

cd ../Build/src/skia

echo "Syncing Deps..."
python tools/git-sync-deps

./bin/gn gen ../../tmp/skia/web --args='
target_cpu=\"wasm\"
skia_use_system_libjpeg_turbo = false
skia_use_system_libpng = false
skia_use_system_zlib = false
skia_use_system_expat = false
skia_use_system_icu = false
skia_use_system_harfbuzz = false
skia_use_libwebp_decode = false
skia_use_libwebp_encode = false
skia_use_xps = false
skia_use_dng_sdk = false
skia_use_expat = true
skia_use_icu = true
skia_use_sfntly = false
skia_use_direct3d = true
skia_use_gl = true
skia_enable_svg = true
skia_enable_skottie = true
skia_enable_pdf = false
skia_enable_particles = true
skia_enable_gpu = true
skia_enable_skparagraph = true
cc = "clang"
cxx = "clang++"
'

./bin/gn gen ../../tmp/skia/web

ninja -C ../../tmp/skia/web

mv ../../tmp/skia/web/skia.lib ../../web
mv ../../tmp/skia/web/skottie.lib ../../web
mv ../../tmp/skia/web/sksg.lib ../../web
mv ../../tmp/skia/web/skshaper.lib ../../web
mv ../../tmp/skia/web/skparagraph.lib ../../web
mv ../../tmp/skia/web/svg.lib ../../web


