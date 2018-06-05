#!/bin/sh
set -e
clang -v -dynamiclib -o libiosmac_preload.dylib -fmodules -Wall preload.m
