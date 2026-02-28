# 🏦 Proyecto GlobalFin

Plataforma bancaria digital **completamente funcional** con integración de base de datos Supabase.

**Estado**: ✅ **PRODUCCIÓN** - Todas las funcionalidades implementadas

## 📦 Componentes del Proyecto

### 📱 App Móvil para Clientes (Flutter)
- **Ubicación**: `App movil/globalfin_app/`
- **Estado**: ✅ Desplegada en Vercel
- **BD**: ✅ Conectada a Supabase
- **Datos**: Clientes, transacciones en tiempo real
- **URL**: Disponible en Vercel (despliegue automático)

### 🖥️ Dashboard para Empleados (JavaFX)
- **Ubicación**: `dashboard/globalfin-dashboard/`
- **Estado**: ✅ Compilado y funcional
- **BD**: ✅ Conectada a Supabase
- **Datos**: Operaciones en tiempo real
- **Ejecución**: `mvn javafx:run`

### 🗄️ Base de Datos (Supabase)
- **Estado**: ✅ Completamente configurada
- **Tablas**: clientes, operaciones, transacciones
- **Registros**: 30 datos de prueba
- **API**: REST con autenticación apikey

---

## 🚀 Cómo Usar

### App Móvil en Navegador
```bash
# Accede directamente desde tu navegador
# https://tu-dominio-vercel.vercel.app
```

### Dashboard Local
```bash
git clone https://github.com/CristianPG1993/Proyecto-GlobalFin.git
cd Proyecto-GlobalFin/dashboard/globalfin-dashboard
mvn javafx:run
```

---

## 📂 Estructura del Proyecto

```
Proyecto-GlobalFin/
├── App movil/globalfin_app/
│   ├── lib/
│   │   ├── main.dart (Inicializa Supabase)
│   │   ├── services/supabase_service.dart
│   │   ├── ui/home_screen.dart
│   │   ├── models/
│   │   ├── widgets/
│   │   └── utils/
│   ├── pubspec.yaml (supabase_flutter)
│   └── build/web/ (Build compilado)
│
├── dashboard/globalfin-dashboard/
│   ├── src/main/java/
│   │   └── com/globalfin/dashboard/
│   │       ├── DashboardApp.java
│   │       ├── service/SupabaseService.java
│   │       ├── data/MockDataProvider.java
│   │       └── model/
│   ├── pom.xml (Maven)
│   └── src/main/resources/
│       ├── supabase_init.sql
│       └── styles/dashboard.css
│
├── public/ (Flutter web build)
├── vercel.json
└── README.md
```

---

## 🎯 Características Implementadas

### App Móvil
✅ Pantalla principal con posición global  
✅ Carrusel de cuentas (datos reales)  
✅ Operaciones rápidas  
✅ Lista de transacciones (datos reales)  
✅ Loading indicator  
✅ Fallback automático a datos mock  
✅ Material Design 3  
✅ Responsive design  

### Dashboard
✅ Métricas KPI en tiempo real  
✅ Tabla de operaciones (datos reales)  
✅ Panel de detalles contextual  
✅ Acciones (revisar, sospechosa, escalar)  
✅ Filtros por estado y riesgo  
✅ Notas internas  
✅ Fallback automático a datos mock  
✅ Diseño profesional  

### Base de Datos
✅ 3 tablas diseñadas  
✅ 30 registros de prueba  
✅ REST API automático  
✅ Row Level Security (RLS)  
✅ Relaciones FK  
✅ Timestamps automáticos  

---

## 🔗 Integración Supabase

### Credenciales
```
URL: https://etlqpvghtqiqofepukqf.supabase.co
API Key: [Anon Key configurada]
Autenticación: Header "apikey"
```

### Métodos Disponibles

**Flutter (SupabaseService.dart)**:
- getClientes() → List<Map>
- getOperaciones() → List<Map>
- getTransacciones() → List<Map>
- getTransaccionesPorCliente(clienteId)
- crearOperacion(data)
- actualizarEstadoOperacion(id, estado)
- getClienteById(id)
- getSaldoCliente(id)

**JavaFX (SupabaseService.java)**:
- getOperaciones() → List<JsonObject>
- getClientes() → List<JsonObject>
- getTransacciones() → List<JsonObject>
- getTransaccionesPorCliente(clienteId)
- crearOperacion(data)
- actualizarEstadoOperacion(id, estado)
- getClienteById(id)
- getSaldoCliente(id)
- testConnection()

---

## 📱 App Móvil

**Ubicación**: `App movil/globalfin_app/`

### Características
- Carga de clientes desde Supabase
- Lista de transacciones actualizadas
- Loading indicator mientras se cargan datos
- Fallback automático a datos mock
- Bottom Navigation con 5 secciones
- Material Design 3
- Responsive Design

### Ejecutar
```bash
cd "App movil/globalfin_app"
flutter pub get
flutter run -d chrome
```

### Documentación
- [README.md](App movil/globalfin_app/README.md)
- [GUIA_IMPLEMENTACION.md](App movil/globalfin_app/GUIA_IMPLEMENTACION.md)
- [INICIO_RAPIDO.md](App movil/globalfin_app/INICIO_RAPIDO.md)

---

## 🖥️ Dashboard

**Ubicación**: `dashboard/globalfin-dashboard/`

### Características
- Tabla de operaciones en tiempo real
- Métricas KPI calculadas automáticamente
- Panel de detalles contextual
- Sistema de filtros
- Notas internas para operaciones
- Fallback a datos mock

### Requisitos
- Java 17+
- Maven 3.6+
- Interfaz gráfica (X11/Windows/Mac)

### Ejecutar
```bash
cd dashboard/globalfin-dashboard
mvn javafx:run
```

### Compilar JAR
```bash
mvn clean package
# JAR: target/dashboard-empleados.jar
```

### Documentación
- [README.md](dashboard/globalfin-dashboard/README.md)

---

## 🚀 Despliegue

### Vercel (App Móvil)
- ✅ Configurado en `vercel.json`
- ✅ Build en `/public`
- ✅ Despliegue automático en git push
- ✅ Ver [DESPLIEGUE_VERCEL.md](DESPLIEGUE_VERCEL.md)

### Local (Dashboard)
```bash
git clone https://github.com/CristianPG1993/Proyecto-GlobalFin.git
cd Proyecto-GlobalFin/dashboard/globalfin-dashboard
mvn javafx:run
```

---

## 📊 Datos de Prueba

### Clientes (10)
Ana García, Carlos Ruiz, María Martínez, Juan López, Laura Gómez, Pedro Sánchez, Elena Rodríguez, Miguel Fernández, Isabel Torres, Francisco Jiménez

### Operaciones (10)
Diferentes tipos: TRANSFER, BIZUM, PAYMENT, WITHDRAWAL, DEPOSIT  
Estados: pending, completed, reviewing, suspicious, rejected  
Niveles: low, medium, high

### Transacciones (10)
Asociadas a clientes y operaciones

---

## 🛠️ Tecnologías

**Frontend**:
- Flutter 3.41.2 / Dart 3.11.0
- JavaFX 21.0.5 / Java 17+
- Material Design 3 / CSS profesional

**Backend/BD**:
- Supabase PostgreSQL
- REST API automático

**Desarrollo**:
- Maven / pubspec
- GitHub / Vercel
- VS Code

---

## 📈 Arquitectura

```
Clientes (Web/App)          Backend Real (Supabase)       Empleados (Desktop)
        ↓                            ↓                            ↓
  Flutter Web                   PostgreSQL                    JavaFX Dashboard
  (Vercel)              (REST API automático)            (Local ejecutable)
        ↓                            ↓                            ↓
  Material Design        ↔ 30 registros prueba ↔      Tabla operaciones
  Responsive            ↔ Row Level Security ↔        Métricas KPI
  Real-time data        ↔ Relaciones FK      ↔        Panel detalles
```

---

## ✅ Checklist Final

- [x] App móvil compilada para web
- [x] Dashboard JavaFX compilado
- [x] Base de datos Supabase creada
- [x] Servicio Flutter integrado
- [x] Servicio JavaFX integrado
- [x] Datos cargando desde Supabase
- [x] Fallback automático a mock
- [x] Vercel configurado
- [x] Despliegue automático activo
- [x] Documentación actualizada

---

## 📚 Documentación

- 📱 [App Móvil](App movil/globalfin_app/README.md)
- 🖥️ [Dashboard](dashboard/globalfin-dashboard/README.md)
- 🚀 [Despliegue](DESPLIEGUE_VERCEL.md)

---

**Última actualización**: 28 de Febrero, 2026  
**Estado**: ✅ Producción  
**Autor**: Cristian Paños Gallego
