FROM ruby:3.2

RUN gem install puma
RUN gem install sinatra
COPY app.rb /app.rb

CMD ["ruby", "/app.rb"]
