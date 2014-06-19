# Local AMP stack (Apache, MariaDB, PHP) development environment

MONGOPID=`ps -ef | grep 'mongod' | grep -v grep | awk '{print $2}'`
MYSQLPID=`ps -ef | grep 'mysqld' | grep -v grep | awk '{print $2}'`

function amp() {
    if [ "$1" = "start" ]; then
        echo "Starting AMP..."
        sudo apachectl start

        if [ "$2" = "mysql" ]; then
            echo "* AMP with MySQL"
            mysql.server start
        elif [ "$2" = "mongo" ] || [ "$2" = "mongodb" ]; then
            echo "* AMP with MongoDB"
            mongod --fork --quiet --dbpath /data/db --bind_ip 127.0.0.1 --rest --logpath /var/log/mongod.log
        fi
    fi

    if [ "$1" = "stop" ]; then
        echo "Stopping AMP..."
        sudo apachectl stop

        if [ ! -z "$MONGOPID" ]; then
            kill -15 $MONGOPID
        fi

        if [ ! -z "$MYSQLPID" ]; then
            kill -15 $MYSQLPID
        fi
    fi

    if [ "$1" = "conf" ]; then
        subl -n ~/.amp/conf/
    fi
}
