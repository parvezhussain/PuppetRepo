class verizonscripts {
    file {"/opt/verizon":
        ensure  => directory,
        source  => 'puppet:///modules/verizonscripts/verizon',
        recurse => remote,
        owner   => $fname,
        group   => $fname,
        mode    => 755,
    }
}
