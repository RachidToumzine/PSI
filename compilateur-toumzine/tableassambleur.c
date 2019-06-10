#include "tabsymbole.h"
#include "tableassambleur.h"

int index_asm=0;
 
assembleur tabass[1000];



int ins_add(char* inst,int val0,int val1,int val2)
    {
        strcpy(tabass[index_asm].ins,inst);
        tabass[index_asm].val0=val0;
        tabass[index_asm].val1=val1;
        tabass[index_asm].val2=val2;

    index_asm++;
return index_asm-1;

    }
int get_last_index_table_assembly()
    {
	    return index_asm-1;
    }


void affichage_assembly_table_ecran(){


	
	for(int i = 0 ; i <  index_asm ; i++) {


		fprintf(stdout,"%s        R%d R%d R%d\n",tabass[i].ins,tabass[i].val0, tabass[i].val1, tabass[i].val2);
	}
}


void affichage_assembly_table(){

	FILE * file = fopen("assemblyfile.asm","w+");
	
	for(int i = 0 ; i <  index_asm ; i++) {


		fprintf(file,"%s %d %d %d\n",tabass[i].ins,tabass[i].val0, tabass[i].val1, tabass[i].val2);
	}

	fclose(file);

}


void msj_jmp(int i)
{
	 tabass[i].val0 = index_asm+1;
}


/*
 int main (){
ins_add("aaddnull",0,1,2);
affichage_assembly_table_ecran();
ins_add("aaddnummmll",1,3,2);
affichage_assembly_table_ecran();
ins_add("aaddfdfdfdfdnull",0,1,2);
affichage_assembly_table_ecran();
printf("%d \n",get_last_index_table_assembly());
affichage_assembly_table();

 }
		
	*/	