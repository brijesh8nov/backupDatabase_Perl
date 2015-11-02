#!/usr/bin/perl
use strict;
use warnings;

use Path::Class;
use autodie; # die if problem reading or writing a file
use File::Find;

my $databasedir = '/var/lib/mysql/masterdb';

my $dir = dir("/root");

my @dots;

my $file = $dir->file("tmp.txt");

# Read in the entire contents of a file
my $content = $file->slurp();

# openr() returns an IO::File object to read from
my $file_handle = $file->openr();

# Read in line at a time
while( my $line = $file_handle->getline() ) 
{
       # print $line;
        chomp $line;
        opendir(DIR, $databasedir) or die $!;
	@dots = grep (/$line.*/, readdir(DIR));
	closedir(DIR);	    
	# Loop through the array printing out the filenames
	#print join(", ", @dots);
	foreach my $filehandler (@dots) 
	{
	    #Move it to a different directory 
	    move("/var/lib/mysql/masterdb/$filehandler","/mnt/cc_delete/$filehandler");
	    #print "$filehandler\n";
	}   
       
}

   
    exit 0;