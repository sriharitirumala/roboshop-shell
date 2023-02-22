source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31mmissing mysql root password\e[0m"
  exit 1
fi

mysql

print_head "Disabling Mysql 8 version"
dnf module disable mysql -y
status_check $?

print_head "Installing mysql server"
yum install mysql-community-server -y
status_check $?

print_head "Enabling mysql server"
systemctl enable mysqld
status_check $?

print_head "Starting mysql server"
systemctl start mysqld
status_check $?

print_head "Set password"
mysql_secure_installation --set-root-pass ${mysql_root_password}
status_check $?


