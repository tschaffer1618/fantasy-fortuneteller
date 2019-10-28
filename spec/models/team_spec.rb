require 'rails_helper'

describe Team, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many(:players).through(:team_players)}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end
end
