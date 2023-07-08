# <a name="top"></a> Cap git-github.11 - Implementiamo Git per TT-ODOO



## Risorse interne

-[]()



## Risorse esterne

-[](https://www.cybrosys.com/blog/odoo-15-development-environment-using-pycharm-in-ubuntu-20-04)
- [](https://www.cybrosys.com/blog/how-to-install-odoo-16-on-ubuntu-2004-lts)


Odoo 15 Development Environment Using Pycharm in Ubuntu 20.04
Technical Odoo 15

Odoo 15 is the newest version of Odoo which is the most advanced and prominent version of the software to achieve ultimate business management with dedicated tools and functional options. Odoo 15 uses Python 3.8+ for the backend development, PostgreSQL for the database server, and JavaScript for the frontend development.

In this blog, we will discuss how to set up a development environment for Odoo 15 using Pycharm IDE.

So before configuring the Pycharm we need to initially install some necessary libraries and packages to run Odoo. Let’s look at that step by step.

## Step 1: Install Pycharm IDE

Pycharm is available in 3 different Editions: Education, Community, and Enterprise. Here we are going to install the Pycharm Community edition and to run Pycharm you need certain minimum system requirements.

Requirement	Minimum	Recommended
Operating System	64-bit of Linux distribution that supports Gnome, KDE, or Unity DE, Microsoft Windows 8 or later, and macOS 10.13 or later	The latest 64-bit version of Windows, macOS, or Linux
RAM	4 GB of free RAM	8 GB of total system RAM
Disk Space	2.5 GB and another 1 GB for caches	SSD drive with at least 5 GB of free space
To install Pycharm either you can directly download the Debian installation file from the following link Download Pycharm
Or Open Terminal (you can use Ctrl + Alt + T to open terminal) and execute the following commands:

sudo apt-get update 
sudo apt-get upgrade
sudo snap install pycharm-community --classic

## Step 2: Install Python3 and necessary packages
We can install the Python3 using the following command:
sudo apt-get install -y python3-pip
The installation of the necessary packages for Python3 can be done using the following code:
sudo apt-get install python-dev python3-dev build-essential libjpeg-dev libpq-dev libjpeg8-dev libxml2-dev libssl-dev libffi-dev libmysqlclient-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev liblcms2-dev 

## Step 3: Install Web dependencies
Next, we have to install the web dependencies:
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs/usr/bin/node 
sudo npm install -g less less-plugin-clean-css 
sudo apt-get install -y node-less

## Step 4: Install the Wkhtmltopdf
If you require to print reports that are generated in Odoo you need to install Wkhtmltopdfwhich can be done using the following code:
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb 
sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb 
sudo apt install -f

## Step 5: Install PostgreSQL
Next, we have to install PostgreSQL:
sudo apt-get install postgresql

## Step 6: Create a Database User Role for Handling Odoo Databases
Next, a password for the distinctive user should be defined, which is needed later in the conf file:
sudo su - postgres
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo15
Make the defined user a superuser
psql
ALTER USER odoo15 WITH SUPERUSER;
And Exit from psql and also from Postgres user
\q 
exit

## Step 7: Download Odoo 15 Source Code
You can download Odoo 15 Community Source code directly from Odoo’s Github repository
Otherwise, you can clone it from git. For that you have to install git, follow the below commands:
sudo apt-get install git
The following command will clone the Odoo source into the odoo15 directory inside your home directory
git clone https://www.github.com/odoo/odoo --depth 1 --branch 15.0 --single-branch odoo15
Step 8: Install Required Python Packages
Odoo required some python packages to be installed, which are listed in the file requirement.txt inside the odoo15 directory.
cd odoo15
sudo pip3 install -r requirements.txt
or
sudo pip3 install -r <path to inside odoo directory>/requirements.txt
Proper Installation of all the elements should be done, otherwise, you may get errors in the future while functioning with Odoo.
Step 9: Open Odoo Project in Pycharm
Open Pycharm Community and Open odoo15 directory
odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

After loading the project, a dialogue box may appear as shown in the below screenshot. If you want to use a virtual environment you can select OK, but here we are not using a virtual environment. So Cancel it.

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

Step 10: Create odoo.conf File inside odoo15 Directory

Right-click on the directory -> New -> File -> odoo.conf

Paste the following block into the file odoo.conf, and you should change the db_password, which is the password you set for the database user odoo15 in the earlier step.

[options]
; Is This The Password That Allows Database Operations:
admin_passwd = admin
db_host = localhost
db_port = 5432
db_user = odoo15
db_password = False
addons_path = /home/user/odoo/addons
xmlrpc_port = 8015
And also change the addons_path value with the actual path of the addons directory inside odoo15.

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

To get the path select the directory and press Ctrl + Shift + C. Then you will get the path of the current directory. Replace it in the addons_path. You can also create another directory to add your custom modules, and that directory’s path also needs to be added in the addons_path separated by commas. 

eg: addons_path = /home/user/odoo/addons, /home/user/odoo/custom_addons

Step 11: Add Python Interpreter

Go to File -> Settings -> Project: odoo15 -> Python Interpreter

Click on the marked icon in the below screenshot and select the Add option available.

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

From the next dialogue box select option System Interpreter and the Python version on the right filed.

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

Step 12: Add Project Configuration in Pycharm

Click the Add Configuration button in the below screenshot

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

Then the following dialogue box will appear, click the ‘+’ button and select ‘Python’ from the list

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

Then you can fill the fields as the ones shown below screenshot.

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

Name: you can provide any name to identify the configuration.

Script Path: Select file ‘odoo-bin’ file from odoo15 directory.

Parameters: Here you can add the parameters to run along with the script, -c is the required parameter and provide a conf file along with it and multiple parameters can be added.

Python Interpreter: Python Interpreter of this project should be added here. It will automatically fill there because we already set the interpreter in the previous step.

Step 13: Test Run Odoo 15

Configuration of Odoo is completed, now you can test it by running the project by clicking the button below.

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

And you can see the status in the log as shown below:

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

Now you can try it on your browser and check localhost:8015

If all your configuration was successful, the browser will navigate to the database manager of Odoo as shown below:

odoo-15-development-environment-using-pycharm-in-ubuntu-20-04

With the new Odoo version 15, you will be able to manage the business with dedicated and well-defined tools that are available that will support the aspects of the business operations at all levels.


