# README
# Testing graph ql

source: https://www.apollographql.com/blog/community/backend/using-graphql-with-ruby-on-rails/


rails new taypi -d postgresql --skip-action-mailbox --skip-action-text --skip-spring --webpack=react -T
rails g model Artist first_name last_name email
rails g model Item title description:text image_url artist:references
# add in app/models/artist.rb
# add in  db/seeds/rb 
rails db:create db:migrate db:seed

# add garph ql
bundle add graphql 
rails generate graphql:install 