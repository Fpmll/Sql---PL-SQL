#include <stdio.h>

int main(){
	
	int valor;
	
	printf("Digite Um Valor: ");
	scanf("%i", &valor);
	
	if (valor == 0){
	 printf("Numero e neutro\n");
	 
	}else if( valor % 2 == 0){
		printf("Numero %i e par\n", valor);
		
	} else {
		printf("Numero %i e impar", valor);
	}
	
	
	
	
	return 0;
}