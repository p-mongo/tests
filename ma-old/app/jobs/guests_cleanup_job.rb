class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Band.create!
    # Do something later
  end
end
