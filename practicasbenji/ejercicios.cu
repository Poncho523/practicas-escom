#include <stdio.h>

__global__ void mostrarIdentificadores(int i) {

    int hilo = threadIdx.x;
    int bloque = blockIdx.x;
    int id_global = blockIdx.x * blockDim.x + threadIdx.x;
    // Cada hilo muestra su identificador
    printf("Hola desde el hilo+100 =  %d \n", id_global+50);

    // Solo el hilo 0 del bloque 0 muestra la información global
    if (hilo%2==0) {
       printf("Soy el hilo %d del bloque %d. Total hilos: %d y soy par\n",  threadIdx.x, blockIdx.x, blockDim.x * gridDim.x);
	}	
	else{
		 printf("Soy el hilo %d del bloque %d. Total hilos: %d y soy impar\n",  threadIdx.x, blockIdx.x, blockDim.x * gridDim.x);

	}
       // int total_hilos = blockDim.x * gridDim.x;
       // int total_bloques = gridDim.x;

       // printf("\n--- Informacion global ---\n");
       // printf("Total de bloques: %d\n", total_bloques);
       // printf("Hilos por bloque: %d\n", blockDim.x);
       // printf("Total de hilos: %d\n\n", total_hilos);
      //  printf("Soy el hilo %d del bloque %d. Total hilos: %d\n",  threadIdx.x, blockIdx.x, blockDim.x * gridDim.x);
    }



int main() {

    int bloques = 3;
    int hilos_por_bloque = 1024;

    // Lanzamiento del kernel
    mostrarIdentificadores<<<bloques, hilos_por_bloque>>>(0);
    //mostrarIdentificadores<<<bloques, hilos_por_bloque>>>(10);
    //mostrarIdentificadores<<<bloques, hilos_por_bloque>>>(20);
	//printf("Soy el hilo %d del bloque %d. Total hilos: %d\n",  threadIdx.x, blockIdx.x, blockDim.x * gridDim.x);



    // Esperar a que termine el kernel
    cudaDeviceSynchronize();

    return 0;
}
