namespace :update do
  desc 'Update player info for current week'

  task projections: :environment do
    service = UpdateService.new
    service.get_current_projections
  end
end
