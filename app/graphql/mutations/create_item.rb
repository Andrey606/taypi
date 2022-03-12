module Mutations
  class CreateItem < Mutations::BaseMutation
    # null true
    argument :title, String
    argument :description, String
    argument :artist_id, ID
    argument :image_url, String

    field :item, Types::ItemType
    field :errors, [String], null: false

    def resolve(title: 'test title', description: 'test description', artist_id:, image_url: 'test url')
      artist = Artist.find(artist_id)
      item = Item.new(
            title: title,
            description: description,
            artist: artist,
            image_url: image_url
      )

      if item.save
        # Successful creation, return the created object with no errors
        {
          item: item,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          comment: nil,
          errors: item.errors.full_messages
        }
      end
    end
  end
end