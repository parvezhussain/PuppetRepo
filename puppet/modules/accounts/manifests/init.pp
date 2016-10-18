# Used to define/realize users on Puppet-managed systems
#
class accounts {

  @accounts::localuser { 'johndoe':
    uid             =>  1001,
    realname        =>  'John Doe',
    pass            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
  }
  @accounts::localuser { 'adil':
    uid             =>  1002,
    realname        =>  'Adil Kapil',
    pass            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
    sshkey            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
  }
  @accounts::localuser { 'jbinst':
    uid             =>  1003,
    realname        =>  'jboss User',
    pass            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
  }
  @accounts::localuser { 'sumouser':
    uid             =>  1004,
    realname        =>  'Sumo User',
    pass            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
  }
  @accounts::localuser { 'tomcat':
    uid             =>  1005,
    realname        =>  'tomcat User',
    pass            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
  }
  @accounts::localuser { 'jbcomp':
    uid             =>  1006,
    realname        =>  'JetBlue Component',
    pass            =>  '$6$0b.gzsmP$xFALXnzKCxVWBRQmQJSI6trIhTqW05nzAj35ulNiemQIINQl.ZpCEuekIilI/RUCnZzdj9C80uABs5JpzvkMn0',
  }

}
