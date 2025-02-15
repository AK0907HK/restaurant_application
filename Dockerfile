# Ruby 3.1.0をベースイメージとして使用
FROM ruby:3.1.0

# OSパッケージのアップデートと必要パッケージのインストール
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  yarn \
  libmariadb-dev \
  build-essential \
  mariadb-client

# 作業ディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockを先にコピーしてbundle installを実施（キャッシュ利用のため）
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションの全ファイルをコピー
COPY . .

# ポート3001をExpose
EXPOSE 3001

# Railsサーバーを起動（ホスト0.0.0.0で接続を受け付ける）
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
