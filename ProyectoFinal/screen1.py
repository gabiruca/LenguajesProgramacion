# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'screen1.ui'
#
# Created by: PyQt5 UI code generator 5.15.4
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets
from cgitb import text
from pydoc import render_doc 
import folium
import webbrowser 
import folium.plugins as plugins
from geopy.geocoders import Nominatim
import pandas as pd 


class Ui_analisis1(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(1057, 821)
        MainWindow.setMinimumSize(QtCore.QSize(1057, 821))
        MainWindow.setMaximumSize(QtCore.QSize(1057, 821))
        MainWindow.setStyleSheet("QWidget#centralwidget{\n"
"background-color: qlineargradient(spread:pad, x1:0, y1:0, x2:1, y2:0, stop:0 rgba(255, 170, 206, 255), stop:1 rgba(255, 255, 255, 255));\n"
"}")
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(420, 20, 241, 71))
        self.label.setStyleSheet("color: rgb(255, 15, 159);\n"
"font: 75 28pt \"Comic Sans MS\";\n"
"")
        self.label.setObjectName("label")
        self.pushButton_3 = QtWidgets.QPushButton(self.centralwidget,clicked= lambda: self.plotOnCanvas())
        self.pushButton_3.setGeometry(QtCore.QRect(30, 50, 181, 31))
        self.pushButton_3.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"color: rgb(150, 129, 255);\n"
"font: 60 12pt \"Rockwell\";\n"
"border-color: rgb(180, 126, 255);")
        self.pushButton_3.setObjectName("pushButton_3")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(170, 80, 741, 71))
        self.label_2.setStyleSheet("color:rgb(150, 129, 255);\n"
"font: 75 20pt \"Comic Sans MS\";\n"
"")
        self.label_2.setObjectName("label_2")
        self.graphicsView = QtWidgets.QGraphicsView(self.centralwidget)
        self.graphicsView.setGeometry(QtCore.QRect(70, 160, 931, 581))
        self.graphicsView.setObjectName("graphicsView")
        self.label_3 = QtWidgets.QLabel(self.centralwidget)
        self.label_3.setGeometry(QtCore.QRect(110, 240, 881, 241))
        self.label_3.setStyleSheet("color:rgb(0, 0, 0);\n"
"font: 100 20pt \"Comic Sans MS\";\n"
"")
        self.label_3.setObjectName("label_3")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 1057, 22))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        
        # self.pushButton_3.clicked.connect(self.cargar)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.label.setText(_translate("MainWindow", "Mapa de calor"))
        self.pushButton_3.setText(_translate("MainWindow", "Cargar mapa de calor"))
        self.label_2.setText(_translate("MainWindow", "??En qu?? ciudad de Ecuador existe mayor oferta de empleo en desarrollo web? "))
        self.label_3.setText(_translate("MainWindow", ""))
        
    def plotOnCanvas(self):
        self.label_3.setText("Los datos se estan cargando, esto demorara unos minutos")
        cor = []
        mapa= folium.Map(
                location=[-1.831239, -78.183406],
                zoom_start=8.
        )
        df = pd.read_csv('analisis1.csv', delimiter=',')
        geolocator = Nominatim(user_agent="HeatMapAuto")
        for i in range(0,len(df.index)):
                texto = str(df['ciudad'][i]) + "," +df['pais'][i]
                location = geolocator.geocode(texto)
                cor.append([location.latitude, location.longitude])
                
        mapa.add_child(plugins.HeatMap(cor))
        mapa.save("index.html")
        webbrowser.open('index.html')

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_analisis1()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
