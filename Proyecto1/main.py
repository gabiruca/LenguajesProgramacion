import sys
from PyQt5 import uic
from PyQt5.QtWidgets import QMainWindow, QApplication
from analizadorLexico import *
from analizadorSintactico import *

class InterfazG(QMainWindow):
    def __init__(self):
        super().__init__()
        uic.loadUi("ventana.ui", self)
        self.analizarLexico.clicked.connect(self.resultados_l)
        self.analizarSintactico.clicked.connect(self.resultados)

    def resultados_l(self):
        self.resultado.setText('')
        datos = self.escribir.toPlainText().strip()
        result = prueba(datos)
        cadena = ''
        for elemento in result:
            cadena += elemento + "\n"
        self.resultado.setText(cadena)

    def resultados(self):
        self.resultado.setText('')
        datos = self.escribir.toPlainText().strip()
        result = prueba_s(datos)
        cadena = ''
        for elemento in result:
            cadena += elemento + "\n"
        self.resultado.setText(cadena)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    GUI = InterfazG()
    GUI.show()
    sys.exit(app.exec_())