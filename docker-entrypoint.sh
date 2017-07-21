#!/bin/sh
set -e
# define help message
show_help() {
    echo """
    Usage: docker run [OPTIONS] <imagename> [COMMAND]

    Commands
    bash     : Start a bash shell
    help     : Show this message

    """
}

# Initialize
initialize() {
    echo "Initializing ..."
    rm -f /var/run/haproxy.pid
}

# Start tasks
main_task() {
    /etc/init.d/rsyslog start
    /etc/init.d/crond start
}

# Run
case "$1" in
    bash)
        /bin/bash "${@:2}"
    ;;
    help)
        show_help
    ;;
    *)
        initialize
        main_task
        exec "$@"
    ;;
esac

