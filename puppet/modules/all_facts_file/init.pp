class all_facts_file {
   file {"/tmp/aaaa":
        ensure => file,
        owner => root,
        group => root,
        mode => 0600,
        source => "puppet:///modules/cron/root"

#  file { '/tmp/facts.yaml':
#    content => inline_template('<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>'),
  }

}
