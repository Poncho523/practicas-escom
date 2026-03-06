#include <stdio.h>

// Kernel: función que se ejecuta en el device (GPU)
__global__ void holaDesdeDevice()
{
  
    
   printf("Jhon Donne\n", bloque, hilo);
}

int main()
{
    holaDesdeDevice<<<3, 10>>>();
    // Mensaje desde el host (CPU)
    printf("Nunca hagas preguntar por quien doblan las campanas; doblan por ti \n");

    // Lanzamiento del kernel
    // <<<numero_de_bloques, numero_de_hilos_por_bloque>>>

    // Esperamos a que la GPU termine
    cudaDeviceSynchronize();

    return 0;
}
