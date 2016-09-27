module ShoppingCart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def add_dependency
      inject_into_file 'config/application.rb', after: "require 'rails/all'" do
        "\nrequire 'shopping_cart'"
      end
    end

    def create_initializer
      unless File.exist? initializer
        copy_file 'shopping_cart.rb', initializer
      end
    end

    def set_user_class
      unless File.readlines(initializer).grep(/config.user_class/).any?
        class_name = ask("User model (leave blank for 'User'):")
        class_name = 'User' if class_name.blank?
        inject_into_file initializer, after: "# Define 'Customer' class" do
          "\n  config.user_class = '#{class_name.capitalize}'"
        end
      end
    end

    def set_checkout_steps
      unless File.readlines(initializer).grep(/config.checkout_steps/).any?
        steps = ask(steps_question)
                .split(/\W+/).map(&:downcase).map(&:to_sym)
                .concat [:confirm, :complete]
        inject_into_file initializer, after: '#Define checkout steps' do
          "\n  config.checkout_steps = #{steps}"
        end
      end
    end

    def set_routes
      unless File.readlines(router).grep(/ShoppingCart::Engine/).any?
        cart_path = ask "Cart path (leave blank for '/cart'):"
        cart_path = '/cart' if cart_path.blank?
        inject_into_file router, after: "Rails.application.routes.draw do" do
          "\n  mount ShoppingCart::Engine, at: '#{cart_path}'"
        end
      end
    end

    def install_migrations
      rake 'shopping_cart:install:migrations'
    end

    def run_migrations
      if yes? 'Do you want to run ShoppingCart migrations now?'
        rake "db:migrate SCOPE=shopping_cart"
      end
    end

    private

    def initializer
      'config/initializers/shopping_cart.rb'
    end

    def router
      'config/routes.rb'
    end

    def steps_question
      "Checkout steps (leave blank for confirmation only):"
    end

  end
end
