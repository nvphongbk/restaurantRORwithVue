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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable
  has_many :restaurants
  validates :email, presence: true, uniqueness: true
end
