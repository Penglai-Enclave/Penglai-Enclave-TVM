#!/bin/bash
# apt-get install flex
# apt-get install bison
make sdk -j8
sh scripts/copy.sh
make -j8
