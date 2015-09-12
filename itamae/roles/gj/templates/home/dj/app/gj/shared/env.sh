#!/bin/bash

export PORT=3001
export HASH_TAG=kosendj
export REDIS_URL="redis://$(cat ~/djbu-config/gj-redis-master):6379"
export CONSUMER_KEY="<%= node[:secrets][:'gj-twitter-consumer_key'] %>"
export CONSUMER_SECRET="<%= node[:secrets][:'gj-twitter-consumer_secret'] %>"
export ACCESS_TOKEN="<%= node[:secrets][:'gj-twitter-access_token'] %>"
export ACCESS_TOKEN_SECRET="<%= node[:secrets][:'gj-twitter-access_token_secret'] %>"
export CAMO_URL=http://camo.kosendj-bu.in
export CAMO_KEY="<%= node[:secrets][:camo_key] %>"

exec "$@"
