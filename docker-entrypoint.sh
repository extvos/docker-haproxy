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
        exec "$@"
    ;;
esac

