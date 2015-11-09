json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :name, :category_id, :amount
  json.amount number_to_currency(transaction.amount, :precision => 2)
  json.url transaction_url(transaction, format: :json)
end
