#!/usr/bin/env perl
use Test::More;
use Cwd qw( getcwd );
use File::Find::Rule;
use Modern::Perl;
use File::Basename qw ( fileparse );

my $working_dir 	= getcwd;
my $dir_markdown	= "$working_dir/public/md";
my $dir_media			= "$working_dir/public/media";

my $rule = File::Find::Rule->new;
	$rule->directory;
	$rule->maxdepth('1');
	$rule->mindepth('1');
my @dirs = $rule->in($dir_markdown);

# Check if there exist the file structure
# 	/public/md/_presentation_/Presentacio.md
# 	/public/md/_presentation_/Config.txt
# 	/public/md/_presentation_/_link_to_media
# 	/public/media/_presentation_

foreach my $file (sort @dirs) { 
	ok( -f -r "$file/Presentacio.md", "$file/Presentacio.md");
	ok( -f -r "$file/Config.txt", "$file/Config.txt");
	ok( -l		"$file/media", "$file/media" );
	ok( readlink "$file/media" eq "../../media", "ok link $file/media");
	my $dir_media = "$dir_media/" . fileparse( $file );
	ok( -d -r  $dir_media, $dir_media);
};

done_testing();
