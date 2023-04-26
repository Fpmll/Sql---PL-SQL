#include <stdio.h>

int main() {
    int A;
    scanf("%d", &A);

    char hex[20];
    sprintf(hex, "%X", A);

    printf("%s\n", hex);

    return 0;
}