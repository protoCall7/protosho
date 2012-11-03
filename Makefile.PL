#!/usr/bin/perl

use Modern::Perl;
use ExtUtils::MakeMaker;

WriteMakefile(
	'NAME' => 'protosho',
	'VERSION_FROM' => 'lib/Protosho/Application.pm',
);
