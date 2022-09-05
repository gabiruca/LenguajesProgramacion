from cgitb import text
# import os 
# import json
from pydoc import render_doc
from sys import maxsize
from tkinter import dialog
from tokenize import Double 
# import requests
import folium
import webbrowser 
import folium.plugins as plugins
from random import randrange
# import geopy
# from geopy.geocoders import Nominatim
from geopy.geocoders import Nominatim 
import geocoder

import pandas as pd 

from geopy.location import Location
import matplotlib.pyplot as plt
import datetime

def cargar():
        meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
        tiempo = ["un", "dos", "tres", "cuatro","cinco","seis","siete","ocho","nueve","diez","once","año"]
        lst = [0] * 12
        df = pd.read_csv('analisis3.csv', delimiter=',')
        for i in range(0,len(df.index)):
                fecha = (datetime.date.today().month) -1 
                # print(fecha)
                texto = str(df['tiempo'][i]).split(" ")
                # print(texto)
                # 17 dias atras
                dia = texto[1]
                # # hace un mes
                mes = texto[2]
                
                if  "dias"  == dia :
                        temporal = lst[fecha]
                        temporal = temporal + 1
                        lst[fecha] = temporal
                elif "mes" or "meses" == mes:
                        num = tiempo.index(dia) + 1
                        num = fecha - num
                        temporal = lst[num]
                        temporal = temporal + 1 
                        lst[num] = temporal  
                                
        fig, ax = plt.subplots( sharey = True) 
        plt.xlabel('Meses')
        plt.ylabel('Numero de ofertas laborales')
        plt.title("Ofertas de trabajos remotos en desarrollo web existen en el último año")
        ax.plot(meses, lst, color = 'tab:orange')
        manager = plt.get_current_fig_manager()
        manager.full_screen_toggle()
        plt.show()
