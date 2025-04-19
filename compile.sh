#/usr/bin/bash

TARGET_REPO=https://github.com/beddinao/MetallC64
EMSDK_REPO=https://github.com/emscripten-core/emsdk

mkdir compile-env && cd compile-env

git clone $EMSDK_REPO && cd $EMSDK_REPO

CUR_PWD=pwd

$CUR_PWD/emsdk install latest
$CUR_PWD/emsdk activate latest
source emsdk_env.sh

cd ..
git clone $TARGET_REPO && cd $TARGET_REPO

CUR_PWD=pwd

git switch emscripten_ready

cd assets/SDL3

mkdir build && cd build

emcmake cmake .. && emmake make -j13

cd $CUR_PWD

emmake make
