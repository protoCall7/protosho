#!/usr/bin/perl

use Modern::Perl;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'protosho',
    'VERSION_FROM' => 'lib/Protosho/Application.pm',
    'PREREQ_PM'    => {
        'Modern::Perl'   => '1.20120521',
        'CLI::Framework' => '0.05',
    }
);
