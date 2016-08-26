$(document).ready ->

  set_shipping_price = ->
    item_total = $('#delivery_step')
                   .find('#item_total_field')
                   .data 'item-total'

    shipping_price = $('#delivery_step')
                       .find("input[name='order[delivery_id]']:checked")
                       .data 'price'

    total_with_shipping = (parseFloat(item_total) + parseFloat(shipping_price))
                            .toFixed(2)

    $('#delivery_step').find('#shipping_price_field')
                       .text "$#{shipping_price}"

    $('#delivery_step').find('#order_total_field')
                       .text "$#{total_with_shipping}"

  set_shipping_price()
  $('#delivery_step').find("input[name='order[delivery_id]']").click ->
    set_shipping_price()
