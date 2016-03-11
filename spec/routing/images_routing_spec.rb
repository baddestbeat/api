require "rails_helper"

RSpec.describe ImagesController, type: :routing do
  describe "routing" do


    it "routes to #new" do
      expect(:get => "/images/new").to route_to("images#new")
    end

    it "routes to #upload via PATCH" do
      expect(:post => "/images/1").to route_to("images#upload", :id => "1")
    end

  end
end
