# == Schema Information
#
# Table name: timers
#
#  id        :integer          not null, primary key
#  name      :string(255)      not null
#  at        :string(255)      not null
#  frequency :integer          default(86400), not null
#  bri       :integer          not null
#  hue       :integer          not null
#  sat       :integer          not null
#  active    :boolean          default(TRUE), not null
#

require 'test_helper'

class TimerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
