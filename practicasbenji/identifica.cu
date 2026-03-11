#include <stdio.h>
#define N 100000

__global__ void hiloLider()
{
    // Identificador global del hilo
    int idGlobal = blockIdx.x * blockDim.x + threadIdx.x;

    // Solo el primer hilo de cada bloque imprime
    if(idGlobal < N && idGlobal > N-100  )
    {
        printf("Soy el hilo lider del bloque %d (ID global: %d)\n",
               blockIdx.x, idGlobal);
    }
}

int main()
{
    int tambloq= 1024;
    int bloques = N/tambloq + 1;

    hiloLider<<<bloques, tambloq>>>();

    cudaDeviceSynchronize();

    return 0;
}