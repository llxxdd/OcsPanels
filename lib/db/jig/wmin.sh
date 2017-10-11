#!/bin/bash

# install webmin
cd
wget "https://raw.githubusercontent.com/llxxdd/sys/master/lib/web/google/webmin_1.850_all.deb"
dpkg --install webmin_1.850_all.deb;
apt-get -y -f install;
rm /root/webmin_1.850_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf


/sbin/iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
/sbin/iptables -A FORWARD -p tcp -s 172.16.0.0/16 --dport 1024:65534 -j DROP
/sbin/iptables -A FORWARD -p ump -s 172.16.0.0/16 --dport 1024:65534 -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
/sbin/iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
/sbin/iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
/sbin/iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
/sbin/iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP

iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 1024:65534 -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP

service webmin restart
service vnstat restart
rm webmin.sh
