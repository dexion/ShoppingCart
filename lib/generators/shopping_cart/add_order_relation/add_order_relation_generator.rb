module ShoppingCart
  class AddOrderRelationGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :type, type: :string, required: true
    argument :model, type: :string, required: true

    def reopen_order_class
      unless File.exist? destination_path
        copy_file 'custom_methods.rb', destination_path
      end
    end

    def add_relation
      inject_into_file destination_path, after: 'self.included(order)' do
        "\norder.#{type} :#{model}, optional: true\norder.accepts_nested_attributes_for :#{model}"
      end
    end

    def create_migration
      generate "migration add_#{model}_reference_to_shopping_cart_orders #{model}:references"
    end

    def migrate
      rake 'db:migrate'
    end

    private

    def destination_path
      'app/models/shopping_cart/custom_methods.rb'
    end
  end
end
