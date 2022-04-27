#!/bin/bash
umask 027

# Save at:
#   /opt/mastodon-maintenance.sh
# Set permission:
#   chmod +x /opt/mastodon-maintenance.sh
# Add cronjob: 
#   0 18 * * 1 bash /opt/mastodon-maintenance.sh

# Mastodon maintenance
su - mastodon
cd /home/mastodon/live
RAILS_ENV=production bin/tootctl media remove --days=7
RAILS_ENV=production bin/tootctl cache clear
RAILS_ENV=production bin/tootctl statuses remove
RAILS_ENV=production bin/tootctl preview_cards remove
RAILS_ENV=production bin/tootctl media remove-orphans