package WSL::Util;

use 5.014;
use warnings;

use base "Exporter";

our @EXPORT_OK = qw/
	getInput
/;

sub getInput() {
	return map {chomp; $_} @ARGV ? @ARGV : <>;
}

1;
