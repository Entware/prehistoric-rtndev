#!/opt/bin/bash
# Usage:  bash ./setup_config.bash
# Bash only!!! Do not use sh interpretator
CWD=`pwd`
OSNAME=`uname`
USERNAME=`whoami`
MACHINE=`uname -m`
date=`date +%Y%m%d%m%s`
shortdate=`echo ${date} | sed s/^...//`
shortname=fidoip_configs_${shortdate}.tar

T1="root"
T2="Linux"
T3="FreeBSD"
T4="DragonFly"

if [ "$OSNAME" = "$T3" ]; then
Z1="BSD"
fi

if [ "$OSNAME" = "$T4" ]; then
Z1="BSD"
Z2="PKGSRC"
fi


# Declaration of allowed symbol for user input scrubbing
declare -r AllowedChars="1234567890/., :-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

echo "--------------------------------------------------------------------"
echo ""
echo "This script setup fidoip's configuration files for you."
echo ""
echo "--------------------------------------------------------------------"
echo ""


echo "Enter your first and last name and press [ENTER]."
echo -n "Sample -  Vasiliy Pampasov: "
read fullname

if [ -z "$fullname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck="${fullname//[^$AllowedChars]/}"
if [ "$fullname" = "$ScrubbedCheck" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting \ before space
#echo  "$fullname" | sed 's_ _\\ _g' > /opt/tmp/fidoiptmp
echo  "$fullname" | sed 's/ /\\ /g' > /opt/tmp/fidoiptmp
fullname1=`cat /opt/tmp/fidoiptmp`

# Inserting space instead of space

echo  "$fullname" | sed 's/ /\_/g' > /opt/tmp/fidoiptmp
fullname2=`cat /opt/tmp/fidoiptmp`


echo "Enter your station name and press[ENTER]."
echo -n "Sample -  MyStation: "
read stationname

if [ -z "$stationname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck1="${stationname//[^$AllowedChars]/}"
if [ "$stationname" = "$ScrubbedCheck1" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting _ instead space
echo  "$stationname" | sed 's/ /\_/g' > /opt/tmp/fidoiptmp
stationname1=`cat /opt/tmp/fidoiptmp`


echo "Enter your location and press[ENTER]."
echo -n "Sample -  Moscow, Russia: "
read locationname
if [ -z "$locationname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck2="${locationname//[^$AllowedChars]/}"
if [ "$locationname" = "$ScrubbedCheck2" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting _ instead space
echo  "$locationname" | sed 's/ /\_/g' > /opt/tmp/fidoiptmp
locationname1=`cat /opt/tmp/fidoiptmp`

# Inserting space instead -
echo  "$locationname1" | sed 's/_/\ /g' > /opt/tmp/fidoiptmp
locationname2=`cat /opt/tmp/fidoiptmp`

# Deleting spaces


echo  "$locationname" | sed 's/\ //g' > /opt/tmp/fidoiptmp
locationname3=`cat /opt/tmp/fidoiptmp`

# Deleting ,
echo  "$locationname3" | sed 's/\,//g' > /opt/tmp/fidoiptmp
locationname4=`cat /opt/tmp/fidoiptmp`

echo "Enter your FTN address and press [ENTER]."
echo -n "Sample -  2:5020/828.555: "
read ftnaddress
if [ -z "$ftnaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck3="${ftnaddress//[^$AllowedChars]/}"
if [ "$ftnaddress" = "$ScrubbedCheck3" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi


# Select zone number
zonenumber=`echo  "$ftnaddress" | sed 's|\:.*||'`

# Inserting \ before / in a FTN address
echo  "$ftnaddress" | sed 's|/|\\/|g' > /opt/tmp/fidoiptmp
ftnaddress1=`cat /opt/tmp/fidoiptmp`

# Deleting everting before / and /
echo  "$ftnaddress" | sed 's/.*\///' > /opt/tmp/fidoiptmp
pointaddress=`cat /opt/tmp/fidoiptmp`
# Deleting everithing after .
echo  "$pointaddress" | sed 's/\..*//' > /opt/tmp/fidoiptmp
nodeaddress=`cat /opt/tmp/fidoiptmp`

echo -e "Enter uplink full name and press press [ENTER]."
echo -n "Sample -  Kirill Temnenkov: "
read uplinkname
if [ -z "$uplinkname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck4="${uplinkname//[^$AllowedChars]/}"
if [ "$uplinkname" = "$ScrubbedCheck4" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting \ before space
echo  "$uplinkname" | sed 's/ /\\ /g' > /opt/tmp/fidoiptmp
uplinkname1=`cat /opt/tmp/fidoiptmp`



# Changing all space to _ 
echo  "$uplinkname" | sed 's/ /\_/g' > /opt/tmp/fidoiptmp
uplinkname2=`cat /opt/tmp/fidoiptmp`


echo -e "Enter uplink FTN address and press [ENTER]."
echo -n "Sample -  2:5020/828: "
read uplinkftnaddress
if [ -z "$uplinkftnaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck5="${uplinkftnaddress//[^$AllowedChars]/}"
if [ "$uplinkftnaddress" = "$ScrubbedCheck5" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting \ before space
echo  "$uplinkftnaddress" | sed 's|/|\\/|g' > /opt/tmp/fidoiptmp
uplinkftnaddress1=`cat /opt/tmp/fidoiptmp`


echo "Enter uplink server name or IP-address and press [ENTER]."
echo -n "Sample -  temnenkov.dyndns.org: "
read uplinkdnsaddress
if [ -z "$uplinkdnsaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck6="${uplinkdnsaddress//[^$AllowedChars]/}"
if [ "$uplinkdnsaddress" = "$ScrubbedCheck6" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi


echo "Enter uplink password and press [ENTER]."
echo -n "Sample -  12345678: " 
read uplinkpassword
if [ -z "$uplinkpassword" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck7="${uplinkpassword//[^$AllowedChars]/}"
if [ "$uplinkpassword" = "$ScrubbedCheck7" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi



echo ""
echo "--------------------------------------------------------------------"
echo ""

echo -n "Your full name is : "
echo $fullname
echo -n "Your system station name : "
echo $stationname
echo -n "Your FTN address is: "
echo $ftnaddress
echo -n "Your location is : "
echo $locationname
echo -n "Uplink name is : "
echo $uplinkname
echo -n "Uplink FTN address is : "
echo $uplinkftnaddress
echo -n "Uplink server name or IP-address is: "
echo $uplinkdnsaddress
echo -n "Your password is: "
echo $uplinkpassword

echo ""
echo "--------------------------------------------------------------------"
echo ""
# asks if you want to change the original files and acts accordingly.

echo "OK? "
echo "[y/n]"
read reply
echo ""  
if [ "$reply" = "y" ];
	then 

if [ -e /opt/etc/binkd.cfg ]; then
echo '------------------------------------------------------------------------'
echo 'Previos configuration files saved to file:'
echo ''
echo $CWD/$shortname
echo ''
echo '------------------------------------------------------------------------'
echo ''

tar -cf $CWD/$shortname /opt/etc/binkd.cfg /opt/etc/golded+/g* /opt/etc/fido/config /opt/sbin/recv /opt/sbin/send > /dev/null 2>&1
sleep 3 
fi

mkdir -p /opt/etc/fidoip/
cp -p /opt/etc/fidoip/binkd.cfg.template /opt/etc/binkd.cfg
cp -p /opt/etc/fidoip/config.template  /opt/etc/fido/config
cp -p /opt/etc/fidoip/decode.txt.template /opt/etc/golded+/golded.cfg
cp -p /opt/etc/fidoip/recv.template /opt/sbin/recv
cp -p /opt/etc/fidoip/send.template /opt/sbin/send


#if [ "$T2" = "$OSNAME" ]; then
echo ''
echo 'Detecting OS...'
echo 'Your OS is Linux.'

sed -i "2s/Vasiliy\ Pampasov"/"$fullname1""/" /opt/etc/fido/config
sed -i "3s/Moscow"/"$locationname4""/" /opt/etc/fido/config
sed -i "4s/Vasiliy\ Pampasov"/"$fullname1""/" /opt/etc/fido/config
sed -i "34s/Vasiliy\ Pampasov"/"$fullname1""/" /opt/etc/fido/config
sed -i "67s/Vasiliy\ Pampasov"/"$fullname1""/" /opt/etc/fido/config
sed -i "1s/Vasiliy\ Pampasov"/"$fullname1""/" /opt/etc/golded+/golded.cfg

sed -i "6s/Falcon"/"$stationname1""/" /opt/etc/binkd.cfg


sed -i "7s/Moscow"/"$locationname1""/" /opt/etc/binkd.cfg
sed -i "7s/$locationname1"/"$locationname2""/" /opt/etc/binkd.cfg


sed -i "5s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/binkd.cfg

sed -i "2s|outbound\ 2|outbound\ "$zonenumber"|" /opt/etc/binkd.cfg

sed -i "6s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/fido/config
sed -i "11s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/fido/config
sed -i "70s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/fido/config
sed -i "71s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/fido/config
sed -i "3s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "67s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "95s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "96s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "97s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "98s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "99s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "100s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "101s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "102s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "103s/2:5020\/828.555"/"$ftnaddress1""/" /opt/etc/golded+/golded.cfg

sed -i "81s/a828"/"a$nodeaddress""/" /opt/etc/golded+/golded.cfg
sed -i "82s/a828"/"a$nodeaddress""/" /opt/etc/golded+/golded.cfg
sed -i "96s/828\.local"/"$nodeaddress"\.local"/" /opt/etc/golded+/golded.cfg
sed -i "96s/828\.local"/"$nodeaddress"\.local"/" /opt/etc/golded+/golded.cfg

sed -i "9s/Kirill\ Temnenkov"/"$uplinkname1""/" /opt/etc/fido/config
sed -i "8s/Kirill_Temnenkov"/"$fullname2""/" /opt/etc/binkd.cfg

sed -i "33s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/binkd.cfg

sed -i "10s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config
sed -i "19s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config
sed -i "40s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config
sed -i "41s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config
sed -i "42s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config
sed -i "43s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config
sed -i "44s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/fido/config

sed -i "69s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/golded+/golded.cfg
sed -i "82s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/etc/golded+/golded.cfg

sed -i "2s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/sbin/recv
sed -i "4s/2:5020\/828"/"$uplinkftnaddress1""/" /opt/sbin/send


sed -i "33s/temnenkov.dyndns.org"/$uplinkdnsaddress"/" /opt/etc/binkd.cfg

sed -i "33s/12345678"/$uplinkpassword"/" /opt/etc/binkd.cfg
sed -i "82s/12345678"/"$uplinkpassword""/" /opt/etc/golded+/golded.cfg
sed -i "12s/12345678"/$uplinkpassword"/" /opt/etc/fido/config
sed -i "40s/828\.local"/"$nodeaddress"\.local"/" /opt/etc/fido/config
sed -i "40s/828\.local"/"$nodeaddress"\.local"/" /opt/etc/fido/config
sed -i "34s|defnode\ \-nr\ \*|\#for\ default\ node\ use\#\ defnode\ \-nr\ \-nd\ \-md\ \-|" /opt/etc/binkd.cfg

# Fixing netmailarea scanning bug for hpt x86_64  
if [ "$MACHINE" = "x86_64" ]; then
sed -i "31s/netmailarea\ -b\ msg"/netmail\ -b\ squish"/" /opt/etc/fido/config
sed -i "95s/netmailarea"/"netmail""/" /opt/etc/golded+/golded.cfg
fi

# Set codepage of URL for ru_RU.KOI8-R  
#if [ "$LANG" = "ru_RU.KOI8-R" ]; then
#sed -i "s|t\ UTF-8|t\ KOI8R|" /opt/etc/golded+/golded.cfg
#fi

#sed -i "s|luit\ -encoding|luit\ -x\ -encoding|" /opt/sbin/gl
sed -i "s|null\ \&|null\ 2\>\&1\ \&|" /opt/etc/golded+/golded.cfg
sed -i "s|EditCompletion|UseSoftCRxlat\ Yes\ \;EditCompletion|" /opt/etc/golded+/golded.cfg

echo "OK. Original configuration files modified successfully."
echo "Please review configuration files."  
#fi

if [ -e /opt/tmp/fidoiptmp ]; then
	rm /opt/tmp/fidoiptmp
fi

if [ -e /opt/tmp/binkd.cfg1 ]; then
	rm /opt/tmp/binkd.cfg*
	rm /opt/tmp/recv1
	rm /opt/tmp/send1
	rm /opt/tmp/config*
	rm /opt/tmp/golded.cfg*
        rm /opt/tmp/gl1
fi


elif [ "$reply" = "n" ];
	then 
echo "Please modify configuration files manually or run this script again."

fi
