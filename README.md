Workaround for VPN Problem using Docker Tech Preview 1 on Apple Silicon
=====================================================================

If you cannot pull from third party Docker registries on a VPN, then this is for you.

**Error Message:**

```
Error response from daemon: Get https://registry-1.docker.io/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

**Usage:**

Find out which utun interface your vpn uses by running if config:

```
ifconfig
```

Then look for a utun interface with an associated IPv4 address:

```
utun2: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
	inet 192.168.50.14 --> 192.168.50.14 netmask 0xffffffe0 
```

Then open the `vpn.sh` file and edit this line appropriately:

```
export UTUN_INTF="utun2"
```

Now execute the script to enable the workaround:

```
./vpn.sh
```

**Note:**

You have to run this script on every reboot.


**Credits**

To the person who originally posted this script on the private Docker Slack Channel