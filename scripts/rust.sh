#!/bin/bash

. ../config.conf
. ./libs.sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
