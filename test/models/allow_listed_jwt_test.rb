# == Schema Information
#
# Table name: allow_listed_jwts
#
#  id         :integer          not null, primary key
#  aud        :string
#  exp        :datetime         not null
#  jti        :string           not null
#  user       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_allow_listed_jwts_on_jti   (jti)
#  index_allow_listed_jwts_on_user  (user)
#
require 'test_helper'

class AllowListedJwtTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
