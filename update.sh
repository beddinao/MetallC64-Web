#/usr/bin/bash

TARGET_REPO=https://github.com/beddinao/commodore_64_emulator
TARGET_NAME=commodore_64_emulator
EMSDK_REPO=https://github.com/emscripten-core/emsdk
EMSDK_NAME=emsdk
PARENT_DIR=`pwd`
COMPILE_DIR=compile-env

mkdir $COMPILE_DIR && cd $COMPILE_DIR
git clone $EMSDK_REPO && cd $EMSDK_NAME
CUR_PWD=`pwd`

$CUR_PWD/emsdk install latest
$CUR_PWD/emsdk activate latest
source emsdk_env.sh

cd ..
git clone $TARGET_REPO && cd $TARGET_NAME
git switch emscripten_ready
CUR_PWD=`pwd`

cd assets/SDL3
mkdir build && cd build

emcmake cmake .. && emmake make -j20
cd $CUR_PWD
emmake make

cd $PARENT_DIR 
mv $COMPILE_DIR/$TARGET_NAME/c64_emu.wasm $COMPILE_DIR/$TARGET_NAME/c64_emu.js assets
git add assets && git commit -m "update" && git push
rm -rf $COMPILE_DIR

