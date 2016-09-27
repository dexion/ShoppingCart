RSpec.describe ShoppingCart do
  describe "#configure" do
    before do
      ShoppingCart.configure do |config|
        config.user_class = 'Customer'
        config.checkout_steps = [:confirm, :complete]
      end
    end

    it "assignes user_class" do
      expect(ShoppingCart.config.user_class).to eq 'Customer'
    end

    it "assignes checkout_steps" do
      expect(ShoppingCart.config.checkout_steps).to eq([:confirm, :complete])
    end
  end
end
