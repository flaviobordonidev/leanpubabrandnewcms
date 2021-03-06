# Splittiamo il format_html su più linee di codice

Come in tutti i blocchi che sono scritti su una riga con "{}"
per portarli su più righe basta usare "do ... end"




## esempio 1

da 

---
  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        #format.html { redirect_to company_path(@company, {:previous=>{"orologio"=>"gialle", "controller"=>"companies"}}), notice: 'Company was successfully updated.' }
        format.html { redirect_to company_path(@company, params_from_submit), notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end
---

a 

---
  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        #format.html { redirect_to company_path(@company, {:previous=>{"orologio"=>"gialle", "controller"=>"companies"}}), notice: 'Company was successfully updated.' }
        format.html do
          redirect_to company_path(@company, params_from_submit), notice: 'Company was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end
---


## esempio 2

---
  # PATCH/PUT /company_person_maps/1
  # PATCH/PUT /company_person_maps/1.json
  def update
    respond_to do |format|
      if @company_person_map.update(company_person_map_params)
        format.html do
          if params[:last_front_controller] == "companies"
            #"seleziona la persona da associare come preferita dell'azienda"
            manage_person_favorite_of_company # private action
          elsif params[:last_front_controller] == "people"
            #"seleziona l'azienda da associare come preferita della persona"
            manage_company_favorite_of_person # private action
          else
            raise "ERROR"
          end
          redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Company person map was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @company_person_map }
      else
        format.html { render :edit }
        format.json { render json: @company_person_map.errors, status: :unprocessable_entity }
      end
    end
  end
---
