require 'clockwork'
require 'clockwork/manager_with_database_tasks'

require_relative './config/boot'
require_relative './config/environment'

module Clockwork

  Clockwork.manager = ManagerWithDatabaseTasks.new

  sync_database_tasks(model: Timer, every: 1.minute) do |name|
    timer = Timer.find_by(name: name)
    timer.execute
  end

end
