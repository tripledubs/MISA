%option yylineno case-insensitive
%{
#include "parser.tab.h"
#include "globals.h"
%}

%%
"//".*			{ /* Ignore Comments */ }
[ \t]			{ /* Ignore whitespace */ }
"LDA"			{ return LDA; }
"LDB"			{ return LDB; }
"ADD"			{ return ADD; }
"SUB"			{ return SUB; }
"MUL"			{ return MUL; }
"DIV"			{ return DIV; }
"MOD"			{ return MOD; }
"STR"			{ return STR; }
"PNT"			{ return PNT; }
"CMP"			{ return CMP; }
"JLT"			{ return JLT; }
"JGT"			{ return JGT; }
"JEQ"			{ return JEQ; }
"JMP"			{ return JMP; }
"STP"			{ return STP; }
\n			{ return EOL; }
[0-9]{1,3}		{ 
				yylval = atoi(yytext); 
				if (yylval > MEMSIZE) {
					yyerror("Memory out of bounds!");
				}
				else if (yylval < 0)
					yyerror("Memory out of bounds!");
				else
					return MEMADDRESS; 
			}
.			{ printf("Mystery char: %c\n", *yytext); }
"INP"			{ 
				char input[300];
				fscanf(yyin,"%s",input);
				yylval = atoi(input);
				return INP;
			}
%%
