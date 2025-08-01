%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "parser.tab.h" //Include Bison-generated header file

    extern YYLTYPE yylloc;

    int line_number = 1;
    int column_number = 1;

%}

%option noyywrap

Num ([0-9])
Letras ([a-zA-Z])+
Identificador ({Letras}({Letras}|{Num})*)
Numero ({Num}{Num}*)

%%

inicio {
    fprintf(yyout, "(PalabrasReservadas, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    yylval.strval = strdup(yytext);
    return INICIO;
}

fin {
    fprintf(yyout, "(PalabrasReservadas, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return FIN;
}

let {
    fprintf(yyout, "(PalabrasReservadas, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return LET;
}

{Numero} {
    fprintf(yyout, "(Numero, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    yylval.num = atoi(yytext);
    return NUMERO;
}

{Identificador} {
    fprintf(yyout, "(Identificador, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    yylval.strval = strdup(yytext);
    return IDENTIFICADOR;
}

[+] {
    fprintf(yyout, "(OperadorSuma, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return SUMA;
}

[-] {
    fprintf(yyout, "(OperadorResta, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return RESTA;
}

[*] {
    fprintf(yyout, "(OperadorMult, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return MULT;
}

[/] {
    fprintf(yyout, "(OperadorDiv, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return DIV;
}

[=] {
    fprintf(yyout, "(OperadorAsignacion, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return ASIGNACION;
}

[;] {
    fprintf(yyout, "(PuntoComa, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return PUNTOCOMA;
}

[(] {
    fprintf(yyout, "(AbreParentesis, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return ABREPARENTESIS;
}

[)] {
    fprintf(yyout, "(ParentesisCierra, %s)", yytext);

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

    return PARENTESISCIERRA;
}

{Numero}{Letras}* {

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;
   
}

\n {

    line_number++;
    column_number = 1;

}

[\t]+ {

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;
    yylloc.last_line = line_number;
    yylloc.last_column = column_number + yyleng - 1;
    column_number += yyleng;

}

[_|:|~|`|!|@|#|$|%|^|&|{|}|[|]|,|<|>|''|""|,] {

    yylloc.first_line = line_number;
    yylloc.first_column = column_number;

}

%%