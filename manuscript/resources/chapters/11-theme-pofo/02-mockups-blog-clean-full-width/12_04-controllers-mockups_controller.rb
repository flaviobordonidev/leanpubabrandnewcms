class MockupsController < ApplicationController
  def page_a
    render layout: 'dashboard'
  end

  def page_b
  end
  
  def login
    render layout: 'mockup'
  end
  
  def blog_clean_full_width
    render layout: 'yield'
  end
end
