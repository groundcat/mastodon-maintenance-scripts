# Change toot limits

This shows you how to change toot limits quickly without creating a fork. However creating a fork to maintain your changes is recommended.

Increase poll options limit

```
sed -i 's/options.size >= 4/options.size >= 16/g' /home/mastodon/live/app/javascript/mastodon/features/compose/components/poll_form.js
sed -i 's/MAX_OPTIONS      = 4/MAX_OPTIONS      = 16/g' /home/mastodon/live/app/validators/poll_validator.rb
```

Increase media size limit

```
sed -i 's/IMAGE_LIMIT = 10.megabytes/IMAGE_LIMIT = 15.megabytes/g' /home/mastodon/live/app/models/media_attachment.rb
sed -i 's/VIDEO_LIMIT = 40.megabytes/VIDEO_LIMIT = 50.megabytes/g' /home/mastodon/live/app/models/media_attachment.rb
```

Increase word count limit

```
sed -i 's/500/1000/g' /home/mastodon/live/app/javascript/mastodon/features/compose/components/compose_form.js
sed -i 's/500/1000/g' /home/mastodon/live/app/validators/status_length_validator.rb
```

Block search engine

```
curl https://gist.githubusercontent.com/groundcat/7b61b701fd1572d82c2a2ffb6407ff01/raw/0db20c91ef71bfe1bb71ee761b358350f4d345d1/robots.txt > /home/mastodon/live/public/robots.txt
```

Precompile the assets

```
su mastodon
cd ~/live
RAILS_ENV=production bundle exec rails assets:precompile
```

```
exit
systemctl restart mastodon-web mastodon-sidekiq mastodon-streaming
```

Clear cache

```
su mastodon
cd ~/live
RAILS_ENV=production bin/tootctl cache clear
```