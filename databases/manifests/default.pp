class mysql {
  $database_name = "logs"
  $createdb_lock = "/home/vagrant/createdb.${database_name}.lock"
  $grant_lock = "/home/vagrant/grant.${database_name}.lock"
  
  exec { "mysql-yum.repo.d":
    command => "rpm -ivh http://repo.mysql.com/mysql-community-release-el6-4.noarch.rpm",
    creates => "/etc/yum.repos.d/mysql-community.repo",
    path    => ["/bin"],
  }
  
  -> package { "mysql-community-server":
    ensure => latest,
  }
  
  ~> service { "mysqld":
    ensure => running,
  }
  
  -> exec { "create-datatbase":
    command => "echo 'create database ${database_name}' | mysql -u root; touch ${createdb_lock}",
    creates => "${createdb_lock}",
    path    => ["/bin", "/usr/bin"],
  }
  
  -> exec { "grant":
    command => "echo \"grant all privileges on *.* to 'root'@'%'\" | mysql ${database_name} -u root; touch ${grant_lock}",
    creates => "${grant_lock}",
    path    => ["/bin", "/usr/bin"],
  }
}

class influxdb {
  package { influxdb:
    ensure => latest,
    source => "http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm",
    provider => rpm,
  }

  ~> service { influxdb:
      ensure => running,
      enable => true,
      hasrestart => true,
  }
}

class elasticsearch {
  package { "java-1.7.0-openjdk": ensure => latest, }

  -> yumrepo { elasticsearch:
    name => 'elasticsearch',
    baseurl => 'http://packages.elasticsearch.org/elasticsearch/1.2/centos',
    gpgcheck => '0';
  }

  -> package { elasticsearch: ensure => latest, }

  ~> service { elasticsearch: ensure => running, }

  -> exec { "head-plugin":
    command => "/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head",
    creates => "/usr/share/elasticsearch/plugins/head"
  }

  -> exec { "inquisitor-plugin":
    command => "/usr/share/elasticsearch/bin/plugin -install polyfractal/elasticsearch-inquisitor",
    creates => "/usr/share/elasticsearch/plugins/inquisitor"
  }
}

include mysql
include influxdb
include elasticsearch

