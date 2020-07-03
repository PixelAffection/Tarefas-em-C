#include<stdio.h>
#include<string.h>

typedef struct
{
char nome[20];
char senha[20];

}REGISTRO;

login(char *n ,char *s)
{
	int i=0;
	FILE *fp;
	REGISTRO x[20];
	fp=fopen("arq_login.bin","a+b");
	while(1)
	{	
	if(fread(&x[i],sizeof(REGISTRO),1,fp)!=1)
	break;
	
	if(strcmp(n,x[i].nome)==0)
		{
			
			if(strcmp(s,x[i].senha)==0)
				printf("Logado com sucesso.");
			else
			printf("Senha incorreta");
		}
		else
		{
		
		printf("Nome nao encontrado.");
		
		}
       i++;
 }
 }

 
 
registrar(char *n ,char *s)
{
	FILE *fp;
	REGISTRO x;
	strcpy(x.nome,n);
	strcpy(x.senha,s);
	if((fp=fopen("arq_login.bin","a+b"))==NULL)
		printf("Arquivo nao abriu");
	else	
	{

	if(fwrite(&x,sizeof(REGISTRO),1,fp)==1)
	{
	
	printf("registrado com sucesso");
}}
	
	
	
	
	
}




main()
{
	FILE fp; int a;
	char nome[20], senha[20];
	printf("Voce ja possui registro?\n");
	printf("1	Sim\n");
	printf("2	Nao\n");
	scanf("%d",&a);
	switch(a)
		{
			case 1:
				
				printf("Digite seu nome:\n");
				scanf("%s",&nome);
				printf("Digite sua senha:\n");
				scanf("%s",&senha);
				login(nome,senha);
				break;	
			case 2:
				
				
				printf("Crie seu nome:\n");
				scanf("%s",&nome);
				fflush(stdin);
				
				printf("Crie sua senha:\n");
				scanf("%s",&senha);
				registrar(nome,senha);
				break;
				
				
				
				
	
			
			
		}	}
	
	
