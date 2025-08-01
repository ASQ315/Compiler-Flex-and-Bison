%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern int yylex(void);
    extern FILE *yyin;
    extern FILE *yyout;

    extern int line_number;
    extern int column_number;

    void yyerror(const char *s);


typedef int num;

typedef struct Symbol {
    char *name;
    int value;
    struct Symbol *next;
} Symbol;

Symbol *symbol_table = NULL;

Symbol* find_symbol(const char *name) {
    Symbol *current = symbol_table;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0){
            return current;
        }
        current = current->next;
    }
    return NULL;
}

void set_symbol_value(const char *name, int value) {
    Symbol *symbol = find_symbol(name);
    if (symbol != NULL) {
        symbol->value = value;
    }else{
        symbol = (Symbol *)malloc(sizeof(Symbol));
        symbol->name = strdup(name);
        symbol->value = value;
        symbol->next = symbol_table;
        symbol_table = symbol;
    }
}

void print_symbol_table() {
    Symbol *current = symbol_table;
    while (current != NULL) {
        printf("Var: %s = %d\n", current->name, current->value);
        current = current->next;
    }
}
%}

%locations

%union {
    int num;
    char *strval;
}

%token <strval> IDENTIFICADOR
%token <num> NUMERO

%token INICIO FIN LET SUMA RESTA MULT DIV ASIGNACION PUNTOCOMA ABREPARENTESIS PARENTESISCIERRA

%type <num> Expr
%type <num> Term
%type <num> Factor
%type <strval> Var

%left SUMA
%left RESTA
%left MULT
%left DIV

%%

/* Gramatica */
S : INICIO { printf("S: Token: INICIO\n");}
            asignaciones FIN {
                printf("S: Token: FIN\n");
                printf("\nTABLA DE SIMBOLOS\n");
                print_symbol_table();
            };

asignaciones : asignacion 
             | asignaciones asignacion
             | error {
                yyerror("Syntax error");
                yyerrok;
             };

asignacion : Let Var ASIGNACION Expr PUNTOCOMA {
            set_symbol_value($2, $4);
};

Let : LET {printf("Token: LET\n");}

Var : IDENTIFICADOR { $$ = $1; printf("Var: %s, Token: IDENTIFICADOR\n", $1);}

Expr : Expr SUMA Term {
        printf("Expr: %d\nToken: SUMA \n Term: %d\n", $1, $3);
        $$ = $1 + $3;
}
    | Expr RESTA Term {
        printf("Expr: %d\nToken: RESTA \n Term: %d\n", $1, $3);
        printf("Token: Resta \n");
        $$ = $1 - $3;
    }

    | Term {
        printf("Term: %d\n", $1);
        $$ = $1;
    };

Term : Term MULT Factor {
            printf("Expr: %d\nToken: MULT \n Factor: %d\n", $1, $3);
            $$ = $1 * $3;}
    
    | Term DIV Factor {
        if($3 == 0) {
            yyerror("Division por cero.");
            $$ = 0;
        }
        else {
            printf("Expr: %d\nToken: DIV \n Factor: %d\n", $1, $3);
            $$ = $1 / $3;
        }
    }

    | Factor {
            printf("Factor: %d\n", $1);
            $$ = $1;
    };

AbreParentesis : ABREPARENTESIS {printf("Token: ABREPARENTESIS\n");}

Factor : AbreParentesis Expr PARENTESISCIERRA {
        printf("Token: PARENTESISCIERRA\n");
        $$ = $2;
}
    | IDENTIFICADOR {
        Symbol *symbol = find_symbol($1);
        if (symbol != NULL) {
            $$ = symbol->value;
        }
        else {
            yyerror("Variable no definida.");
            $$ = 0; 
        }
    }
    | NUMERO {$$ = $1;};

%%
int main(void) {

    yyin = fopen("ProgramaPrueba.txt", "r");
    yyout = fopen("Resultado.txt", "w");

    if(!yyin || !yyout){
        perror("Error opening output file");
        exit(EXIT_FAILURE);
    }

    yyparse();

    fclose(yyin); //Close the input file
    fclose(yyout); //Close the output file

    return 0;
} 

void yyerror(const char *s) {
    fprintf(stderr, "Bison error: %s at line %d, column %d\n", s, yylloc.first_line, yylloc.first_column); //Handle syntax errors
}