#!/usr/bin/env python
################################################################################
##
################################################################################
#                                                                              #                                                     
#    Licensed under the Apache License, Version 2.0 (the "License"); you may   #
#    not use this file except in compliance with the License. You may obtain   #
#    a copy of the License at                                                  #
#                                                                              #
#         http://www.apache.org/licenses/LICENSE-2.0                           #
#                                                                              #
#    Unless required by applicable law or agreed to in writing, software       #
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT #
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the  #
#    License for the specific language governing permissions and limitations   #
#    under the License.                                                        #
#                                                                              #
################################################################################
'''
Simple script with very little error checking to take all of the SVIs from a IOS
configuration and turn them into EPGs under a single Tenant and single Applicaiton Profile.
By default this script sets all of the subnets to advertise.
'''

import sys, re, random, os.path

# local file that contains the IOS config you want to replicate
iosconfig = "juniper_1.txt"
ge = set()
xe = set()

# Regular expressions of information in the IOS config file
#aninterface = re.compile('^set interfaces\s([xe,ge]-\d{1,2}/\d{1,2}/\d{1,2}/)\s')
#aninterface = re.compile('^(set interfaces)')
xeinterface = re.compile('^set interfaces\s(xe-\d{1,2}/\d{1,2}/\d{1,2})\s')
geinterface = re.compile('^set interfaces\s(ge-\d{1,2}/\d{1,2}/\d{1,2})\s')

def parsetheline(iosline):
    global ge, xe
    
    print iosline
    if xeinterface.match(iosline):
        print ("Hi!")
        interface = xeinterface.findall(iosline)[0]
        xe.add(interface)
    if geinterface.match(iosline):
        interface = geinterface.findall(iosline)[0]
        ge.add(interface)


def readconfigfile():
    global iosconfig
    while True:
        if os.path.isfile(iosconfig):
            with open(iosconfig) as openfileobject:
                for line in openfileobject:
                    parsetheline(line)
            openfileobject.close()
            break
        else:
            print ("Unable to find file: {}".format(iosconfig))
            iosconfig = raw_input('Please enter a config file name: ')

def main():

    readconfigfile()
    
    print len(xe), xe
    print len(ge), ge
    print ("\nFound {} interfaces.".format(len(ge)+len(xe)))

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass