module ShoppingCart
  class Configuration
    attr_accessor :user_class
    attr_accessor :checkout_steps

    def initialize
      @user_class = 'User'
      @checkout_steps = [:address, :delivery, :payment, :confirm, :complete]
    end
  end
end
