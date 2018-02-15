
[![Build Status](https://api.shippable.com/projects/55b129faedd7f2c0528139bc/badge?branchName=master)](https://app.shippable.com/projects/55b129faedd7f2c0528139bc/builds/latest)

## Overview
---
This repo produces a turn key VPN -> SOCKS5 tunnel to route you to the Internet. There could be many reasons why you might need a solution like this. Limitations of your current network restricting access, more security when traveling. Whatever the reason this build gives you a great turn key solution.

There are currently two builds to select:

	*	Version 0.4.0 is ONLY the VPN
	* 	Version 0.5.0 provides the VPN and ability to remote traffic to a remote proxy



### Please Note:
The Official SoftEther VPN is built using **CentOS 7** this is a working build using **Ubuntu**. There is a *current* limitation with Docker and building the image via automated tools, the volume devicemapper which [appears to be fixed](https://github.com/docker/docker/issues/6980) in Docker 1.6.2. After numerous attempts and configuration tweaks the building the image was not successful. I was able to change the Dockerfile to use **Ubuntu** as the underlaying OS. **Success!**




## Version 0.5.0 (VPN -> SOCKS5)

[![](https://badge.imagelayers.io/htmlgraphic/vpn:0.5.0.svg)](https://imagelayers.io/?images=htmlgraphic/vpn:0.5.0 'Get your own badge on imagelayers.io')

* L2TP/IPSec PSK
* SecureNAT enabled
* Perfect Forward Secrecy (DHE-RSA-AES256-SHA)
* This build pulls from the official SoftEther VPN GitHub repo master, a large 300Mb repo, a solid network connection will be needed to pull the Docker build
* SOCK5 Proxy connection using [REDSOCKS](http://darkk.net.ru/redsocks/)

**Example:**
```
docker run -d -p 500:500/udp -p 4500:4500/udp -p 1701:1701/tcp -e PROXY_HOST=123.3.2.1 -e PROXY_PORT=8080 htmlgraphic/vpn:0.5.0
```


## Version 0.4.0 (VPN)
[![](https://badge.imagelayers.io/htmlgraphic/vpn:0.4.0.svg)](https://imagelayers.io/?images=htmlgraphic/vpn:0.4.0 'Get your own badge on imagelayers.io')

* L2TP/IPSec PSK
* SecureNAT enabled
* Perfect Forward Secrecy (DHE-RSA-AES256-SHA)
* This build pulls from the official SoftEther VPN GitHub repo master, a large 300Mb repo, a solid network connection will be needed to pull the Docker build

**Example:**
```
docker run -d -p 500:500/udp -p 4500:4500/udp -p 1701:1701/tcp htmlgraphic/vpn:0.4.0`
```



Connectivity tested on Android + iOS, Mac OS X devices. It seems Android devices do not require L2TP server to have port 1701/tcp open.

## Credentials

Required:

* `-e PROXY_HOST`: hostname or IP address of Proxy Server, allow only valid VPN connections.
* `-e PROXY_PORT`: proxy connection port.



Optional:

* `-e PSK`: Pre-Shared Key (PSK), if not set: “notasecret” (without quotes) by default.
* `-e USERNAME`: if not set a random username (“user[nnnn]”) is created.
* `-e PASSWORD`: if not set a random weak password is created.

It only creates a single user account with the above credentials in DEFAULT hub. See the docker log for username and password (unless -e PASSWORD is set), which would look like:

```
========================
user6301
2329.2890.3101.2451.9875
========================
```

Dots (.) are part of the password. Password will not be logged if specified via `-e PASSWORD`; use `docker inspect <container_id>` in case you need to see it.

To review the system generated username and password, use `docker logs <container_id>`

---

## Patches / Feedback Welcome!
[Send a message](https://github.com/htmlgraphic/VPN/issues/new)
