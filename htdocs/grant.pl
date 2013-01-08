#!/usr/bin/perl
#######################################
# OpenSplash - Wireless Captive Portal
# Copyright (c) Aleksandr Melentiev
# See LICENSE for copyright information
#######################################

require 5.004;
use Fcntl qw(:DEFAULT);
use NDBM_File;

# Get the users IP address
$USERIP = $ENV{REMOTE_ADDR};

# Include the timestamp for time limiting
# Unix timestamp in seconds
# ...Not implemented yet!!!
$TSTAMP = time();

# .db extension will be appended automatically
$FILE = "/tmp/opensplash";

tie %hash, "NDBM_File", $FILE, O_RDWR|O_CREAT, 0644;

$hash{userip} = $USERIP;
$hash{tstamp} = $TSTAMP;

untie %hash;

print "Content-type: text/html\r\n\r\n";
print "You have been granted access for a limited time.\n Happy Surfing!\n";
