#!/usr/bin/env perl

##
## Timestamp
##

my @fields = localtime();
my $timestampStr = sprintf("[%02d:%02d:%02d]", $fields[2], $fields[1], $fields[0]);

##
## Current Directory
##

# my $cwdStr = `pwd -P`;
# chomp $cwdStr;

my $pwd = `pwd -P`;
my $cwdStr = `basename $pwd`;
chomp $cwdStr;

##
## Current username
##

my $curUser = `whoami`;
chomp $curUser;

##
## Root warning
##

my $rootWarning = "";
# $rootWarning = "(ROOT) "
# 	if $curUser eq "root";
	
##
## Font Attributes
##

my $resetAttrs  = "\001\033[0m\002";
my $boldStart   = "\001\033[1m\002";
my $redStart    = "\001\033[31m\002";

my $boldRedStart = "\001\033[1;31m\002";

my $promptAttr = $boldStart;
$promptAttr = $boldRedStart
	if $curUser eq "root";
	
##
## Construct Prompt
##

my $prompt = join("", $promptAttr, $rootWarning, $timestampStr, " ", $cwdStr, ": ", $resetAttrs);

print STDOUT $prompt;