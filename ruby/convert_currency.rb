def convert_currency(amount, source_currency, target_currency, conversion_rates)
  if source_currency.to_sym == target_currency.to_sym
    amount
  elsif source_currency.to_sym == :usd
    amount * conversion_rates[target_currency.to_sym]
  elsif target_currency.to_sym == :usd
    amount / conversion_rates[source_currency.to_sym]
  else
    amount * conversion_rates[target_currency.to_sym] / conversion_rates[source_currency.to_sym]
  end
end

conversion_rates = {
  usd: 1.0,
  jpy: 110.0,
  eur: 0.8
}

puts convert_currency(100, :usd, :jpy, conversion_rates)
