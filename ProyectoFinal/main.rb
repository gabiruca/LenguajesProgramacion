require 'open-uri' # consultar a la plataforma o sitio web
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv

puts ('Ofertas de trabajo en ec.indeed.com en el área de Guayaquil')
puts ('-----------------------------------------------------------')
link = 'https://ec.indeed.com/jobs?q&l=Guayaquil%2C%20Provincia%20del%20Guayas&from=searchOnHP&vjk=55362b489264712d'
contenido = URI.open(link)
contenidoHTML = Nokogiri::HTML(contenido)
contenidoHTML.css('.jobTitle').css('span').each do |spans|
  puts spans.inner_text
end