# Blueprint: Libraria - Tu Biblioteca

## Visión General

"Libraria" es una aplicación de gestión de bibliotecas personales desarrollada en Flutter y Firebase. Permite a los usuarios registrarse e iniciar sesión de forma segura para administrar su colección. La aplicación, completamente en **español**, ha sido rediseñada con una interfaz de usuario **elegante, exótica y formal**, utilizando un tema claro con acentos de color distintivos para una experiencia moderna y sofisticada.

---

## Características Implementadas

### 1. Vista de Detalles del Libro
- **Nueva Pantalla de Detalles (`lib/book_detail_page.dart`):** Se ha creado una página dedicada que muestra toda la información de un solo libro en un formato de pantalla completa, ideal para una lectura detallada y sin distracciones.
- **Navegación Intuitiva:** Se accede a esta vista a través de un nuevo icono de "ojo" (`Icons.visibility`) presente en cada tarjeta de libro, facilitando el descubrimiento de más información.

### 2. Flujo de Autenticación Completo
- **Servicio Dedicado (`lib/auth_service.dart`):** Centraliza la lógica de autenticación (iniciar sesión, registrarse, cerrar sesión).
- **Página de Acceso (`lib/auth_page.dart`):** Pantalla de entrada para "Iniciar Sesión" o "Registrarse".
- **Controlador de Acceso (`lib/auth_gate.dart`):** Dirige a los usuarios a la vista correcta según su estado de autenticación.
- **Cerrar Sesión:** Botón de `logout` accesible en la barra de la aplicación.

### 3. Funcionalidad CRUD en Español
- **Operaciones Completas:** Crear, Leer, Actualizar y Eliminar libros, con una interfaz y diálogos completamente en español.

### 4. Diseño Visual y Experiencia de Usuario (UI/UX) - **Rediseño Completo**
- **Nuevo Tema "Exótico y Formal" (Claro):**
    - **Paleta de Colores:** Se abandonó el tema oscuro en favor de un fondo **blanco hueso** (`#FAF9F6`), una barra de navegación **verde azulado oscuro** (`#004D40`), y acentos en **dorado vibrante** (`#FFC107`).
    - **Tipografía:** Se mantiene `google_fonts` ("Montserrat") pero ahora con texto en **negro** para un contraste óptimo y una legibilidad perfecta.
- **Iconografía Mejorada y Funcional:**
    - **Icono de Vista:** Se ha añadido un icono de un "ojo" para acceder a la nueva página de detalles.
    - **Colores de Acción:** Los iconos de **editar** y **eliminar** ahora usan colores azul y rojo respectivamente para ser más reconocibles y funcionales.
- **Presentación de Datos Clara y Directa:**
    - **Información Siempre Visible:** Todos los datos del libro, incluida la descripción, se muestran directamente en la tarjeta.

---

## Estilo y Diseño Detallado

- **Fuentes:** "Montserrat".
- **Nueva Paleta de Colores (Tema Claro):**
    - `primary` (AppBar): `Color(0xFF004D40)`
    - `secondary` (Acentos, FAB): `Color(0xFFFFC107)`
    - `background` (Fondo): `Color(0xFFFAF9F6)`
    - `surface` (Tarjetas): `Colors.white`
- **Iconografía:**
    - **Vista:** `Icons.visibility` (color dorado).
    - **Editar:** `Icons.edit` (color azul).
    - **Eliminar:** `Icons.delete` (color rojo).
    - **Añadir:** `Icons.add`.
    - **Cerrar Sesión:** `Icons.logout`.
- **Efectos Visuales:** Sombra suave en las tarjetas y efecto hover que las agranda y colorea la sombra con el tono dorado de acento.
