#include <stdint.h>

int main(){
	
	double salario, vendas,soma;
	char nome[20];
	
	scanf("%s", &nome);
	scanf("%lf", &salario);
	scanf("%lf", &vendas);
	
	soma = (vendas * 0.15) + salario;

	
	printf("TOTAL = R$ %.2lf\n", soma);
	
	return 0;
}