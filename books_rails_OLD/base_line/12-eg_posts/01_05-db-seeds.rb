# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Inseriamo sei articoli per tre utenti"

#u1 = User.find(1)
u1 = User.first
u1.eg_posts.create(headline: "Il mio primo articolo", incipit: "Perché scrivere questo articolo")
u1.eg_posts.create(headline: "Il mio secondo articolo", incipit: "Ci ho preso gusto")
u1.eg_posts.create(headline: "Il mio terzo articolo", incipit: "Adesso sono esperto")

#u2 = User.find(2)
u2 = User.second
u2.eg_posts.create(headline: "La conferenza uno", incipit: "Una interessante conferenza sul cielo")
u2.eg_posts.create(headline: "La conferenza due", incipit: "Perché si formano le nuvole? Capiamo il ciclo dell'acqua")
u2.eg_posts.create(headline: "La conferenza tre", incipit: "Il sole è una stella nana")


#u3 = User.find(3)
u3 = User.third
u3.eg_posts.create(headline: "Studio di caso alfa", incipit: "In questo studio la nostra azienda è stata brava")
u3.eg_posts.create(headline: "Studio di caso beta", incipit: "In questo studio identifichiamo i pesci nell'acquario")
u3.eg_posts.create(headline: "Studio di caso gamma", incipit: "Questo studio è praticamente identico a quello dell'architetto")

3.times do |i|
  u1.eg_posts.create headline: "articolo di #{u1.email} - articolo numero #{i}"
  u2.eg_posts.create headline: "articolo di #{u2.email} - articolo numero #{i}"
  u3.eg_posts.create headline: "articolo di #{u3.email} - articolo numero #{i}"
end
