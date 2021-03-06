use Module::Build;
use Data::Dumper;
my $build = Module::Build->new(
    dist_abstract => 'helm - Easy server and cluster automation',
    module_name   => 'Helm',
    license       => 'perl',
    requires      => {
        'perl'                  => '5.8.0',
        'Moose'                 => '1.14',
        'Getopt::Long'          => '2.38',
        'Pod::Usage'            => '1.38',
        'URI'                   => '1.55',
        'Try::Tiny'             => '0.06',
        'File::Spec::Functions' => '3.33',
        'File::Basename'        => '2.78',
        'File::HomeDir'         => '0.93',
        'Net::OpenSSH'          => '0.49',
        'Cwd'                   => '3.33',
        'Data::UUID'            => '1.217',
        'Carp'                  => '0',
        'Fcntl'                 => '0',
        'Term::ANSIColor'       => '3.00',
        'DateTime'              => '0.63',
        'Parallel::ForkManager' => '0.7.7',
        'IO::Pipe'              => '1.13',
        'IO::File'              => '1.14',
        'AnyEvent'              => '5.271',
    },
    recommends => {
        'Email::Simple'          => '2.100',
        'Email::Simple::Creator' => '1.424',
        'Email::Sender'          => '0.102370',
        'Email::Valid'           => '0.184',
        'AnyEvent::IRC::Client'  => '',
        'Config::ApacheFormat'  => '1.2',
    },
    create_makefile_pl => 'small',
);
$build->create_build_script;
