[![Code Climate](https://codeclimate.com/github/kirill-oleynik/ShoppingCart/badges/gpa.svg)](https://codeclimate.com/github/kirill-oleynik/ShoppingCart)
[![Build Status](https://travis-ci.org/kirill-oleynik/ShoppingCart.svg?branch=development)](https://travis-ci.org/kirill-oleynik/ShoppingCart)
# ShoppingCart
ShoppingCart plugin provides checkout functionality, which can be integrated into your online store and configured according to your business logic.

## Description

### Cart
The plugin provides a cart, in which logged in users can add any number of different types of products. Cart provides an opportunity to modify the amount of added products, as well as their removal from the order. The user can also enter a coupon code to receive the discount.

### Checkout
By default checkout consists of 5 steps. The first three are used to obtain additional order information:
* `:address` – user can specify billing & shipping addresses
* `:delivery` – user can choose delivery method
* `:payment` – user can enter credit card information.
These steps may be canceled, amended or changed during the plugin connection & configuration. You can also configure the desired sequence of these steps.

The last two steps are static:
* `:confirmation`, where the user can view all the information and confirm it,
* `:completed`, where he can see the message that order was created.

### Orders
The following states can be applied to orders for management:
* `:in_progress` - created but not confirmed order by the user (the default state)
* `:processing` - confirmed by the user, accepted in processing by the manager
* `:in_delivery` - sent to customer
* `:delivered` - delivered to the customer (the final state)
* `:canceled` - canceled by the manager for some reason (the final state)

## Installation & Configuration
Add this line to your application's Gemfile:

```ruby
gem 'shopping_cart'
```
Run the bundle command to install it.

Run the built-in generator with the command:
```bash
$ rails g shopping_cart:install
```
This will create an initializer and after that you'll be asked next questions:
* ```User model (leave blank for 'User'):``` – it's a *customer* model in your main application. If you type nothing, than 'User' will be set as *customer* model.
* ```Checkout steps (leave blank for confirmation only):``` – presence and order of checkout steps that will be shown to customer during checkout. If you type nothing, you'll got only ```:confirm``` and ```:complete```. **Note:** you don't need to specify these two steps, they will automatically be added anyway.
* ```Cart path (leave blank for '/cart'):``` – path in main application, where shopping cart will be available. If you type nothing, '/cart' path will be set by default. This action will add routes to your 'routes.rb' file.
* ```Do you want to run ShoppingCart migrations now?``` – if 'yes' or 'y', all just copied migration files will be executed. If you prefere to run them later, you can run ```$ bin/rails db:migrate SCOPE=shopping_cart``` any time.

### Example
```bash
→ rails g shopping_cart:install
Running via Spring preloader in process 13433
      create  config/initializers/shopping_cart.rb
User model (leave blank for 'User'): customer
      append  config/initializers/shopping_cart.rb
Checkout steps (leave blank for defaults): address delivery payment
      append  config/initializers/shopping_cart.rb
Cart path (leave blank for '/cart'): /shopping_cart
      insert  config/routes.rb
        rake  shopping_cart:install:migrations
Copied migration 20160915181819_create_shopping_cart_addresses.shopping_cart.rb from shopping_cart
Copied migration 20160915181820_create_shopping_cart_coupons.shopping_cart.rb from shopping_cart
Copied migration 20160915181821_create_shopping_cart_credit_cards.shopping_cart.rb from shopping_cart
Copied migration 20160915181822_create_shopping_cart_deliveries.shopping_cart.rb from shopping_cart
Copied migration 20160915181823_create_shopping_cart_order_items.shopping_cart.rb from shopping_cart
Copied migration 20160915181824_create_shopping_cart_orders.shopping_cart.rb from shopping_cart
Do you want to run ShoppingCart migrations now? yes
        rake  db:migrate SCOPE=shopping_cart
== 20160916085535 CreateShoppingCartAddresses: migrating ======================
-- create_table(:shopping_cart_addresses)
   -> 0.0156s
== 20160916085535 CreateShoppingCartAddresses: migrated (0.0157s) =============

== 20160916085536 CreateShoppingCartCoupons: migrating ========================
-- create_table(:shopping_cart_coupons)
   -> 0.0135s
== 20160916085536 CreateShoppingCartCoupons: migrated (0.0136s) ===============

== 20160916085537 CreateShoppingCartCreditCards: migrating ====================
-- create_table(:shopping_cart_credit_cards)
   -> 0.0147s
== 20160916085537 CreateShoppingCartCreditCards: migrated (0.0148s) ===========

== 20160916085538 CreateShoppingCartDeliveries: migrating =====================
-- create_table(:shopping_cart_deliveries)
   -> 0.0099s
== 20160916085538 CreateShoppingCartDeliveries: migrated (0.0102s) ============

== 20160916085539 CreateShoppingCartOrderItems: migrating =====================
-- create_table(:shopping_cart_order_items)
   -> 0.0213s
== 20160916085539 CreateShoppingCartOrderItems: migrated (0.0216s) ============

== 20160916085540 CreateShoppingCartOrders: migrating =========================
-- enable_extension("uuid-ossp")
   -> 0.0557s
-- create_table(:shopping_cart_orders)
   -> 0.0303s
== 20160916085540 CreateShoppingCartOrders: migrated (0.0862s) ================
```

## Requirements for the main application models
* **User model** –  must be configurated with [devise](https://github.com/plataformatec/devise). Only logged in users can create orders.
* **Product models** – must have `title` and `price` colums in database. You may use as many product types as you want.

## Add data to database
You can add any data as usual from rails console. However plugin provides some helpful generators to save your time.

### Delivery types
It allows you to add new delivery type just running:
```bash
$ rails g shopping_cart:add_delivery 'Funny express' 5
```
In this example a new delivery type will be added to database with title *Funny express*, which costs $5.00

### Coupon codes
It allows you to add new coupon code just running:
```bash
$ rails g shopping_cart:add_coupon 'i want discount' 20
```
In this example a new coupon will be added to database with code *i want discount*, which gives 20% discount.

## Using in views
### 'Add to cart' form on your product page
Now, when you finished all configurations, you can add a form to your product page. In this case we have a `Product` class and @product variable.
```
<%= form_tag shopping_cart.orders_path, method: :post do %>
  <%= number_field_tag :quantity, 1, min: '1' %>
  <%= hidden_field_tag :productable_id, @product.id %>
  <%= hidden_field_tag :productable_type, @product.class.to_s %>
  <%= submit_tag 'Add to cart' %>
<% end %>
```

### Useful links
* For creating a cart button you can use helper: `shopping_cart.root_path`
* If you want to give customer direct link to checkout, you can use helper: `shopping_cart.checkout_index_path`. If user have no order 'in progress', he will be redirected to empty cart.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
