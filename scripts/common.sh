#!/bin/bash
set -e

function find-msbuild {
    powershell -ExecutionPolicy ByPass -File scripts/find-msbuild.ps1
}

function csharp-build {
    if [ "$OSTYPE" = msys ]; then
        msbuild=`find-msbuild`
        if [ $? != 0 ]; then
            exit $?
        fi
        "$msbuild" //m //p:Configuration=$CONFIGURATION //v:minimal "$@"
    else
        msbuild /m /property:Configuration=$CONFIGURATION /verbosity:minimal "$@"
    fi
}

function csharp-clean {
    if [ "$OSTYPE" = msys ]; then
        msbuild=`find-msbuild`
        if [ $? != 0 ]; then
            exit $?
        fi
        "$msbuild" //m //t:Clean //p:Configuration=Debug "$@"
        "$msbuild" //m //t:Clean //p:Configuration=Release "$@"
    else
        msbuild /m /target:Clean /property:Configuration=Debug "$@"
        msbuild /m /target:Clean /property:Configuration=Release "$@"
    fi
}

function dotnet-clr {
    if [ "$OSTYPE" = msys ]; then
        "$@"
    elif which mono64 > /dev/null 2>&1; then
        mono64 "$@"
    else
        mono "$@"
    fi
}

function uno {
    dotnet-clr prebuilt/uno.exe "$@"
}

function h1 {
    str="$@"
    printf "\n\e[92m$str\n"
    for ((i=1; i<=${#str}; i++)); do 
        echo -n -
    done
    printf "\e[39m\n"
}

function p {
    str="$@"
    printf "\e[90m$str\e[39m\n"
    cmd=$1
    shift
    $cmd "$@"
}
