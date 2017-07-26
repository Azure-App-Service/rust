#!/usr/bin/env bash
service ssh start
mkdir -p /home/LogFiles
touch /home/LogFiles/dotnet_$WEBSITE_ROLE_INSTANCE_ID_out.log
echo "$(date) Container started" >> /home/LogFiles/dotnet_$WEBSITE_ROLE_INSTANCE_ID_out.log

# If there is any command line argument specified, run it
[ $# -ne 0 ] && exec "$@"

echo "Starting default app..."
exec /app/defaulthomeapp
