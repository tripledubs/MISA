p02: tokens.l parser.y globals.h
	bison -d -t -v parser.y
	flex tokens.l
	gcc parser.tab.c lex.yy.c -lfl -o p02
clean:
	rm p02 parser.tab.h parser.tab.c lex.yy.c parser.output 
