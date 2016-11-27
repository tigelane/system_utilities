#!/usr/bin/env python

from __future__ import print_function

import sys, requests
import socket, time, datetime

name = "brimstone"

inet_host = "8.8.8.8"
app_port = '5000'
app_addr = '192.168.1.21'
max_attempts = 10

# print (" * APP Server: {0}".format(app_addr))

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def get_ipaddress():
    post_attempts = 0
    while True:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect((inet_host, 80))
            break
        except:
            time.sleep(5)
            post_attempts += 1
            eprint("Unable to find a network connection.  Sleeping.")
            if max_attempts == post_attempts:
                eprint("Unable to find a network connection.  {} attempts were made.".format(max_attempts))

    return s.getsockname()[0]

def main():
    entry = get_ipaddress()
    post_time = datetime.datetime.now().strftime("%d %B %Y : %I:%M%p")

    url = 'http://{0}:{1}/add_entry?name={2}&entry={3}'.format(app_addr, app_port, name, entry)

    try: 
        result = requests.post(url)
        print ("{} - Posted: {} Server: {}".format(post_time, app_addr, entry))
        # print (result.text)
    except:
        print ("Unable to post to server: {}".format(app_addr))
    
if __name__ == '__main__':
    main()
