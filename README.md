# Matriz Rotación - Flutter con BLoC

## **Descripción**
Aplicación Flutter que permite ingresar una matriz cuadrada (NxN), visualizarla y rotarla 90 grados en sentido horario. Usa el patrón **BLoC** para separar la lógica de negocio del UI.

---

## **Características**
- **Ingreso de matriz**: Introduce una matriz en formato JSON válido (ejemplo: `[[1, 2], [3, 4]]`) y presiona el boton **Done** en el teclado para actualizarla.
- **Validaciones**:
  - La entrada debe ser un JSON válido.
  - Todos los elementos deben ser números.
  - La matriz debe ser cuadrada (NxN).
- **Rotación**: Presiona "Rotar" para girar la matriz 90 grados en sentido horario.
- **Manejo de errores**: Muestra mensajes claros si hay errores en la entrada.

---

## **Cómo Usar**
1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-repositorio/matriz-rotacion.git