module PricingHelper
  def cost_per_gigabyte
    format_money(Rails.configuration.cost_per_gigabyte)
  end

  def price_per_gigabyte
    format_money(Rails.configuration.price_per_gigabyte)
  end

  def price(quantity)
    quantity * Rails.configuration.price_per_gigabyte.to_i
  end

  def price_options
    [1, 5, 10, 50, 100].map do |i|
      [[format_money(price(i)), number_to_human_size(i.gigabytes)].join(" / "), price(i)]
    end
  end

  def format_money(amount, currency = Money.default_currency)
    value = Money.new(amount, currency)
    number_to_currency(value.amount, unit: value.symbol)
  end
end
