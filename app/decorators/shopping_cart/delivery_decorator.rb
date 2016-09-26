module ShoppingCart
  class DeliveryDecorator < Drape::Decorator
    delegate_all

    def price_in_currency
      h.number_to_currency object.price
    end

    def full_info
      "#{object.title} + #{price_in_currency}"
    end

    def full_info_list
      h.capture_haml do
        h.haml_tag :ul, class: 'list-unstyled' do
          h.haml_tag(:li) { h.haml_concat object.title }
          h.haml_tag(:li) { h.haml_concat price_in_currency }
        end
      end
    end
  end
end
