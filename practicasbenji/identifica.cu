#include <stdio.h>

#define TOTAL_HILOS 100000

__global__ void funcion()
{
    // Cálculo del identificador global
    int idGlobal = blockIdx.x * blockDim.x + threadIdx.x;

    // Solo un hilo específico imprime
    if(idGlobal == TOTAL_HILOS - 1)
    {
        printf("Hola, soy el hilo especifico con ID global: %d\n", idGlobal);
    }
}

int main()
{
    int hilosPorBloque = 1024;
    int bloques = TOTAL_HILOS / hilosPorBloque + 1;

    funcion<<<bloques, hilosPorBloque>>>();

    cudaDeviceSynchronize();

    return 0;
}