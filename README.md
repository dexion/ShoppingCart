[![Code Climate](https://codeclimate.com/github/kirill-oleynik/ShoppingCart/badges/gpa.svg)](https://codeclimate.com/github/kirill-oleynik/ShoppingCart)
[![Build Status](https://travis-ci.org/kirill-oleynik/ShoppingCart.svg?branch=development)](https://travis-ci.org/kirill-oleynik/ShoppingCart)

# ShoppingCart

ShoppingCart plugin provides checkout functionality, which can be integrated into your online store and configured according to your business logic.

 1. [Description](#description)
  - [Cart](#cart)
  - [Checkout](#checkout)
  - [Orders](#orders)
  - [Requirements](#requirements)
 2. [Installation & Configuration](#installation-and-configuration)
  - [Basic setup](#basic-setup)
  - [Filling the database](#filling-the-database)
  - [Integration into the templates](#integration-into-the-templates)
 3. [Creating custom steps](#creating-custom-steps)
  - [Define your step](#define-step-name)
  - [Create model and configure associations](#create-model-and-configure-associations)
  - [Prepare data for views](#prepare-data-for-views) (optional)
  - [Create templates](#create-templates)
  - [Create a handler](#create-a-handler)

---

## Description

### Cart

The plugin provides a cart, in which logged in users can add any number and any types of products. Cart provides an opportunity to:

 - change the amount of products
 - remove products from the order
 - apply a discount code
 - empty cart

### Checkout

By default checkout consists of 5 steps.

 1. `:address` – specify billing & shipping
 2. `:delivery` – choose delivery method
 3. `:payment` – add credit card
 4. `:confirm` – view all previous information and confirm it
 5. `:complete` – success message and final order information

`[:address, :delivery, :payment]` – are not required, so you can disable one/all of them, can change their order. You also can [specify your own steps](#add-custom-steps).

`[:confirm, :complete]` – are required and can not be removed.

### Orders

Orders can have 5 predefined states. You can use aasm-transactions (listed in third column) to change order state in your code.

| State          | Description                                 | Method |
| -------------- | ------------------------------------------- | ----- |
| `:in_progress` | Created by customer but not confirmed yet (**default state**)  | *–* |
| `:processing`  | Confirmed by customer and accepted in processing. You'll got this state after customer completed checkout.  | `:completed` |
| `:in_delivery` | Sent to customer                            | `:sent_to_client` |
| `:delivered`   | Delivered to the customer (**final state**) | `:delivered` |
| `:canceled`    | Canceled by the manager (**final state**)   | `:canceled` |

For now you can not change these states. Wait for this feature in future versions.

### Requirements

* **User model** –  must be configurated with [devise](https://github.com/plataformatec/devise).
* **Product models** – must have `title` and `price` colums.
* **Database** – [PostgreSQL](https://www.postgresql.org)

---

## Installation and Configuration

### Basic setup

Add this line to your application's Gemfile and run the bundle command to install it.

```ruby
gem 'shopping_cart'
```

Run the built-in generator with the command:

```bash
$ rails g shopping_cart:install
```

This will do all the necessary actions for you. At runtime, you will be asked the following questions:

 1. ```User model (leave blank for 'User'):``` – It's a *Customer* model in your main application. **Note:** If you type nothing, plugin will try to interact 'User'-model.

 2. ```Checkout steps (leave blank for confirmation only):``` – Presence and order of checkout steps. Specify your own or listed above. **Note:** If you type nothing, you'll got only ```:confirm``` and ```:complete``` steps, which will be created automatically anyway.

 3. ```Cart path (leave blank for '/cart'):``` – Route in main application, where shopping cart will be available. **Note:** If you type nothing shopping cart will be available on '/cart' path.

 4. ```Do you want to run ShoppingCart migrations now?```– Runs all just copied plugin migrations. **Note:** If you prefere to do this later, you can run ```$ bin/rails db:migrate SCOPE=shopping_cart``` any time.

### Filling the database

You can add any data as usual in console. However plugin provides some useful generators to save your time.

**Delivery types**

```bash
$ rails g shopping_cart:add_delivery 'Funny express' 5
```

In this example a new delivery type will be added to database with title *Funny express* and price $5.00

**Coupon codes**

```bash
$ rails g shopping_cart:add_coupon 'i want discount' 20
```

In this example a new coupon will be added to database with code *i want discount*, which gives 20% discount.

### Integration into the templates

**"Add to cart" form on product page**

Just create a usual form tag with `shopping_cart.orders_path` and `method: :post`. You must send the following:

 - `:quantity` of product
 - `:productable_id` – an id of your product
 - `:predictable_type` – your product's *Class* name

Here is an example:

```
<%= form_tag shopping_cart.orders_path, method: :post do %>
  <%= number_field_tag :quantity, 1, min: '1' %>
  <%= hidden_field_tag :productable_id, @product.id %>
  <%= hidden_field_tag :productable_type, @product.class.to_s %>
  <%= submit_tag 'Add to cart' %>
<% end %>
```

**"Cart" button**

Path for your link: `shopping_cart.root_path`

**"Checkout" button**

Path for your link: `shopping_cart.checkout_index_path`. If user have no order with state `:in_progress`, he will be redirected to empty cart.

---

## Creating custom steps

Under the hood `ShoppingCart` manipulates [Rectify's](https://github.com/andypike/rectify) *Commands* and *Query Objects* inside [Wicked](https://github.com/schneems/wicked)-based controller structure. It means that you do not need to create new controller for your step. Here is what you have to do:

 1. [Define your step](#define-your-step)
 2. [Create model and configure associations](#create-model-and-configure-associations)
 3. [Prepare data for templates](#prepare-data-for-templates) (optional)
 4. [Create templates](#create-templates)
 5. [Create a handler](#create-a-handler)

Lets imagine that we have different packing options in our store. So our custom step will be called `:packing`.

> **Note:** there are conventions about step name all over the plugin, so be careful with giving names to models, templates and so on...

### Define your step

There are two ways to do it:

 - Specify step name during the `shopping_cart:install` runtime ([see above](#basic-setup))
 - Manualy configure `ShoppingCart.checkout_steps` array in `config/initializers/shopping_cart.rb` file.

> **Note:** you'll need to restart application after changing initializer.

### Create model and configure associations

**Create your model**

According to our example with *packing options*, we need a model with *title* and *price*. Let's do it.

    rails g model Packing title price:float

> **Note:**
> ShoppingCart is smart enough. It will try to find a `price` in your model. And if it succeeds, then that value **will be added to the order total.** Therefore, if you do not want this, come up with another name. On the other hand, if the price should be further processed, create a `price` method, which will return the desired value.

**Add relation to Order model**

You've got an awesome generator for this task. Just run

    rails g shopping_cart:add_order_relation belongs_to packing

and that will add `belongs_to` association to `ShoppingCart::Order`, create appropriate migrations and run them.  If you need another relation type feel free to specify it here.

### Prepare data for templates

**Create a query object**

`ShoppingCart` uses [Rectify's Query Objects](https://github.com/andypike/rectify#query-objects) to prepare data for checkout steps. It will try to create new `StepNameForCheckout` and `:call` it automatically. The answer will be saved to `@checkout_data` variable, which will be available in templates.

> **Note:** If query object does not exist you'll get `false` inside `@checkout_data`. So if you don't need anything for your custom step, just do nothing.

According to our example we need to create a `PackingForCheckout` class:

```ruby
module ShoppingCart
  class PackingForCheckout < Rectify::Query
    def query
      Packing.all
    end
  end
end
```

**Additional arguments**

This query object will be created with current `@order` as an argument. So you can define initializer and catch it if you need.

**File location**

You can place this file anywhere in you 'app' folder, inside of `shopping_cart` namespace. However recommended path is: `app/queries/shopping_cart/packing_for_checkout.rb`.

### Create templates

You'll need templates for two 'spots':

 - Step page
 - Confirmation/Completed pages.

> **Note:** In examples below we'll use [Bootstrap](http://getbootstrap.com) and [Haml](http://haml.info).

**Step page**

It's important to remember that at that point you are inside a form for current order. And default plugin's templates build with [Bootstrap](http://getbootstrap.com). So two things are required:

 1. Place all your code inside
`= render 'shopping_cart/checkout/checkout_form' do |f|`
 2. Width of this template must be 8 bootstrap columns (because of 'order summary' sidebar nearby).

Also you have access to:

 - `@order` with current order
 - `@checkout_data` with the result of [calling query object](#prepare-data-for-views)
 - form helper `f`

In our example we are gonna to list all available packing options. Also we want to mark an option, which is already associated with current order.

```ruby
= render 'shopping_cart/checkout/checkout_form' do |f|
  .col-md-8
    .well
      %h3 Packing options
      %ul.list-group
        - @checkout_data.all.each_with_index do |packing, i|
          %li.fields.form-group.list-group-item
            = f.radio_button :packing_id, packing.id,
                checked: (packing.title == @order.try(:packing).try(:title))
            = f.label :packing_id,
                "#{packing.title} +#{number_to_currency packing.price}"
```

This file must be named by step name and placed into `shopping_cart` namespace. In our case the path will be:
`app/views/shopping_cart/checkout/packing.html.haml`.

**Confirmation & Completed pages**

Both `:confirm` and `:complete` steps contain information the user has previously selected. So, you need to specify how your information should appear.  It will be the same for both pages.

It's required to place all code here inside `div` with id named by your step. You can use a helper method `edit_step_link` with name of your step as an argument if you want to allow user go back to your step. And of course, `@order` variable is available here.

Here goes our example:

```ruby
#packing_block
  %h4
    Packing opitons
    %small= edit_step_link :packing
  %p
    = @order.packing.title
    = number_to_currency @order.packing.price
```

The name of this file has the same requirements as in previous case, except that it must have a `_confirmation_` prefix. So in our case it will be:
`app/views/shopping_cart/checkout/_confirmation_packing.html.haml`.

**Completely custom templates**

As you can see in example above, you are using the existing plugin templates. They are incredibly beautiful, but can not quite perfect balance with the design of your application. If you want to replace them, just create a new templates and save them in the main application according to the structure below.

```
└─ views
    ├─ shopping_cart
    │   └─ checkout
    │       ├─ packing.html.haml
    │       ├─ payment.html.haml
    │       ├─ confirm.html.haml
    │       ├─ complete.html.haml
    │       └─ ...
    └─ layouts
       └─ shopping_cart
           ├─ checkout.html.haml
           └─ ...
```

Keep in mind that for each checkout step you need a template with the exact same name.

### Create a handler
Each step's brains are encapsulated in a separate [Rectify's Command](https://github.com/andypike/rectify#commands). `ShoppingCart` will try to send a `:call` to a command named `StepNameCheckoutStep` with `@order` and `params` as an arguments.

So, let's define our command:

```ruby
module ShoppingCart
  class PackingCheckoutStep < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @order.update_attributes packing_params
    end

    private

    def packing_params
      @params.require(:order).permit(:packing_id)
    end
  end
end
```
Feel free to add any additional logic and validations here.

You can place this file anywhere in you 'app' folder, inside of `shopping_cart` namespace. However recommended path is: `app/commands/shopping_cart/packing_checkout_step.rb`.

---

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
