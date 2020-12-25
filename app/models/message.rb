# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  email      :string
#  message    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Message < ApplicationRecord
end
