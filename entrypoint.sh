#!/bin/bash
set -e

# pidファイルが残ってたら削除
rm -f /hsportal/tmp/pids/server.pid

# run command
exec "$@"
