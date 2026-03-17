#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdlib>
#include <cuda_runtime.h>

void guardarArregloEnArchivo(const char* nombreArchivo, float* datos, int cantidad) {
    std::ofstream archivo(nombreArchivo);

    if (!archivo.is_open()) {
        std::cerr << "No se pudo abrir el archivo para escritura: " << nombreArchivo << std::endl;
        return;
    }

    for (int i = 0; i < cantidad; ++i) {
        archivo << datos[i] << "\n";
    }

    archivo.close();
    std::cout << "Archivo guardado exitosamente: " << nombreArchivo << std::endl;
}

int main() {
    const int N = 70;

    // Arreglos dinámicos (apuntadores)
    float *a = new float[N];
    float *b = new float[N];
    float *c = new float[N];
    float *x1 = new float[N];
    float *x2 = new float[N];

    std::ifstream fin("datos_ecuaciones.csv");
    if (!fin.is_open()) {
        std::cerr << "No se puede abrir datos_ecuaciones.csv" << std::endl;
        return 1;
    }

    std::string line;
    // Leer encabezado
    std::getline(fin, line);

    int idx = 0;
    while (std::getline(fin, line) && idx < N) {
        std::stringstream ss(line);
        std::string token;

        // a
        std::getline(ss, token, ',');
        a[idx] = std::stof(token);

        // b
        std::getline(ss, token, ',');
        b[idx] = std::stof(token);

        // c
        std::getline(ss, token, ',');
        c[idx] = std::stof(token);

        // x1
        std::getline(ss, token, ',');
        x1[idx] = std::stof(token);

        // x2
        std::getline(ss, token, ',');
        x2[idx] = std::stof(token);

        idx++;
    }
    fin.close();

    // Verificar lectura (imprimir algunos)
    for (int i = 0; i < 5 && i < idx; ++i) {
        std::cout << "i=" << i
                  << "   a=" << a[i]
                  << "   b=" << b[i]
                  << "   c=" << c[i]
                  << "   x1=" << x1[i]
                  << "   x2=" << x2[i]
                  << "\n";
    }

    // Aquí podrías hacer cudaMalloc / cudaMemcpy para subir a GPU, etc.

    // Liberar memoria
    delete[] a;
    delete[] b;
    delete[] c;
    delete[] x1;
    delete[] x2;

    return 0;
}

