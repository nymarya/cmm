
digit      [0-9]
letter     [a-zA-Z]
ID         [a-zA-Z][a-zA-Z0-9]*
WHITESPACE [ ]
newline    [\n]
TAB        [\t]
STR        (\"(\\.|[^"\\])*\")

bool       (true)|(false)
float      {digit}+"."{digit}+

%{
 
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
int c;
extern int yylval;

    int coluna = 1;
    int yycol = 0;
%}
%%
" "       ;
     /* OPERADORES */

"+" {yycol = coluna;
coluna+=yyleng;
yylval='+';
return SUM_OP;}

"-" {yycol = coluna;
coluna+=yyleng;
yylval='-';
return DIF_OP;}

"*" {yycol = coluna;
coluna+=yyleng;
return MULTI_OP;}

"/" {yycol = coluna;
coluna+=yyleng;
return DIV_OP;}

"%" {yycol = coluna;
coluna+=yyleng;
return MOD_OP;}

"<=" {yycol = coluna;
coluna+=yyleng;
return LEQ_OP;}

"<" {yycol = coluna;
coluna+=yyleng;
return LESSER_OP;}

">=" {yycol = coluna;
coluna+=yyleng;
return GEQ_OP;}

">" {yycol = coluna;
coluna+=yyleng;
return GREATER_OP;}

"==" {yycol = coluna;
coluna+=yyleng;
return EQUAL_OP;}

"!=" {yycol = coluna;
coluna+=yyleng;
return DIFF_OP;}

"=" {yycol = coluna;
coluna+=yyleng;
return ASSIGN_OP;}

"&&" {yycol = coluna;
coluna+=yyleng;
return AND_OP;}

"||" {yycol = coluna;
coluna+=yyleng;
return OR_OP;}

"!" {yycol = coluna;
coluna+=yyleng;
return NOT_OP;}

    /* SÍMBOLOS */

";" {yycol = coluna;
coluna+=yyleng;
return SEMICOLON;}

"," {yycol = coluna;
coluna+=yyleng;
return COMMA;}

"." {yycol = coluna;
coluna+=yyleng;
return DOT;}

"(" {yycol = coluna;
coluna+=yyleng;
return LEFT_PARENTHESIS;}

")" {yycol = coluna;
coluna+=yyleng;
return RIGHT_PARENTHESIS;}

   /* REGEX */

{WHITESPACE}+|{newline}|{TAB}+ {coluna+=yyleng;return yytext[0];}
 
{digit}+ {yycol = coluna;
coluna+=yyleng;
yylval = atoi(yytext);
return INT;}

{float} {yycol = coluna;
coluna+=yyleng;
yylval = atof(yytext);
//printf("%s\n", yytext);
return FLOAT;}

{bool} {yycol = coluna;
coluna+=yyleng;
c = yytext[0];
yylval = c;
return BOOL;}

{STR} {yycol = coluna;
coluna+=yyleng;
yylval = yytext[0] - 'a';
return STRING;}

{ID} {yycol = coluna;
coluna+=yyleng;
c = yytext[0];
yylval = c;
return ID;}

<<EOF>> {yycol = coluna;
coluna+=yyleng;
return EOFF;}

%%