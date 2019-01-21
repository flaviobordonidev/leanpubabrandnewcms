class ExampleStaticPagesController < ApplicationController
  def page_a
  end

  def page_b
  end

  def slider
    #applica un layout differente
    render layout: 'yield'
  end
end
