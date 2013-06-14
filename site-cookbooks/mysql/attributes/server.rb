default[:mysql][:rpm_server] = 'http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-server-5.6.12-1.linux_glibc2.5.x86_64.rpm/from/http://cdn.mysql.com/'
default[:mysql][:rpm_server_name] = 'MySQL-server-5.6.12-1.linux_glibc2.5.x86_64.rpm'

default[:mysql][:rpm_client] = 'http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-client-5.6.12-1.linux_glibc2.5.x86_64.rpm/from/http://cdn.mysql.com/'
default[:mysql][:rpm_client_name] = 'MySQL-client-5.6.12-1.linux_glibc2.5.x86_64.rpm'

default[:mysql][:rpm_devel] = 'http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-devel-5.6.12-1.linux_glibc2.5.x86_64.rpm/from/http://cdn.mysql.com/'
default[:mysql][:rpm_devel_name] = 'MySQL-devel-5.6.12-1.linux_glibc2.5.x86_64.rpm'

default[:mysql][:rpm_shared_compat] = 'http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-shared-compat-5.6.12-1.linux_glibc2.5.x86_64.rpm/from/http://cdn.mysql.com/'
default[:mysql][:rpm_shared_compat_name] = 'MySQL-shared-compat-5.6.12-1.linux_glibc2.5.x86_64.rpm'

default[:mysql][:rpm_shared] = 'http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-shared-5.6.12-1.linux_glibc2.5.x86_64.rpm/from/http://cdn.mysql.com/'
default[:mysql][:rpm_shared_name] = 'MySQL-shared-5.6.12-1.linux_glibc2.5.x86_64.rpm'

default[:mysql][:rpm_test] = 'http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-test-5.6.12-1.linux_glibc2.5.x86_64.rpm/from/http://cdn.mysql.com/'
default[:mysql][:rpm_test_name] = 'MySQL-test-5.6.12-1.linux_glibc2.5.x86_64.rpm'


default[:mysql][:ini_dir] = '/etc'

default[:mysql][:mysqld][:character_set_server] = 'utf8'
default[:mysql][:mysqld][:basedir] = '/var/lib/mysql'
default[:mysql][:mysqld][:datadir] = '/var/lib/mysql/mysql'
default[:mysql][:mysqld][:socket] = '/var/lib/mysql/mysql.sock'
default[:mysql][:mysqld][:pid_file] = '/var/run/mysqld/mysql.pid'
default[:mysql][:mysqld][:user] = 'mysql'
default[:mysql][:mysqld][:symbolic_links] = '0'
default[:mysql][:mysqld][:max_connections] = '200'
default[:mysql][:mysqld][:key_buffer] = '256M'
default[:mysql][:mysqld][:max_allowed_packet] = '16M'
default[:mysql][:mysqld][:table_cache] = '64'
default[:mysql][:mysqld][:sort_buffer_size] = '1M'
default[:mysql][:mysqld][:read_buffer_size] = '1M'
default[:mysql][:mysqld][:read_rnd_buffer_size] = '1M'
default[:mysql][:mysqld][:character_set_server] = 'utf8'
default[:mysql][:mysqld][:innodb_data_home_dir] = '/var/lib/mysql/ibdata'
default[:mysql][:mysqld][:innodb_data_file_path] = 'ibdata1:10M:autoextend'
default[:mysql][:mysqld][:innodb_log_group_home_dir] = '/var/lib/mysql/iblogs'
default[:mysql][:mysqld][:innodb_buffer_pool_size] = '256M'
default[:mysql][:mysqld][:innodb_additional_mem_pool_size] = '20M'
default[:mysql][:mysqld][:innodb_log_file_size] = '16M'
default[:mysql][:mysqld][:innodb_log_buffer_size] = '128M'
default[:mysql][:mysqld][:innodb_flush_log_at_trx_commit] = '1'
default[:mysql][:mysqld][:innodb_lock_wait_timeout] = '1'
default[:mysql][:mysqld][:server_id] = '1'

default[:mysql][:mysqld_safe][:log_error] = '/var/log/mysql.log'
default[:mysql][:mysqld_safe][:pid_file] = '/var/run/mysqld/mysql.pid'

default[:mysql][:mysqldump][:default_character_set] = 'utf8'
default[:mysql][:datadir] = '/var/lib/mysql/mysql'

