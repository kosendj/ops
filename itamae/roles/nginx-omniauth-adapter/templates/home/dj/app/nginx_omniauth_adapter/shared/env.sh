#!/bin/bash

export NGX_OMNIAUTH_ENVSH="$0"
export NGX_OMNIAUTH_ENVVER=a

export NGX_OMNIAUTH_SESSION_COOKIE_NAME=djbuauth
export NGX_OMNIAUTH_SESSION_COOKIE_TIMEOUT=3456000
export NGX_OMNIAUTH_SECRET="<%= node[:secrets][:'nginx_omniauth_adapter-secret'] %>"
export NGX_OMNIAUTH_SESSION_SECRET="<%= node[:secrets][:'nginx_omniauth_adapter-session_secret'] %>"
export NGX_OMNIAUTH_HOST='https://<%= node[:nginx_omniauth_adapter][:host] %>'
export NGX_OMNIAUTH_ALLOWED_APP_CALLBACK_URL='\Ahttps?://.+\.kosendj-bu\.in/'
export NGX_OMNIAUTH_ALLOWED_BACK_TO_URL='\Ahttps?://.+\.kosendj-bu\.in/'

export NGX_OMNIAUTH_GITHUB_KEY="<%= node[:secrets][:'nginx_omniauth_adapter-github_key'] %>"
export NGX_OMNIAUTH_GITHUB_SECRET="<%= node[:secrets][:'nginx_omniauth_adapter-github_secret'] %>"
export NGX_OMNIAUTH_GITHUB_TEAMS=kosendj/owners

exec "$@"
