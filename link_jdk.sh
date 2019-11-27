#!/bin/bash


# build/sdk
OPENJFX_DIR=$1

# /usr/lib/jvm/java-1.8.0-openjdk
JDK_DIR=$2

echo "OPENJFX_DIR=${OPENJFX_DIR}"
echo "JDK_DIR=${JDK_DIR}"

pushd () {
	command pushd "$@" > /dev/null
}

popd () {
	command popd "$@" > /dev/null
}


function _get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

function _sym {
		echo linking ${JDK_DIR}/$1/$2 to `_get_abs_filename $2`
    sudo rm -rf ${JDK_DIR}/$1/$2
		sudo ln -s `_get_abs_filename $2` ${JDK_DIR}/$1/$2
}



pushd ${OPENJFX_DIR}

pushd bin
for file in *
do
  _sym bin $file
done
popd

pushd lib
for file in *
do
  _sym lib $file
done
popd

pushd rt/lib

_sym jre/lib javafx.properties
_sym jre/lib jfxswt.jar

pushd amd64
for file in *
do
  _sym jre/lib/amd64 $file
done
popd

pushd ext
for file in *
do
  _sym jre/lib/ext $file
done
popd

popd