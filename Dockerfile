FROM ruby:3.1.0

# Node.jsとYarnを導入
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs build-essential libmariadb-dev mariadb-client git python3 && \
    npm install -g yarn@1

WORKDIR /app

COPY Gemfile Gemfile.lock ./


# 環境変数を設定（外部から渡される RAILS_ENV を反映）
ENV RAILS_ENV=${RAILS_ENV}


# 本番環境では development/test の gem を除外
RUN if [ "$RAILS_ENV" = "production" ]; then \
      bundle config set --local without "development test"; \
    fi && \
    bundle install

COPY package.json yarn.lock ./
RUN yarn cache clean && yarn install --frozen-lockfile

COPY . .

# tailwindcss のビルドを事前に実行
RUN yarn run build:css

# Rails のアセットプリコンパイル（本番環境のみ）
RUN if [ "$RAILS_ENV" = "production" ]; then \
      bundle exec rails assets:precompile; \
    fi

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3001
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3001"]
