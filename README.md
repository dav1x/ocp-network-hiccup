# ocp-network-hiccup
When a perfect network without latency or bandwidth contraints is available all is well. However when conditions are not perfect there can be detrimental effects to SNO installation. 

The TC commands were generated with tcconfig and set a 20Mbps cap on ssh incoming and outgoing for IPv6 traffic. 

```
$ tcset br-ex --direction incoming --rate 20Mbps --network ::/0 --ipv6 --port 22 --tc-script
$ tcset br-ex --direction outgoing --rate 20Mbps --network ::/0 --ipv6 --port 22 --tc-script

```

Now, let's create some latency in the cluster as well. 

```
tcset br-ex --direction incoming --rate 20Mbps --delay 115ms --network ::/0 --ipv6 --tc-script
tcset br-ex --direction incoming --rate 20Mbps --delay 115ms  --tc-script
tcset br-ex --direction outgoing --rate 20Mbps --delay 115ms  --network ::/0 --ipv6 --tc-script
tcset br-ex --direction outgoing --rate 20Mbps --delay 115ms  --tc-script
```

In our case we will be applying these rules to our hub cluster as MachineConfigs. For our disconnected registry we will use the tc commands.

Additionally, a container can be used to apply tc commands to the host:

```
podman run -it –privileged --network=host -t quay.io/dphillip/tcconfig:latest tcset ens192 --direction outgoing --rate 20Mbps --delay 115ms
podman run -it –privileged --network=host -t quay.io/dphillip/tcconfig:latest tcset ens192 --direction incoming --rate 20Mbps --delay 115ms


podman run -it –privileged --network=host -t quay.io/dphillip/tcconfig:latest tcshow ens192

{
    "ens192": {
        "outgoing": {
            "protocol=ip": {
                "filter_id": "800::800",
                "delay": "115ms",
                "rate": "20Mbps"
            }
        },
        "incoming": {
            "protocol=ip": {
                "filter_id": "800::801",
                "delay": "115ms",
                "rate": "20Mbps"
            }
        }
    }
}


```
