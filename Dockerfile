# base imageの取得
FROM ruby:2.7.0

ENV LANG ja_JP.UTF-8
ENV LC_ALL C

# 基本のインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# コンテナ上にプロジェクトディレクトリを作成・移動
RUN mkdir /HSPortal
WORKDIR /HSPortal

COPY Gemfile /HSPortal/Gemfile
COPY Gemfile.lock /HSPortal/Gemfile.lock
COPY package.json /HSPortal/package.json
COPY package-lock.json /HSPortal/package-lock.json
COPY yarn.lock /HSPortal/yarn.lock

# localとコンテナでbundlerのバージョンを合わせないとエラーがでる
RUN gem install bundler -v 2.1.2
RUN bundle install
# Bootstrap、Tempusdominus(DatetimePicker)周りのインストール
RUN yarn install

# プロジェクトをコピー
COPY . /HSPortal

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
