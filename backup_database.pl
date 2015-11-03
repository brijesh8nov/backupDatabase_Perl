###################################################################################################################################
# This program 1)Reads data from .txt file 2) Greps all files with the data in .txt file 3) Moves the data to a different location 
# Written by Brijesh Chauhan: brijesh@brijeshradhika.com 
# Date Added : 03-Nov-2015
####################################################################################################################################

#!/usr/bin/perl
use strict;
use warnings;

use Path::Class;
use autodie; # die if problem reading or writing a file
use File::Find;
use File::Copy; # This is required for MOVE

my $databasedir = '/var/lib/mysql/masterdb'; # the directory where to search files from

my $dir = dir("/root"); # directory which contains the text file

my $file = $dir->file("tmp.txt");

# Read in the entire contents of a file
my $content = $file->slurp();

# openr() returns an IO::File object to read from
my $file_handle = $file->openr();

# Read in line at a time
while( my $line = $file_handle->getline() ) 
{
        print $line;
        chomp $line;
        opendir(DIR, $databasedir) or die $!;
	my @dots = grep (/$line.*/, readdir(DIR)); # use grep to get all results with .* regular expression and store it in an array
	closedir(DIR);	    
	# Loop through the array printing out the filenames
	#print join(", ", @dots);
	foreach my $filehandler (@dots) 
	{
	    #Move it to a different directory 
	    move("/var/lib/mysql/masterdb/$filehandler","/mnt/cc_delete/$filehandler");
	   # print "$filehandler\n";
	}   
       
}

   
    exit 0;