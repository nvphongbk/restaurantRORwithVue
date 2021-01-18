# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           not null
#  encrypted_password :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
end
