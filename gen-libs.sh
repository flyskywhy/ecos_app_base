#! /bin/sh

# Author: Li Zheng <flyskywhy@gmail.com>
# Automatically generate libs that current app needed. 

baseDirForScriptSelf=$(cd "$(dirname "$0")"; pwd)
APP_DIR=${baseDirForScriptSelf}

if [ 777 = 777${ECOS_ECC_FILE} ]; then
# lunch in ecos/scripts/envsetup.sh can get ECOS_ECC_FILE
    echo
    echo "Please run bellow command first"
    echo "lunch"
    echo
    exit 1
fi

LIBS_HOST=`grep "export COMMAND_PREFIX" ${ECOS_ECC_FILE%.*}_build/makefile | xargs echo | sed "s/export COMMAND_PREFIX := //" | sed "s/\-$//"`

# libjpeg.a
cd ${APP_DIR}/..
[ ! -d jpeg/.git ] && git clone git://git.ghostscript.com/thirdparty/jpeg.git
cd jpeg
CONFIGURE="--host=${LIBS_HOST} --enable-shared=no CPPFLAGS=-I${APP_DIR}/${ECOS_ECC_FILE%.*}_install/include"
CONFIGURE_LDFLAGS="LDFLAGS=-L${APP_DIR}/${ECOS_ECC_FILE%.*}_install/lib -Ttarget.ld -nostdlib"
LIBS_HOST_FILE=`find -name config.status`
if [ 777 != 777${LIBS_HOST_FILE} ]; then
    if [ 0 = `grep ${LIBS_HOST} -c ${LIBS_HOST_FILE}` ]; then
        ./configure ${CONFIGURE} "${CONFIGURE_LDFLAGS}"
        make clean
    fi
else
    ./configure ${CONFIGURE} "${CONFIGURE_LDFLAGS}"
    make clean
fi
make
cp .libs/libjpeg.a ${APP_DIR}/
cd ${APP_DIR}
