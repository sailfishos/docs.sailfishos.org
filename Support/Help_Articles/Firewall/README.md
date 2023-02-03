---
title: Firewall 
permalink: Support/Help_Articles/Firewall/
parent: Help Articles
layout: default
nav_order: 460
---

Firewall in Sailfish OS is controlled by ConnMan by its internal rules and configuration files. A proper firewall was introduced first in Sailfish OS update 3.0.1.

A normal Sailfish OS user should not need to read this document. It is intended for developers and for Internet enthusiasts.

## Basics

ConnMan uses iptables to manage the firewall. This is communicated using unix sockets. Firewall is set up when ConnMan starts and cleared when it stops.


## Configuration files

The iptables firewall configurations are supported as of ConnMan 1.32+git41 (Sailfish OS update 3.0.1). These configurations are stored in the format described in this document in the following files and locations:

  - `/etc/connman/firewall.conf`
  - `/etc/connman/firewall.d/*-firewall.con`

1) The main configuration
2) A directory in which all files ending with `-firewall.conf` are used in alphabetical order.


## Main configuration of Sailfish OS firewall

The default configurations are delivered in package **configs-connman-sailfish**.


### Rules

The package **configs-connman-sailfish** sets the following rules in the following files:

#### /etc/connman/firewall.conf

  - IPv4
    - Allow established and related packages (`-m conntrack --ctstate RELATED,ESTABLISHED`)
    - Allow all incoming packages to loopback interface (required by connman DNS resolving)
    - Default: block all incoming traffic by default (filter table INPUT chain default policy)
  - IPv6
    - Allow established and related packages (`-m conntrack --ctstate RELATED,ESTABLISHED`)
    - Allow all incoming packages to loopback interface (required by connman DNS resolving also for IPv6)
    - Default: block all incoming traffic by default (filter table `INPUT` chain default policy)


#### /etc/connman/firewall.d/10-allow-dhcp-firewall.conf

  - IPv4
    - Workaround possible issue with **DHCPv4** when ACK packet is not determined to be in `RELATED` state by iptables during allocation or lease.
    - Allows traffic to **UDP port 68** that is open only during processing DHCP requests
  - IPv6
    - Similar workaround to IPv4 case when **DHCPv6** may be otherwise dropped.
    - Allows from `fe80::/10` to access **DHCPv6 UDP** client port (546)

#### /etc/connman/firewall.d/10-block-icmp-firewall.conf

  - IPv4
    - Allow incoming **ICMP** that is any other than (ping) echo request (i.e., block only incoming echo request )
    - Allow outgoing **ICMP** that is any other than (ping) echo reply (i.e., block only outgoing echo reply)
  - IPv6
    - Allow incoming **ICMP** that is any other than (ping) echo request (i.e., block only incoming echo request )
    - Allow outgoing **ICMP** that is any other than (ping) echo reply (i.e., block only outgoing echo reply)

#### /etc/connman/firewall.d/10-block-ipv6-failed-reverse-path-test-firewall.conf

  - IPv6 only
    - A prerouting chain for mitigating **CVE-2019-14899**
    - Drops packets that fail reverse path test.

#### /etc/connman/firewall.d/11-allow-dccp-non-privileged-ports-firewall.conf

  - Both IPv4 and IPv6
    - Allow incoming **DCCP** protocol traffic on ports 1024:65535

#### /etc/connman/firewall.d/11-allow-sctp-non-privileged-ports-firewall.conf

  - Both IPv4 and IPv6
    - Allow incoming **SCTP** protocol traffic on ports 1024:65535

#### /etc/connman/firewall.d/11-allow-tcp-non-privileged-ports-firewall.conf

  - Both IPv4 and IPv6
    - Allow incoming **TCP** protocol traffic on ports 1024:65535

#### /etc/connman/firewall.d/11-allow-udp-non-privileged-ports-firewall.conf

  - Both IPv4 and IPv6
    - Allow incoming **UDP** protocol traffic on ports 1024:65535
    - Allow incoming **UDPlite** protocol traffic on ports 1024:65535

#### /etc/connman/firewall.d/12-allow-ipsec-firewall.conf

  - Both IPv4 and IPv6
    - Allow all incoming IPSec Authentication Header (**AH**) protocol traffic
    - Allow all incoming IPSec Encapsulating Security Payload (**ESP**) protocol traffic

#### /etc/connman/firewall.d/12-allow-ipv6-mobility-firewall.conf

  - IPv6 only
    - Allow all incoming IPv6 Mobility Header (**MH**) traffic

#### /etc/connman/firewall.d/12-allow-gre-firewall.conf
  - Both IPv4 and IPv6
    - Allow to use of `gre` protocol (required by **PPTP**).


### Developer mode

The developer mode configuration is with **jolla-developer-mode** package. This package sets the following rules in file:

#### /etc/connman/firewall.d/00-devmode-firewall.conf

  - IPv4 & IPv6
    - Allow incoming TCP connections to SSH over WiFi and Ethernet (dynamic rule, enabled when WiFi and/or Ethernet is connected)


### Tethering

The tethering mode configuration is included as built-in feature. When tethering is enabled default rules to accept all traffic from the tethering adapter is used. The rules for tethering can be added later on to be more restrictive. For this a `[tethering]` group, similar to the dynamic rules groups (see below), was added into the configs.

Tethering rules are applied only for WiFi tethering, i.e., when using a hotspot. For usb tethering the default rules apply regardless of the `[tethering]` rules configuration.

The tethering rules must be complete. If there is at least one rule set, no default rules will be added as they would make these custom rules set in `[tethering]` unnecessary by allowing all traffic.

For this, for example the following rules could be enabled to allow only DHCP and DNS, into, e.g.,
`/etc/connman/firewall.d/42-tethering-firewall.conf`. Please pay attention to the long lines below (use the scroll bar to get the entire lines):

```
[tethering]

IPv4.INPUT.RULES = -p udp -m udp --dport 53 -j ACCEPT; -p tcp -m tcp --dport 53 -j ACCEPT; -p udp -m udp --dport 67 -j ACCEPT

IPv6.INPUT.RULES = -p udp -m udp --dport 53 -j ACCEPT; -p tcp -m tcp --dport 53 -j ACCEPT; -p udp -m udp --dport 67 -j ACCEPT
```

## Configuration file processing

The main configuration (`/etc/connman/firewall.conf`) is loaded first.

The rest of the configurations are loaded from `/etc/connman/firewall.d` in alphabetical order.

### Processing order of rules:
  - Since the keys from files are loaded in alphabetical order, the rules in file with, e.g., 00 prefix will be processed and added first.
  - Rules from main config are added as last rules into iptables. These are considered as base rules.
  - When dynamic rules are enabled these are inserted to top in iptables
  - As for example:
    - Configs and processing order:;
      1. base `firewall.conf` - has `[General]` rules and POLICY set
      2. `firewall.d/10-firewall.conf` - has `[wifi]` rules
      3. `firewall.d/20-firewall.conf` - has `[General]` rules
      4. `firewall.d/30-firewall.conf` - has `[wifi]` and `[General]` rules
     - Rules in firewall at ConnMan start:
       - Policy from 1
       - Rules:
         - Rules from 3 `[General]`
         - Rules from 4 `[General]`
         - Rules from 1 `[General]`
     - Rules in firewall after enabling WiFi
       - Policy from 1
       - Rules:
         - Rules from 2 `[wifi]`
         - Rules from 4 `[wifi]`
         - Rules from 3 `[General]`
         - Rules from 4 `[General]`
         - Rules from 1 `[General]`

### When multiple different rules are used:
  - From `[General]` section, the latest `POLICY` definition overrules the previous ones.
  - Rules from each group type are appended to the existing rules.

### When a config has been added or removed, do:
```
systemctl reload connman
```

  - If a new package is installed, reload is enough
  - Rules from new config are added to internal lists in order but:
    - Order in iptables is correct with dynamic rules after re-establishment of service connection (e.g., WiFi)
    - Order in iptables is correct with General rules after connman restart
      - Applies only if there are rules that should be added to a certain position based on the order dictated by filename.

### When an existing config was modified, do:
```
systemctl restart connman
```

Detection of changes in configs is on our TODO list.

## Configuration file format

The files follow the key file format.

  - Each group is specified with `[ ]`
    - E.g. `[General]`, which means that all keys until next `[ ]` belong to this group.
  - Group names are case sensitive.
  - Each key is case sensitive and is written in plain without tags, followed by equal char.
    - E.g., `IPv4.INPUT.RULES = -p tcp -m tcp -j ACCEPT`
  - Each rule key can exist in one group only once (glib key file parser is used and it processes only the first one)
  - Separator for rules is semicolon **;**
  - Rules can be commented out with **#** as the first char
    - For example:
      - `#-p udp -m udp --dport 23 -j ACCEPT; -p udp -m udp --dport 24 -j ACCEPT`
      - Will discard the first _--dport 23_ rule and use _--dport 24_ rule.


## Definition of Groups

The groups and keys in the files `[General]` section:
  - IPv4.INPUT.RULES = #Rules set into IPv4 filter table INPUT chain.
  - IPv4.OUTPUT.RULES = #Rules set into IPv4 filter table OUTPUT chain.
  - IPv4.FORWARD.RULES = #Rules set into IPv4 filter table FORWARD chain.
  - IPv4.INPUT.POLICY = #Default policy for filter table INPUT chain, can be either ACCEPT or DROP
  - IPv4.OUTPUT.POLICY = #Default policy for filter table OUTPUT chain, can be either ACCEPT or DROP
  - IPv4.FORWARD.POLICY = #Default policy for filter table FORWARD chain, can be either ACCEPT or DROP
  - IPv6.INPUT.RULES = #Rules set into IPv6 filter table INPUT chain.
  - IPv6.OUTPUT.RULES = #Rules set into IPv6 filter table OUTPUT chain.
  - IPv6.FORWARD.RULES = #Rules set into IPv6 filter table FORWARD chain.
  - IPv6.INPUT.POLICY = #Default policy for IPv6 filter table INPUT chain, can be either ACCEPT or DROP
  - IPv6.OUTPUT.POLICY = #Default policy for IPv6 filter table OUTPUT chain, can be either ACCEPT or DROP
  - IPv6.FORWARD.POLICY = #Default policy for IPv6 filter table FORWARD chain, can be either ACCEPT or DROP

The dynamic device type groups:
  - These are enabled when a connman service with the given type is brought up (e.g., WiFi is connected).
  - Each rule type will have the interface of the service included into the rule appropriately.
    - E.g., INPUT rules will have `-i <interface>` set.
  - Each group can have following keys (same as General section):
    - IPv4.INPUT.RULES = 
    - IPv4.OUTPUT.RULES = 
    - IPv4.FORWARD.RULES = 
    - IPv6.INPUT.RULES = 
    - IPv6.OUTPUT.RULES = 
    - IPv6.FORWARD.RULES = 
  - The detected groups are:
    - [unknown] - not used or supported but because it is part of connman's internal device types, it is included
    - [system]
    - [ethernet]
    - [wifi]
    - [bluetooth]
    - [cellular]
    - [gps]
    - [vpn]
    - [gadget]
    - [p2p]
    - [tethering] - settings to be applied when tethering is enabled.
  - If you still have problem with tethering, add into `[General]` group:, e.g, `95-tether-override-firewall.conf`:
    ```
    [General]
    IPv4.INPUT.RULES = -i tether -j ACCEPT
    IPv6.INPUT.RULES = -i tether -j ACCEPT
    ```

## Rule format

  - Rules follow iptables format, see, e.g. [iptables tutorial](https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html)
    - Options are validated for each protocol and/or match type
    - Option values are validated for count and type of value
    - If rule does not exist in iptables the rule was ignored by rule parser
    - Negations are supported as in iptables
  - Because everything cannot be supported in first version, some of the iptables supported switches that ConnMan cannot add are ignored:
    - Not supported iptables switches:
      - Chain modifiers: `-A, -D, -X, -F, -I, -P, -E, -R, -Z` (and the longer equivalents of these)
        - New chains or existing chains are not to be modified with rules. All rules go to connman managed firewall rules, which support no such thing.
        - These may be added in the future, if need arises.
    - Destination speficiers for DNAT: `--to-destination, --from-destination`
    - Fragment switches: `-f, --fragment`
    - IP family switches: `--ipv4, -4, --ipv6, -6`
    - Match (-m) switches that are not supported:
      - IPv4: `-m comment, -m state (use --ctstate), -m recent, -m hashlimit, -m icmpv6/ipv6-icmp`
      - IPv6: `-m comment, -m state (use --ctstate), -m recent, -m ttl, -m hashlimit, -m frag, -m` icmp
      - The switches above are either not implemented in ConnMan or are for invalid IP family.
  - The targets (`-j TARGET`) are the same as with default iptables: ACCEPT, DROP, REJECT, LOG and QUEUE.
  - Protocols (-p protocol) are the same as with iptables: `tcp, udp,udplite, icmp, icmpv6, ipv6-icmp, esp, ah, sctp, mh` (IPv6 only) and the special keyword all.
    - If something is missing, pelase report.

## Each rule

  - Has to have one target (`-j/--jump TARGET` or `-g/--goto TARGET`) which is the bare minimum of the rule
  - Can have **0...1 protocol matches** (`-p/--protocol protocol`)
    - With SCTP, DCCP and MH protocols the protocol match cannot be used. E.g.,
      - `-p sctp -m sctp --dport 22 -j DROP` does not work (error) but
      - `-p sctp --dport 22 -j DROP` works
  - Can have **0...2 match specifiers** (`-m/--match match`)
    - E.g., to allow one attempt per second to telnet:
    - `-p udp -m udp --dport 23 -m limit --limit 1/second --limit-burst 1 -j ACCEPT`
  - Can have
    - **0...2 port switches** with regular port option (same direction cannot be used twice)
      - with a protocol modifier (`-m <protocol>`): `--destination-port, --dport, --source-port, --spt`
    - **0...1 port switches** with multiport
      - with `-m multiport`: `--destination-ports, --dports, --source-ports, --sports, --port, --ports` and the switches that are applicable with regular port option
  - Can have **0...2 destination specifiers** (same direction cannot be used twice)
    - `--source, --src, -s, --destination, --dst, -d`
  - Each `[General]` section rule can also have **0...2 interface switches**(same direction cannot be used twice)
    - `--in-interface, -i, --out-interface, -o`
    - These are ignored with dynamic rules meant for service types.


## Troubleshooting
If, for some reason, there is a problem with some application that would seem like a network/iptables problem, proceed with the following steps:

  1. If you have developer mode, open up terminal and type devel-su or SSH into the device over WiFi and gain root access.
  2. Set up the basic iptables monitoring with IPv4:
     ```
     watch -n 1 iptables -t filter -L -v -n
     ```
     and IPv6:
     ```
     watch -n 1 ip6tables -t filter -L -v -n 
     ```
     Use Ctrl+C to quit.
  3. Check the output and amount of dropped packets in Chain INPUT (policy DROP).
  4. Run the application and check which counters increase, the topmost DROP will increase if packets are being dropped, the packet counters on each rule will increase if packets match that rule
  5. If the problem is with dropping packets, you can try:
     * a temporary solution to allow all traffic by default on IPv4:
     ```
     iptables -t filter -P INPUT ACCEPT
     ```
     and on IPv6:
     ```
     ip6tables -t filter -P INPUT ACCEPT
     ```
     * if you wish it to be permanent, add file **/etc/connman/firewall.d/99-accept-all-firewall.conf** and write the following lines to it:
     ```
     [General]
     IPv4.INPUT.POLICY = ACCEPT
     IPv6.INPUT.POLICY = ACCEPT
     ```
     and restart connman with
     ```
     systemctl restart connman
     ```
  6. If the problem was solved with this, please report this problem at [Sailfish OS forum](https://forum.sailfishos.org).

If there are other network related issues with the device try the example configuration above **99-accept-all-firewall.conf**) to solve the issue if it seems like a firewall issue. If this
 solves any issue please report the problem with logs at [Sailfish OS forum](https://forum.sailfishos.org).
