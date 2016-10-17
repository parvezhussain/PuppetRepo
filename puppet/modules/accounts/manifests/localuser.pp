# Defined type for creating virtual user accounts
#
define accounts::localuser ($uid,$realname,$pass,$sshkey="") {

  user { $title:
    ensure            =>  'present',
    uid               =>  $uid,
    gid               =>  $title,
    shell             =>  '/bin/bash',
    home              =>  "/home/${title}",
    comment           =>  $realname,
    password          =>  $pass,
    managehome        =>  true,
    require           =>  Group[$title],
  }

  group { $title:
    gid               =>  $uid,
  }

  file { "/home/${title}":
    ensure            =>  directory,
    owner             =>  $title,
    group             =>  $title,
    mode              =>  0750,
    require           =>  [ User[$title], Group[$title] ],
  }
  if ( $sshkey != "" )  {
       ssh_authorized_key { $title:
            ensure  =>      "present",
            type    =>      "ssh-rsa",
            key     =>      "$sshkey",
            user    =>      "$title",
            require =>      User["$title"],
            name    =>      "$title",
   }
 }
}
