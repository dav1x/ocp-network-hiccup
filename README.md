# ocp-network-hiccup
When a perfect network without latency or bandwidth contraints is available all is well. However when conditions are not perfect there can be detrimental effects to SNO installation. 

The TC commands were generated with tcconfig and set a 20Mbps cap on ssh incoming and outgoing for IPv6 traffic. 

```
$ tcset br-ex --direction incoming --rate 20Mbps --network ::/0 --ipv6 --port 22 --tc-script
$ tcset br-ex --direction outgoing --rate 20Mbps --network ::/0 --ipv6 --port 22 --tc-script

```

Now, let's create some latency in the cluster as well. 




