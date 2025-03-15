#!/bin/sh

set -e

rm -f /app/tmp/pids/server.pid

#if [ "$RAILS_ENV" = "production" ]; then
#  bundle exec rails assets:clobber
#  bundle exec rails assets:precompile
#  bundle exec rails db:migrate
  #初回のみ実行（２回目以降はコメントアウト）
#  bundle exec rails db:seed
#fi

exec "$@"