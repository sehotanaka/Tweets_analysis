#!/usr/bin/perl -w

use strict;
use warnings;

#This is where you have to specify your local of file you want to examine

my $file = "Fill in";
open FI, " < $file" or die "unable to locate the file";

my %hashhash;
my @hashtag_pre;
my %accounts;
my $tweet_counter;
my ($negative, $positive, $neutral);

#putting in the tweets and organize them

while ( my $text = <FI> ) {
    my @lines = split(/\n/,$text);
    foreach my $i (@lines) {
        my @accounts = split(/[\s\.,:;\?!"'“„\(\)—]+/,$i);
        foreach my $h (@accounts) {
            if ( $h =~ m/@\w/ ) {
            $accounts{$h}++;
        }
    }
        if ( $i =~ m/^\#/) {
            push(@hashtag_pre,$i);}
        #print"$i\n\n";
        $i =~ s/RT//g;
        if ( $i =~ /,negative/) {
                $hashhash{"negative"}{"tweets"}{$i}++;
                $tweet_counter+=1;
                $negative+=1;
            }
        if ( $i =~ /,positive/) {
                $hashhash{"positive"}{"tweets"}{$i}++;
                $tweet_counter+=1;
                $positive+=1;
            }
        if ( $i =~ /,neutral/) {
                $hashhash{"neutral"}{"tweets"}{$i}++;
                $tweet_counter+=1;
                $neutral+=1;
        }
    }
}


my @hashtag_true;

#making hashtag hash

foreach my $hashtag (@hashtag_pre) {
    my    @split_hashtag = split(/( |,)/,$hashtag);
    foreach my $hashtag2 (@split_hashtag) {
        push(@hashtag_true,$hashtag2);
    }
}

my %hashtag_hash = map { $_ => 1 } @hashtag_true;

#printing out the positives,negatives,neutrals...
print "total tweets are $tweet_counter\n";
print "tweets type
       neutral : $neutral
       negative : $negative
       positive : $positive
      \n";


print "\t\t\t\t\t\tPrinting the neutrals...\n\n\n\n\n\n\n\n";
foreach my $subject ( sort keys %{ $hashhash { "neutral" }{"tweets" } }  ) {
    $subject =~ s/,negative|,neutral|,positive//g;
    print"$subject\n\n";
}

print ("Press enter to continue");
my $input = <STDIN>;
system('clear
    clear');

print "\t\t\t\t\t\tPrinting the positives...\n\n\n\n\n\n\n\n";
foreach my $subject ( sort keys %{ $hashhash { "positive" }{"tweets" } }  ) {
    $subject =~ s/,negative|,neutral|,positive//g;
        print"$subject\n\n";
}

print ("Press enter to continue");
 $input = <STDIN>;
system('clear
    clear'
    );
print "\t\t\t\t\t\tPrinting the negatives...\n\n\n\n\n\n\n\n\n";
foreach my $subject ( sort keys %{ $hashhash { "negative" }{"tweets" } }  ) {
    $subject =~ s/,negative|,neutral|,positive//g;
    print"$subject\n\n";
}

print ("Press enter to continue");
$input = <STDIN>;
system('clear
    clear'
    );

print "\t\t\t\t\t\tPrinting the hashtags...\n\n\n\n\n\n\n\n\n\n";
foreach my $hashtag_key ( sort keys %hashtag_hash) {
    print "$hashtag_key\n";
}

print ("Press enter to continue");
$input = <STDIN>;
system('clear
    clear'
    );

print"\t\t\t\t\t\tPrinting the accounts...\n\n\n\n\n\n\n\n\n";
foreach my $key ( sort { $accounts{$b} <=> $accounts{$a} } keys %accounts) {
    print "$key : $accounts{$key} times\n";
}

