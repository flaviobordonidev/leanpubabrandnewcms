# CompanyPersonMaps nested new

Questa parte è stata poi risolta in una maniera più semplice e più elegante chiamando direttamente people/new.

Ma tra i vari tentativi avevo pensato di mettere su company_person_maps/new un link che mi chiamava l'azione company_person_maps_controllers -> new_person
su questa azione facevo creare una nuova persona e poi aprivo la wiew company_person_maps/new/new_person. (mi rendo conto che non fa molto senso ma erano delle prove)
La cosa interessante che voglio evidenziare è il codice su config/routes

---
  resources :company_person_maps
  #2.10.3 Adding Routes for Additional New Actions
  resources :company_person_maps do
    get 'new_person', on: :new
  end
  # This will enable Rails to recognize paths such as /company_person_maps/new/new_person with GET, 
  # and route to the new_person action of CompanyPersonMapsController. 
  # It will also create the new_person_new_company_person_map_url and new_person_new_company_person_map_path route helpers.
---

il get 'new_person' lo mettiamo dentro l'azione "new" annidato in "company_person_maps"
quindi con l'helper "new_person_new_company_person_map_path"




Nel controller ho scritto (il codice ha poco senso ma didatticamente è interessante)
creo una nuova persona 
con "raise" vedo i parametri passati sull'url
faccio un redirect ad una nuova associazione persona+azienda "new_company_person_map_path"

LO DEVO PULIRE E FARE UN ESEMPIO CHE ABBIA PIU' SENSO :(

---
  def new_person
    # se dall'elenco delle persone non ne trovo una già presente da associare ma la devo creare ex novo
    Person.new(title: "Nuova persona", first_name: "", last_name: "", locale: :it).save
    Person.last.update(title: "New person", locale: :en)
    raise "merda - company_id: #{params[:company_id]}, nested_id: #{Person.last.id}"
    format.html { redirect_to new_company_person_map_path(company_id: params[:company_id], nested_id: person.id), notice: 'Nuova persona creata.' }
    #@company_person_map.person_id = Person.last.id
    #@company_person_map.company_id = params[:last_front_id]
  end
---



Senza il redirect mi si apre 

wiews/company_person_maps/new/new_person
