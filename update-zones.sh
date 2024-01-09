#!/usr/bin/env nix-shell
#!nix-shell -i bash -p iprange whois

url="cc2asn.com"


echo "Download and & Shrink zone files..."

for cc in $(ls ipv4 | sed 's/.zone//'); do
  echo -n "$cc "
  # ipv4/6 has bug, request all instead
  whois -h "$url" all "$cc" | sed '/^A/d;/:/d' | iprange > "ipv4/${cc}.zone"
  whois -h "$url" all "$cc" | sed '/^A/d;/\./d' | sort > "ipv6/${cc}.zone"
done
echo ""

