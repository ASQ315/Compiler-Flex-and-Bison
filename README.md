# Proyecto de Compilador en C (Flex y Bison)

Este proyecto es un compilador básico escrito en C usando **Flex** (Lex) y **Bison** (Yacc). Analiza e interpreta un lenguaje simple que soporta declaraciones de variables y operaciones aritméticas.

---

## 🖥️ Requisitos

- **Cygwin Terminal** (entorno Linux para Windows)
- **Flex**
- **Bison**
- **GCC**

---

## 💾 Instalación de Cygwin (Windows)

1. **Descargar el instalador de Cygwin**  
   Ve a [https://www.cygwin.com/](https://www.cygwin.com/) y descarga el archivo `setup-x86_64.exe`.

2. **Guía en video (opcional)**  
   Puedes seguir este video paso a paso para instalar Flex, Bison y GCC en Cygwin:  
   📺 [Cómo instalar Cygwin + Flex + Bison + GCC en Windows](https://www.youtube.com/watch?v=nO4SIa3pe0I)

3. **Ejecuta el instalador**  
   Sigue los pasos para instalarlo. Cuando llegues a *"Select Packages"*, busca e instala los siguientes paquetes:

   - `gcc-core` → compilador de C
   - `flex` → generador del analizador léxico
   - `bison` → generador del analizador sintáctico
   - `make` (opcional, para automatizar compilación)

   Puedes buscarlos en la sección **Devel** durante la instalación.

4. **Abrir Cygwin Terminal**  
   Luego de instalar, abre el terminal y escribe:

   ```bash
   gcc --version
   flex --version
   bison --version
   
# Proyecto de Compilador en C (Flex y Bison)
## 📁 Estructura del Proyecto

- `lexic.l` – Analizador léxico (definido en Flex)
- `parser.y` – Analizador sintáctico y semántico (definido en Bison)
- `ProgramaPrueba.txt` – Archivo de prueba con el código fuente a compilar
- `Resultado.txt` – Archivo de salida ejecutable (generado con gcc)
- `parser.tab.h` / `parser.tab.c` – Archivos generados por Bison
- `lex.yy.c` – Archivo generado por Flex

## ⚙️ Cómo compilar

   ```bash
   bison -d parser.y       # genera parser.tab.c y parser.tab.h
   flex lexic.l            # genera lex.yy.c
   gcc lex.yy.c parser.tab.c -o Result      # compila todo
   ./Result                # ejecuta el archivo

## 📦 Salida esperada
   S: Token: INICIO
   Token: LET
   Var: x, Token: IDENTIFICADOR
   Factor: 3
   Term: 3
   Token: LET
   Var: y, Token: IDENTIFICADOR
   Factor: 3
   Term: 3
   Factor: 7
   Expr: 3
   Token: SUMA
   Term: 7
   S: Token: FIN
   
   TABLA DE SIMBOLOS
   Var: y = 10
   Var: x = 3

