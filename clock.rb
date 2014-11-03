require 'clockwork'
require 'clockwork/database_events'

require_relative './config/boot'
require_relative './config/environment'

module Clockwork

  Clockwork.manager = DatabaseEvents::Manager.new

  sync_database_events(model: Timer, every: 1.minute) do |timer|
    timer.execute
  end

end
