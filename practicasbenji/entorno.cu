#include <stdio.h>
#include <cuda_runtime.h>
// Kernel: función que se ejecuta en el device (GPU)
__global__ void holaDesdeDevice()
{
    int hilo = threadIdx.x;   // Índice del hilo dentro del bloque
    int bloque = blockIdx.x;  // Índice del bloque
    
   printf("Jhon Donne\n", bloque, hilo);
}
void imprimirArreglo(int arr[]){
 for (int i=0; i<3;i++){
      printf("%d es %d \n",i,arr[i]);

}


}

int main()
{

int deviceCount;
cudaError_t error = cudaGetDeviceCount(&deviceCount);
if (error == cudaSuccess) {
// La función se ejecutó correctamente
printf("Número de dispositivos CUDA disponibles: %d\n", deviceCount);
} 
else 
{
// Ocurrió un error al obtener el número de dispositivos CUDA
printf("Error al obtener el número de dispositivos CUDA: %s\n",        cudaGetErrorString(error));
}

cudaDeviceProp prop;
error = cudaGetDeviceProperties(&prop, 0);

if (error == cudaSuccess) {
    // La función se ejecutó correctamente, se pueden acceder a las propiedades del dispositivo
printf("Nombre del dispositivo: %s\n", prop.name);
printf("Arquitectura del dispositivo (Compute Capability): %d.%d\n", prop.major, prop.minor);
printf("Número de hilos por warp: %d\n", prop.warpSize);

printf("Memoria global total (bytes): %ld\n", prop.totalGlobalMem);
printf("Memoria compartida por bloque (bytes): %ld\n", prop.sharedMemPerBlock);
printf("Registros por bloque: %d\n", prop.regsPerBlock);

printf("Máximo número de hilos por bloque: %d\n", prop.maxThreadsPerBlock);

printf("Dimensión máxima de hilos por bloque: ");
imprimirArreglo(prop.maxThreadsDim);

printf("\nDimensión máxima de la cuadrícula (grid): ");
imprimirArreglo(prop.maxGridSize);

printf("\nCantidad de multiprocesadores (SM): %d\n", prop.multiProcessorCount);
    // ... otras propiedades del dispositivo
}
else 
{
    // Ocurrió un error al obtener las propiedades del dispositivo
    printf("Error al obtener las propiedades del dispositivo: %s\n", cudaGetErrorString(error));
}

    // Mensaje desde el host (CPU)
    printf("Nunca hagas preguntar por quien doblan las campanas; doblan por ti \n");

    // Lanzamiento del kernel
    // <<<numero_de_bloques, numero_de_hilos_por_bloque>>>
    holaDesdeDevice<<<1, 1>>>();

    // Esperamos a que la GPU termine
    cudaDeviceSynchronize();

    return 0;
}
