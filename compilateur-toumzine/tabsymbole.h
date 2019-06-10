#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct tableau_des_symboles
{
char id[1600]; 
int type;
int addr;
int deph;

} symboles; 

extern int depth;
extern int index_ts;
extern int next_addr;


void ts_inc_depth();
void ts_dec_depth();
void ts_add_symble(char* name, int type );
int ts_add_symbol_tmp();
int  ts_supp_symbole_temp();
int ts_get_symble_address_by_name(char* name);
void ts_affichage_tab();
int ts_verify_variable_existence(char* name);
int get_last_address();
void ts_dec();


