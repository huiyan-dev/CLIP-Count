#!/usr/bin/bash

set -e

env_root_dir=~/.counting_jdl
python_exec=""
virtualenv_exec=""

function check_env() {
  # check python
  if (! which python3)>/dev/null; then
    printf '[ERROR} : python3 not found , you must install python3 first.\n'
    exit
  else
    python_exec=$(which python3)
  fi
  # check virtualenv
  if ! (which virtualenv)>/dev/null; then
    printf '[ERROR} : virtualenv not found, you must install python3 first.sudo apt install virtualenv or pip install virtualenv.\n' 
    read -r -p "Are you want to install it by 'sudo apt install virtualenv'? [y/N] " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
      if ! (sudo apt install virtualenv);then
        printf "[ERROR] : can not install virtualenv automaticly."
      else
        virtualenv_exec=$(which virtualenv)
      fi
    else
      exit
    fi
  else
    virtualenv_exec=$(which virtualenv)
  fi
}

check_env

printf '[INFO] : use python : %s.\n' "$python_exec"
printf '[INFO] : use virtualenv : %s.\n' "$virtualenv_exec"
printf '[INFO] : \033[33m if not exist python env of %s then create in it.\033[0m\n' "$env_root_dir"


if [ ! -d $env_root_dir ]; then
  printf 'start create env, exec : virtualenv %s -p %s \n' "$env_root_dir" "$python_exec"
  "$virtualenv_exec" "$env_root_dir" -p "$python_exec"
fi

# activate virtual python env
printf "[INFO] activate env : source %s/bin/activate\n" "$env_root_dir"
source $env_root_dir/bin/activate

# pip install git+https://github.com/openai/CLIP.git
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 --index-url https://download.pytorch.org/whl/cu118 -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir
# pip install -r requirements.txt
# pip install ftfy regex tqdm