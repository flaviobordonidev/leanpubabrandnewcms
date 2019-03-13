# Una selezione di menu a cascata senza utilizzare ENUM

Il campo della tabella "posts" che utilizziamo per il menu a cascata è "select_media" ed è di tipo :integer



## Implementiamo il menu a cascata per modificare il media del post

Nel menu a cascata scegliamo se il nostro articolo (post) ha un'immagine, un video di youtube, un video di vimeo, un audio, ...
Nel campo archiviamo semplicemente un numero ma nel menu a cascata visualizziamo le corrispondenze. Evitiamo |enum| perché non è semplice gestire il multilingua. 
Evitiamo una nuova tabella con relazione uno-a-molti per tenere le cose semplici; tanto l'elenco è fisso e non varia.

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
              <%= form.select :select_media, h_options_for_media, {}, prompt: 'Scegline uno', class: 'form-control' %>
~~~~~~~~

{title=".../app/helpers/application_helper.rb", lang=ruby, line-numbers=on, starting-line-number=70}
~~~~~~~~
  def h_options_for_media
    [
      ["immagine",1],
      ["video youtube",2],
      ["video vimeo",3]
    ]
  end
~~~~~~~~




## Aggiorniamo la view

Impostiamo l'icona corrispondente alla scelta fatta in select_media



mostriamo solo o l'immagine o il video youtube o il video vimeo a seconda della scelta fatta in select_media

{title=".../app/views/posts/_post_single.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=24}
~~~~~~~~
                  <% if post.select_media == 1 %>
                    <li><a href="#"><i class="icon-camera-retro"></i></a></li>
                  <% elsif post.select_media == 2 or post.select_media == 3 %>
                    <li><a href="#"><i class="icon-film"></i></a></li>
                  <% end %>
~~~~~~~~

{title=".../app/views/posts/_post_single.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=31}
~~~~~~~~
                <% if post.select_media == 1 %> <!-- image -->
                  <% if post.image.present? %>
                    <!-- Entry Image
                    ============================================= -->
                    <div class="entry-image">
                      <!-- <a href="#"><img src="images/blog/full/1.jpg" alt="Blog Single"></a> -->
                      <!--<a href="#"><%#= image_tag "blog-full-1.jpg", alt: "Blog Single" %></a>-->
                      <!--<a href="#"><%#= image_tag @post.image_url, alt: "Blog Single" %></a>-->
                      <%= link_to image_path(post.image_url), target: "_blank" do %>
                        <%= image_tag post.image_url, alt: "Blog Single" %>
                      <% end %>
                    </div><!-- .entry-image end -->
                  <% end %>
                <% elsif post.select_media == 2 %> <!-- youtube -->
                  <% if post.video_id.present? %>
                    <!-- Entry Video
                    ============================================= -->
                    <div class="entry-image">
                      <iframe src='https://www.youtube.com/embed/<%= post.video_id %>?rel=0&autoplay=<%= params[:autoplay] || 0 %>' frameborder='0' allowfullscreen></iframe>
                    </div><!-- .entry-image end -->
                  <% end %>
                <% elsif post.select_media == 3 %> <!-- vimeo -->
                  <% if post.video_id.present? %>
                    <!-- Entry Video
                    ============================================= -->
                    <div class="entry-image">
    									<iframe src="https://player.vimeo.com/video/87701971" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
                    </div><!-- .entry-image end -->
                  <% end %>
                <% end %>
~~~~~~~~

verifichiamo 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails s -b $IP -p $PORT
~~~~~~~~





## Attiviamo la multilingua / internazionalizzazione



              <%= form.select :select_media, h_options_for_media, {}, prompt: t("application.company_status.one"), class: 'form-control' %>



{title=".../app/helpers/application_helper.rb", lang=ruby, line-numbers=on, starting-line-number=70}
~~~~~~~~
  def h_options_for_media
    [
      [t("application.company_status.one"),1],
      [t("application.company_status.two"),2],
      [t("application.company_status.three"),3],
      [t("application.company_status.four"),4],
      [t("application.company_status.five"),5],
      [t("application.company_status.six"),6],
      [t("application.company_status.seven"),7],
      [t("application.company_status.eight"),8]
    ]
  end
~~~~~~~~

implementiamo la traduzione in italiano

{title="config/locales/it.yml", lang=yaml, line-numbers=on, starting-line-number=27}
~~~~~~~~
  people:
    show:
      breadcrumbs: "Persona"
      
      'Scegline uno'
~~~~~~~~

implementiamo la traduzione in inglese

{title="config/locales/en.yml", lang=yaml, line-numbers=on, starting-line-number=27}
~~~~~~~~
  people:
    show:
      breadcrumbs: "Person"
      
      'Select One'
~~~~~~~~


aggiorniamo git 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add companies edit"
~~~~~~~~




## Per visualizzarlo

show
~~~~~~~~
      <%= content_tag :p,"#{h_company_status(@company.status)} - #{@company.sector}" %>
~~~~~~~~

helper
~~~~~~~~
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
~~~~~~~~
