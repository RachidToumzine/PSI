 

%{
	#include "tabsymbole.h"
	#include "tableassambleur.h"
	
	void yyerror();
	int yylex();
	//int yydebug = 1;
%}

%token tMAIN tPLUS tEGALE tMOIN tINF tSUP tMULTI tDIV tACOLADEOUV tACOLADFERM tCONST tINTEGER tESPACE tPARENTHESEOUV tPARENTHSESEFER tTAB tIF tELSE tFOR tVERG tNOMBRE tFININS  tVAR tPRINTF tERREUR tNEWLINE tWHILE


%right tEGALE
%left tPLUS tMOIN
%left tMULTI tDIV


%union {
	int nb;
	char* str;
}

%type <nb> tNOMBRE
%type <str> tVAR

%%

start : functions;

functions:
	main
	| function functions
	;

function:tINTEGER tVAR tPARENTHESEOUV tPARENTHSESEFER tACOLADEOUV body tACOLADFERM;

main: tINTEGER tMAIN tPARENTHESEOUV tPARENTHSESEFER tACOLADEOUV body tACOLADFERM;

body: declarations instructions ;

declarations: 
   	declaration
   	| declaration declarations
	;

declaration:

//tINTEGER variables tFININS;


	tINTEGER variables  tFININS ;


variables:
	variable
	| variable tVERG variables 
	;

variable:
	tVAR tEGALE expression {
		 ts_supp_symbole_temp();
		ts_add_symble($1,depth);
		// voir affec
		
		}
	| tVAR {ts_add_symble($1,depth);}
	;


instructions:instruction |instruction instructions;

instruction:tVAR tEGALE expression tFININS  {
ins_add("LOAD",0,get_last_address(),0);
ins_add("STORE",ts_get_symble_address_by_name($1),0,0);
 ts_supp_symbole_temp();



 } 
|tPRINTF  tPARENTHESEOUV expression  tPARENTHSESEFER  tFININS
|if|while
;

if: tIF tPARENTHESEOUV condition tPARENTHSESEFER body_if_while {msj_jmp($<nb>3);}
| tIF tPARENTHESEOUV condition tPARENTHSESEFER body_if_while {$<nb>$ = ins_add("JMP",-1,0,0);msj_jmp($<nb>3);}tELSE body_if_while{msj_jmp($<nb>7);} ;


body_if_while:tACOLADEOUV { ts_inc_depth();} body tACOLADFERM {ts_dec_depth();} ;

while: tWHILE   tPARENTHESEOUV condition tPARENTHSESEFER body_if_while {ins_add("JMP",get_last_index_table_assembly()+1,0,0); msj_jmp($<nb>3);};

expression:
	tNOMBRE{
		
		ts_add_symbol_tmp();
		ins_add("AFC",0,$1,0);
		ins_add("STORE",get_last_address(),0,0);
	
	} 
	| tVAR 
	{
		ts_add_symbol_tmp();
		ins_add("LOAD",0,ts_get_symble_address_by_name($1),0);
		ins_add("STORE",get_last_address(),0,0);
		
	}

	| expression tPLUS expression
	{
	   ins_add("LOAD",0,get_last_address(),0);
	   ts_dec();
	   ins_add("LOAD",1,get_last_address(),0);
	   ins_add("ADD",2,0,1);  
	   ins_add("STORE",get_last_address(),2,0);
	}


    | expression tMULTI expression

{

	   ins_add("LOAD",0,get_last_address(),0);
	   ts_dec();
	   ins_add("LOAD",1,get_last_address(),0);
	   ins_add("MUL",2,0,1);  
	   ins_add("STORE",get_last_address(),2,0);
	 
	}

	| expression tMOIN expression
	{
	  
	   ins_add("LOAD",0,get_last_address(),0);
	   ts_dec();
	   ins_add("LOAD",1,get_last_address(),0);
	   ins_add("SOU",2,0,1);  
	   ins_add("STORE",get_last_address(),2,0);


	}

	| expression tDIV expression
	{

	   ins_add("LOAD",0,get_last_address(),0);
	   ts_dec();
	   ins_add("LOAD",1,get_last_address(),0);
	   ins_add("DIV",2,0,1);  
	   ins_add("STORE",get_last_address(),2,0);
	}

	|tPARENTHESEOUV expression tPARENTHSESEFER  

;



condition: expression tEGALE tEGALE  expression {
		int ad1 = ts_supp_symbole_temp() ; 
		int ad2 = ts_supp_symbole_temp();
		ins_add("LOAD",0,ad1,0);
		ins_add("LOAD",1,ad2,0);
		ins_add("EQU",0,0,1);
		$<nb>$ = ins_add("JMPC",-1,0,0);
	}

/*	| expression {
		int ad1 = ts_supp_symbole_temp() ;
		ins_add("LOAD",0,ad1,0);
		ins_add("AFC",1,0,0);
		ins_add("EQU",0,0,1);
		ins_add("AFC",1,0,0);
		ins_add("EQU",0,0,1);
		$<nb>$ = ins_add("JMPC",-1,0,0);}
*/
	| expression tSUP expression {
		int ad1 = ts_supp_symbole_temp();
		int ad2 = ts_supp_symbole_temp();
		ins_add("LOAD",0,ad2,0);
		ins_add("LOAD",1,ad1,0);
		ins_add("tSUP",0,0,1);
		$<nb>$ = ins_add("JMPC",-1,0,0);
	}
	| expression tINF expression {
		int ad1 = ts_supp_symbole_temp();
		int ad2 = ts_supp_symbole_temp();
		ins_add("LOAD",0,ad2,0);
		ins_add("LOAD",1,ad1,0);
		ins_add("INF",0,0,1);
		$<nb>$ = ins_add("JMPC",-1,0,0);

	}
	;








%%

int main() {
yyparse();

ts_affichage_tab();

affichage_assembly_table();
}

	






