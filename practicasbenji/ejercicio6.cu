#include <stdio.h>

#define N 100000

__global__ void mostrarHilos()
{
    // Identificador del hilo dentro del bloque (2D)
    int hiloLocal = threadIdx.y * blockDim.x + threadIdx.x;
    int idx=threadIdx.x + blockDim.x*blockIdx.x;
    int idy=threadIdx.y + blockDim.y*blockIdx.y;

    // Identificador del bloque en la grid (2D)
    int bloqueGlobal = blockIdx.y * gridDim.x + blockIdx.x;

    // ID global del hilo
    printf("Hola desde el hilo %d,%d del bloque %d,%d Id en x= %d id en y = %d \n", threadIdx.x,threadIdx.y,blockIdx.x,blockIdx.y, idx,idy);


    if (threadIdx.x==0 && threadIdx.y == 0 && blockIdx.x==0 && blockIdx.y == 0){
        printf("Numero de hilos en total en X: %d \n", blockDim.x * gridDim.x);
        printf("Numero de hilos en total en X: %d \n", blockDim.y * gridDim.y);
        printf("Numero de hilos en total %d \n", blockDim.x * gridDim.x * blockDim.y * gridDim.y);



    }
    
}

int main()
{
    int totalHilos = N;

    // Configuración 2D
    dim3 hilos(3,2);      
    dim3 bloques(5,4);    

    mostrarHilos<<<bloques, hilos>>>();

    cudaDeviceSynchronize();

    return 0;
}