Steps:

Add them to `/etc/systemd/system/`

```
wget -O /etc/systemd/system/mastodon-sidekiq-default-@.service "https://raw.githubusercontent.com/groundcat/mastodon-maintenance-scripts/main/split-sidekiq-queues/mastodon-sidekiq-default-%40.service"
wget -O /etc/systemd/system/mastodon-sidekiq-mailers-@.service "https://raw.githubusercontent.com/groundcat/mastodon-maintenance-scripts/main/split-sidekiq-queues/mastodon-sidekiq-mailers-%40.service"
wget -O /etc/systemd/system/mastodon-sidekiq-pull-@.service "https://raw.githubusercontent.com/groundcat/mastodon-maintenance-scripts/main/split-sidekiq-queues/mastodon-sidekiq-pull-%40.service"
wget -O /etc/systemd/system/mastodon-sidekiq-push-@.service "https://raw.githubusercontent.com/groundcat/mastodon-maintenance-scripts/main/split-sidekiq-queues/mastodon-sidekiq-push-%40.service"
```

Reload the deamon and enable all processes

```
systemctl daemon-reload
systemctl enable --now mastodon-sidekiq-default-@1.service mastodon-sidekiq-push-@1.service mastodon-sidekiq-mailers-@1.service mastodon-sidekiq-pull-@1.service
```
