class ProcessOrdersJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    puts order
  end
end
