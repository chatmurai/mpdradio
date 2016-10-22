#!/usr/bin/env python
# see --> https://gist.github.com/furkanmustafa/cf32f9ed2a3181486b00
# Based on http://ubuntuforums.org/showthread.php?t=984492&p=6193749#post6193749

import subprocess
import re
import json


def getWifiNetworks():
	"""Renvoie un JSON contenant les information des réseaux wifi disponibles"""
	proc = subprocess.Popen('iwlist scan 2>/dev/null', shell=True, stdout=subprocess.PIPE, )
	stdout_str = proc.communicate()[0]
	stdout_list = stdout_str.split('\n')

	networks = []
	network = {}

	for line in stdout_list:
		line = line.strip()
		match = re.search('Address: (\S+)',line)
		if match:
			if len(network):
				networks.append(network)
			network = {}
			network["mac"] = match.group(1)

		match = re.search('ESSID:"(\S+)"',line)
		if match:
			network["ssid"] = match.group(1)

	    # Quality=100/100  Signal level=72/100
		match = re.search('Quality=([0-9]+)\/([0-9]+)[ \t]+Signal level=([0-9]+)\/([0-9]+)',line)
		if match:
			network["quality"] = match.group(1)
			network["quality@scale"] = match.group(2)
			network["dbm"] = match.group(3)

		# Encryption key:on
		match = re.search('Encryption key:(on|.+)',line)
		if match:
			network["encryption"] = match.group(1)

		# Channel:1
		match = re.search('Channel:([0-9]+)',line)
		if match:
			network["channel"] = match.group(1)

		# Frequency:2.412 GHz (Channel 1)
		match = re.search('Frequency:([0-9\.]+) GHz',line)
		if match:
			network["freq"] = match.group(1)

	if len(network):
		networks.append(network)

	return json.dumps(networks)

print getWifiNetworks()
