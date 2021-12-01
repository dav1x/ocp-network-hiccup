# Incoming IPv6
modprobe ifb
/usr/sbin/ip link add ifb5268 type ifb
/usr/sbin/ip link set dev ifb5268 up
/usr/sbin/tc qdisc add dev br-ex ingress
/usr/sbin/tc filter add dev br-ex parent ffff: protocol ipv6 u32 match u32 0 0 flowid 1494: action mirred egress redirect dev ifb5268
/usr/sbin/tc qdisc add dev ifb5268 root handle 1494: htb default 1
/usr/sbin/tc class add dev ifb5268 parent 1494: classid 1494:1 htb rate 32000000.0kbit
/usr/sbin/tc class add dev ifb5268 parent 1494: classid 1494:158 htb rate 20000.0Kbit ceil 20000.0Kbit burst 2500.0KB cburst 2500.0KB
/usr/sbin/tc qdisc add dev ifb5268 parent 1494:158 handle 2cfb: netem delay 115.0ms
/usr/sbin/tc filter add dev ifb5268 protocol ipv6 parent 1494: prio 6 u32 match ip6 dst ::/0 match ip6 src ::/0 flowid 1494:158

# Incoming IPv4
modprobe ifb 
/usr/sbin/ip link add ifb5268 type ifb 
/usr/sbin/ip link set dev ifb5268 up
/usr/sbin/tc qdisc add dev br-ex ingress
/usr/sbin/tc filter add dev br-ex parent ffff: protocol ip u32 match u32 0 0 flowid 1494: action mirred egress redirect dev ifb5268
/usr/sbin/tc qdisc add dev ifb5268 root handle 1494: htb default 1
/usr/sbin/tc class add dev ifb5268 parent 1494: classid 1494:1 htb rate 32000000.0kbit
/usr/sbin/tc class add dev ifb5268 parent 1494: classid 1494:42 htb rate 20000.0Kbit ceil 20000.0Kbit burst 2500.0KB cburst 2500.0KB
/usr/sbin/tc qdisc add dev ifb5268 parent 1494:42 handle 2cfb: netem delay 115.0ms
/usr/sbin/tc filter add dev ifb5268 protocol ip parent 1494: prio 5 u32 match ip dst 0.0.0.0/0 match ip src 0.0.0.0/0 flowid 1494:42

# Outgoing IPv6
/usr/sbin/tc qdisc add dev br-ex root handle 1494: htb default 1
/usr/sbin/tc class add dev br-ex parent 1494: classid 1494:1 htb rate 32000000.0kbit
/usr/sbin/tc class add dev br-ex parent 1494: classid 1494:158 htb rate 20000.0Kbit ceil 20000.0Kbit burst 2500.0KB cburst 2500.0KB
/usr/sbin/tc qdisc add dev br-ex parent 1494:158 handle 2cfb: netem delay 115.0ms
/usr/sbin/tc filter add dev br-ex protocol ipv6 parent 1494: prio 6 u32 match ip6 dst ::/0 match ip6 src ::/0 flowid 1494:158

# Outgoing IPv4

/usr/sbin/tc qdisc add dev br-ex root handle 1494: htb default 1
/usr/sbin/tc class add dev br-ex parent 1494: classid 1494:1 htb rate 32000000.0kbit
/usr/sbin/tc class add dev br-ex parent 1494: classid 1494:42 htb rate 20000.0Kbit ceil 20000.0Kbit burst 2500.0KB cburst 2500.0KB
/usr/sbin/tc qdisc add dev br-ex parent 1494:42 handle 2cfb: netem delay 115.0ms
/usr/sbin/tc filter add dev br-ex protocol ip parent 1494: prio 5 u32 match ip dst 0.0.0.0/0 match ip src 0.0.0.0/0 flowid 1494:42
