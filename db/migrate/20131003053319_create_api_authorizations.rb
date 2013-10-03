class CreateApiAuthorizations < ActiveRecord::Migration
  def change
    create_table :api_authorizations do |t|
      t.string :name
      t.string :value
      t.datetime :expires_on
      t.references :admin, index: true

      t.timestamps
    end
  end
end
