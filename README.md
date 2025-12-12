# Reportes La Paz

Una aplicación móvil comunitaria que permite a los ciudadanos reportar problemas, inconvenientes y situaciones en su comunidad. Los usuarios pueden crear, ver y interactuar con reportes de otros miembros de la comunidad.

## Descripción del Proyecto

**Reportes La Paz** es una plataforma digital diseñada para fortalecer la comunicación comunitaria y permitir que los ciudadanos compartan información sobre problemas locales. La aplicación facilita el reporte de incidencias, permitiendo a otros usuarios visualizar, comentar y compartir estos reportes.

### Características Principales

- **Autenticación de Usuarios**: Sistema seguro de login y registro
- **Crear Reportes**: Los usuarios pueden crear reportes detallados con título, descripción, contenido adicional e imágenes
- **Feed de Reportes**: Visualizar todos los reportes de la comunidad en un feed centralizado
- **Interacción Social**: Opción para dar "Me gusta", comentar y compartir reportes
- **Perfil de Usuario**: Cada reporte muestra la información del usuario que lo creó
- **Interfaz Limpia y Moderna**: Diseño intuitivo con colores verde y rojo que representa la identidad de la aplicación

## Requisitos

- Flutter SDK: ^3.9.2
- Dart: ^3.9.2

## Instalación

1. **Clonar el repositorio**
```bash
git clone <tu-repositorio>
cd app_reportes
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```

## Estructura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada de la aplicación
├── screens/
│   ├── welcome_screen.dart            # Pantalla de bienvenida
│   ├── login_screen.dart              # Pantalla de login
│   ├── sign_up_screen.dart            # Pantalla de registro
│   ├── report_list_screen.dart        # Feed de reportes
│   └── create_report_screen.dart      # Crear nuevo reporte
└── widgets/
    ├── custom_button.dart             # Botón personalizado reutilizable
    └── custom_input.dart              # Campo de entrada personalizado
```

## Pantallas Principales

### 1. Pantalla de Bienvenida (Welcome Screen)
Pantalla inicial que presenta la aplicación con opciones para hacer login o crear una nueva cuenta.

### 2. Pantalla de Login (Login Screen)
Permite a usuarios registrados iniciar sesión con sus credenciales (usuario/email y contraseña).

### 3. Pantalla de Registro (Sign Up Screen)
Formulario para que nuevos usuarios se registren con:
- Nombre de usuario
- Email
- Fecha de nacimiento
- Contraseña

### 4. Feed de Reportes (Report List Screen)
- Muestra todos los reportes de la comunidad
- Cada reporte incluye:
  - Perfil del usuario
  - Hora del reporte
  - Contenido del reporte con imagen
  - Botones de interacción (Me gusta, Comentar, Compartir)

### 5. Crear Reporte (Create Report Screen)
Formulario para crear un nuevo reporte con:
- Título del reporte
- Descripción detallada
- Contenido adicional
- Opción de añadir imágenes

## Dependencias

- `flutter`: SDK de Flutter
- `cupertino_icons`: Iconos para iOS
- `http`: Cliente HTTP para comunicación con API (futuro)

## Tema y Diseño

La aplicación utiliza un sistema de colores distintivo:
- **Verde**: Color primario (Verde claro y oscuro para gradientes)
- **Rojo**: Color secundario (Color rojo brillante #E31C23 para botones principales)
- **Púrpura**: Color adicional (#6B4FA3) para elementos secundarios

## Instrucciones de Uso

### Para Usuarios Nuevos
1. Descargar la aplicación
2. En la pantalla de bienvenida, seleccionar "SIGN UP"
3. Completar el formulario de registro
4. Confirmar el registro

### Para Usuarios Existentes
1. En la pantalla de bienvenida, seleccionar "LOG IN"
2. Ingresar credenciales (usuario/email y contraseña)
3. Acceder al feed de reportes

### Para Crear un Reporte
1. Una vez logueado, presionar el botón "+" en la esquina inferior derecha
2. Completar el formulario del reporte
3. Presionar "PUBLICAR"

### Para Interactuar con Reportes
- **Me gusta**: Presionar el botón de corazón
- **Comentar**: Presionar el botón de comentarios
- **Compartir**: Presionar el botón de compartir

