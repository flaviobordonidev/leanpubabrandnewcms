# Helper h_client_supplier

Evidenziamo se l'azienda è un cliente, un fornitore o entrambi.
Ci basiamo sul campo "rate" che sarà poi sostituito dalle stelline da 1 a 5 (incluse le mezze stelline).

* [railscasts sulle 5 stelline](http://railscasts.com/episodes/101-refactoring-out-helper-object?autoplay=true)
  http://railscasts.com/episodes/101-refactoring-out-helper-object?view=comments
* [21 CSS Star Ratings](https://freefrontend.com/css-star-ratings/)

---
  
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
  
---