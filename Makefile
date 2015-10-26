a.out: tokens.l parser.y globals.h
	bison -d -t -v parser.y
	flex tokens.l
	gcc parser.tab.c lex.yy.c -lfl
clean:
	rm a.out parser.tab.h parser.tab.c lex.yy.c parser.output 
