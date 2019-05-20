# inject-mysql-ryby

```bash
gem install bundler
bundler install
# and I don't know how to rackup without RubyMine.
# plz teach me how to rackup config.ru 
```
## mysql up
```bash
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=123456 -p \
3306:3306 -v ~/mysqldata:/var/lib/mysql -e MYSQL_DATABASE=homework -d \
mysql
# and execute db_up.sql in some-mysql
```