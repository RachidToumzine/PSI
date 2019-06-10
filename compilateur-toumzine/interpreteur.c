#include "tabsymbole.h"
#include "tableassambleur.h"

int registres[3];
int memoire[100];

void explore()
{    for(int i=0;i<index_asm;i++)
    {
        if(strcmp(tabass[i].ins, "ADD") == 0) {
            registres[tabass[i].val0] = registres[tabass[i].val1]+registres[tabass[i].val2];

        } else if(strcmp(tabass[i].ins, "MUL") == 0) {
                registres[tabass[i].val0] = registres[tabass[i].val1]*registres[tabass[i].val2];
                
        } else if(strcmp(tabass[i].ins, "SOU") == 0) {
                registres[tabass[i].val0] = registres[tabass[i].val1]-registres[tabass[i].val2];

        } else if(strcmp(tabass[i].ins, "DIV") == 0) {
                registres[tabass[i].val0] = registres[tabass[i].val1]/registres[tabass[i].val2];

        } else if(strcmp(tabass[i].ins, "AFC") == 0) {
            registres[tabass[i].val0] = tabass[i].val1;

        } else if(strcmp(tabass[i].ins, "LOAD") == 0) {
            registres[tabass[i].val0] = memoire[tabass[i].val1];

        } else if(strcmp(tabass[i].ins, "STORE") == 0) {
            memoire[tabass[i].val0] = registres[tabass[i].val1];

        } else if(strcmp(tabass[i].ins, "EQU") == 0) {
            if (registres[tabass[i].val1] == registres[tabass[i].val2]) {
                registres[tabass[i].val0] = 1;
            } else {
                registres[tabass[i].val0] = 0;
            }
        } else if(strcmp(tabass[i].ins, "INF") == 0) {
            if (registres[tabass[i].val1] < registres[tabass[i].val2]) {
                registres[tabass[i].val0] = 1;
            } else {
                registres[tabass[i].val0] = 0;
            }
        } else if(strcmp(tabass[i].ins, "SUP") == 0) {
            if (registres[tabass[i].val1] > registres[tabass[i].val2]) {
                registres[tabass[i].val0] = 1;
            } else {
                registres[tabass[i].val0] = 0;
            }

        } else if(strcmp(tabass[i].ins, "JMPC") == 0) {
            if(registres[tabass[i].val1] == 0) {
                i = tabass[i].val0-1;
            }
            
      
      }

}
}
void Affichage_des_registres() {
	printf("############### Registres ############# \n");	
	for(int i=0; i<3; i++) {
		printf("Registre[%d] = %d\n", i, registres[i]);
	}
}

void affiche_de_memoire() {
	printf("############### Memory ############# \n");
	for(int i=0; i<30; i++) {
		printf("Memory[%d] = %d\n", i, memoire[i]);
	}
}


int main()
{

explore();
affiche_de_memoire() ;
Affichage_des_registres();

}