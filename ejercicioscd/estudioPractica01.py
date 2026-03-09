#Estudio acerca de los temas que se vieron en clase, con el fin de entenderlos mejor y poder aplicarlos en el futuro.

#USO DE LAS CADENAS
#Invertir cada palabra de la lista usando slicing palabras = ["python", "datos", "algoritmo", "lista"]
palabras = ["python", "datos", "algoritmo", "lista"]
palabrasin=[]
for i in range(len(palabras)):
    palabrasin.append(palabras[i][::-1])
#print(palabrasin)
#Dada una lista de palabras, crea una nueva lista con solo las primeras 3 letras de cada palabra.
palabras2 = ["computadora", "teclado", "pantalla", "mouse"]
palabrasr2=[]
for i in range(len(palabras2)):
    palabrasr2.append(palabras2[i][0:3:1])
#print(palabrasr2)
#Crea una lista nueva solo con las palabras que tengan mas de 5 letras
palabras3 = ["sol", "computadora", "python", "luz", "algoritmo"]
palabrasr3=[]
palabras3r=[palabra for palabra in palabras3 if len(palabra)>5]
#print(palabras3r)
#Obtener solo la primera mitad de cada palabra
palabras4= ["python", "codigo", "datos"]
palabrasr4 = [
    palabra1[0:int((len(palabra1)+1)/2):] if len(palabra1)%2!=0 else palabra1[0:int(len(palabra1)/2):]
    for palabra1 in palabras4]
print(palabrasr4)
#Listas de compresion

#Funciones de orden mayor

