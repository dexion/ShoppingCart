module ShoppingCart
  class CreditCardDecorator < Drape::Decorator
    delegate_all

    def holder
      "#{object.first_name} #{object.last_name}"
    end

    def expiration
      "#{object.month} / #{object.year}"
    end

    def protected_number
      "xxxx-xxxx-xxxx-#{object.number[-4..-1]}"
    end

    def full_info
      h.capture_haml do
        h.haml_tag :ul, class: 'list-unstyled' do
          h.haml_tag(:li) { h.haml_concat holder }
          h.haml_tag(:li) { h.haml_concat protected_number }
          h.haml_tag(:li) { h.haml_concat expiration }
        end
      end
    end
  end
end
