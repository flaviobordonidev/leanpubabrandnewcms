class MockupsController < ApplicationController
  def page_a
  end

  def page_b
  end

  def page_c
  end

  def login
    render layout: 'mockup'
  end

end
