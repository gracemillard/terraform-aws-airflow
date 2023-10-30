#!/bin/bash

set -x

# function install_anaconda() {
#     wget --quiet https://repo.continuum.io/archive/Anaconda2-5.1.0-Linux-x86_64.sh -O Anaconda-latest-Linux-x86_64.sh

#     bash Anaconda-latest-Linux-x86_64.sh -f -b -p /home/centos/anaconda2 > /dev/null

#     rm -f Anaconda-latest-Linux-x86_64.sh
# }

# function install_with_conda() {
#     for PACKAGE in $*; do
#         conda install -qy $PACKAGE
#     done
# }

 function install_with_pip() {
     for PACKAGE in $*; do
         pip3 install $PACKAGE
     done
 }

function install_dependencies() {
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install git
    sudo apt install python3-pip
    # sudo apt-get install python3-virtualenv
    sudo apt install python3.11-venv
    python3 -m venv venv
    source venv/bin/activate
    # sudo apt -y install postgresql-12 postgresql-client-12
}

function install_python_packages() {
   # echo ". /home/centos/anaconda2/etc/profile.d/conda.sh" >> /home/centos/.bashrc

   # source /home/centos/anaconda2/etc/profile.d/conda.sh

    #conda update -yn base conda
    ##conda create -q -yn py34 python=3.4
    #conda activate py34

    #pip install -q --upgrade pip

    #install_with_conda \
    #    numpy \
    #    scipy \
    #    scikit-learn \
    #    pandas

    #pip install -qU setuptools --ignore-installed

    install_with_pip \
        apache-airflow \
        psycopg2-binary \
        cryptography \
        pandas \
        numpy  

   # chown -R centos: /home/centos/anaconda2
}

function start_airflow() {
    mkdir -p /home/admin/airflow
    mkdir -p /home/admin/airflow/dags

    mv /var/tmp/airflow.cfg /home/admin/airflow/

    export AIRFLOW_HOME=/home/admin/airflow 

    chown -R admin:admin /home/admin/airflow

    #conda activate py34
   # airflow initdb
    airflow db migrate

    mkdir -p /var/log/airflow

    nohup airflow webserver > /var/log/airflow/webserver.log &
    nohup airflow scheduler > /var/log/airflow/scheduler.log &
}

START_TIME=$(date +%s)

service sshd start

install_dependencies
#install_anaconda
install_python_packages
start_airflow

END_TIME=$(date +%s)
ELAPSED=$(($END_TIME - $START_TIME))

echo "Deployment complete. Time elapsed was [$ELAPSED] seconds"
