#!/bin/sh
# Install dependencies
yum -y install openssl openssl-devel
yum -y install zlib
yum -y install gcc gcc-c++
if [ ! -x $python3 ];then
# Download the Pyhotn 3.6 source code version
if [ ! -f Python-3.6.5.tgz ];then
wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz;
# Unzip file
tar zxvf Python-3.6.5.tgz
fi
# Go into the directory
cd Python-3.6.5
# Change the option and install with openssl
# Use sed to operate the Setup.dist
sed -i -e s/#_ssl/_ssl/ -e'/_ssl/{n;s/#//;{n;s/#//;}}' Modules/Setup.dist
./configure --prefix=/usr
# Make the configure
make
# Install Python3
make install
fi
# We use python3 -m before pip to avoid confliction of python2.7 and python3.6
# This command will use python3.6's pip and will not affect the python2.7
python3 -m pip install virtualenv
# Create a virtual environment
# We use the virtualenv to make sure some operation will not affect the system's python
if [ ! -d myproject ];then
python3 -m virtualenv myproject
# Activate the virtual environment
fi

source myproject/bin/activate

# The Uwsgi framework is a python web server framework
pip install -U uwsgi
# The flask is a framework of python web application
pip install -U flask
# Install pandas for operating file of data
pip install -U pandas
# install pandas will auto-install numpy
# Sklearn is a highly-intergated api of machine learning
pip install -U sklearn
# Install jieba
pip install -U jieba
# Install scipy
pip install -U scipy
# Install the nginx
if [ ! -f /etc/yum.repos.d/nginx.repo ];then
echo "[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/mainline/centos/7/\$basearch/
gpgcheck=0
enabled=1">/etc/yum.repos.d/nginx.repo
fi

yum update
yum -y install nginx

# Configure the project
#if [ ! -f nginxbak.conf ];then
#cp /etc/nginx/nginx.conf nginxbak.conf;
#fi
# Replace the config file
#cp nginx.conf /etc/nginx/nginx.conf
# Start the nginx
#systemctl restart nginx
#nginx -t /etc/nginx/nginx.conf
#nginx -c /etc/nginx/nginx.conf
#nohup uwsgi --ini wsgi.ini --thunder-lock &
#echo "The server is started!"
#deactivate
