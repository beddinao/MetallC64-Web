#/usr/bin/bash

TARGET_REPO=https://github.com/beddinao/MetallC64
TARGET_NAME=MetallC64
EMSDK_REPO=https://github.com/emscripten-core/emsdk
EMSDK_NAME=emsdk
PARENT_DIR=`pwd`

mkdir compile-env && cd compile-env

git clone $EMSDK_REPO && cd $EMSDK_NAME

CUR_PWD=`pwd`

$CUR_PWD/emsdk install latest
$CUR_PWD/emsdk activate latest
source emsdk_env.sh

cd ..
git clone $TARGET_REPO && cd $TARGET_NAME

CUR_PWD=`pwd`

git switch emscripten_ready

cd assets/SDL3

mkdir build && cd build

emcmake cmake .. && emmake make -j13

cd $CUR_PWD

emmake make

cd ..

mv MetallC64/MetallC64.wasm MetallC64/MetallC64.js assets

git add assets && git commit -m "update" && git push


