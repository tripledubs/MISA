%{
#include <stdio.h>

int rega; 		/* Register A */
int regb;		/* Register B */
int pc;			/* Program Counter */ 
int statusRegister;	/* Status Register */
int memory[32];		/* So, so much memory */
void printMemory();	/* Print Memory Contents */
extern FILE* yyin; 	/* Not working exactly, yet, only reads from stdin */

%}

%token MEMADDRESS
%token INP LDA LDB STR PNT JLT JGT JEQ JMP
%token ADD SUB MUL DIV MOD CMP STP
%token EOL

%%
statement: 
   /* Nothing */
 | statement operation EOL { }
 | statement EOL { 
	 printMemory();
	 printf("Program Counter = %d\n",pc);
	 printf("Register A = %d\n",rega);
	 printf("Register B = %d\n",regb);
	 printf("Status Register = %d\n",statusRegister);
 }
;

operation: 
   nullary
 | unary 
;

nullary: 
   ADD 	{ regb = rega + regb; }
 | SUB 	{ regb = rega - regb; }
 | MUL 	{ regb = rega * regb; }
 | DIV 	{ regb = rega / regb; }
 | MOD 	{ regb = rega % regb; }
 | CMP 	{ 
		if (rega < regb)
			statusRegister = -1;
		if (rega > regb)
			statusRegister = 1;
		if (rega == regb)
			statusRegister = 0;
	}
 | STP
;

unary: 
   INP address { memory[$2] = $$; }
 | LDA address { rega = memory[$2]; }
 | LDB address { regb = memory[$2]; }
 | STR address { memory[$2] = regb; }
 | PNT address { printf("%i\n",memory[$2]); }
 | JLT address { }
 | JGT address { }
 | JEQ address { }
 | JMP address { }
;

address: MEMADDRESS
;

%% 
void printMemory() {
	int i;
	for (i=0; i < 32; i++) {
		printf("%i:%i\n",i,memory[i]);
	}
}

main (int argc, char **argv) 
{
	statusRegister = rega = regb = pc = 0;
	if (argc > 1) {
		if (!(yyin = fopen(argv[1],"r"))) {
			perror(argv[1]);
			return (1);
		}
	}
	yyparse();
}

yyerror(char *s) {
	printf(" %s: yylval=%i\n",  s, yylval);
}

