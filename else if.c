#include <stdio.h>

int main() {
    double salario, novo_salario, reajuste, taxa;
    scanf("%lf", &salario);

    if (salario <= 400.00) {
        taxa = 0.15;
    } else if (salario <= 800.00) {
        taxa = 0.12;
    } else if (salario <= 1200.00) {
        taxa = 0.10;
    } else if (salario <= 2000.00) {
        taxa = 0.07;
    } else {
        taxa = 0.04;
    }

    reajuste = salario * taxa;
    novo_salario = salario + reajuste;

    printf("Novo salario: %.2f\n", novo_salario);
    printf("Reajuste ganho: %.2f\n", reajuste);
    printf("Em percentual: %.0f %%\n", taxa * 100);

    return 0;
}