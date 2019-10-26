require 'rails_helper'

describe 'update service' do
  it "updates data" do
    service = UpdateService.new

    cur_proj = service.get_current_projections
    expect(cur_proj.first).to eq(nil)

    updated = service.update_backend_projections
    expect(updated.body).to be_a(String)
  end
end
