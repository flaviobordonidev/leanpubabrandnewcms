class MockupsController < ApplicationController
  def page_a
  end

  def page_b
  end

  def bs_grid
    render layout: 'bs_demo'
  end

  def edu_index_4
    render layout: 'edu_demo'
  end
end
