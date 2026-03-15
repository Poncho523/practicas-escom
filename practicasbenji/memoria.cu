#include <iostream>
#include <cstdlib>
#include <ctime>
#include <cuda_runtime.h>

using namespace std;

// Kernel para sumar dos arreglos
__global__ void sumaArreglos(int *A, int *B, int *C, int N)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if(idx < N)
    {
        C[idx] = A[idx] + B[idx];
    }
}

// Mostrar resultado
void mostrarResultado(int *array, int N)
{
    cout << "\nPrimeros 10 valores:\n";

    for(int i = 0; i < 10 && i < N; i++)
    {
        cout << array[i] << " ";
    }

    cout << "\n\nUltimos 10 valores:\n";

    for(int i = N - 10; i < N; i++)
    {
        if(i >= 0)
            cout << array[i] << " ";
    }

    cout << endl;
}

int main()
{
    int N = 500000;

    srand(time(NULL));

    // Memoria en host
    int *h_A = new int[N];
    int *h_B = new int[N];
    int *h_C = new int[N];

    // Inicializar arreglos
    for(int i = 0; i < N; i++)
    {
        h_A[i] = rand() % 100;
        h_B[i] = rand() % 100;
    }

    // Memoria en device
    int *d_A, *d_B, *d_C;

    cudaMalloc((void**)&d_A, N * sizeof(int));
    cudaMalloc((void**)&d_B, N * sizeof(int));
    cudaMalloc((void**)&d_C, N * sizeof(int));

    // Copiar datos host -> device
    cudaMemcpy(d_A, h_A, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, N * sizeof(int), cudaMemcpyHostToDevice);

    // Configuración paralela
    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    // Lanzar kernel
    sumaArreglos<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, N);

    cudaDeviceSynchronize();

    // Copiar resultado device -> host
    cudaMemcpy(h_C, d_C, N * sizeof(int), cudaMemcpyDeviceToHost);

    // Mostrar resultado
    mostrarResultado(h_C, N);

    // Liberar memoria
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    delete[] h_A;
    delete[] h_B;
    delete[] h_C;

    return 0;
}