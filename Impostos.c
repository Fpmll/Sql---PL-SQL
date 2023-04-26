#include <stdio.h>

int main(){
	
	double salario, soma, porcento, valorir, valorirano, VaPagar;
	char nome[30];
	
	printf("Digite seu nome: ");
	scanf("%s", nome);
	
	printf("Digite seu salario anual: ");
	scanf("%lf", &salario);
	
	soma = salario / 12;
	
	
	if (soma <= 1903.98)
		porcento = 0;
	else if (soma <= 2826.65)
		porcento = 7.5;
	else if (soma <= 3751.05)
		porcento = 15;
	else if (soma <= 4664.68)
		porcento = 22.5;
	else if (soma > 4664.68)
		porcento =27.5;
	
	valorir = (soma * ( porcento / 100)) + soma;
	valorirano = valorir * 12;
	VaPagar = valorirano - salario;
	
	       if (porcento == 0){
		printf("%s, e isento de impostos.", nome);
	} else if (porcento > 0 ) {
		printf("%s, deve pagar os seguintes impsotos:\nValor do ir: R$%.2lf\nValor do ir Ano: RS%.2lf\nValor a Pagar: R$%.2lf\n",nome, valorir, valorirano, VaPagar);
		
	} if(VaPagar == 0){
		printf("Parabens voce conseguiu zerar o imposto de renda.\n");
		
	} else if( VaPagar > 0){
		printf("Voce ainda devera pagar o valor de %.2lf de imposto de renda.\n", VaPagar);
		
	} else  if (VaPagar < 0){
		printf("Voce tera restituiçao de %.2lf de imposto de renda", VaPagar);
	}
		
	
	
	
	return 0;
}