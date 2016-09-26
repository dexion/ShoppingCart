$(document).ready ->

  allow_billing = $('#order_use_billing_allow')
  shipping_fields = $("div[class*=shipping_address]")

  shipping_fields.hide()

  allow_billing.click ->
    if $(this).is(':checked')
      shipping_fields.hide()
    else
      shipping_fields.show()
