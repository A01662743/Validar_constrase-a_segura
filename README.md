# Validador de Contraseñas Seguras mediante Paradigmas Alternativos
Este proyecto presenta la solución al problema de validación de seguridad de contraseñas utilizando dos enfoques de programación: el Paradigma Funcional (implementado en Racket) y el Paradigma Lógico (implementado en Prolog). El objetivo es demostrar cómo un mismo problema puede resolverse con ambos paradigmas, teniendo sus pros y contras pero llegando a una solución efectiva independientemente de las restricciones estructurales de cada una, sin recurrir a la mutación de estados ni a ciclos de control tradicionales.
## 1. Contexto y Descripción del Problema
En el ámbito de la ciberseguridad y el desarrollo de aplicaciones web, la validación de contraseñas en el flujo de registro es un paso crítico para evitar ataques de fuerza bruta y asegurar validaciones de identidad estrictas.
El problema consiste en evaluar si una cadena de texto (string) cumple simultáneamente con un conjunto de restricciones específicas en cualquier orden:
- Contener al menos una letra mayúscula.
- Contener al menos una letra minúscula.
- Contener al menos un dígito numérico.
- Contener al menos un carácter especial del conjunto delimitado: {'!', '@', '#', '$', '%', '*', '&', '-'}.
## 2. Modelos y Arquitectura de la Solución
Para mapear la solución sin generar un único Autómata Finito Determinista secuencial, se optó por una arquitectura de sub-autómatas de dos estados en paralelo.
Cada condición obligatoria actúa como una pequeña máquina de estados independiente:
- Estado Inicial (q0): El criterio no ha sido encontrado en el prefijo analizado de la cadena.
- Estado de Aceptación (q1): El criterio ya fue identificado. Una vez que se transiciona a este estado, se mantiene ahí permanentemente (lazo de retorno) para el resto del flujo.
### Diagrama de Arquitectura de Filtros de Estado

<img width="717" height="706" alt="Captura de pantalla 2026-05-22 002638" src="https://github.com/user-attachments/assets/17ce991f-a46a-4096-bcb8-8d095b2e4f42" />


### Sustentación Teórica
De acuerdo con Hopcroft, Motwani y Ullman (2007), las expresiones regulares y los autómatas finitos son equivalentes en su poder de cómputo para reconocer lenguajes regulares. Sin embargo, la intersección de múltiples lenguajes regulares (las cuatro condiciones obligatorias en cualquier orden) incrementa exponencialmente la complejidad del diseño de un solo grafo de transiciones.
Al modelar la solución mediante la descomposición funcional o la declaración de restricciones independientes, se explota la propiedad de clausura bajo la intersección de los lenguajes regulares sin penalizar la claridad de la implementación del software.
## 3. Implementaciones de Código
### Propuesta A: Paradigma Funcional en Racket
La implementación en Racket utiliza variables acumuladoras en los argumentos de la función para simular las transiciones de estado, optimizada al apoyarse con la validación de un estado “true” mediante la sentencia “AND”.
### Propuesta B: Paradigma Lógico en Prolog
La implementación en Prolog se aleja por completo de la naturaleza algorítmica secuencial y describe las metas que debe satisfacer la base de conocimiento para que la consulta se unifique con éxito.
## 4. Análisis y Optimización Algorítmica
Complejidad Espacial y Temporal
Métrica de Complejidad
Propuesta A: Racket (Funcional)
Propuesta B: Prolog (Lógico)
Complejidad Temporal (Peor Caso)
O(n)
O(n)
Complejidad Espacial (Peor Caso)
O(n)
O(n)

- Complejidad Temporal: En ambos lenguajes, el peor de los casos se presenta cuando el string es inválido o el último carácter es el que activa la última bandera faltante. Se requiere inspeccionar de forma lineal los “n” caracteres de la cadena.
- Complejidad Espacial: Al procesar las estructuras mediante listas ligadas dinámicas, transformar el string a tokens individuales consume memoria proporcional a la longitud del input, resultando en una complejidad de espacio de O(n).
### Comparación de Soluciones
El diseño con el paradigma funcional destaca en el control explícito del flujo de datos sin mutación. La ventaja de Racket radica en su eficiente manejo de espacio y su implementación optimizada del backtracking que lo permite.
Por otro lado, el diseño en Prolog destaca por su expresividad declarativa. No hay necesidad de estructurar iteraciones o acumuladores; Prolog gestiona las unificaciones y el descarte de ramas muertas, reduciendo drásticamente las líneas de código y potenciales errores humanos en la definición de lógica compleja de bifurcación.
## 5. Reporte de Pruebas Automatizadas
Ambas soluciones incorporan pruebas automatizadas utilizando los frameworks oficiales de grado industrial respectivos (rackunit y plunit).
### Ejecución de Pruebas en Racket
Al ejecutar la suite de pruebas unitarias configurada dentro del archivo, el reporte de interfaz de texto arroja la siguiente salida en consola, demostrando la cobertura total de los casos válidos, inválidos y límites (frontera vacía):


-- 7 success(es) 0 failure(s) 0 error(s) 7 test(s) run --

### Ejecución de Pruebas en Prolog
Al compilar y ejecutar el módulo de pruebas mediante la instrucción run_tests. en la consola interactiva de SWI-Prolog, se despliega el reporte de validación formal de predicados:

-- %- validador_contrasenias: passed 7 tests
true. --

Ambas ejecuciones confirman que el código pasa correctamente el 100% de las pruebas automatizadas diseñadas, garantizando la consistencia del modelo lógico y funcional frente a las restricciones planteadas.


## 6. Referencias Bibliográficas
- Clocksin, W. F., & Mellish, C. S. (2003). Programming in Prolog (5th ed.). Springer-Verlag.
- Felleisen, M., Findler, R. B., Flatt, M., & Krishnamurthi, S. (2018). How to Design Programs (2nd ed.). MIT Press.
- Hopcroft, J. E., Motwani, R., & Ullman, J. D. (2007). Introduction to Automata Theory, Languages, and Computation (3rd ed.). Addison-Wesley.
- Sipser, M. (2013). Introduction to the Theory of Computation (3rd ed.). Cengage Learning.
