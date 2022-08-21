from PyQt5 import QtWidgets, uic

app=QtWidgets.QApplication([])

#Crear el resto de ventanas pendiente!!
main=uic.loadUi("MainVentana.ui")


main.show()
app.exec()