class PlayerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    service = UpdateService.new
    service.update_backend_projections
    service.get_current_projections
  end
end
