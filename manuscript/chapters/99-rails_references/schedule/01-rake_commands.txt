# Rake comands

prima di mettere un timer con cron/whenever o heroku_scheduler dobbiamo preparare il comando da eseguire. Questo comando lo creiamo con rake.




## Esempio di jasonseifer

Seguiamo l'esempio di questo ottimo [tutorial](http://jasonseifer.com/2010/04/06/rake-tutorial)
Scriviamo dei task per il risveglio mattutino nel file lib/tasks/scheduler.rake semplicemente perché questo file è quello utilizzato dallo heroku_scheduler.

{title="../lib/tasks/scheduler.rake", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
task :turn_off_alarm do
  puts "Turned off alarm. Would have liked 5 more minutes, though."
end

task :groom_myself do
  puts "Brushed teeth."
  puts "Showered."
  puts "Shaved."
end

task :make_coffee do
  cups = ENV["COFFEE_CUPS"] || 2
  puts "Made #{cups} cups of coffee. Shakes are gone."
end

task :walk_dog do
  puts "Dog walked."
end

task :ready_for_the_day => [:turn_off_alarm, :groom_myself, :make_coffee, :walk_dog] do
  puts "Ready for the day!"
end
~~~~~~~~

Possiamo già eseguire i comandi rakes.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ cd myrailsapp/
$ rake turn_off_alarm
   Turned off alarm. Would have liked 5 more minutes, though.
$ rake groom_myself
   Brushed teeth.
   Showered.
   Shaved.
$ rake COFFEE_CUPS=5 make_coffee
   Made 5 cups of coffee. Shakes are gone.
$ rake make_coffee COFFEE_CUPS=5
   Made 5 cups of coffee. Shakes are gone.
$ rake walk_dog
   Dog walked.
$ rake ready_for_the_day
   Turned off alarm. Would have liked 5 more minutes, though.
   Brushed teeth.
   Showered.
   Shaved.
   Made 2 cups of coffee. Shakes are gone.
   Dog walked.
   Ready for the day!
$ rake COFFEE_CUPS=5 ready_for_the_day
   Turned off alarm. Would have liked 5 more minutes, though.
   Brushed teeth.
   Showered.
   Shaved.
   Made 5 cups of coffee. Shakes are gone.
   Dog walked.
   Ready for the day!
~~~~~~~~




## Namespaces

Se creiamo un nuovo file minni.rake tutte le funzioni vengono viste come in un unico file. E se eseguiamo un rake di una funzione che ha lo stesso nome in entrambi i files la funzione sarà eseguita due volte.

{title="../lib/tasks/minni.rake", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
task :turn_off_alarm do
  puts "Turned off alarm. Would have liked 15 more minutes, though."
end
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ cd myrailsapp/
$ rake turn_off_alarm
   Turned off alarm. Would have liked 5 more minutes, though.
   Turned off alarm. Would have liked 15 more minutes, though.
~~~~~~~~

Per evitare questo è bene creare dei namespaces

{title="../lib/tasks/minni.rake", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
namespace :morning do
  task :turn_off_alarm do
    puts "Turned off alarm. Would have liked 15 more minutes, though."
  end
end
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ cd myrailsapp/
$ rake turn_off_alarm
   Turned off alarm. Would have liked 5 more minutes, though.
$ rake morning:turn_off_alarm
   Turned off alarm. Would have liked 15 more minutes, though.
~~~~~~~~
