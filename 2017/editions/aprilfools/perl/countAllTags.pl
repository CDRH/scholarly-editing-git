#!/usr/local/bin/perl

open (OUTFILE, ">tagcount");
$dir = $ARGV[0];
opendir(DIR, $dir) or die "can't opendir $dir: $!";
while (defined($file = readdir(DIR))) {
next if $file =~ /^\./;
open(INFILE, "< $dir/$file") or die "BORK: $!\n";
    while (<INFILE>) {
		while (/(\<[A-Za-z0-9 =".#]*?\>)/g) {
			$match = $1;
			$match =~ s/id=".*?"/id="\#"/g;
			$match =~ s/ID=".*?"/ID="\#"/g;
			$match =~ s/name=".*?"/name="\#"/g;
			$match =~ s/target=".*?"/target="\#"/g;
			$match =~ s/n=".*?"/n="\#"/g;
			$taglist{$match} += 1;
		}

		while (/(\&[A-Za-z0-9\#]{1,15}\;)/g) {
			$match = $1;
			$entlist{$match} += 1;
		}

    }
	close (INFILE);
}

	&sort_print;
	undef %taglist;
	undef %entlist;

close (OUTFILE);

sub sort_print {

	@taglist = sort tag_count keys(%taglist);
	@entlist = sort ent_count keys(%entlist);
	@tagsort = reverse(@taglist);
	@entsort = reverse(@entlist);

	print OUTFILE "\n\n----------\n$file\n----------";

	print OUTFILE "\n\n-- <> Tags --\n\n";

	foreach (@tagsort) {
		$tag = $_;
		print OUTFILE "($taglist{$tag})   $tag\n"; 
	}


	print OUTFILE "\n\n-- Entities --\n\n";

	foreach (@entsort) {
		$ent = $_;
		print OUTFILE "($entlist{$ent})   $ent\n"; 
	}
       
	print OUTFILE "\n";

}

sub tag_count {
	if($taglist{$a} != $taglist{$b}) {
		$taglist{$a} <=> $taglist{$b};
	}else{
		$a cmp $b;
	}
}

sub ent_count {
	if($entlist{$a} != $entlist{$b}) {
		$entlist{$a} <=> $entlist{$b};
	}else{
		$a cmp $b;
	}
}



