class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :admin, :id, :created_at, :updated_at
end
