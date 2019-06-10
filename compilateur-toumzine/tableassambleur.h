#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int index_asm;
 
typedef struct tableau_assembleur

{
char ins[1600]; 
int val0;
int val1;
int val2;

} assembleur;
assembleur tabass[1000];

int ins_add(char *ins,int val0,int val1,int val2);
int get_last_index_table_assembly();
void affichage_assembly_table();
void msj_jmp(int i);