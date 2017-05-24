package WSL::PathConverter;

use 5.014;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Cwd qw/abs_path/;

use base "Exporter";

our @EXPORT_OK = qw/
	convertToWin
/;

our $WSL_ROOT_DIR = "C:/Users/nyaap/AppData/Local/lxss/";

sub convertToWin($path, $ignore_check = 0) {
	$path =~ s/:.*//;
	die "Unexisted path: $path" unless $ignore_check || -e $path;

	my $abs_path = abs_path($path); 
	unless ( $abs_path =~ s@^/mnt/([a-z])(/|\Z)@$1:/@ ) {
		$abs_path = "$WSL_ROOT_DIR/$abs_path";
	}
	$abs_path =~ s@/@\\@g;
	1 while $abs_path =~ s@\\\\@\\@;
	return $abs_path;
}

1;
