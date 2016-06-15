#!/usr/bin/env python

import sys
from subprocess import call

gw = '.1'
mask = '255.255.255.0'
net = '.0'
broadcast = '.255'
dns = '8.8.8.8'

network_file = '/etc/network/interfaces'
reboot_text = ''
netdata = {}

def verify(ip_components):
	if ip_components[0] == '0':
		return False
	for octet in ip_components:
		if int(octet) > 255:
			return False
	return True

def reboot_server():
	print (netdata['reboot_text'])
	answer = raw_input('\nWould you like to restart the interface now? (Y/n): ') or "Y"
	if answer.lower() == "y":
		call("sudo ifdown eth0 && sudo ifup eth0", shell=True)

	return

def build_netdata(ipaddress):
	ip_components = ipaddress.split('.')
	baseip = '.'.join(ip_components[0:3])

	if not verify(ip_components):
		print ("This is not a valid IP address:  " + ipaddress)
		exit()

	netdata['ipaddr'] = ipaddress
	netdata['gw'] = baseip + gw
	netdata['mask'] = mask
	netdata['network'] = baseip + net
	netdata['broadcast'] = baseip + broadcast
	netdata['reboot_text'] = "I have created a /24 based IP Address and netmask based on {0}".format(netdata['ipaddr'])


	return netdata

def build_netfile(netdata):
	target_data = ''
	print ("Assuming {} mask, {} default gateway, {} dns.".format (mask, gw, dns))

	target_data += '##  This file written by changeip.py'
	target_data += '\nauto eth0'
	target_data += '\niface eth0 inet static'
	target_data += '\n  address ' + netdata['ipaddr']
	target_data += '\n  gateway ' + netdata['gw']
	target_data += '\n  netmask ' + netdata['mask']
	target_data += '\n  network ' + netdata['network']
	target_data += '\n  broadcast ' + netdata['broadcast']
	target_data += '\n  dns-nameservers ' + dns
	target_data += '\n'

	return target_data

def build_dhcpfile():
	target_data = '''
	# interfaces(5) file used by ifup(8) and ifdown(8)
	# Include files from /etc/network/interfaces.d:
	source-directory /etc/network/interfaces.d

	# The loopback network interface
	auto lo
	iface lo inet loopback

	auto eth0
	iface eth0 inet dhcp
	'''

	netdata['reboot_text'] = "I have setup the networking to look for a dhcp address."
	return target_data


def write_data(target_data):
	target_file = open(network_file, 'w')
	target_file.truncate()
	target_file.write(target_data)
	target_file.close()

	return

def main(argv):
	if len(argv) < 2:
		print ("Please enter the ip address or 'dhcp' for this server on the command line.")
		print ("Examples:  {0} 10.1.1.12   :  {0} dhcp").format(argv[0])
		exit()
	
	if argv[1].lower() == "dhcp":
		target_data = build_dhcpfile()
	else:
		netdata = build_netdata(argv[1])
		target_data = build_netfile(netdata)

	write_data(target_data)

	print ("\nChanges completed.")
	print ("These changes will not take effect until the system is rebooted or the interface is reset.")

	reboot_server()

if __name__ == '__main__':
	main(sys.argv)
