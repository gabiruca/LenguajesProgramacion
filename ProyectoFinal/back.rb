require 'open-uri' 
require 'nokogiri' 
require 'csv' 

puts ('Scraping integrante 1 - ')
puts ('-----------------------------------------------------------')













puts " "
puts " "
puts ('Scraping integrante 2 - Gabriela Sosa Casal')
puts ('-----------------------------------------------------------')

#Funciones
def analisis4(link)
  stats=0
  #Ciudad - área - últimos 30 días
  contenido = URI.open(link)
  contenidoHTML = Nokogiri::HTML(contenido)
  contenidoHTML.css('.mosaic').css('.cardOutline').each do |cardsT|
    stats+=1
  end
  return stats
end

#Tomamos en cuenta los 5 primeros li de paginations
def comprobarMasPags(link)
  lim=0
  listaLinks=Array.new
  linkN=''
  prefijo='https://ec.indeed.com'
  contenido = URI.open(link)
  contenidoHTML = Nokogiri::HTML(contenido)
  contenidoHTML.css('.pagination').css('li').css('a').each do |numPags|
    if(lim<4)
      linkN= prefijo+(numPags.attr('href'))
      if(!(listaLinks.include?linkN))
        listaLinks.push(linkN)
      end
      lim+=1
    end
  end
  return listaLinks
end






#Ejecuciones de análisis
#Guayaquil
puts "---> Pregunta 4 - Ofertas de trabajo en la última semana en Quito y Guayaquil, separadas por áreas"
puts " "
puts "**** Guayaquil ****"
#informática
linkGI = 'https://ec.indeed.com/jobs?q=Inform%C3%A1tica&l=Guayaquil%2C%20Provincia%20del%20Guayas&fromage=7&sort=date&vjk=5ff8ab25c8ffe451'
resultadoGI=analisis4(linkGI)
lista=comprobarMasPags(linkGI)
lista.each do |link|
  resultadoGI=resultadoGI+analisis4(link)
end
puts "Trabajos en el área informática: #{resultadoGI}"
#Administración
linkGA = 'https://ec.indeed.com/jobs?q=Administraci%C3%B3n&l=Guayaquil%2C%20Provincia%20del%20Guayas&fromage=7&sort=date&vjk=5ff8ab25c8ffe451'
resultadoGA=analisis4(linkGA)
lista=comprobarMasPags(linkGA)
lista.each do |link|
  resultadoGA=resultadoGA+analisis4(link)
end
puts "Trabajos en el área administración: #{resultadoGA}"
#Logística
linkGL = 'https://ec.indeed.com/jobs?q=Log%C3%ADstica&l=Guayaquil%2C%20Provincia%20del%20Guayas&fromage=7&sort=date&vjk=db75c0b93aeaf95b'
resultadoGL=analisis4(linkGL)
lista=comprobarMasPags(linkGL)
lista.each do |link|
  resultadoGL=resultadoGL+analisis4(link)
end
puts "Trabajos en el área logística: #{resultadoGL}"
#Ventas
linkGV = 'https://ec.indeed.com/jobs?q=Ventas&l=Guayaquil%2C%20Provincia%20del%20Guayas&fromage=7&sort=date&vjk=89080d922da65138'
resultadoGV=analisis4(linkGV)
lista=comprobarMasPags(linkGV)
lista.each do |link|
  resultadoGV=resultadoGV+analisis4(link)
end
puts "Trabajos en el área ventas: #{resultadoGV}"
#Turismo
linkGT = 'https://ec.indeed.com/jobs?q=Turismo&l=Quito%2C%20Provincia%20de%20Pichincha&fromage=7&sort=date&vjk=45cbfa16e42ad7f1'
resultadoGT=analisis4(linkGT)
lista=comprobarMasPags(linkGT)
lista.each do |link|
  resultadoGT=resultadoGT+analisis4(link)
end
puts "Trabajos en el área turismo: #{resultadoGT}"
#Salud
linkGS = 'https://ec.indeed.com/jobs?q=salud&l=Guayaquil%2C%20Provincia%20del%20Guayas&fromage=7&sort=date&vjk=150b4944182c0cd3'
resultadoGS=analisis4(linkGS)
lista=comprobarMasPags(linkGS)
lista.each do |link|
  resultadoGS=resultadoGS+analisis4(link)
end
puts "Trabajos en el área salud: #{resultadoGS}"

puts " "
#Quito
puts "**** Quito ****"
#informática
linkQI = 'https://ec.indeed.com/jobs?q=Inform%C3%A1tica&l=Quito%2C%20Provincia%20de%20Pichincha&sort=date&fromage=7&vjk=1c4c82188f51d018'
resultadoQI=analisis4(linkQI)
lista=comprobarMasPags(linkQI)
lista.each do |link|
  resultadoQI=resultadoQI+analisis4(link)
end
puts "Trabajos en el área informática: #{resultadoQI}"
#Administración
linkQA = 'https://ec.indeed.com/jobs?q=Administraci%C3%B3n&l=Quito%2C%20Provincia%20de%20Pichincha&sort=date&fromage=7&vjk=443bf0a66fb952d6'
resultadoQA=analisis4(linkQA)
lista=comprobarMasPags(linkQA)
lista.each do |link|
  resultadoQA=resultadoQA+analisis4(link)
end
puts "Trabajos en el área administración: #{resultadoQA}"
#Logística
linkQL = 'https://ec.indeed.com/jobs?q=Log%C3%ADstica&l=Quito%2C%20Provincia%20de%20Pichincha&fromage=7&sort=date&vjk=1d539d05f50c86bb'
resultadoQL=analisis4(linkQL)
lista=comprobarMasPags(linkQL)
lista.each do |link|
  resultadoQL=resultadoQL+analisis4(link)
end
puts "Trabajos en el área logística: #{resultadoQL}"
#Ventas
linkQV = 'https://ec.indeed.com/jobs?q=Ventas&l=Quito%2C%20Provincia%20de%20Pichincha&fromage=7&sort=date&vjk=443bf0a66fb952d6'
resultadoQV=analisis4(linkQV)
lista=comprobarMasPags(linkQV)
lista.each do |link|
  resultadoQV=resultadoQV+analisis4(link)
end
puts "Trabajos en el área ventas: #{resultadoQV}"
#Turismo
linkQT = 'https://ec.indeed.com/jobs?q=Turismo&l=Quito%2C%20Provincia%20de%20Pichincha&fromage=7&sort=date&vjk=45cbfa16e42ad7f1'
resultadoQT=analisis4(linkQT)
lista=comprobarMasPags(linkQT)
lista.each do |link|
  resultadoQT=resultadoQT+analisis4(link)
end
puts "Trabajos en el área turismo: #{resultadoQT}"
#Salud
linkQS = 'https://ec.indeed.com/jobs?q=salud&l=Quito%2C%20Provincia%20de%20Pichincha&fromage=7&sort=date&vjk=37eeccfaf4d6664f'
resultadoQS=analisis4(linkQS)
lista=comprobarMasPags(linkQS)
lista.each do |link|
  resultadoQS=resultadoQS+analisis4(link)
end
puts "Trabajos en el área salud: #{resultadoQS}"

puts " "

puts " "
puts "---> Pregunta 5"
puts " "