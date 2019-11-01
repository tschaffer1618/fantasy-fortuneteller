require 'rails_helper'

describe 'update service' do
  it "updates data" do
    @player = create(:player, ffn_id: 1, id: 2548)
    service = UpdateService.new

    cur_proj = service.get_current_projections
    expect(cur_proj.first.id).to eq(2548)

    updated = service.update_backend_projections
    expect(updated.body).to be_a(String)
  end
end
