#!/usr/bin/perl -w

use strict;
require 5.6.0;
#use utils qw(%ERRORS $TIMEOUT &print_revision &support &usage);
#use Switch;
use LWP::Simple;
use LWP::UserAgent;

my $num_args = $#ARGV + 1;
my $queueselect=$ARGV[0];
my $address= $ARGV[1];
my $port = $ARGV[2];
my $username = $ARGV[3];
my $pass = $ARGV[4];
my $browser = LWP::UserAgent->new;
my $req =  HTTP::Request->new( GET => "http://$address:$port/admin/xml/queues.jsp");
$req->authorization_basic( "$username", "$pass" );
my $page = $browser->request( $req );
my (%args, %queues);
my ( $tmp, $switch, $queuevalue);
my $key = my $value = my $i = my $k = 0;


# main();

$queueselect=$ARGV[0]; 
&getinfo;
$queuevalue=-1;
foreach my $str (keys %queues){
		if($queueselect eq $str){ 
                  $queuevalue = $queues{$queueselect}; 
			last; }
		else { 
			next; }
		}
#print 1200;
print $queuevalue;
exit;

# Subroutines

	sub getinfo {
		my @lines = split ' ', $page->content();
		foreach my $line (@lines){
			if($line =~ /name/i || $line =~ /size/i){
				$line =~ s/^name="//g;
				$line =~ s/^size="//g;
				$line =~ s/"(>)?$//g;
				#print "line ".${line} ;				
				if($i == 1){
					#print "line ".${line} ;
					$queues{$tmp} = $line;
					$i = 0;
				}
				else{
					$tmp = $line;
					$i++;
				}
			}
		}
	}


