#!/usr/bin/env nix-shell
#!nix-shell -i bash -p iprange wget

ip6file=ipv6-all-zones.tar.gz
ip4file=all-zones.tar.gz


mkdir -p tmp

echo "Download zone files..."
wget http://www.ipdeny.com/ipblocks/data/countries/$ip4file
tar -C tmp -xf $ip4file

echo "Shrink zone files..."
for i in `ls tmp`; do
  iprange tmp/$i > ipv4/$i
done

rm -r tmp
rm $ip4file

echo "Download IPv6 zone files"
wget http://www.ipdeny.com/ipv6/ipaddresses/blocks/$ip6file
tar -C ipv6 -xf $ip6file
rm $ip6file
