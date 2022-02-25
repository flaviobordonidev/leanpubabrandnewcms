module CompaniesHelper
  
  def h_client_supplier(client_rate, supplier_rate)
    #raise "client_rate: #{client_rate}"
    client_rate = 0 unless client_rate.present?
    supplier_rate = 0 unless supplier_rate.present?
    client = 0
    supplier = 0
    client = 1 if client_rate != 0
    supplier = 2 if supplier_rate != 0

    case client.to_i + supplier.to_i
    when 0
      return ""
    when 1
      return "(cliente)"
    when 2
      return "(fornitore)"
    when 3
      return "(cliente e fornitore)"
    end

    return "errore"
  end
  
end
