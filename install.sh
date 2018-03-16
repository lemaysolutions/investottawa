#!/bin/sh
RED='\033[0;31m'
BLUE='\033[1;34m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^${WHITE}#####${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^${WHITE}#:::#  ##     ##     ##     ##     #####${BLUE}^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^${WHITE}#:::# #::::# #::::# #::::# #::::#  #:::#${BLUE}^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^${WHITE}#:::# #:::::##:::::##:::::##:::::# #:::#${BLUE}^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^${WHITE}#:::#  #::::# #::::# #::::# #::::# #:::#${BLUE}^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^${WHITE}#####     ##     ##     ##     ##  #:::#${BLUE}^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${WHITE}#:::#${BLUE}^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${WHITE}#####${BLUE}^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${BLUE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
printf "${NC}"

echo "Lemay Solutions Consulting, Inc."
echo  "Installation Script for InvestOttawa / IBM I3"


# install all libraries
apt-get -y update install wget git-core ipython ipython-notebook build-essential libssl-dev libffi-dev python-dev python3-pip python3-numpy python3-scipy

# install all Python3 libraries
pip3 install pandas keras PyMySQL requests tensorflow==1.5.0 geopandas==0.2.1 jupyter uwsgi flask scikit-learn

# generate OpenSSL cert for Jupyter 
openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout /home/mykey.key -out /home/mycert.pem

# create folders where files and demos will be held
mkdir /root/notebooks
mkdir /root/notebooks/deep-learning-with-python-notebooks

# configure jupyter notebook
jupyter notebook --generate-config
echo "c = get_config()" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.IPKernelApp.pylab = 'inline'" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.certfile = u'/home/mycert.pem'" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.keyfile = u'/home/mykey.key'" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = '/root/notebooks'" >> /root/.jupyter/jupyter_notebook_config.py

# Enter password for Jupyter
echo "ENTER PASSWORD FOR JUPYTER"
jupyter notebook password

# Download examples for machine learning
git clone https://github.com/fchollet/deep-learning-with-python-notebooks /root/notebooks/deep-learning-with-python-notebooks

# start jupyter notebook 
nohup jupyter notebook --allow-root &
