#
#===============================================================================
#
#         FILE: Application.pm
#
#  DESCRIPTION: protosho main application module
#
#        FILES: IP.pm, Search.pm, ExploitSearch.pm ExploitFetch.pm
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Peter H. Ezetta (PE), peter.ezetta@zonarsystems.com
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 10/12/2012 21:50:19
#     REVISION: ---
#===============================================================================

package Protosho::Application;
use Modern::Perl;
use Config::Auto;
use Shodan::WebAPI;
use base qw( CLI::Framework );

$VERSION = '1.0';

#===  FUNCTION  ================================================================
#         NAME: command_map
#      PURPOSE: Main command name to command object mapping
#   PARAMETERS: N/A
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub command_map {
      'ip'             => 'Protosho::Commands::IP',
	  'search'		   => 'Protosho::Commands::Search',
      'exploit_search' => 'Protosho::Commands::ExploitSearch',
      'exploit_fetch'  => 'Protosho::Commands::ExploitFetch',
	  'msf_search'	   => 'Protosho::Commands::MsfSearch',
	  'msf_fetch'	   => 'Protosho::Commands::MsfFetch',
}

#===  FUNCTION  ================================================================
#         NAME: usage_text
#      PURPOSE: Help menu usage text definition
#   PARAMETERS: N/A
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub usage_text {
    qq{
================================================================================
protosho v1.0
Copyright (c)2012 Peter Ezetta
================================================================================

		$0 <COMMAND> [--long-opt|o]

		COMMANDS
			ip              - Search for hosts by IP
			search          - Search SHODAN Database by Keyword
			exploit_search 	- Search ExploitDB
			exploit_fetch 	- Fetch ExploitDB Exploit

};
}

#===  FUNCTION  ================================================================
#         NAME: init
#      PURPOSE: Initialization routine.  Instantiates and caches an api object.
#   PARAMETERS: N/A
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub init {
	my ($self, $opts)  = @_;

	my $config         = Config::Auto::parse("protosho.config");
    my $SHODAN_API_KEY = $config->{'api_key'};
    my $api            = new Shodan::WebAPI($SHODAN_API_KEY);

	$self->cache->set( api => $api );
}

1;
