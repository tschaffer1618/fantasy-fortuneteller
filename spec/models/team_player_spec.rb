require 'rails_helper'

describe TeamPlayer, type: :model do
  describe "relationships" do
    it {should belong_to :team}
    it {should belong_to :player}
  end
end
