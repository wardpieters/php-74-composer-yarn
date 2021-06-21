#!/bin/bash
set -e

#
# If $TIMEZONE variable is passed to the image - it will set system timezone 
# and php.ini date.timezone value as well
# Overwise the default system Etc/UTC timezone will be used
#
# Also you can set the php timezone with direct setting it in php.ini 
# within your .gitlab-ci.yml like
# before_script:
# - echo "America/New_York" > /usr/local/etc/php/conf.d/timezone.ini

if [[ ! -z "$TIMEZONE" ]]
then
  echo "$TIMEZONE" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
fi
echo "date.timezone=`cat /etc/timezone`" > /usr/local/etc/php/conf.d/timezone.ini

exec "$@"
