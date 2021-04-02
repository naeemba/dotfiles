#!/bin/sh

ipinfo=$(curl -sf "https://ipinfo.io/json")
ipinfovpn=$(curl -sf "https://ipinfo.io/json" --proxy http://192.168.0.104:8118)

if [ -n "$ipinfo" ] && [ -n "$ipinfovpn" ]; then
    ipinfo_ip=$(echo "$ipinfo" | jq -r '.ip')
    ipinfo_country=$(echo "$ipinfo" | jq -r '.country')
    ipinfo_ip_vpn=$(echo "$ipinfovpn" | jq -r '.ip')
    ipinfo_country_vpn=$(echo "$ipinfovpn" | jq -r '.country')

    echo "# $ipinfo_ip [ $ipinfo_country ] # VPN $ipinfo_ip_vpn [ $ipinfo_country_vpn ]"
else
    echo ""
fi
