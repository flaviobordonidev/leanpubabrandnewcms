
## Visualizziamo il telefono su index

DA METTERE SU COMPANY

***code n/a - .../app/views/company_person_maps/_master_company.html.erb - line:n/a***

```html+erb
<p><%= company.address %> | <%= "#{company.telephones.first.name}: #{company.telephones.first.prefix} #{company.telephones.first.number} " if company.telephones.first.present? %> | Email: info@peroni.it</p>
```

inseriamo un nuovo helper

***code n/a - .../app/views/company_person_maps/_master_company.html.erb - line:n/a***

```html+erb
<p><%= company.address %> | <%= h_company_telefones_first(company.telephones) %> | Email: info@peroni.it</p>
```

creiamo il nuovo helper

***code n/a - .../app/helpers/company_person_maps_helper.rb - line:01***

```ruby
module CompanyPersonMapsHelper
  
  def h_company_telefones_first(telephones)
    "#{telephones.first.name}: #{telephones.first.prefix} #{telephones.first.number} " if telephones.first.present?
  end

  def h_company_telefones_all(telephones)
    telephones_all = ""
    telephones.each do |telephone|
     telephones_all = telephones_all + "#{telephone.name}: #{telephone.prefix} #{telephone.number} " if telephone.present?
    end
    return telephones_all
  end
end
```

Volendo visualizzare tutti i numeri archiviati usiamo il metodo `h_company_telefones_all`.

***code n/a - .../app/views/company_person_maps/_master_company.html.erb - line:n/a***

```html+erb
<p><%= company.address %> | <%= h_company_telefones_all(company.telephones) %> | Email: info@peroni.it</p>
```
