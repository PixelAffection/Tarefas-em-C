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
#define OP_MAIS_ALUGADOS '6'
#define OP_MOSTRAR_EXEMPLARES '7'
#define OP_ALUGAR '8'
#define OP_DEVOLVER '9'

#define OP_SAIR '0'

#define OP_PESQ_ANO '1'
#define OP_PESQ_TITULO '2'

FILE *fp; /*Variável Global pois é útil ao longo do programa*/

typedef struct
{
	int Dia=0;
	int Mes=0;
	int Ano=0;
}DATA;

typedef struct
{
	char CodigoL[4+1];
	char StatusL; //Status do livro 
	DATA DE; // Data de Empréstimo
	DATA DD; // Data de Devolução
}LIVRO;

typedef struct
{
	char Titulo[30+1];
	char Autores[100+1];
	char Assunto[30+1];
	char Editora[30+1];
	int Ano;
	int Edicao;
	int N_Exemplares;  //Quantidade de Exemplares existentes na biblioteca
	int N_Emprestados; //Quantidade de Exemplares Alugados
	int Cont; //Quantas vezes essa obra foi alugada
	int n_registro;
	char StatusO; 	/*		'*' indica que o registro será apagado		*/	
	LIVRO Exemplar[4];
}OBRA;

int dictstrcmp(char *str1, char *str2)					//completo
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

void Copiar_Obra(OBRA *dest, OBRA orig)					//completo
{
	int i=0;
	
	dest->Ano=orig.Ano;
	dest->Cont=orig.Cont;
	dest->Edicao=orig.Edicao;
	dest->N_Emprestados=orig.N_Emprestados;
	dest->N_Exemplares=orig.N_Exemplares;
	dest->StatusO=orig.StatusO;
	
	strcpy(dest->Assunto,orig.Assunto);
	strcpy(dest->Autores,orig.Autores);
	strcpy(dest->Editora,orig.Editora);
	strcpy(dest->Titulo,orig.Titulo);
	
	
	for(i=0;i<4;i++)
	{
	dest->Exemplar[i].DD=orig.Exemplar[i].DD;
	dest->Exemplar[i].DE=orig.Exemplar[i].DE;
	dest->Exemplar[i].StatusL=orig.Exemplar[i].StatusL;
	}
}

void obrasort(OBRA *obras, int nstrings)				//completo
{
int i, j;
int didswap;
OBRA tmp;

do	{
	didswap = 0;
	for(i = 0; i < nstrings - 1; i++)
		{
		j = i + 1;
		if(dictstrcmp(obras[i].Titulo, obras[j].Titulo) > 0)
			{
			Copiar_Obra(&tmp,obras[i]);
			Copiar_Obra(&obras[i],obras[j]);
			Copiar_Obra(&obras[j],tmp);
			didswap=1;
			}
			
		}
	} while(didswap);
}

void Ler_Obra(OBRA *o) 									//completo
{
	int i; int cont_nreg=0;
	printf("Título	: ");gets(o->Titulo);fflush(stdin);
	printf("Autores	: ");gets(o->Autores);fflush(stdin);
	printf("Editora	: ");gets(o->Editora);fflush(stdin);
	printf("Ano	: ");scanf("%d",&o->Ano);fflush(stdin);
	printf("Edição	: ");scanf("%d",&o->Edicao);fflush(stdin);
	printf("Assunto	: ");gets(o->Assunto);fflush(stdin);
	printf("Quantidade de exemplares na biblioteca (0,1,2,3 ou 4)	: ");scanf("%d",&o->N_Exemplares);fflush(stdin);
	
	for(i=0;i<(o->N_Exemplares);i++)
	{
		if(i>4)
		{
			puts("\n\nquantidade de livros excessiva, ajustamos a quantidade para 4\n\n");
			o->N_Exemplares=4;
			break;
		};
		o->Exemplar[i].StatusL='E';
		
	}
	
	while(i<4)
	{
		o->Exemplar[i].StatusL='I';
		i++;
	}
	
	o->N_Emprestados=0;
	o->Cont=0;
	
	o->StatusO=' ';
	fflush(stdin);
//	fp=&cont_nreg++;
//	fwrite(fp,sizeof(int),1,ARQ);
}

void Mensagem(char *msg)								//completo
{
	printf(msg);
	getchar();
}

void Adicionar_Obra (OBRA o) 							//completo
{
	fseek(fp,0L, SEEK_END);
	if(fwrite(&o,sizeof(o),1,fp)!=1)
		Mensagem("adicionar Pessoa: Falhou a escrita do registro");
}

void Inserir_Obra()  									//completo
{//Adiciona uma pessoa ao arquivo
	OBRA o;
	Ler_Obra(&o);
	Adicionar_Obra(o);
	Mensagem("Livro adicionado com sucesso");
 }

void Mostrar_Obra(OBRA o)								//completo
{
	puts("\n\n");
	printf("Número de Registro:%d  \n\n",o.n_registro+1);
	printf("Título:%s  \n\n",o.Titulo);
	printf("Autores:%s  \n\n",o.Autores);
	printf("Editora:%s  \n\n",o.Editora);
	printf("Ano:%d  \n\n",o.Ano);
	printf("Edição:%d  \n\n",o.Edicao);
	printf("Assunto:%s  \n\n",o.Assunto);
	printf("Quantidade de Exemplares existentes na biblioteca:%d  \n\n",o.N_Exemplares);
	printf("Quantidade de Exemplares Alugados:%d  \n\n",o.N_Emprestados);
	printf("Quantas vezes essa obra foi alugada:%d  \n\n",o.Cont);
	
}

void Inic()												//completo
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

void Listar()											//completo
{
	int j, k;
	long int N_Linhas=0;
	OBRA reg;
	rewind(fp);
	while(1)
	{
		if (fread(&reg,sizeof(reg),1,fp)!=1)break; /*Sair do Laço*/
		
		
		if (reg.StatusO=='*')continue; /*Passa ao próximo registro*/
		
		Mostrar_Obra(reg);
		
			for(j=0;j<1; j++){
				for(k=0;k<100; k++){
					printf("*"); 
				}
			}
			printf("\n\n");
			
		N_Linhas++;
		
		if(N_Linhas%20==0)
		Mensagem("PESSIONE <ENTER> para continuar	.	.	. ");
	 }
	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/ 
 }

void Alterar_Obra()										//completo
{
	OBRA x;
	long int n_reg;
	printf("Qual o Nº do Registro: ");
	scanf("%ld", &n_reg);fflush(stdin);
	if(fseek(fp, (n_reg-1)*sizeof(OBRA),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");
		return;	
			
		}
	if(fread(&x,sizeof(OBRA),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");
		return;
	}
	if(x.StatusO=='*')
	{
		Mensagem("Um Registro Apagado não pode ser alterado!!!\n\n");
		return;
	}
		
	printf("\n\nDados Atuais\n\n");
	Mostrar_Obra(x);
	printf("\n\nNovos Dados\n\n");
	Ler_Obra(&x);
	
	//Recuar um Registro no Arquivo
	fseek(fp,-(long) sizeof(OBRA),SEEK_CUR);
	//Reescrever o Registro;
	fwrite(&x,sizeof(OBRA),1,fp);
	fflush(fp); /*Despejar os Dados no Disco Rígido*/	
 }

void Apagar_Obra()										//completo
{
	OBRA x;
	long int n_reg;
	char resp;
	
	printf("Qual o Nº do Registro:");
	scanf("%ld", &n_reg);fflush(stdin);
	
	if(fseek(fp, (n_reg-1)*sizeof(OBRA),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");
		return;	
			
		}
	if(fread(&x,sizeof(OBRA),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");
		return;
	}
	if(x.StatusO=='*')
	{
		Mensagem("O registro já está apagado!!!\n\n");
		return;
	}
	
	printf("\n\nDados Atuais\n\n");
	Mostrar_Obra(x);
	
	printf("\n\nApagar o Registro (s/n)???: "); resp=getchar(); fflush(stdin);
	if (toupper(resp)!='S') return;
	
	x.StatusO='*';
		//Recuar um Registro no Arquivo
	fseek(fp,-(long) sizeof(OBRA),SEEK_CUR);
	//Reescrever o Registro;
	fwrite(&x,sizeof(OBRA),1,fp);
	fflush(fp); /*Despejar os Dados no Disco Rígido*/	
	
 }

int Reescrever()				  					    //completo
{
	int i=0,j=0;
	OBRA obra_aux;
	OBRA v[10];
	OBRA w[10];
	rewind(fp);
	while(1)
	{
		if (fread(&obra_aux,sizeof(OBRA),1,fp)!=1)
		{
		printf("Término do processo de transferência do arquivo para RAM na %d-ésima tentativa",i);	
		break;
		}
		if(obra_aux.StatusO!='*')
		{
			//Recuar um Registro no Arquivo
			fseek(fp,-(long) sizeof(OBRA),SEEK_CUR);
	
			if(fread(&v[j],sizeof(OBRA),1,fp)!=1)
			{
				printf("Erro no processo de reescrever na %d-ésima tentativa",i);
			}
			printf("%d-ésimo elemento do vetor RAM adicionado com sucesso\n\n",j);
			j++;
		}
		i++;
	}
	
	
	for(i=0;i<j;i++)
	Mostrar_Obra(v[i]);
		
	printf("\n\n\nTÉRMINO DA MOSTRA DE OBRAS\n\n\n");
		obrasort(v,j);
		
		
	for(i=0;i<j;i++)
	{
	v[i].n_registro=i;
	Mostrar_Obra(v[i]);	
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
		fwrite(&v[i],sizeof(OBRA),1,fp);
	}
	
	fflush(fp);
	return (j);
}

void Pesquisar_Titulo(char *s)			  			    //completo
{

	OBRA reg;
	rewind(fp);
	
	while(fread(&reg,sizeof(OBRA),1,fp))
	if(reg.StatusO!='*'&&strstr(reg.Titulo,s))
		Mostrar_Obra(reg);
		
	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/	
 }

void Pesquisar_Ano (int ini, int fim) 				    //completo
{
	OBRA reg;
	rewind(fp);
	
	while(fread(&reg,sizeof(OBRA),1,fp))
	if(reg.StatusO!='*' && reg.Ano>=ini && reg.Ano<=fim)
		Mostrar_Obra(reg);
	
	Mensagem("PESSIONE <ENTER> para continuar	.	.	. "); /*No fim da Listagem*/		
 }

void Mostrar_Exemplares()  			    			    //completo
{
	
	OBRA x;
	long int n_reg;
	printf("Qual o Nº do Registro: ");
	scanf("%ld", &n_reg);fflush(stdin);
	if(fseek(fp, (n_reg-1)*sizeof(OBRA),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");
		return;	
			
		}
	if(fread(&x,sizeof(OBRA),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");
		return;
	}
	if(x.StatusO=='*')
	{
		Mensagem("Um Registro Apagado não pode ser lido!!!\n\n");
		return;
	}
		
	printf("\n\nDados Atuais\n\n");
	Mostrar_Obra(x);
	
	printf("\n\nDados dos exemplares:\n\n");
	
	int i;
	for(i=0;i<4;i++)
	{
		
			printf("Exemplar %d: Status: %c ; Data de empréstimo:%d/%d/%d ; Data de devolução:%d/%d/%d\n\n",i+1,x.Exemplar[i].StatusL,
																											x.Exemplar[i].DE.Dia,
																											x.Exemplar[i].DE.Mes,
																											x.Exemplar[i].DE.Ano,
																											x.Exemplar[i].DD.Dia,
																											x.Exemplar[i].DD.Mes,
																											x.Exemplar[i].DD.Ano);
	}
	
	puts("Aperte qualquer tecla para voltar ao menu principal");
	getchar();
	
	
  } 

void Alugar_livro()               				        //completo
{
	OBRA reg;
	char resp;
	long int n_reg;
	printf("Qual o Nº do Registro: ");
	scanf("%ld", &n_reg);fflush(stdin);
	if(fseek(fp, (n_reg-1)*sizeof(OBRA),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");return;	
		}
	if(fread(&reg,sizeof(OBRA),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");return;
	}
	if(reg.StatusO=='*')
	{
		Mensagem("Um Registro Apagado não pode ser alugado!!!\n\n");return;
	}
		
	printf("\n\nDados Atuais\n\n");
	Mostrar_Obra(reg);
	printf("\n\nDados dos exemplares:\n\n");
	
	int i;
	for(i=0;i<4;i++)
	{
		
		printf("Exemplar %d: Status: %c ; Data de empréstimo:%d/%d/%d ; Data de devolução:%d/%d/%d\n\n",i+1,  reg.Exemplar[i].StatusL,
																						reg.Exemplar[i].DE.Dia,
																						reg.Exemplar[i].DE.Mes,
																						reg.Exemplar[i].DE.Ano,
																						reg.Exemplar[i].DD.Dia,
																						reg.Exemplar[i].DD.Mes,
																						reg.Exemplar[i].DD.Ano);
	 }
	 printf("Deseja alugar esse livro?<s/n> ");resp=getchar();
       if (toupper(resp)=='S')
       {
		 printf("Qual exemplar?");
		 scanf("%d",&i);
		 i--;
		 if(i<4)
		 {
			if((reg.Exemplar[i].StatusL)=='I')
				printf("Exemplar não existente\n");
			
			else if((reg.Exemplar[i].StatusL)=='A')
				printf("Exemplar não disponivel\n");
			
			else if((reg.Exemplar[i].StatusL)=='E') //alugando o livro
			{
				printf("Data de Empréstimo:\n");
				printf("Dia: ");scanf("%d",&reg.Exemplar[i].DE.Dia);
				printf("Mês: ");scanf("%d",&reg.Exemplar[i].DE.Mes);
				printf("Ano: ");scanf("%d",&reg.Exemplar[i].DE.Ano);
				reg.Exemplar[i].StatusL='A';
				reg.Exemplar[i].DD.Dia=reg.Exemplar[i].DE.Dia+7;//dia que alugou + 7 dias = dia de devolução 
				if(reg.Exemplar[i].DD.Dia>31) //se passar do dia 31 passa pro proximo mes
				{
					reg.Exemplar[i].DD.Dia=reg.Exemplar[i].DD.Dia-31;
					reg.Exemplar[i].DD.Mes=reg.Exemplar[i].DE.Mes+1;
				}
				else
				reg.Exemplar[i].DD.Mes=reg.Exemplar[i].DE.Mes;
				reg.Exemplar[i].DD.Ano=reg.Exemplar[i].DE.Ano;
				printf("\n\nData de Devolução: %d/%d/%d \n\n",reg.Exemplar[i].DD.Dia,reg.Exemplar[i].DD.Mes,reg.Exemplar[i].DD.Ano);
				reg.Cont=reg.Cont+1;
				reg.N_Emprestados=reg.N_Emprestados+1;
				fseek(fp,-(long) sizeof(OBRA),SEEK_CUR);		//Reescrever o Registro;
				fwrite(&reg,sizeof(OBRA),1,fp);fflush(fp); /*despejar dados no arquivo*/		/*Despejar os Dados no Disco Rígido*/
				printf("Livro alugado com sucesso\n");
				}
			}
	   }
	fflush(stdin);
	Mensagem("Aperte qualquer tecla para voltar ao menu principal");
	system("cls");

}

void Devolver_livro()								    //completo
{
	OBRA reg;
	char resp;
	long int n_reg;
	printf("Qual o Nº do Registro: ");
	scanf("%ld", &n_reg);fflush(stdin);
	if(fseek(fp, (n_reg-1)*sizeof(OBRA),SEEK_SET)!=0)
		{
		Mensagem("Registro Inexistente ou Problemas no Posicionamento!!!");return;	
		}
	if(fread(&reg,sizeof(OBRA),1,fp)!=1)
	{
		Mensagem("Problemas na leitura do Registro!!!");return;
	}
	if(reg.StatusO=='*')
	{
		Mensagem("Um Registro Apagado não pode ser alugado!!!\n\n");return;
	}
		
	printf("\n\nDados Atuais\n\n");
	Mostrar_Obra(reg);
	printf("\n\nDados dos exemplares:\n\n");
	
	int i;
	for(i=0;i<4;i++)
	{
		
		printf("Exemplar %d: Status: %c ; Data de empréstimo:%d/%d/%d ; Data de devolução:%d/%d/%d\n\n",i+1,  reg.Exemplar[i].StatusL,
																						reg.Exemplar[i].DE.Dia,
																						reg.Exemplar[i].DE.Mes,
																						reg.Exemplar[i].DE.Ano,
																						reg.Exemplar[i].DD.Dia,
																						reg.Exemplar[i].DD.Mes,
																						reg.Exemplar[i].DD.Ano);
	 }
	 printf("Deseja devolver esse livro?<s/n> ");resp=getchar();
       if (toupper(resp)=='S')
       {
		 printf("Qual exemplar?");
		 scanf("%d",&i);
		 i--;
		 if(i<4)
		 {
			if((reg.Exemplar[i].StatusL)=='I')
				printf("Exemplar não existente\n");
			
			else if((reg.Exemplar[i].StatusL)=='E')
				printf("Exemplar ja esta na biblioteca\n");
			
			else if((reg.Exemplar[i].StatusL)=='A') //devolvendo o livro
			{
				reg.Exemplar[i].StatusL='E';
				reg.N_Emprestados=reg.N_Emprestados-1;
				reg.Exemplar[i].DD.Dia=0;
				reg.Exemplar[i].DD.Mes=0;
				reg.Exemplar[i].DD.Ano=0;
				reg.Exemplar[i].DE.Dia=0;
				reg.Exemplar[i].DE.Mes=0;
				reg.Exemplar[i].DE.Ano=0;
				fseek(fp,-(long) sizeof(OBRA),SEEK_CUR);		//Reescrever o Registro;
				fwrite(&reg,sizeof(OBRA),1,fp);fflush(fp); /*despejar dados no arquivo*/		/*Despejar os Dados no Disco Rígido*/
				printf("Livro retornado com sucesso\n");
				}
			}
	   }
	fflush(stdin);
	Mensagem("Aperte qualquer tecla para voltar ao menu principal");
	system("cls");
}

void Mais_Alugados()			/*em manutencao*/
{
	int i=0,j=0,a;
	int didswap;
	OBRA tmp;
	OBRA v[10];
	OBRA w[10];
	rewind(fp);
	while(1)
	{
		if (fread(&tmp,sizeof(OBRA),1,fp)!=1)
		{
		printf("Término do processo de transferência do arquivo para RAM na %d-ésima tentativa",i);	
		break;
		}
		if(tmp.StatusO!='*')
		{
			//Recuar um Registro no Arquivo
			fseek(fp,-(long) sizeof(OBRA),SEEK_CUR);
	
			if(fread(&v[j],sizeof(OBRA),1,fp)!=1)
			{
				printf("Erro no processo de reescrever na %d-ésima tentativa",i);
			}
			printf("%d-ésimo elemento do vetor RAM adicionado com sucesso\n\n",j);
			j++;
		}
		i++;
	}
	system("cls");
		printf("\n\n\n**********MAIS ALUGADOS**********\n\n\n");
do	{
	didswap = 0;
	for(i = 0; i < j - 1; i++)
		{
		a = i + 1;
		if(v[i].Cont < v[a].Cont)
			{
				Copiar_Obra(&tmp,v[i]);
				Copiar_Obra(&v[i],v[a]);
				Copiar_Obra(&v[a],tmp);
				didswap=1;
			}
			
		}
	} while(didswap);
	
	for(i=0;i<j;i++)
		Mostrar_Obra(v[i]);
		
	printf("\n\n\nTÉRMINO DA MOSTRA DE OBRAS\n\n\n");
	system("pause");
	
}

char *MainMenu[]=										//completo
{
	"1. Inserir Livro",
	"2. Alterar Livro",
	"3. Apagar Livro",
	"4. Listar Livros na biblioteca",
	"5. Pesquisas",
	"6. Listar livros mais alugados",
	"7. Listar os exemplares de um livro",
	"8. Alugar um livro",
	"9. Devolver um livro",
	"0. Sair",
	NULL	/* Acabaram as opções*/
};

char *PesqMenu[]= 										//completo
{
	"1. Pesquisar por Intervalo  de Ano de Lançamento",
	"2. Pesquisar por Título",
	"0. Voltar",
	NULL	/* Acabaram as opções*/ 	
};

char Menu(char *Opcoes[])								//completo
{
	int i;
	char ch;
	
	while(1)
	{  
		system("cls");
		for(i=0;Opcoes[i]!=NULL; i++)
		printf("\t\t%s\n\n",Opcoes[i]);
		
	printf("\n\n\tOpção: ");
	ch=getchar(); fflush(stdin);
	for(i=0; Opcoes[i]!=NULL; i++)
	if(Opcoes[i][0]==ch)
		return ch;
	 }
 }

int main()      			                       		//função principal
{	
	
	setlocale(LC_ALL, "Portuguese");
	char Opcao;
	system("color 0b");
	Inic();
	Reescrever();
	while((Opcao=Menu(MainMenu))!=OP_SAIR)
		switch(Opcao)
		{
			case OP_INSERIR: printf("Adicionar livro selecionado\n\n");
							 Inserir_Obra();break;
			case OP_ALTERAR: printf("Alterar obra selecionado\n\n");
						 Alterar_Obra();break;
			case OP_APAGAR:  printf("Apagar obra selecionado\n\n");
							 Apagar_Obra(); break;
			case OP_LISTAR:  printf("Listar selecionado\n\n");
							 Listar(); break;
			case OP_MAIS_ALUGADOS: printf("Mais Alugados selecionado\n\n");
							 
							 Mais_Alugados(); break;
			case OP_MOSTRAR_EXEMPLARES: printf("Mostrar exemplares livro selecionado\n\n");
							 Mostrar_Exemplares();break;
			case OP_ALUGAR:  printf("Alugar livro selecionado\n\n");
							 Alugar_livro();break;
			case OP_DEVOLVER: printf("Devolver livro selecionado\n\n");
							 Devolver_livro();break;
			case OP_PESQUISAR:
				while((Opcao=Menu(PesqMenu))!=OP_SAIR)
				switch(Opcao)
				{
					case OP_PESQ_ANO:
						{
							int n1,n2;
							printf("Qual o intervalo de anos de lançamento: ");
							scanf("%d%d",&n1,&n2);fflush(stdin);
							Pesquisar_Ano(n1,n2);
							break; 
						}
					case OP_PESQ_TITULO:
						{
							char string[BUFSIZ+1];
							printf("Qual o título do livro a Procurar: ");
							gets(string);fflush(stdin);
							Pesquisar_Titulo(string);
						}
				 }
		 }
 }


//Referências:

/*

"Gest.c", código resposta da questão 1 do capítulo 11 do livro "Linguagem C"(pág. 387-pág. 391) do autor Luis Damas, por Luis Damas. 
Foi utilizado como base da manipulação de arquivos e structs durante o código, assim como usado para definir o esboço do padrão
de identação utilizado.

"http://www.eskimo.com/~scs/cclass/int/sx10b.html", "C programming class notes - 24.2 What are Function Pointers Good For?". 
Foi utilizado como base para o algoritmo da função de ordenção dos registros.


*/
