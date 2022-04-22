#!/usr/bin/env raku
# Initialise a new presentation

use v6;

sub MAIN () {
	my $path = '../public/'.IO;
	my $dir = $path.add('md').dir.sort.Array.pop.basename +1;
	run 'cp', '-av', '00.md', $path.add("md/$dir").resolve.absolute;
	run 'cp', '-av', '00.media', $path.add("media/$dir").resolve.absolute;
}

