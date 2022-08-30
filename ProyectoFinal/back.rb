require 'open-uri' 
require 'nokogiri' 
require 'csv' 

puts ('Scraping integrante 1 - Lizbeth Vergara')
puts ('-----------------------------------------------------------')

# ¿En qué ciudad de ecuador existe mayor oferta de empleo acerca de x (que podría ser ingresado) puesto de trabajo? 
def consultaUno
  pagina = 'https://ec.jooble.org/SearchResult?p=4&ukw=desarrollo%20web'
  datosHTML = URI.open(pagina)
  datosStr = datosHTML.read
  parsed_content = Nokogiri::HTML(datosStr)
  l = []
  ciudades = []
  ciudadesFinal = []
  contadorCiudades = []
  my_hash = {}
  con = 0
  parsed_content.css("//div[@class='infinite-scroll-component uPUK9D _serpContentBlock']").css('div').css('article').each do |datos|
    t = datos.css('section').css('div')[2].css('div').css('div')[4].to_s.split('>')[1].to_s.split('<')[0]
    
    ciudades.push(t.to_s.split(",")[0])
   
  end
  # puts ciudades
  encabezado = ['ciudad','pais']
  CSV.open('analisis1.csv', 'w+', write_headers: true, headers: encabezado) do |csv|
    ciudades.each do |c|  
                csv << [c, ' Ecuador']

    end
  end  
  ciudades.each do |c|
    con = 0
    ciudades.each do |ciu|
      if ciu == c
        con= con + 1
      end
    end
    my_hash[c] = con
    
  end
  return my_hash
end
uno = consultaUno()
puts 'Provincias en ecuador en donde existen trabajos de desarrollo web '
puts uno
puts
puts


# ¿Cuáles son las empresas destacadas que están enlazadas con la plataforma? 

def consultaDos
  pagina = 'https://ec.jooble.org/SearchResult?p=2&ukw=programador%20junior'
  datosHTML = URI.open(pagina)
  datosStr = datosHTML.read
  parsed_content = Nokogiri::HTML(datosStr)
  l = %w[developer programador desarrollador programmer]
  informacion = []
  linkTemporal = ''
  ofertaTemporal = ''
  oferta = ''
  ofertaJunior = ''
  ciudadTemporal = ''
  empresaTemporal = ''
  temp = false
  my_hash = {}

  parsed_content.css("//div[@class='infinite-scroll-component uPUK9D _serpContentBlock']").css('div').css('article').each do |datos|
    t = datos.css('section').css('div')[2].css('div').css('div')[4]
    ciudadTemporal = t.to_s.split('>')[1].to_s.split('<')[0].to_s.split('(')[0]
    empresaTemporal = datos.css('section').css('div')[2].css('div').css('div')[2].to_s.split('>')[2].to_s.split('<')[0]
    # puts datos.css('header').css('div')
    datos.css('header').css('div').each do |busqueda|
      # puts busqueda
      # linkTemporal = busqueda.attr('href')
      
      ofertaTemporal = busqueda.css('span').inner_text
      if ofertaTemporal.downcase[l[0]] || ofertaTemporal.downcase[l[1]] || ofertaTemporal.downcase[l[2]] || ofertaTemporal.downcase[l[3]]
        oferta = ofertaTemporal
        end
      if oferta.downcase['junior']
        ofertaJunior = oferta if oferta.downcase['junior']
        informacion.push(ofertaJunior)
        informacion.push(ciudadTemporal)
        temp = true
      else
        temp = false
      end
      if temp
        my_hash[empresaTemporal] = informacion
        informacion = []
      else
        informacion = []
      end
    end
  end
  my_hash
end
dos = consultaDos

puts 
puts 'Empresas que necesiten programadores Junior:  '
puts dos
puts
puts

# ¿Qué empresas tienen ofertas de trabajos remotos? 
def consultaTres
  pagina = 'https://ec.jooble.org/SearchResult?loc=2&ukw=desarrollo%20web'
  datosHTML = URI.open(pagina)
  datosStr = datosHTML.read
  parsed_content = Nokogiri::HTML(datosStr)
  link = ''
  empresa = ''
  tiempo = ''
  my_hash = {}
  parsed_content.css("//div[@class='infinite-scroll-component uPUK9D _serpContentBlock']").css('div').css('article').each do |datos|
    link = datos.css('header').css('h2').css('div').css('a').attr('href').inner_text
    empresa = datos.css('section').css('div')[4].css('p').inner_text
    tiempo = datos.css('section').css('div')[4].css('div').css('div')[5].css('div').inner_text
    my_hash[empresa] = [link, tiempo]
  end
  my_hash
end
tres = consultaTres
puts  
puts 'Empresas que ofrecen trabajos remotos en desarrollo web y hace cuando fue publicado: '
puts tres
puts
puts


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

#Pregunta 6 - Gabriela Sosa
def analisis6(link)
  trabajos=Array.new
  medioT=0
  tiempoC=0
  practicas=0
  contenido = URI.open(link)
  contenidoHTML = Nokogiri::HTML(contenido)
  contenidoHTML.css('.job_seen_beacon').css('.attribute_snippet').each do |tiempos|
    tiempo=tiempos.inner_text
    if(tiempo=='Tiempo completo')
      tiempoC+=1
    end
    if(tiempo=='Medio tiempo')
      medioT+=1
    end
    if(tiempo=='Prácticas')
      practicas+=1
    end
  end
  trabajos.push(tiempoC)
  trabajos.push(practicas)
  trabajos.push(medioT)
  return trabajos
end
#Aquí reutilizamos el código anterior, la función comprobarMasPags
#Tomamos en cuenta los 5 primeros li de paginations
def sumarArrs(arrTodos)
  comp=0
  medio=0
  pract=0
  arrRet=Array.new
  arrTodos.each do |arr|
    comp+=arr[0]
    medio+=arr[1]
    pract+=arr[2]
  end
  arrRet.push(comp)
  arrRet.push(medio)
  arrRet.push(pract)
  return arrRet
end

def porcentaje(vCalc,vTotal)
  mult=vCalc*100
  div=mult/vTotal
  return div.round(2)
end
#Ejecuciones de análisis - Gabriela Sosa
puts "---> Pregunta 4 - Ofertas de trabajo en la última semana en Quito y Guayaquil, separadas por áreas"
puts " "
puts "**** Guayaquil ****"
#Guayaquil
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
#Developers
linkDev='https://ec.jooble.org/SearchResult?p=2&ukw=developer&withSalary=true'
sDev=analisis5(linkDev)
promDev=calcProm(sDev)
puts "Salario mensual promedio de un desarrollador (remoto): $#{promDev}"
#Asistentes de administración
linkAdm='https://ec.jooble.org/SearchResult?ukw=asistente&withSalary=true'
sAdm=analisis5(linkAdm)
promAdm=calcProm(sAdm)
puts "Salario mensual promedio de un asistente de administración: $#{promAdm}"
#Contador/Auditor
linkCAud='https://ec.jooble.org/SearchResult?ukw=contador&withSalary=true'
sCAud=analisis5(linkCAud)
promCAud=calcProm(sCAud)
puts "Salario mensual promedio de un contador/auditor: $#{promCAud}"
#Vendedores
linkVen='https://ec.jooble.org/SearchResult?ukw=vendedor&withSalary=true'
sVen=analisis5(linkVen)
promVen=calcProm(sVen)
puts "Salario mensual promedio de un vendedor: $#{promVen}"
#Técnicos mecánicos
linkMec='https://ec.jooble.org/SearchResult?ukw=t%C3%A9cnico%20mec%C3%A1nico&withSalary=true'
sMec=analisis5(linkMec)
promMec=calcProm(sMec)
puts "Salario mensual promedio de un técnico mecánico: $#{promMec}"
#Recepcionistas/atención al cliente
linkAC='https://ec.jooble.org/SearchResult?ukw=recepcionista&withSalary=true'
sAC=analisis5(linkAC)
promAC=calcProm(sAC)
puts "Salario mensual promedio de un recepcionista/personal de atención al cliente: $#{promAC}"

puts "   "
puts "---> Pregunta 6"
puts " "
linkTTrab='https://ec.indeed.com/jobs?q=inform%C3%A1tica&l=Guayaquil%2C%20Provincia%20del%20Guayas&sort=date&vjk=9ba3212fbfed1452'
arrTT=analisis6(linkTTrab)
arrTodos=Array.new
arrTodos.push(arrTT)
arrLinks=comprobarMasPags(linkTTrab)
arrLinks.each do |link|
  arrTodos.push(analisis6(link))
end
arrSumas=sumarArrs(arrTodos)
completo=arrSumas[0]
medio=arrSumas[1]
practicas=arrSumas[2]
total=completo+medio+practicas

puts "Ofertas de empleo Computación/Informática en Guayaquil"
puts "Tiempo completo: #{completo}"
puts "Medio tiempo: #{medio}"
puts "Prácticas: #{practicas}"


porcComp=porcentaje(completo.to_f,total.to_f)
porcMedio=porcentaje(medio.to_f,total.to_f)
porcPrac=porcentaje(practicas.to_f,total.to_f)
puts " "
puts "Representación en porcentajes"
puts "Tiempo completo: #{porcComp}%"
puts "Medio tiempo: #{porcMedio}%"
puts "Prácticas: #{porcPrac}%"