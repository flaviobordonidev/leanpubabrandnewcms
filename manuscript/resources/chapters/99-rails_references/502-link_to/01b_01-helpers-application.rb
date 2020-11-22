module ApplicationHelper
  include Pagy::Frontend

  def h_prev_params()
    #passiamo subito tutto un hash di 2 coppie key: "value"
    #prev_params = {cane: "zoppo", cabra: "campa"}

    #creiamo l'hash in più passaggi
    #prev_params = {}
    #prev_params[:cane] = "zoppo"
    #prev_params[:cabra] = "camba"

    # hash = {:item1 => 1}
    #Add a new item to it:
    # hash[:item2] = 2

    #creiamo l'hash in più passaggi usando .merge
    # prev_params = {}
    # prev_params = prev_params.merge(cane: "zoppo")
    # prev_params = prev_params.merge(cabra: "camba")

    prev_params = {}
    params.each do |key,value|
      prev_params = prev_params.merge("prev_"+key => value)
    end
    return prev_params
    # esempio di uso su companies/index -- <%= link_to companies_path(h_prev_params) ...
  end
end
