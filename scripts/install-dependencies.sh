#!/bin/bash

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ..

if [[ ! -z $(which yum) ]]; then
    sudo yum install -y pandoc python3 python3-pip python3-setuptools
elif [[ ! -z $(which apt-get) ]]; then
    sudo apt-get update
    sudo apt-get install -y pandoc python3 python3-pip python3-setuptools
fi

pip3 install -r requirements.txt
