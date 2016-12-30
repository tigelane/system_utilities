#!/usr/bin/env python

import ipaddress

def is_valid_ip(address):
	uaddress = unicode(address, "utf-8")
	try:
		ipaddress.ip_address(uaddress)
		return True
	except (ValueError):
		return False