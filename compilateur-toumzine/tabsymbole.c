
#include "tabsymbole.h"

int depth=0;
int index_ts=0;
int next_addr=100;
int before_entrer_index;

symboles tab[1000];

void ts_add_symble(char* name, int type )
	{
		printf("l'ajout de symbole :%s \n",name);
		ts_affichage_tab();
	if(ts_verify_variable_existence(name)==0 && index_ts<1000){
		tab[index_ts].type=type;
		strcpy(tab[index_ts].id,name);
		tab[index_ts].addr = next_addr;
		next_addr+=4;
		tab[index_ts].deph=depth;
			index_ts++;
	}
	else  {
		printf("ce symbole existe deja : %s\n", name);
		exit(0);
	}

	}
		

int ts_verify_variable_existence(char* name)
	{

		for (int i=index_ts;i>=0 && tab[i].deph==depth;i--)
			{
				if ((strcmp(name,tab[i].id)==0 ) ) return 1 ;
			}
			
				return 0;						
			
	}

int ts_get_symble_address_by_name(char* name)
	{ 
		for (int i=index_ts;i>=0;i--)
			{
				if (strcmp(name,tab[i].id)==0) return tab[i].addr ;
			}

			return -1;

	}




int ts_add_symbol_tmp()
	{
		ts_affichage_tab();
		if(index_ts>=1000){

			exit(1);
		}	
		strcpy(tab[index_ts].id, "#tmp");
		tab[index_ts].addr=next_addr;
		tab[index_ts].deph=depth;
		index_ts++;
		next_addr+=4;
		return index_ts-1;
	}
int  ts_supp_symbole_temp()
	{
		
		ts_affichage_tab();
		if(index_ts<=0)
	{exit(1);}
		next_addr-=4;
		return index_ts--;
	}



void ts_inc_depth()
	{
		//before_entrer_index=index_ts;
		depth++;
	}




void ts_dec_depth()
	{
		for(int i=index_ts-1;tab[i].deph==depth && i>=0;i--)
		{
			index_ts--;
		}
		next_addr=tab[index_ts].addr;
		depth--;
	}


int get_last_address()
	{
		return tab[index_ts-1].addr;
	}


void ts_affichage_tab()
	{	
	
		printf("====================== Symbols Table =====================\n");
		for (int i = 0 ; i<index_ts ;i++)
			{
				printf("index = %d, \t ID = %s,\t  addr = %d, \t deph = %d\n",i,tab[i].id,tab[i].addr, tab[i].deph);
			}
		printf("==========================================================\n");
	}

void ts_dec(){
	index_ts--;

}

/*
int main() {

	 ts_add_symble( "hello", 0); ts_affichage_tab();
 ts_add_symble( "heo", 0);ts_affichage_tab();
 ts_add_symble( "helvho", 0);ts_affichage_tab();
 ts_inc_depth();ts_affichage_tab();
 ts_add_symble( "helvho", 0);ts_affichage_tab();
 ts_add_symble( "fff", 0);ts_affichage_tab();
 ts_dec_depth();ts_affichage_tab();
ts_add_symbol_tmp();ts_affichage_tab();
ts_add_symbol_tmp();ts_affichage_tab();
ts_add_symbol_tmp();ts_affichage_tab();
 ts_supp_symbole_temp();ts_affichage_tab();



}
*/













