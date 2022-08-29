from PyQt5 import QtWidgets, uic

app=QtWidgets.QApplication([])

#Llamada a ventanas
main=uic.loadUi("MainVentana.ui")
ventana4=uic.loadUi("screen4.ui")
ventana5=uic.loadUi("screen5.ui")
ventana6=uic.loadUi("screen6.ui")

#Funciones
def pantalla4():
    main.hide()
    ventana4.show()

def pantalla5():
    main.hide()
    ventana5.show()

def pantalla6():
    main.hide()
    ventana6.show()

def back_p4():
    ventana4.hide()
    main.show()

def back_p5():
    ventana5.hide()
    main.show()

def back_p6():
    ventana6.hide()
    main.show()

#Funcionalidad
main.pushButton_4.clicked.connect(pantalla4)
main.pushButton_5.clicked.connect(pantalla5)
main.pushButton_6.clicked.connect(pantalla6)
ventana4.pushButton_3.clicked.connect(back_p4)
ventana5.pushButton_3.clicked.connect(back_p5)
ventana6.pushButton_3.clicked.connect(back_p6)

main.show()
app.exec()