#!/usr/bin/perl
use strict;
use warnings;

use Path::Class;
use autodie; # die if problem reading or writing a file
use File::Find;
use File::Copy;

my $databasedir = '/var/lib/mysql/masterdb';

my $dir = dir("/root");

opendir(DIR, $databasedir) or die $!;

my $file = $dir->file("tmp.txt");

# Read in the entire contents of a file
my $content = $file->slurp();

# openr() returns an IO::File object to read from
my $file_handle = $file->openr();

# Read in line at a time
while( my $line = $file_handle->getline() ) {
       print $line;

my @dots 
        = grep { 
            /$line.*/           # Begins with a period
	    && -f "$databasedir/$_"   # and is a file
	} readdir(DIR);

    # Loop through the array printing out the filenames
    foreach my $file (@dots) {
	    #Move it to a different directory 
	    move("/var/lib/mysql/masterdb/$file","/mnt/cc_delete/$file");
        print "$file\n";
    }   
       
}

#
#my @dots 
#        = grep { 
#            /folder5102_param.*/           # Begins with a period
#	    && -f "$dir/$_"   # and is a file
#	} readdir(DIR);
#
#    # Loop through the array printing out the filenames
#    foreach my $file (@dots) {
#       print "$file\n";
#    }

    closedir(DIR);
    exit 0;