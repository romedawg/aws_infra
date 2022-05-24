#!/usr/bin/env python3

import argparse
import socket
import sys

ap = argparse.ArgumentParser()
ap.add_argument("--hosts",
                required=True,
                help="Hosts",
                nargs='+'
                )
ap.add_argument("--port",
                type=int,
                required=True,
                help="Port"
                )
args = vars(ap.parse_args())
hosts = args['hosts']
port = args['port']

soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

for host in hosts:
    result = soc.connect_ex((host, port))
    if result != 0:
        print("Port {} is closed for {}".format(port, host))
        sys.exit(1)
    print("Connection to {} port {} succeeded".format(host, port))
