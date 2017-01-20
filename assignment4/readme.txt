-----------------------------------------------------------------------------------------------------------------------------------------------
								README
-----------------------------------------------------------------------------------------------------------------------------------------------

You are in folder assignment4.
The purpose of this assignment is to find the sysuptime for about 150 devices using non-blocking SNMP calls. Each device is probed every 30 seconds. The results are presented through a web dashboard.

This document describes the information about the various files in this folder, modules/software needed and steps to run this assignment.

This folder consists of 7 files in total:
-----------------------------------------

1. search.php
	 This is the php script which is used to find the path to db.conf which contains details of the database

2.backend.sh
          This is the shell script that calls the perl script backend.pl for every 30 seconds

3. backend.pl
   This is the perl script which runs every 30 seconds.
   It is used to probe 150 devices and obtain their sysuptime with sleep command.

4. 2.php
	 This is the php script which dispalys the detailed information of each selected device. 
	 It displays the device information, the number of sent and lost requests, the sysuptime and the local web server time.

5. index.php
   This the main index page for the web dashboard. 
   It shows the devices list.

6. readme.txt
   This is the text file which describes the details of the various files in the "assignment4" folder and the steps to run this assignment.

     


Software Requirements:
----------------------

1. Operating System: Ubuntu 14.04 LTS.

2. You need to install Apache server, MySQL and PHP.

3. SNMP Modules which are needed to be installed from CPAN are:
	 Data::Dumper
	 DBD::Mysql
	 DBI
   FindBin
   File::Basename
   File::Spec::Functions
 
Steps to run this assignment:
-----------------------------

1. Go to the terminal in move to the directory /var/www/html/et2536-veti15/assignment4/ 
   (Move to the path of your working directory configured in your Apache server)

2. Run the shell script "backend.sh" in the terminal with the command "sh backend.sh". 
	 This script has a sleep command which runs the script "backend.pl" every 30 seconds.

3. Now, open a web browser and type the following URL: (it is assumed that the working directory is in /var/www/html/)
	 http://localhost/et2536-veti15/assignment4/index.php

4. This page dispalys the list of all the devices.

5. You can select any one device and view the detailed information of that device such as IP, Port, Community, SysUpTime, Number of sent and  	 lost requests, Local web server time.
