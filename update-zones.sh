#!/usr/bin/env nix-shell
#!nix-shell -i bash -p iprange curl

url="www.cc2asn.com/data/"



echo "Download and & Shrink zone files..."
for i in `cat cc-list`; do
  echo "$i"
  curl -s ${url}${i}_ipv4 | iprange > ipv4/${i}.zone
  curl -s ${url}${i}_ipv6 > ipv6/${i}.zone
done

