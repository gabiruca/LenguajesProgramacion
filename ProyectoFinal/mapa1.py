from cgitb import text
import os 
import json
from pydoc import render_doc 
import requests
import folium
import webbrowser 
import folium.plugins as plugins
import geopy
from geopy.geocoders import Nominatim

import pandas as pd 

def abrirMapa():
        cor = []
        mapa= folium.Map(
                location=[-1.831239, -78.183406],
                zoom_start=8.
        )

        df = pd.read_csv('analisis1.csv', delimiter=',')
        geolocator = Nominatim(user_agent="HeatMapAuto")

        print (df)
        for i in range(0,len(df.index)):

                texto = str(df['ciudad'][i]) + "," +df['pais'][i]
                print(texto)
                location = geolocator.geocode(texto)
                cor.append([location.latitude, location.longitude])

        print (cor)
        mapa.add_child(plugins.HeatMap(cor))

        # location = geolocator.geocode("Amaguaña, Ecuador")
        # print (location.latitude,location.longitude) 

        mapa.save("index.html")
        webbrowser.open('index.html')
