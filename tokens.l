%{
#include "parser.tab.h"
%}

%%

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
"INP"			{ 
				char input[300];
				fscanf(yyin,"%s",input);
				yylval = atoi(input);
				return INP;
			}
\n			{ return EOL; }
[0-9]{1,3}		{ yylval = atoi(yytext); return MEMADDRESS; }
[ \t]			{ }
.			{ printf("Mystery char: %c\n", *yytext); }
%%
