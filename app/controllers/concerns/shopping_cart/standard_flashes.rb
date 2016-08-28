module ShoppingCart
  module StandardFlashes
    extend ActiveSupport::Concern

    def updated_notice obj
      flash[:notice] = t('flash.updated', obj: obj)
    end

    def update_error obj
      flash[:error] = t('flash.not_updated', obj: obj)
    end

    def create_order_failed
      flash[:error] = t('cart.create_order_failed')
      redirect_back(fallback_location: main_app.root_path)
    end
  end
end
