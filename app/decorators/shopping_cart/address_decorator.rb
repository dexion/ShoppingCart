module ShoppingCart
  class AddressDecorator < Drape::Decorator
    delegate_all

    def full_name
      "#{object.first_name} #{object.last_name}"
    end

    def full_info
      h.capture_haml do
        h.haml_tag :ul, class: 'list-unstyled' do
          h.haml_tag(:li) { h.haml_concat full_name }
          [:street, :city, :country_code, :zipcode, :phone].each do |field|
            h.haml_tag(:li) { h.haml_concat object.public_send(field) }
          end
        end
      end
    end
  end
end
