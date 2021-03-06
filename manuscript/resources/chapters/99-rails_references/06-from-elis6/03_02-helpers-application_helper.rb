module ApplicationHelper

  # per l'uso di "optional arguments" ringrazio http://codeloveandboards.com/blog/2014/02/05/ruby-and-method-arguments/
  #
  # :locale
  # :last_front_controller
  # :last_front_action
  # :last_front_id
  # :last_front_related
  # :last_front_page
  # :last_front_search
  # :last_rear_controller
  # :last_rear_action
  # :last_rear_id
  # :last_rear_related
  # :last_rear_page
  # :last_rear_search
  # :related
  # :page
  # :search
  #
  def h_params_path(path: "", locale: params[:locale], last_front_controller: params[:last_front_controller], last_front_action: params[:last_front_action], last_front_id: params[:last_front_id], last_front_related: params[:last_front_related], last_front_page: params[:last_front_page], last_front_search: params[:last_front_search], last_rear_controller: params[:last_rear_controller], last_rear_action: params[:last_rear_action], last_rear_id: params[:last_rear_id], last_rear_related: params[:last_rear_related], last_rear_page: params[:last_rear_page], last_rear_search: params[:last_rear_search], last_rear_rear_controller: params[:controller], last_rear_rear_action: params[:action], last_rear_rear_id: params[:id], last_rear_rear_related: params[:related], last_rear_rear_page: params[:page], last_rear_rear_search: params[:search], related: params[:related], page: 1, search: "", tab_active: "default", change_id: nil, link_name: nil, supplier_id: nil, factory_id: nil)
    path_url = "#{path}?locale=#{locale}&last_front_controller=#{last_front_controller}&last_front_action=#{last_front_action}&last_front_id=#{last_front_id}&last_front_related=#{last_front_related}&last_front_page=#{last_front_page}&last_front_search=#{last_front_search}&last_rear_controller=#{last_rear_controller}&last_rear_action=#{last_rear_action}&last_rear_id=#{last_rear_id}&last_rear_related=#{last_rear_related}&last_rear_page=#{last_rear_page}&last_rear_search=#{last_rear_search}&last_rear_rear_controller=#{last_rear_rear_controller}&last_rear_rear_action=#{last_rear_rear_action}&last_rear_rear_id=#{last_rear_rear_id}&last_rear_rear_related=#{last_rear_rear_related}&last_rear_rear_page=#{last_rear_rear_page}&last_rear_rear_search=#{last_rear_rear_search}&related=#{related}&page=#{page}&search=#{search}&tab_active=#{tab_active}&change_id=#{change_id}&link_name=#{link_name}&supplier_id=#{supplier_id}&factory_id=#{factory_id}"
    return path_url
  end

  def h_front_params_path(path: "", locale: params[:locale], last_front_controller: params[:controller], last_front_action: params[:action], last_front_id: params[:id], last_front_related: params[:related], last_front_page: params[:page], last_front_search: params[:search], last_rear_controller: params[:last_rear_controller], last_rear_action: params[:last_rear_action], last_rear_id: params[:last_rear_id], last_rear_related: params[:last_rear_related], last_rear_page: params[:last_rear_page], last_rear_search: params[:last_rear_search], related: params[:related], page: 1, search: "", tab_active: "default", change_id: nil, link_name: nil, supplier_id: nil, factory_id: nil)
    path_url = "#{path}?locale=#{locale}&last_front_controller=#{last_front_controller}&last_front_action=#{last_front_action}&last_front_id=#{last_front_id}&last_front_related=#{last_front_related}&last_front_page=#{last_front_page}&last_front_search=#{last_front_search}&last_rear_controller=#{last_rear_controller}&last_rear_action=#{last_rear_action}&last_rear_id=#{last_rear_id}&last_rear_related=#{last_rear_related}&last_rear_page=#{last_rear_page}&last_rear_search=#{last_rear_search}&related=#{related}&page=#{page}&search=#{search}&tab_active=#{tab_active}&change_id=#{change_id}&link_name=#{link_name}&supplier_id=#{supplier_id}&factory_id=#{factory_id}"
    return path_url
  end

  def h_rear_params_path(path: "", locale: params[:locale], last_front_controller: params[:last_front_controller], last_front_action: params[:last_front_action], last_front_id: params[:last_front_id], last_front_related: params[:last_front_related], last_front_page: params[:last_front_page], last_front_search: params[:last_front_search], last_rear_controller: params[:controller], last_rear_action: params[:action], last_rear_id: params[:id], last_rear_related: params[:related], last_rear_page: params[:page], last_rear_search: params[:search], related: params[:related], page: 1, search: "", tab_active: "default", change_id: nil, link_name: nil, supplier_id: nil, factory_id: nil)
    path_url = "#{path}?locale=#{locale}&last_front_controller=#{last_front_controller}&last_front_action=#{last_front_action}&last_front_id=#{last_front_id}&last_front_related=#{last_front_related}&last_front_page=#{last_front_page}&last_front_search=#{last_front_search}&last_rear_controller=#{last_rear_controller}&last_rear_action=#{last_rear_action}&last_rear_id=#{last_rear_id}&last_rear_related=#{last_rear_related}&last_rear_page=#{last_rear_page}&last_rear_search=#{last_rear_search}&related=#{related}&page=#{page}&search=#{search}&tab_active=#{tab_active}&change_id=#{change_id}&link_name=#{link_name}&supplier_id=#{supplier_id}&factory_id=#{factory_id}"
    return path_url
  end

  def h_rear_rear_params_path(path: "", locale: params[:locale], last_front_controller: params[:last_front_controller], last_front_action: params[:last_front_action], last_front_id: params[:last_front_id], last_front_related: params[:last_front_related], last_front_page: params[:last_front_page], last_front_search: params[:last_front_search], last_rear_controller: params[:last_rear_controller], last_rear_action: params[:last_rear_action], last_rear_id: params[:last_rear_id], last_rear_related: params[:last_rear_related], last_rear_page: params[:last_rear_page], last_rear_search: params[:last_rear_search], last_rear_rear_controller: params[:controller], last_rear_rear_action: params[:action], last_rear_rear_id: params[:id], last_rear_rear_related: params[:related], last_rear_rear_page: params[:page], last_rear_rear_search: params[:search], related: params[:related], page: 1, search: "", tab_active: "default", from_rear: "yes", change_id: nil, link_name: nil, supplier_id: nil, factory_id: nil)
    path_url = "#{path}?locale=#{locale}&last_front_controller=#{last_front_controller}&last_front_action=#{last_front_action}&last_front_id=#{last_front_id}&last_front_related=#{last_front_related}&last_front_page=#{last_front_page}&last_front_search=#{last_front_search}&last_rear_controller=#{last_rear_controller}&last_rear_action=#{last_rear_action}&last_rear_id=#{last_rear_id}&last_rear_related=#{last_rear_related}&last_rear_page=#{last_rear_page}&last_rear_search=#{last_rear_search}&last_rear_rear_controller=#{last_rear_rear_controller}&last_rear_rear_action=#{last_rear_rear_action}&last_rear_rear_id=#{last_rear_rear_id}&last_rear_rear_related=#{last_rear_rear_related}&last_rear_rear_page=#{last_rear_rear_page}&last_rear_rear_search=#{last_rear_rear_search}&related=#{related}&page=#{page}&search=#{search}&tab_active=#{tab_active}&change_id=#{change_id}&from_rear=#{from_rear}&link_name=#{link_name}&supplier_id=#{supplier_id}&factory_id=#{factory_id}"
    return path_url
  end


  def h_ico_name
    if params[:related].present?
      ico_name = "ico_#{params[:related].singularize}"
    else
      ico_name = "ico_favorite"
    end 
    return ico_name   
  end

  def h_company_status(status)
    status = 6 if status.blank?
    case status
    when 1
      #return t("application.company_status.one")
      return t("h.company_status_one")
    when 2
      return t("h.company_status_two")
    when 3
      return t("h.company_status_three")
    when 4
      return t("h.company_status_four")
    when 5
      return t("h.company_status_five")
    when 6
      return t("h.company_status_six")
    when 7
      return t("h.company_status_seven")
    when 8
      return t("h.company_status_eight")
    else
      raise "NON DOVEVI ARRIVARE QUI. Cosa succede?"
    end
  end

  def h_options_for_status
    [
      [t("h.company_status_one"),1],
      [t("h.company_status_two"),2],
      [t("h.company_status_three"),3],
      [t("h.company_status_four"),4],
      [t("h.company_status_five"),5],
      [t("h.company_status_six"),6],
      [t("h.company_status_seven"),7],
      [t("h.company_status_eight"),8]
    ]
  end

  def h_options_for_rounding
    [
      [t("h.hundredths"),2],
      [t("h.tenths"),1],
      [t("h.ones"),0],
      [t("h.tens"),-1],
      [t("h.hundreds"),-2]
    ]
  end
  
  def h_options_rounding(rounding)
    rounding = 0 if rounding.blank?
    case rounding
    when 2
      return t("h.hundredths")
      #return "centesimi"
    when 1
      return t("h.tenths")
      #return "decimi"
    when 0
      return t("h.ones")
      #return "unità"
    when -1
      return t("h.tens")
      #return "decine"
    when -2
      return t("h.hundreds")
      #return "centinaia"
    else
      raise "NON DOVEVI ARRIVARE QUI. Cosa succede?"
    end
  end
end