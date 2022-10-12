import ply.lex as lex


# Cindy
# .
# .
reserved = {
    'if': 'IF',
    'else': 'ELSE',
    'do': 'DO',
    'while': 'WHILE',
    'end_while': 'END_WHILE',
    'for': 'FOR',
    'switch': 'SWITCH',
    'case': 'CASE',
    'end_switch': 'END_SWITCH',
    'break': 'BREAK',
    'continue': 'CONTINUE',
    'default': 'DEFAULT',
    'as': 'AS',
    'rsort': 'RSORT',
    'count': 'COUNT',
    'array': 'ARRAY',
    'global': 'GLOBAL',
    'static': 'STATIC',
    'print': 'PRINT',
    'const': 'CONST',
    'function': 'FUNCTION',
    'return': 'RETURN',
    'class': 'CLASS',
    'new': 'NEW',
    'extends': 'EXTENDS',
    'int': 'INTEGER',
    'string': 'STRING',
    'bool': 'BOOLEAN',
    'float': 'FLOAT',
    'null': 'NULL',
    'true': 'TRUE',
    'false': 'FALSE',
    'compare': 'COMPARE',
    'current': 'CURRENT'
}
tokens = [
    'PUNTOYCOMA',
    'PUNTO',
    'COMA',
    'COMDOB',
    'DOSPUNTOS',
    'PARENIZQ',
    'PARENDER',
    'LLAVEIZQ',
    'LLAVEDER',
    'CORCHIZQ',
    'CORCHDER',
    'AMPERSAND',
    'OPERASIGNACION',
    'MAS',
    'MENOS',
    'MULTIPLICA',
    'DIVIDE',
    'MODULO',
    'EXPONENCIACION',
    'MASIGUAL',
    'MENOSIGUAL',
    'ASTERISCOIGUAL',
    'BARRAIGUAL',
    'PORCENTAJEIGUAL',
    'DOBLEASTERISCOIGUAL',
    'OPERCOMPARACION',
    'OPERLOGICO_OR',
    'OPERLOGICO_AND',
    'OPERLOGICO_XOR',
    'OPERLOGICO_OREXCLUSIVO',
    'OPERLOGICO_NOT',
    'OPERASIG_ARRAY',
    'BOOLEANO',
    'MAYORQUE',
    'MENORQUE',
    'INICIO',
    'FIN',
    'CADENA',
    'ENTERO',
    'FLOTANTE',
    'COMENTARIO_UNA_LINEA',
    'COMENTARIO_LARGO',
    'NOMBRE',
    'VARIABLE_PHP',
    'OPERAMAPA',
    'OPERALOGICO_MAP',
    'OPERACIONSUM',
    'OPERAPUT',
    'ECHO',
    'PUBLIC',
    'PROTECTED',
    'PRIVATE',
    'TEXTOSENCILLO'
 ] + list(reserved.values())

t_PUNTOYCOMA = r';'
t_PUNTO = r'\.'
t_COMA = r','
t_COMDOB = r'\"'
t_DOSPUNTOS = r':'
t_PARENIZQ = r'\('
t_PARENDER = r'\)'
t_LLAVEIZQ = r'\{'
t_LLAVEDER = r'\}'
t_CORCHIZQ = r'\['
t_CORCHDER = r'\]'
t_AMPERSAND = r'\&'
t_OPERASIGNACION = r'='
t_MAS = r'\+'
t_MENOS = r'\-'
t_MULTIPLICA = r'\*'
t_DIVIDE = r'/'
t_MODULO = r'%'
t_EXPONENCIACION = r'\*\*'
t_MASIGUAL = r'\+\='
t_MENOSIGUAL = r'\-\='
t_ASTERISCOIGUAL = r'\*\='
t_BARRAIGUAL = r'\/\='
t_PORCENTAJEIGUAL = r'\%\='
t_DOBLEASTERISCOIGUAL = r'\*\*\='
t_OPERCOMPARACION = r'=='
t_ignore = " \t"
#t_OPERASIG_ARRAY = r'=>'
t_OPERAMAPA = r'array\_map'
t_OPERALOGICO_MAP = r'\->'
t_OPERACIONSUM = r'sum\(\)'
t_OPERAPUT = r'put'

#cindy


def t_OPERASIG_ARRAY(t):
    r'(\=){1}(\>){1}'
def t_TEXTOSENCILLO(t):
    r'([A-Z].*?[\.!?]|[A-Z].*(\ )*)'
    return t


def t_OPERLOGICO_OR(t):
    r'or'
    return t


def t_OPERLOGICO_XOR(t):
    r'xor'
    return t


def t_OPERLOGICO_AND(t):
    r'and'
    return t


def t_OPERLOGICO_OREXCLUSIVO(t):
    r'\|\|'
    return t


def t_OPERLOGICO_NOT(t):
    r'!'
    return t
#cindy


def t_INICIO(t):
    r'<\?php'
    return t


def t_FIN(t):
    r'\?>'
    return t


def t_ECHO(t):
    r'echo'
    return t


def t_PUBLIC(t):
    r'public'
    return t


def t_PROTECTED(t):
    r'protected'
    return t


def t_PRIVATE(t):
    r'private'
    return t

#.
#.
#Cindy

#Gabriela


t_MAYORQUE=r'>'
t_MENORQUE = r'<'


def t_BOOLEANO(t):
    r'True|False'
    return t


def t_CADENA(t):
    r'\"(.)+\"|\'(.)+\''
    return t


t_COMENTARIO_UNA_LINEA =r'//'+'.*'
t_COMENTARIO_LARGO = r'/\*'+'.*'+'\*/'


def t_FLOTANTE(t):
    r'\d+\.\d+'
    t.value = float(t.value)
    return t

# def t_VARIABLE(t):
#     r'(\$[a-zA-Z_][a-zA-Z0-9_]* | [a-zA-Z_][a-zA-Z0-9_]*)'
#     t.type = reserved.get(t.value, "VARIABLE")
#     return t


def t_NOMBRE(t):
    r'[a-zA-Z_][a-zA-Z0-9_]*'
    t.type = reserved.get(t.value, "VARIABLE")
    return t



def t_VARIABLE_PHP(t):
    r'\$[a-zA-Z_][a-zA-Z0-9_]*'
    return t


#--------------

#.
#.
#Daniel


def t_ENTERO(t):
    r'\d+'
    t.value = int(t.value)
    return t
#.
#.
#Daniel

#Gabriela


def t_contadorLineas(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

#Cindy
# def t_PRINT(t):
#     r'print'
#     return t

#-------------


resultados = []


def t_error(t):
    lineae="Caracter no reconocido {t.value[0]} en línea {t.lineno}"
    print(lineae)
    resultados.append(lineae)
    t.lexer.skip(1)


def prueba(data):
    global resultados

    lexer = lex.lex()
    lexer.input(data)
    resultados.clear()
    while True:
        tok = lexer.token()
        if not tok:
            break
        linea = "Linea {:4} Tipo {:16} Valor {:16}".format(str(tok.lineno), str(tok.type), str(tok.value))
        resultados.append(linea)
    return resultados


lexer = lex.lex()
if __name__ == '__main__':
    while True:
        data = input("input: ")
        prueba(data)
        print(resultados)


print("Analizador Léxico")


