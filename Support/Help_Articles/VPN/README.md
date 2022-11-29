---
title: VPN
permalink: Support/Help_Articles/VPN/
parent: Help Articles
layout: default
nav_order: 5000
---
Virtual Private Network (VPN) is a tool for improving security and privacy when making connections via the Internet.

There are many different VPN categories and service providers. Most of them require signing up and paying for the service.

The target of this help article is just to introduce the basics of using VPN on Sailfish devices. We configure an OpenVPN service to the device. The service provider used here as for example is the free [vpnbook.com](https://www.vpnbook.com/), for simplicity.

1. Open Sailfish Browser and go to web page [vpnbook.com](https://www.vpnbook.com/).
2. Find heading/link "Free OpenVPN Account" and tap that.
3. Tap one of the servers below, e.g., "PL226 OpenVPN Certificate Bundle". Choose location where to download the file, for example under "Downloads".
Also, pay attention to the username and password at the end of the server list - you will need them later.
4. Open Settings > Transfers. You will see "VPNbook.com-OpenVPN-PL226.zip" at the top of the list. Tap it.
5. List of included ".ovpn" files appears. Pull down "Extract all". Those files are now ready to be used in "Downloads > VPNBook" folder.
6. Open Settings > VPN. Pull down "Add new VPN".
7. Tap "OpenVPN". Tap "Import file". Tap "Home folder".  Tap "Downloads". Tap "VPNBook".
8. Select what kind of VPN service you want to use. Let's say it is TCP via port 80. Tap "vpnbook-pl226-tcp80".
9. Tap "Accept" at the top right corner and Page "OpenVPN set up is ready" appears.
10. Tap "vpnbook-pl226-tcp80" to enable the VPN service.
11. Type "vpnbook" for the Username. Tap the password from step 4 to the Password line. Tap "Remember credential information".
12. Tap connect. You should see "Connected" under "vpnbook-pl226-tcp80".
13. Go to the Home view and look at the status icons at the top of the display: there is the VPN icon "Shield" indicating that VPN is active.
14. Start browsing over the VPN connection.

Please note that those credentials of the vpnbook service are generic, not private, so this service may not be completely safe. It serves the purpose of getting familiar with VPN on Sailfish, though.

Later on, you can add more VPN services following the steps above. Menu page "Settings > VPN" will list all the registered services for you, making it easy to start/stop/change the VPN service you want to use.


