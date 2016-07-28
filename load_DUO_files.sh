#!/bin/sh
#
#       LETS ADD Duo RHEL6 files from the WEB,Github ... etc ...
#       ---RobO MAY 2014
#
#
echo "DOU install Started ................."

cd /root
yum -y install openssl-devel
yum -y install pam-devel
#### go get Duo ---compile it
echo "get the DOU EXEC ................."
wget https://dl.duosecurity.com/duo_unix-latest.tar.gz
tar zxf duo_unix-latest.tar.gz
cd duo_unix-1.9.18/
./configure --with-pam --prefix=/usr && make && sudo make install

cd /root
# SAV file to be changed
mv /etc/pam.d/system-auth /etc/pam.d/system-auth.ORG
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.SAV
mv /etc/duo/pam_duo.conf /etc/duo/pam_duo.conf.SAV
mv /etc/pam.d/sshd /etc/pam.d/sshd.ORG

#go get them from GITHUB
echo "go get the FILES needed from GITHUB"
cd /etc/duo/
getno https://raw.githubusercontent.com/RobOJHU/DUO-Security/master/pam_duo.conf
chmod 600 ./pam_duo.conf
cd /etc/pam.d/
getno https://raw.githubusercontent.com/RobOJHU/DUO-Security/master/system-auth
getno https://raw.githubusercontent.com/RobOJHU/DUO-Security/master/sshd
cd /etc/ssh/
getno https://raw.githubusercontent.com/RobOJHU/DUO-Security/master/sshd_config


service sshd restart



echo "DOU install completed for a RHEL6 machine --RobO"
echo "##########"
echo "##########"
echo "##########   you MUST remember to FIX the now obfuscated  /etc/duo/pam_duo.conf FILE ########"
echo "##########"
echo "##########"
