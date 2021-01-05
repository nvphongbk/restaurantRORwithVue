# == Schema Information
#
# Table name: jwt_denylists
#
#  id         :integer          not null, primary key
#  expired_at :datetime         not null
#  jti        :string           not null
#
# Indexes
#
#  index_jwt_denylists_on_jti  (jti)
#
require 'test_helper'

class JwtDenylistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
