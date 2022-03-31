   /* cs152-calculator */

%{
   int currLine = 1, currPos = 1;
   int numInt = 0;
   int numOper = 0;
   int numParens = 0;
   int numEquals = 0;
%}

DIGIT    [0-9]

%%
"="            {printf("EQUAL\n"); currPos += yyleng; numEquals++;}
"+"            {printf("PLUS\n"); currPos += yyleng; numOper++;}
"-"            {printf("MINUS\n"); currPos += yyleng; numOper++;}
"/"            {printf("DIV\n"); currPos += yyleng; numOper++;}
"*"            {printf("MULT\n"); currPos += yyleng; numOper++;}
"("            {printf("L_PAREN\n"); currPos += yyleng; numParens++;}
")"            {printf("R_PAREN\n"); currPos += yyleng; numParens++;}
{DIGIT}+       {printf("NUMBER %s\n", yytext); currPos += yyleng; numInt++;}

[ \t]+	       {/* ignore spaces */ currPos += yyleng;}

"\n"	       {currLine++; currPos = 1;}

.	       {printf("Error at line %d, column %d: unrecognized symbol \"%s\" \n", currLine, currPos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
   	if(argc >= 2){
		yyin = fopen(argv[1], "r");
		if(yyin == NULL){
			yyin = stdin;
		}	
	}
	else{
		yyin = stdin;
	}
	
	yylex();

	printf("# Integers: %d\n" , numInt);
        printf("# Operators: %d\n", numOper);
	printf("# Parentheses: %d\n", numParens);
	printf("# Equal Signs: %d\n", numEquals);

}

