class AddUserIdToProfessionalAndClientTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :clients, :user, type: :uuid, index: true, foreign_key: true
  end
end
