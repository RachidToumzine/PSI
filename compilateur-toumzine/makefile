
compiler: lex.yy.c y.tab.c
	gcc -o compiler y.tab.c tabsymbole.c  tableassambleur.c lex.yy.c -ly -lfl

y.tab.c: xyz.y
	yacc -d -v -t xyz.y

lex.yy.c: xyz.l
	flex xyz.l 

clean:
	rm -f a.out compilateur compiler y.tab.c y.tab.h
