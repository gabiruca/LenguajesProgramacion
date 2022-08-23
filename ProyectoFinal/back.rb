require 'open-uri' 
require 'nokogiri' 
require 'csv' 

puts ('Scraping integrante 1 - ')
puts ('-----------------------------------------------------------')













puts " "
puts " "
puts ('Scraping integrante 2 - Gabriela Sosa Casal')
puts ('-----------------------------------------------------------')

#Funciones------

#Pregunta 4
def analisis4(link)
  stats=0
  #Ciudad - área - últimos 7 días
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

#Pregunta 5
def analisis5(link)
  salariosL=Array.new
  contenido = URI.open(link)
  contenidoHTML = Nokogiri::HTML(contenido)
  contenidoHTML.css('article').css('section').css('._3-PWkq').css('.jNebTl').each do |salarios|
    sal= salarios.inner_text
    if(!(sal.include?"por ano"))
      if(!(sal.include?"por hora"))
        if (sal.include?"-")
          salSep=sal.split('-')[0]
          salInt=salSep.split(" ").join("")
          if(salariosL.count()<20)
            salariosL.push(salInt.to_i)
          end
        else
          salSep=sal.slice(0,5)
          if(salSep.include?"U")
            salSep=sal.split(' ')[0]
            if(salariosL.count()<20)
              salariosL.push(salSep.to_i)
            end
          else
            salInt=salSep.split(" ").join("")
            if(salariosL.count()<20)
              salariosL.push(salInt.to_i)
            end
          end
        end
      end
    end
  end
  return salariosL
end

def calcProm(salarios)
  suma=salarios.sum()
  total=salarios.count()
  promedio=suma/total
  return promedio
end

#Ejecuciones de análisis - Gabriela Sosa
#Guayaquil

puts " "


puts " "
puts "---> Pregunta 5"
puts " "
#Developers
linkDev='https://ec.jooble.org/SearchResult?p=2&ukw=developer&withSalary=true'
sDev=analisis5(linkDev)
promDev=calcProm(sDev)
puts "Salario mensual promedio de un desarrollador (remoto): #{promDev}"
#Asistentes de administración
linkAdm='https://ec.jooble.org/SearchResult?ukw=asistente&withSalary=true'
sAdm=analisis5(linkAdm)
promAdm=calcProm(sAdm)
puts "Salario mensual promedio de un asistente de administración: #{promAdm}"
#Contador/Auditor
linkCAud='https://ec.jooble.org/SearchResult?ukw=contador&withSalary=true'
sCAud=analisis5(linkCAud)
promCAud=calcProm(sCAud)
puts "Salario mensual promedio de un contador/auditor: #{promCAud}"
#Vendedores
linkVen='https://ec.jooble.org/SearchResult?ukw=vendedor&withSalary=true'
sVen=analisis5(linkVen)
promVen=calcProm(sVen)
puts "Salario mensual promedio de un vendedor: #{promVen}"
#Técnicos mecánicos
linkMec='https://ec.jooble.org/SearchResult?ukw=t%C3%A9cnico%20mec%C3%A1nico&withSalary=true'
sMec=analisis5(linkMec)
promMec=calcProm(sMec)
puts "Salario mensual promedio de un técnico mecánico: #{promMec}"
#Recepcionistas/atención al cliente
linkAC='https://ec.jooble.org/SearchResult?ukw=recepcionista&withSalary=true'
sAC=analisis5(linkAC)
promAC=calcProm(sAC)
puts "Salario mensual promedio de un recepcionista/personal de atención al cliente: #{promAC}"
