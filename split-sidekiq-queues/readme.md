Steps:

Add them to `/etc/systemd/system/`

```
wget -O /etc/systemd/system/mastodon-sidekiq-default-@.service "https://github.com/groundcat/mastodon-maintenance-scripts/blob/main/split-sidekiq-queues/mastodon-sidekiq-default-%40.service"
wget -O /etc/systemd/system/mastodon-sidekiq-mailers-@.service "https://github.com/groundcat/mastodon-maintenance-scripts/blob/main/split-sidekiq-queues/mastodon-sidekiq-mailers-%40.service"
wget -O /etc/systemd/system/mastodon-sidekiq-pull-@.service "https://github.com/groundcat/mastodon-maintenance-scripts/blob/main/split-sidekiq-queues/mastodon-sidekiq-pull-%40.service"
wget -O /etc/systemd/system/mastodon-sidekiq-push-@.service "https://github.com/groundcat/mastodon-maintenance-scripts/blob/main/split-sidekiq-queues/mastodon-sidekiq-push-%40.service"
```

Reload the deamon and enable all processes

```
systemctl daemon-reload
systemctl enable --now mastodon-sidekiq-default mastodon-sidekiq-*
```
