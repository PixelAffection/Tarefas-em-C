#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <stdlib.h> /* Função exit*/
#include <ctype.h> /* Função toupper*/
#include <locale.h>

#define ARQ "Dados.Dat" /* Arquivo com os dados*/

#define OP_INSERIR '1'
#define OP_ALTERAR '2'
#define OP_APAGAR  '3'
#define OP_LISTAR '4'
#define OP_PESQUISAR '5'

#define OP_SAIR '0'

#define OP_PESQ_AREA '1'
#define OP_PESQ_PRECOS '2'
#define OP_PESQ_BAIRRO '3'
#define OP_PESQ_CASA '4'
#define OP_PESQ_APTO '5'

char *MainMenu[]={
	"1. Inserir Imóvel",
	"2. Alterar Imóvel",
	"3. Apagar Imóvel",
	"4. Listar Imóvels",
	"5. Pesquisas",
	"0. Sair",
	NULL	/* Acabaram as opções*/
};

char *PesqMenu[]={
	
	//
	
	"1. Listar por Intervalo de Área", 
	"2. Listar por Intervalo  de Preço",
	"3. Listar por Bairro",
	"4. Listar Casas",
	"5. Listar Apartamentos",
	"0. Voltar",
	NULL	/* Acabaram as opções*/ 	
};


FILE *fp; /*Variável Global pois é útil ao longo do programa*/


typedef struct
{
	int n_registro=0;
	char Identificacao[4+1];
	char Bairro[30+1];
	char Endereco[30+1];
	int n_quartos;
	float Area;
	float Aluguel;
	char Status; 	/*		'*' indica que o registro será apagado		*/
}IMOVEL;

void Mostrar_Imovel(IMOVEL i)
{
	puts("\n\n");
	printf("Número de Registro:%d  \n\n",i.n_registro+1);
	printf("Identificação (Casa ou Apto.):%s	\n\n",i.Identificacao);
	printf("Bairro:%s	\n\n",i.Bairro);
	printf("Endereço:%s	\n\n",i.Endereco);
	printf("Número de Quartos:%d	\n\n",i.n_quartos);
	printf("Área total:%.2f	\n\n",i.Area);
	printf("Aluguel:%.2f	\n\n",i.Aluguel);
}


int dictstrcmp(char *str1, char *str2)
{
while(1)
	{
	char c1 = *str1++;
	char c2 = *str2++;

	if(isupper(c1))
		c1 = tolower(c1);

	if(isupper(c2))
		c2 = tolower(c2);

	if(c1 != c2)
		return c1 - c2;
	if(c1 == '\0')
		return 0;
	}
}

void Copiar_Imovel(IMOVEL *dest, IMOVEL orig)
{	
	dest->n_quartos=orig.n_quartos;
	dest->Aluguel = orig.Aluguel ;
	dest->Area = orig.Area ;
	dest->Status = orig.Status ;
	
	strcpy(dest->Bairro,orig.Bairro);
	strcpy(dest->Endereco,orig.Endereco);
	strcpy(dest->Identificacao,orig.Identificacao);

}

void imovelsort(IMOVEL *imoveis, int nstrings)
{
int i, j;
int didswap;
IMOVEL tmp;

do	{
	didswap = 0;
	for(i = 0; i < nstrings - 1; i++)
		{
		j = i + 1;
		if(dictstrcmp(imoveis[i].Endereco, imoveis[j].Endereco) > 0)
			{
			Copiar_Imovel(&tmp,imoveis[i]);
			Copiar_Imovel(&imoveis[i],imoveis[j]);
			Copiar_Imovel(&imoveis[j],tmp);
			didswap=1;
			}
			
		}
	} while(didswap);
}


void Reescrever()
{
	int i=0,j=0;
	IMOVEL imovel_aux;
	IMOVEL v[10];
	IMOVEL w[10];
	rewind(fp);
	while(1)
	{
		if (fread(&imovel_aux,sizeof(IMOVEL),1,fp)!=1)
		{
		//printf("Término do processo de transferência do arquivo para RAM na %d-ésima tentativa",i);	
		break;
		}
		if(imovel_aux.Status!='*')
		{
			//Recuar um Registro no Arquivo
			fseek(fp,-(long) sizeof(IMOVEL),SEEK_CUR);
	
			if(fread(&v[j],sizeof(IMOVEL),1,fp)!=1)
			{
		//		printf("Erro no processo de reescrever na %d-ésima tentativa",i);
			}
		//	printf("%d-ésimo elemento do vetor RAM adicionado com sucesso\n\n",j);
			j++;
		}
		i++;
	}
	
/*	
	for(i=0;i<j;i++)
	Mostrar_Imovel(v[i]);
		
	printf("\n\n\nTÉRMINO DA MOSTRA DE IMOVELS\n\n\n");
	
*/
		imovelsort(v,j);
		
		

	for(i=0;i<j;i++)
	{
	v[i].n_registro=i;
//	Mostrar_Imovel(v[i]);	
	}

	
	
	
	fclose(fp);
	
	fp=fopen(ARQ,"w+b");
		if(fp==NULL)
		{
			fprintf(stderr,"ERRO FATAL: Impossível Criar Arquivo de Dados\n");
			exit(1);
		}
		
	for(i=0;i<j;i++)
	{
		fwrite(&v[i],sizeof(IMOVEL),1,fp);
	}
	
	fflush(fp);	
}



void Mensagem(char *msg);


void Ler_Imovel(IMOVEL *i)
{
	int op;
	
	printf("É uma Casa ou um Apartamento?\n\n");
	puts("Digite 1 para Casa\n\n");
	puts("Digite 2 para Apartamento\n\n");
	scanf("%d",&op);
	
	switch(op)
	{
		case 1: strcpy(i->Identificacao,"CASA");break;
		case 2: strcpy(i->Identificacao,"APTO");break;
		default: puts("Opção inválida: Tente novamente, digitando 1 ou 2."); return;
	}
	printf("Número de quartos	: ");scanf("%d",&i->n_quartos);fflush(stdin);
	printf("Área total	: ");scanf("%f",&i->Area);fflush(stdin);
	printf("Bairro	: ");gets(i->Bairro);fflush(stdin);
	printf("Endereço	: ");gets(i->Endereco);fflush(stdin);
	printf("Preço do Aluguel	:");scanf("%f",&i->Aluguel);fflush(stdin);
	i->Status=' ';
	fflush(stdin);
}



void Adicionar_Imovel (IMOVEL i)
{
	fseek(fp,0L, SEEK_END);
	if(fwrite(&i,sizeof(i),1,fp)!=1)
		Mensagem("adicionar Pessoa: Falhou a escrita do registro");
}

void Mensagem(char *msg)
{
	printf(msg);
	getchar();
}

void Inic()
{
	fp=fopen(ARQ,"r+b"); /*Tentar Abrir*/
	if(fp==NULL)
	{
		fp=fopen(ARQ,"w+b");
		if(fp==NULL)
		{
			fprintf(stderr,"ERRO FATAL: Impossível Criar Arquivo de Dados\n");
			exit(1);
		}
	}
}

char Menu(char *Opcoes[])
 {
 	int i;
 	char ch;
 	
 	while(1)
 	{  /*Cls*/
 		printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
 		for(i=0;Opcoes[i]!=NULL; i++)
 		printf("\t\t%s\n\n",Opcoes[i]);
 		
 	printf("\n\n\tOpção: ");
 	ch=getchar(); fflush(stdin);
 	for(i=0; Opcoes[i]!=NULL; i++)
 	if(Opcoes[i][0]==ch)
 		return ch;
	 }
 }

void Inserir_Imovel()
 {
 	IMOVEL x;
 	Ler_Imovel(&x);
 	Adicionar_Imovel(x);
 }

void Alterar_Imovel()
 {
 	IMOVEL x;
 	long int n_reg;
	printf("Qual o Nº do Registro: ");
	scanf("%ld", &n_reg);fflush(stdin);
	if(fseek(fp, (n_reg-1)*sizeof(IMOVEL),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");
		return;	
			
		}
	if(fread(&x,sizeof(IMOVEL),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");
		return;
	}
	if(x.Status=='*')
	{
		Mensagem("Um Registro Apagado não pode ser alterado!!!\n\n");
		return;
	}
		
	printf("\n\nDados Atuais\n\n");
	Mostrar_Imovel(x);
	printf("\n\nNovos Dados\n\n");
	Ler_Imovel(&x);
	
	//Recuar um Registro no Arquivo
	fseek(fp,-(long) sizeof(IMOVEL),SEEK_CUR);
	//Reescrever o Registro;
	fwrite(&x,sizeof(IMOVEL),1,fp);
	fflush(fp); /*Despejar os Dados no Disco Rígido*/	 
 }

 void Apagar_Imovel()
 {
 	IMOVEL x;
 	long int n_reg;
 	char resp;
 	
 	printf("Qual o Nº do Registro:");
 	scanf("%ld", &n_reg);fflush(stdin);
 	
 	if(fseek(fp, (n_reg-1)*sizeof(IMOVEL),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");
		return;	
			
		}
	if(fread(&x,sizeof(IMOVEL),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");
		return;
	}
	if(x.Status=='*')
	{
		Mensagem("O registro já está apagado!!!\n\n");
		return;
	}
	
	printf("\n\nDados Atuais\n\n");
	Mostrar_Imovel(x);
	
	printf("\n\nApagar o Registro (s/n)???: "); resp=getchar(); fflush(stdin);
	if (toupper(resp)!='S') return;
	
	x.Status='*';
		//Recuar um Registro no Arquivo
	fseek(fp,-(long) sizeof(IMOVEL),SEEK_CUR);
	//Reescrever o Registro;
	fwrite(&x,sizeof(IMOVEL),1,fp);
	fflush(fp); /*Despejar os Dados no Disco Rígido*/	
	
 }

 void Listar()
 {
 	long int N_Linhas=0;
 	IMOVEL reg;
 	rewind(fp);
 	while(1)
 	{
 		if (fread(&reg,sizeof(reg),1,fp)!=1)break; /*Sair do Laço*/
 		if (reg.Status=='*')continue; /*Passa ao próximo registro*/
 		Mostrar_Imovel(reg);
 		N_Linhas++;
 		if(N_Linhas%20==0)
 		Mensagem("PESSIONE <ENTER> para continuar	.	.	. ");
	 }
	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/ 
 }

void Pesquisar_Area (float ini, float fim)
{
	IMOVEL reg;
	rewind(fp);
	
	while(fread(&reg,sizeof(IMOVEL),1,fp))
	if(reg.Status!='*' && reg.Area>=ini && reg.Area<=fim)
		Mostrar_Imovel(reg);
	
	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/		
 } 

 void Pesquisar_Preco (float ini, float fim)
{
	IMOVEL reg;
	rewind(fp);
	
	while(fread(&reg,sizeof(IMOVEL),1,fp))
	if(reg.Status!='*' && reg.Aluguel>=ini && reg.Aluguel<=fim)
		Mostrar_Imovel(reg);
	
	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/		
 } 
 
  void Pesquisar_Bairro(char *s)
 {
 	IMOVEL reg;
 	rewind(fp);
 	
 	while(fread(&reg,sizeof(IMOVEL),1,fp))
 	if(reg.Status!='*'&&strstr(reg.Bairro,s))
 		Mostrar_Imovel(reg);
 		
 	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/	
 }
 
void Pesquisar_Casa()
{
	IMOVEL reg;
 	rewind(fp);
 	
 	while(fread(&reg,sizeof(IMOVEL),1,fp))
 	if(reg.Status!='*'&&(strcmp(reg.Identificacao,"CASA")==0))
 		Mostrar_Imovel(reg);
 		
 	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/	
}

void Pesquisar_Apto()
{
	IMOVEL reg;
 	rewind(fp);
 	
 	while(fread(&reg,sizeof(IMOVEL),1,fp))
 	if(reg.Status!='*'&&(strcmp(reg.Identificacao,"APTO")==0))
 		Mostrar_Imovel(reg);
 		
 	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/	
}

int main()
 {
 	
 	setlocale(LC_ALL, "Portuguese");
 	char Opcao;
 	Inic();
 	Reescrever();
 	while((Opcao=Menu(MainMenu))!=OP_SAIR)
 		switch(Opcao)
 		{
 			
			case OP_INSERIR: Inserir_Imovel();break;
 			case OP_ALTERAR: Alterar_Imovel();break;
 			case OP_APAGAR:  Apagar_Imovel(); break;
 			case OP_LISTAR:  Listar(); break;
 			case OP_PESQUISAR:
 				while((Opcao=Menu(PesqMenu))!=OP_SAIR)
 				switch(Opcao)
 				{
 					case OP_PESQ_AREA:
 						{
 							int n1,n2;
 							printf("Qual o intervalo áreas totais desejado?\n\n\n");
 							scanf("%d%d",&n1,&n2);fflush(stdin);
 							Pesquisar_Area(n1,n2);
 							break; 
					 	}
					 	
						case OP_PESQ_PRECOS:
 						{
 							int n1,n2;
 							printf("Qual o intervalo de preços desejado?\n\n\n");
 							scanf("%d%d",&n1,&n2);fflush(stdin);
 							Pesquisar_Preco(n1,n2);
 							break; 
					 	}
						 	
					case OP_PESQ_BAIRRO:
						{
							char string[BUFSIZ+1];
							printf("Qual o nome do Bairro a ser pesquisado?\n\n\n");
							gets(string);fflush(stdin);
							Pesquisar_Bairro(string);
							break;
						}
						
					case OP_PESQ_CASA:
						{
							puts("Segue a lista de Casas\n\n\n");
							Pesquisar_Casa();
							break;
						}
						
					case OP_PESQ_APTO:
						{
						}
						puts("Segue a lista de Apartamentos\n\n\n");
						Pesquisar_Apto();
						break;
						
						}
				 }
		 } 
		 
		 
//Referências:

/*

"Gest.c", código resposta da questão 1 do capítulo 11 do livro "Linguagem C"(pág. 387-pág. 391) do autor Luis Damas, por Luis Damas. 

Foi utilizado como base da manipulação de arquivos e structs durante o código.
"http://www.eskimo.com/~scs/cclass/int/sx10b.html", "C programming class notes - 24.2 What are Function Pointers Good For?". 
Foi utilizado como base para o algoritmo da função de ordenção dos registros.

"Reescrever()".
 função nova, feita especialmente para ordenar registros alfabeticamente, elaborada pelo colega Vinícius Menezes Monte. 
 Pediu-se ajuda porque ela é muito complicada, graças à utilização de vetores de registros, ordenamento e reescrevimento de arquivo, 
 e exigiu a escrita de várias outras funções totalizando mais de 100 linhas

*/
