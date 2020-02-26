#!/usr/bin/env nix-shell
#!nix-shell -i bash -p iprange curl

url="https://www.cc2asn.com/data/"


echo "Download and & Shrink zone files..."

for cc in `ls ipv4 | sed 's/.zone//'`; do
  echo -n "$cc "
  curl -s ${url}${cc}_ipv4 | iprange > ipv4/${cc}.zone
  curl -s ${url}${cc}_ipv6 | sort > ipv6/${cc}.zone
done
echo ""

