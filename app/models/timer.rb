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

class Timer < ActiveRecord::Base

  has_and_belongs_to_many :lights

  # after_save { Timer.update_scheduler }

  validates_presence_of :bri, :sat, :hue, :at

  def execute
    lights.each do |l|
      l.change(bri: bri, sat: sat, hue: hue)
    end
  end

  # def self.update_scheduler
  #   s = Rufus::Scheduler.singleton
  #   s.jobs.each(&:unschedule)

  #   Timer.find_each do |t|
  #     next_time = Chronic.parse(t.time.localtime.strftime('%H:%M:%S'))

  #     s.every('5s', first_at: next_time) do
  #       t.lights.each do |l|
  #         l.change(bri: t.bri, hue: t.hue, sat: t.sat)
  #       end
  #     end
  #   end
  # end

end
