require 'rails_helper'

describe Team, type: :model do
  describe "relationships" do
    it {should belong_to :user}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end
end
