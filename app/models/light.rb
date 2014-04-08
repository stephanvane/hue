# == Schema Information
#
# Table name: lights
#
#  id       :integer          not null, primary key
#  light_id :integer
#  name     :string(255)
#

class Light < ActiveRecord::Base

  validates_presence_of :light_id, :name

  has_and_belongs_to_many :timer

  def change(arg={})
    arg = arg.with_indifferent_access
    c = HTTPClient.new
    json = c.get_content("http://192.168.192.12/api/stephanvane/lights/#{light_id}")
    current_state = MultiJson.load(json)['state']

    new_state = {
      'bri' => arg['bri'] || current_state['bri'],
      'hue' => arg['hue'] || current_state['hue'],
      'sat' => arg['sat'] || current_state['sat'],
      'on'  => arg['on'].nil? ? true : arg['on']
    }
    c.put("http://192.168.192.12/api/stephanvane/lights/#{light_id}/state",
      MultiJson.dump(new_state))
  end

  def turn_off
    change(on: false)
  end

  def default_state
    change(bri: 254, hue: 14922, sat: 144)
  end

end
