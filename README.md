# Testing graph ql

1. Query: this allows us to get data. It is the “read” in CRUD. 
2. Mutation: this allows us to change information, including adding, updating, or removing data. It is where “create”, “update”, and “destroy” are in CRUD.

source: https://www.apollographql.com/blog/community/backend/using-graphql-with-ruby-on-rails/


rails new taypi -d postgresql --skip-action-mailbox --skip-action-text --skip-spring --webpack=react -T
rails g model Artist first_name last_name email
rails g model Item title description:text image_url artist:references
### add in app/models/artist.rb
### add in  db/seeds/rb 
rails db:create db:migrate db:seed

### add garph ql
bundle add graphql 
rails generate graphql:install 

### check db 
psql taypi_development -c "\d"
psql taypi_development -c "\d artists"

taypi_schema.rb - This is where it declares where all the queries should go and set up mutations. 
config/routes.rb - graphiql::Rails::Engine, Alternatively, you can use the Apollo Studio Explorer. It’s Apollo’s web IDE for creating, running, and managing your GraphQL operations. 

# add in query_type.rb new field 'items'
field :items, 
[Types::ItemType],
null: false, 
description: "Return a list of items"

def items
  Item.all
end 

# Теперь мы хотим сгенерировать с ItemTypeпомощью драгоценного камня GraphQL Ruby
rails g graphql:object item

# Теперь нам нужно обновить  файл types/item_type.rb  , включив в него поля с типом и опцией, допускающей значение null. 
field :id, ID, null: false
field :title, String, null: true
field :description, String, null: true
field :image_url, String, null: true
field :artist_id, Integer, null: false
field :artist, Types::ArtistType, null: false
field :created_at, GraphQL::Types::ISO8601DateTime, null: false
field :updated_at, GraphQL::Types::ISO8601DateTime, null: false


# Теперь давайте сделаем то же самое, но для ArtistType. 
rails g graphql:object artist

# В  файл artist_type.rb  добавьте full_nameметод и full_nameполе. 
 module Types
  class ArtistType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :email, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def full_name 
      [object.first_name, object.last_name].compact.join("")
    end 
  end
end

# add to the manifest.js
//= link graphiql/rails/application.css
//= link graphiql/rails/application.js

# Теперь у нас достаточно кода для запуска вашего сервера rails. Запустите rails в консоли и откройте GraphiQL:  http://localhost:3000/graphiql  в веб-браузере.

