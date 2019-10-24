require 'rails_helper'

describe Team, type: :model do
  it "relationships" do
    it {should belong_to :user}
  end
end
