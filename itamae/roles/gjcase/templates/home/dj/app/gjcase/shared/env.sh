#!/bin/bash

export GJCASE_ENVSH="$0"
export GJCASE_ENVVER=a

export RAILS_ENV=production

export SECRET_KEY_BASE="<%= node[:secrets][:'gjcase-secret_key_base'] %>"

export DATABASE_URL="mysql2://gjcase:<%= node[:secrets][:'db-gjcase-password'] %>@172.19.0.1:3306/gjcase?encoding=utf8mb4&read_timeout=5&pool=5"
export REDIS_URL="redis://172.19.0.1:6379"

export GJCASE_CAMO_URL=http://camo.kosendj-bu.in
export GJCASE_CAMO_KEY="<%= node[:secrets][:camo_key] %>"

export GJCASE_STORAGE=http://gjcase-storage.kosendj-bu.in
export GJCASE_S3_BUCKET=gjcase-prod
export GJCASE_S3_REGION=ap-northeast-1

export GJCASE_AUTO_MIRROR=1

export GJCASE_TUMBLR_KEY="<%= node[:secrets][:'gjcase-tumblr_consumer_key'] %>"

export GJCASE_GJ_URL=http://gj.kosendj-bu.in

exec "$@"
