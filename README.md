# 🏦 Proyecto GlobalFin

Plataforma bancaria digital completa con aplicación móvil para clientes y dashboard de operaciones para empleados.

## 🌐 Despliegue en Producción

### 📱 App Móvil (Clientes)
**🚀 Desplegada en Vercel**

La aplicación móvil está lista para desplegarse en Vercel. Ver instrucciones completas en [DESPLIEGUE_VERCEL.md](DESPLIEGUE_VERCEL.md)

**Demo:** Una vez desplegada, estará disponible en tu URL de Vercel

### 🖥️ Dashboard (Empleados)
**💻 Aplicación de Escritorio (JavaFX)**

El dashboard se ejecuta localmente en las máquinas de los empleados.

```bash
cd dashboard/globalfin-dashboard
mvn javafx:run
```

---

## 📂 Estructura del Proyecto

```
Proyecto-GlobalFin/
├── App movil/
│   └── globalfin_app/          # 📱 App Flutter para clientes
│       ├── lib/
│       │   ├── main.dart
│       │   ├── ui/
│       │   │   └── home_screen.dart
│       │   ├── widgets/        # Componentes reutilizables
│       │   ├── models/         # Modelos de datos
│       │   └── utils/          # Colores y estilos
│       └── build/web/          # ✅ Build listo para Vercel
│
├── dashboard/
│   └── globalfin-dashboard/    # 🖥️ Dashboard JavaFX para empleados
│       ├── src/main/java/
│       │   └── com/globalfin/dashboard/
│       │       ├── DashboardApp.java
│       │       ├── model/
│       │       └── data/
│       └── src/main/resources/
│           └── styles/
│               └── dashboard.css
│
├── vercel.json                 # ⚙️ Configuración de Vercel
├── .vercelignore              # 🚫 Archivos ignorados en despliegue
└── DESPLIEGUE_VERCEL.md       # 📖 Guía de despliegue
```

---

## 📱 App Móvil - Aplicación para Clientes

**Ubicación:** `App movil/globalfin_app/`

Aplicación multiplataforma desarrollada en **Flutter** para clientes bancarios.

### ✨ Características Implementadas:

- 🏠 **Pantalla Principal** con posición global consolidada
- 💳 **Carrusel de Cuentas** con 3 cuentas bancarias
- 💰 **6 Operaciones Rápidas**: Transferir, Pagar, Bizum, Retirar, Ingresar, Más
- 📊 **Lista de Movimientos** con 7 transacciones recientes
- 📋 **Bottom Sheet** con acciones detalladas
- 🔔 **Notificaciones** y perfil de usuario
- 🧭 **Bottom Navigation** con 5 secciones

### 🛠️ Tecnologías:

- Flutter 3.41.2
- Dart 3.11.0
- Material Design 3
- Responsive Design

### 📖 Documentación:

- [README.md](App movil/globalfin_app/README.md) - Documentación completa
- [GUIA_IMPLEMENTACION.md](App movil/globalfin_app/GUIA_IMPLEMENTACION.md) - Guía técnica
- [INDICE_ARCHIVOS.md](App movil/globalfin_app/INDICE_ARCHIVOS.md) - Estructura de archivos
- [INICIO_RAPIDO.md](App movil/globalfin_app/INICIO_RAPIDO.md) - Getting started

### 🚀 Ejecutar Localmente:

```bash
cd "App movil/globalfin_app"
flutter pub get
flutter run -d chrome    # En navegador
flutter run              # En dispositivo/emulador
```

### 🌐 Desplegar en Vercel:

```bash
# Build ya está listo en build/web/
# Sigue las instrucciones en DESPLIEGUE_VERCEL.md
```

---

## 🖥️ Dashboard - Panel de Operaciones para Empleados

**Ubicación:** `dashboard/globalfin-dashboard/`

Dashboard interno desarrollado en **JavaFX** para empleados que gestionan operaciones bancarias.

### ✨ Características Implementadas:

- 📊 **Panel de Métricas KPI** con 4 indicadores clave
- 📋 **Tabla de Operaciones** con 10 operaciones de ejemplo
- 👉 **Panel de Detalles** contextual con información completa
- 🎮 **Acciones**: Marcar revisada, marcar sospechosa, escalar a fraude
- 🔍 **Filtros** por estado, riesgo y fecha
- 🎨 **Diseño Corporativo** con tema profesional
- 📝 **Campo de Notas** para comentarios internos

### 🛠️ Tecnologías:

- JavaFX 21.0.5
- Java 17+
- Maven 3.6+
- Gson 2.10.1 (preparado para backend)

### 📖 Documentación:

- [README.md](dashboard/globalfin-dashboard/README.md) - Documentación completa del dashboard

### 🚀 Ejecutar Localmente:

**Requisitos:** Java 17+, Maven 3.6+, Entorno con interfaz gráfica

```bash
cd dashboard/globalfin-dashboard
mvn javafx:run
```

### 📦 Crear JAR para Distribución:

```bash
cd dashboard/globalfin-dashboard
mvn clean package
# El JAR estará en: target/dashboard-empleados-1.0.0-SNAPSHOT.jar
```

---

## 🎨 Documentación de Diseño

Los wireframes y diseños se encuentran en:

### App Móvil:
- `App movil/low fidelity home.png`
- `App movil/low fidelity reealizar operacion.png`
- `App movil/high fidelity inicio app.png`
- `App movil/high fidelity app.png`

### Dashboard:
- `dashboard/low-high fidelity/` (wireframes del dashboard)

---

## 🎯 Estado del Proyecto

### ✅ Completado:

#### App Móvil:
- ✅ Estructura completa del proyecto Flutter
- ✅ HomeScreen con todos los componentes
- ✅ 4 widgets reutilizables
- ✅ 3 modelos de datos con datos mock
- ✅ Sistema de colores y estilos
- ✅ Build para producción web
- ✅ Configuración para Vercel
- ✅ Documentación completa (4 archivos MD)

#### Dashboard:
- ✅ Estructura Maven completa
- ✅ DashboardApp con UI completa (400+ líneas)
- ✅ Modelos de datos (Operation, DashboardMetrics)
- ✅ MockDataProvider con 10 operaciones
- ✅ Estilos CSS corporativos
- ✅ Compilación sin errores
- ✅ README con instrucciones completas

### 📋 Próximos Pasos Sugeridos:

1. **Desplegar App Móvil en Vercel**
   - Ver [DESPLIEGUE_VERCEL.md](DESPLIEGUE_VERCEL.md)

2. **Integración con Backend Real**
   - Crear API REST
   - Conectar ambas aplicaciones
   - Implementar autenticación

3. **Funcionalidades Adicionales**
   - Login/registro de usuarios
   - Notificaciones push
   - Chat de soporte
   - Gráficos y reportes avanzados

---

## 🏗️ Arquitectura

```
┌─────────────────────────────────────┐
│         👥 CLIENTES                 │
│                                     │
│    📱 App Móvil Flutter             │
│    🌐 Vercel (Web/PWA)              │
│    Consultas y operaciones          │
└──────────────┬──────────────────────┘
               │
               │ (Futura API REST)
               │
┌──────────────▼──────────────────────┐
│       👨‍💼 EMPLEADOS                  │
│                                     │
│    🖥️ Dashboard JavaFX              │
│    💻 Local (Escritorio)            │
│    Gestión de operaciones           │
└─────────────────────────────────────┘
```

---

## 🛠️ Tecnologías Utilizadas

### Frontend Clientes:
- **Flutter** 3.41.2 - Framework multiplataforma
- **Dart** 3.11.0 - Lenguaje de programación
- **Material Design 3** - Sistema de diseño

### Frontend Empleados:
- **JavaFX** 21.0.5 - Framework de UI para Java
- **Java** 17+ - Lenguaje de programación
- **Maven** - Gestión de dependencias

### Despliegue:
- **Vercel** - Hosting de la app móvil
- **GitHub** - Control de versiones

---

## 📚 Documentación Adicional

- 📱 [App Móvil - README](App movil/globalfin_app/README.md)
- 🖥️ [Dashboard - README](dashboard/globalfin-dashboard/README.md)
- 🚀 [Guía de Despliegue en Vercel](DESPLIEGUE_VERCEL.md)

---

## 👥 Autor

**Cristian Paños Gallego**

---

## 📄 Licencia

Este proyecto ha sido desarrollado como parte de un proyecto académico.
  - UI responsive y accesible

- 🔄 **Dashboard**: En planificación

- 📅 **Backend**: Pendiente

## 🔗 Recursos

- Documentación Flutter: https://flutter.dev
- Material Design: https://m3.material.io

## 📝 Licencia

Proyecto educativo - GlobalFin
