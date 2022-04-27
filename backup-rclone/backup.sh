#!/bin/bash

umask 027

# Save this file at /opt/mastodon-backup/backup.sh
# mkdir -p /opt/mastodon-backup/
# mkdir -p /opt/mastodon-backup/logs
# Example cron job:
# 0 3 * * * bash /opt/mastodon-backup/backup.sh > /opt/mastodon-backup/logs/backup.log 2>&1

# Replace the values below with your Rclone config

rclone_config_name="REPLACE_ME"
rclone_config_pass="REPLACE_ME"
s3_bucket_name="REPLACE_ME"

backup_time="$(date +"%Y_%m_%d_%I_%M_%p")"

# Remove old backup directory
rm -rf /home/mastodon/S3_backup/*
rm -rf /home/mastodon/live/db_*.dump

# Create temporary backup directory
backup_file_name=${backup_time}_$RANDOM
backup_direcotry=/home/mastodon/S3_backup/${backup_file_name}
[ -e ${backup_direcotry} ] || mkdir -p ${backup_direcotry}

# Generate a database dump backup
su - mastodon -c "cd /home/mastodon/live && pg_dump -Fc mastodon_production > db_${backup_time}.dump"

# Move the database dump
mkdir -p $backup_direcotry/database_dump/ && mv /home/mastodon/live/db_${backup_time}.dump $backup_direcotry/database_dump/

# Copy files
mkdir -p $backup_direcotry/mastodon_env/ && cp /home/mastodon/live/.env.production $backup_direcotry/mastodon_env/backup.env.production
mkdir -p $backup_direcotry/redis/ && cp /var/lib/redis/dump.rdb $backup_direcotry/redis/
mkdir -p $backup_direcotry/nginx/ && cp /etc/nginx/sites-available/* $backup_direcotry/nginx/
mkdir -p $backup_direcotry/elasticsearch/ && cp /etc/elasticsearch/jvm.options $backup_direcotry/elasticsearch/
mkdir -p $backup_direcotry/backup_script/ && cp /opt/mastodon-backup/backup.sh $backup_direcotry/backup_script/

# Compress
7z a /home/mastodon/S3_backup/${backup_file_name}.7z $backup_direcotry

# Load the rclone password
export RCLONE_CONFIG_PASS=$rclone_config_pass

# Upload the backup
rclone move /home/mastodon/S3_backup/${backup_file_name}.7z $rclone_config_name:$s3_bucket_name/

# Remove backup directory
# rm -rf /home/mastodon/S3_backup/*