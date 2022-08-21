require 'open-uri' 
require 'nokogiri' 
require 'csv' 

puts ('-----------------------------------------------------------')
puts ('Scraping integrante 1 - ')
puts ('-----------------------------------------------------------')













puts ('-----------------------------------------------------------')
puts ('Scraping integrante 2 - Gabriela Sosa Casal')
puts ('-----------------------------------------------------------')
link = 'https://ec.indeed.com/jobs?q&l=Guayaquil%2C%20Provincia%20del%20Guayas&from=searchOnHP&vjk=55362b489264712d'
contenido = URI.open(link)
contenidoHTML = Nokogiri::HTML(contenido)
contenidoHTML.css('.jobTitle').css('span').each do |spans|
  puts spans.inner_text
end