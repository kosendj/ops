#!/bin/bash

export GJCASE_ENVSH="$0"
export GJCASE_ENVVER=a

export AWS_ACCESS_KEY_ID="<%= node[:gjcase][:aws_access_key_id] %>"
export AWS_SECRET_ACCESS_KEY="<%= node[:gjcase][:aws_secret_access_key] %>"

export RAILS_ENV=production

export SECRET_KEY_BASE="<%= node[:secrets][:'gjcase-secret_key_base'] %>"

export DATABASE_URL="mysql2://gjcase:<%= node[:secrets][:'db-gjcase-password'] %>@$(cat ~/djbu-config/gj-mysql-master):3306/gjcase?encoding=utf8mb4&read_timeout=5&pool=5"
export REDIS_URL="redis://$(cat ~/djbu-config/gj-redis-master):6379"

export GJCASE_CAMO_URL=https://camo.kosendj-bu.in
export GJCASE_CAMO_KEY="<%= node[:secrets][:camo_key] %>"

export GJCASE_STORAGE=https://gjcase-storage.kosendj-bu.in
export GJCASE_S3_BUCKET=gjcase-prod
export GJCASE_S3_REGION=ap-northeast-1

export GJCASE_AUTO_MIRROR=1

export GJCASE_TUMBLR_KEY="<%= node[:secrets][:'gjcase-tumblr_consumer_key'] %>"

export GJCASE_GJ_URL=https://gj.kosendj-bu.in

exec "$@"
