%{
	#include "y.tab.h"
%}

%%
"+" {printf("plus"); return tPLUS;}
"=" {printf("egale");return tEGALE;}
"-" {printf("moin");return tMOIN;}
"<" {printf("inf");return tINF;}
">" {printf("sup");return tSUP;}
"*" {printf("multi");return tMULTI;}
"/" {printf("div");return tDIV;}
"{" {printf("acolade ouvrante");return tACOLADEOUV;}
"}" {printf("acolade fermante");return tACOLADFERM;}
"main" {printf("fonction main "); return tMAIN;}
"const" {printf("constante");return tCONST;}
"int" {printf("entier");return tINTEGER;}
" " {printf("espace");/*return tESPACE;*/}
"\n" {printf("newline");/*return tNEWLINE;*/}
"(" {printf("parenthese ouvrante");return tPARENTHESEOUV;}
")" {printf("parenthese fermante");return tPARENTHSESEFER;}
"\t" {printf("tabulation");/*return tTAB;*/}
"if" {printf("if");return tIF;}
"else" {printf("else");return tELSE;}
"for" {printf("for");return tFOR;}
"while" {printf("while");return tWHILE;}
"printf" {printf("ECRITURE");return tPRINTF;}
"," {printf("vergule");return tVERG;}
";" {printf("fin ins");return tFININS;}
[0-9]* 	{
			yylval.nb = atoi(yytext);
			printf(" nombre entier : %s", yytext); 
			return tNOMBRE;
		}
([a-z]|[A-Z])([a-z]|[A-Z]|_|[0-9])* {
										yylval.str = strdup(yytext);
										printf("nom de variable");
										return tVAR;
									}
. {printf("error");return tERREUR;}

