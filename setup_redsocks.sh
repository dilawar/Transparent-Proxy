#!/bin/bash
# Originally written by przemoc.net. 
# First modified and shared by Rajesh Veeankani. This is a clone.
# Modified by Dilawar. 
echo "Executing the script..."
cd darkk-redsocks-*/
clear
echo -e "Compiling redsocks\n"
make
sudo mv ./redsocks /usr/local/sbin/redsocks
package=redsocks
if [ $? -eq 0 ]
        then echo -e "$package install succeeded\n"
          rm -rf darkk*
          rm redsocks.zip
        else 
	echo -e "$package install failed..exiting!\n"
	exit 1
fi
clear
echo -e "Configuring redscoks.conf file..n"
redsocks_conf_set(){
touch redsocks.conf

echo "base {
 log_debug = on;
 log_info = on;
 log = \"file:/tmp/redsock.log\";
 daemon = on;
 //user = $USER;
 //group = redsocks;
 redirector = iptables;
}
redsocks {
 /* 'local_ip' defaults to 127.0.0.1 for security reasons,
 * use 0.0.0.0 if you want to listen on every interface.
 * 'local_*' are used as port to redirect to.
 */
 local_ip = 127.0.0.1;
 local_port = 5123;
// 'ip' and 'port' are IP and tcp-port of proxy-server
// This is the ip of proxy.ncbs.res.in
 ip = 172.16.223.223;
 port = 3128;
// known types: socks4, socks5, http-connect, http-relay
 type = http-relay;
}
redsocks {
 local_ip = 127.0.0.1;
 local_port = 5124;
ip = 172.16.223.223;
 port = 3128;
type = http-connect;
}" > $HOME/.redsocks.conf
}

redsocks_conf_set 
sudo groupadd -f redsocks
sudo usermod -a -G redsocks $USER

if [ -f $HOME/.redsocks.conf ];
then 
  echo "\nNOTICE : Configuration file .redsocks.conf is created in your home folder."
else 
  echo "\nConfiguration failed. Existing..."
  exit
fi 

