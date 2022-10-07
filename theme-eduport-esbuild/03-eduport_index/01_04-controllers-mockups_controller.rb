class MockupsController < ApplicationController
  def page_a
  end

  def edu_index
    render layout: "edu_demo"
  end
end
