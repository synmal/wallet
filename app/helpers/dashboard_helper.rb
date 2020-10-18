module DashboardHelper
  def transaction_detail(trans)
    if /Credit/ === trans.type
      'Deposit'
    elsif /Debit/ === trans.type
      'Withdrawal'
    elsif transfer_in?(trans)
      "Transfer from #{trans.transact_from.name}"
    elsif transfer_out?(trans)
      "Transfer to #{trans.transact_to.name}"
    end
  end

  def track_balance(trans)
    if money_in?(trans) || transfer_in?(trans)
      number_with_precision(trans.transact_to_final, precision: 2)
    elsif money_out?(trans) || transfer_out?(trans)
      number_with_precision(trans.transact_from_final, precision: 2)
    else
      '-'
    end
  end

  def money_in?(trans)
    /Credit/ === trans.type || transfer_in?(trans)
  end

  def money_out?(trans)
    /Debit/ === trans.type || transfer_out?(trans)
  end

  def transfer_out?(trans)
    /Transfer/ === trans.type && trans.transact_from.owner == current_person
  end

  def transfer_in?(trans)
    /Transfer/ === trans.type && trans.transact_to.owner == current_person
  end
end
