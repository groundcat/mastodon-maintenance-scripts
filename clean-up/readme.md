Save at `/opt/mastodon-maintenance.sh`

Set permission
```
chmod +x /opt/mastodon-maintenance.sh
```

Add cronjob (weekly)

```
0 3 * * 1 bash /opt/mastodon-maintenance.sh
```

