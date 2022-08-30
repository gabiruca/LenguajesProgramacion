from PyQt5 import QtWidgets, uic
import mapa1

app=QtWidgets.QApplication([])

#Llamada a ventanas
main=uic.loadUi("MainVentana.ui")
ventana1=uic.loadUi("screen1.ui")
ventana2=uic.loadUi("screen2.ui")
ventana4=uic.loadUi("screen4.ui")
ventana5=uic.loadUi("screen5.ui")
ventana6=uic.loadUi("screen6.ui")

#Funciones
def pantalla1():
    main.hide()
    ventana1.show()

def pantalla2():
    main.hide()
    ventana2.show()

def pantalla4():
    main.hide()
    ventana4.show()

def pantalla5():
    main.hide()
    ventana5.show()

def pantalla6():
    main.hide()
    ventana6.show()

def back_p1():
    ventana1.hide()
    main.show()

def back_p2():
    ventana2.hide()
    main.show()

# def back_p3():
#     ventana3.hide()
#     main.show()


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
main.pushButton.clicked.connect(mapa1.abrirMapa)
main.pushButton.clicked.connect(pantalla1)
main.pushButton_2.clicked.connect(pantalla2)

main.pushButton_4.clicked.connect(pantalla4)
main.pushButton_5.clicked.connect(pantalla5)
main.pushButton_6.clicked.connect(pantalla6)

ventana1.pushButton_3.clicked.connect(back_p1)
ventana2.pushButton_3.clicked.connect(back_p2)
# ventana3.pushButton_3.clicked.connect(back_p3)
ventana4.pushButton_3.clicked.connect(back_p4)
ventana5.pushButton_3.clicked.connect(back_p5)
ventana6.pushButton_3.clicked.connect(back_p6)

main.show()
app.exec()