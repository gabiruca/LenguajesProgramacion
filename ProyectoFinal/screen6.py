# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'screen6.ui'
#
# Created by: PyQt5 UI code generator 5.15.4
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.

#Integrante - Gabriela Sosa
from PyQt5 import QtCore, QtGui, QtWidgets
import csv
import matplotlib.pyplot as plt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
from numpy import random

class Ui_analisis6(object):
    def setupUi(self, analisis6):
        analisis6.setObjectName("analisis6")
        analisis6.resize(1057, 821)
        analisis6.setMinimumSize(QtCore.QSize(1057, 821))
        analisis6.setMaximumSize(QtCore.QSize(1057, 821))
        analisis6.setStyleSheet("QWidget#centralwidget{\n"
"background-color: qlineargradient(spread:pad, x1:0, y1:0, x2:1, y2:0, stop:0 rgba(255, 170, 206, 255), stop:1 rgba(255, 255, 255, 255));\n"
"}")
        self.centralwidget = QtWidgets.QWidget(analisis6)
        self.centralwidget.setObjectName("centralwidget")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(410, 20, 251, 71))
        self.label.setStyleSheet("color: rgb(255, 15, 159);\n"
"font: 75 23pt \"Comic Sans MS\";\n"
"")
        self.label.setObjectName("label")
        self.pushButton_3 = QtWidgets.QPushButton(self.centralwidget, clicked= lambda: self.hide())
        self.pushButton_3.setGeometry(QtCore.QRect(30, 30, 101, 31))
        self.pushButton_3.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"color: rgb(150, 129, 255);\n"
"font: 60 12pt \"Rockwell\";\n"
"border-color: rgb(180, 126, 255);")
        self.pushButton_3.setObjectName("pushButton_3")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(170, 80, 751, 71))
        self.label_2.setStyleSheet("color:rgb(150, 129, 255);\n"
"font: 75 16pt \"Comic Sans MS\";\n"
"")
        self.label_2.setObjectName("label_2")
        self.label_3 = QtWidgets.QLabel(self.centralwidget)
        self.label_3.setGeometry(QtCore.QRect(20, 720, 1011, 51))
        self.label_3.setStyleSheet("font: 12pt \"Comic Sans MS\";\n"
"")
        self.label_3.setText("")
        self.label_3.setObjectName("label_3")
        self.horizontalLayoutWidget = QtWidgets.QWidget(self.centralwidget)
        self.horizontalLayoutWidget.setGeometry(QtCore.QRect(70, 160, 931, 551))
        self.horizontalLayoutWidget.setObjectName("horizontalLayoutWidget")
        self.horizontalLayout = QtWidgets.QHBoxLayout(self.horizontalLayoutWidget)
        self.horizontalLayout.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout.setObjectName("horizontalLayout")
        #plot
        self.figure=plt.figure()
        self.canvas=FigureCanvas(self.figure)
        self.horizontalLayout.addWidget(self.canvas)
        #end plot

        self.pushButton_4 = QtWidgets.QPushButton(self.centralwidget,clicked=lambda: self.plotOnCanvas())
        self.pushButton_4.setGeometry(QtCore.QRect(30, 70, 101, 31))
        self.pushButton_4.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"color: rgb(150, 129, 255);\n"
"font: 60 12pt \"Rockwell\";\n"
"border-color: rgb(180, 126, 255);")
        self.pushButton_4.setObjectName("pushButton_4")
        analisis6.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(analisis6)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 1057, 26))
        self.menubar.setObjectName("menubar")
        analisis6.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(analisis6)
        self.statusbar.setObjectName("statusbar")
        analisis6.setStatusBar(self.statusbar)

        self.retranslateUi(analisis6)
        QtCore.QMetaObject.connectSlotsByName(analisis6)

    def retranslateUi(self, analisis6):
        _translate = QtCore.QCoreApplication.translate
        analisis6.setWindowTitle(_translate("analisis6", "graficaPastel"))
        self.label.setText(_translate("analisis6", "Gráfica pastel"))
        self.pushButton_3.setText(_translate("analisis6", "Regresar"))
        self.label_2.setText(_translate("analisis6", "Ofertas de trabajo informática: Jornadas de trabajo (Gye)"))
        self.pushButton_4.setText(_translate("analisis6", "Graficar"))

    def plotOnCanvas(self):
        self.figure.clear()
        fruits=['Apple','Oranges','Coconuts','Pawpaw']
        values=random.randint(50, size=(4))

        plt.bar(fruits,values,color='red',width=0.4)
        plt.xlabel("type of fruits")
        plt.ylabel("Quantity")
        plt.title("Random fruits in my basket")

        #self.canvas.draw()


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    analisis6 = QtWidgets.QMainWindow()
    ui = Ui_analisis6()
    ui.setupUi(analisis6)
    analisis6.show()
    sys.exit(app.exec_())
