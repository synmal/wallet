module DashboardHelper
  def transaction_class(type)
    case type
    when 'Credit'
      'text-success'
    when 'Debit'
      'text-success'
    when 'Transfer'
      ''
    end
  end

  def transact_amount(amount, type)
    _amount = number_with_precision(amount, precision: 2)

    case type
    when 'Credit'
      "+ #{_amount}"
    when 'Debit'
      "- #{_amount}"
    when 'Transfer'

    end
  end
end
