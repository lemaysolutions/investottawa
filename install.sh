#!/bin/sh
RED='\033[0;31m'
BLUE='\033[1;34m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
HIGHLIGHTGREEN='\033[102m'
#HIGHLIGHTYELLOW='\033[102m'

printf "${BLUE} ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ \n"
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
printf "${BLUE} ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ \n"
printf "${NC}"

echo "Lemay Solutions Consulting, Inc."
echo  "Installation Script for InvestOttawa / IBM I3"


# install all libraries
printf "${BLUE}Updating and installing libraries and packages...${NC}\n"
apt-get update
apt-get -y install wget git-core ipython ipython-notebook build-essential libssl-dev libffi-dev python-dev python3-pip python3-numpy python3-scipy

# install all Python3 libraries
printf "${BLUE}Installing python3 libraries and packages...${NC}\n"
pip3 install pandas keras PyMySQL requests tensorflow==1.5.0 geopandas==0.2.1 jupyter uwsgi flask scikit-learn

# update numpy for 0xa/0xb version issue
printf "${BLUE}Patch for NumPy version issues...${NC}\n"
pip3 install --upgrade numpy 

# generate OpenSSL cert for Jupyter 
printf "${BLUE}Generating OpenSSL certificate for Jupyter Notebook...${NC}\n"
openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout /home/mykey.key -out /home/mycert.pem

# create folders where files and demos will be held
printf "${BLUE}Create folders where files and demos will be held...${NC}\n"
mkdir /root/notebooks
mkdir /root/notebooks/deep-learning-with-python-notebooks

# configure jupyter notebook
printf "${BLUE}Create folders where files and demos will be held...${NC}\n"
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
printf "${BLUE}ENTER PASSWORD FOR JUPYTER:${NC}\n"
jupyter notebook password

# Download examples for machine learning
printf "${BLUE}Cloning demo repos...${NC}\n"
git clone https://github.com/fchollet/deep-learning-with-python-notebooks /root/notebooks/deep-learning-with-python-notebooks

# start jupyter notebook 
printf "${BLUE}Nohup for Jupyter...${NC}\n"
nohup jupyter notebook --allow-root &
