# 📋 Índice de Archivos - GlobalFin App

Este documento lista todos los archivos creados con su propósito y líneas de código.

## 📂 Archivos de Configuración

### `pubspec.yaml` (25 líneas) - ACTUALIZADO
**Propósito:** Configuración del proyecto, dependencias y metadatos  
**Dependencias principales:**
- flutter (SDK)
- cupertino_icons
- **supabase_flutter: ^1.10.0** ⭐ NUEVO
- **http: ^1.1.0** ⭐ NUEVO

### `analysis_options.yaml` (7 líneas)
**Propósito:** Reglas de linting y análisis de código estático  
**Reglas habilitadas:**
- prefer_const_constructors
- avoid_print
- prefer_single_quotes

---

## 🎨 Utilidades

### `lib/utils/app_colors.dart` (31 líneas)
**Propósito:** Paleta de colores centralizada  
**Define:**
- Colores primarios (azul marino oscuro, verde turquesa)
- Colores de fondos y tarjetas
- Colores para gastos/ingresos
- Colores de estados y bordes

### `lib/utils/app_text_styles.dart` (74 líneas)
**Propósito:** Estilos de texto reutilizables  
**Define:**
- Headers (large, medium, small)
- Body (large, medium, small)
- Estilos especiales (balance, amounts, buttons)

---

## 📦 Modelos de Datos

### `lib/models/account.dart` (38 líneas)
**Propósito:** Modelo de cuenta bancaria  
**Propiedades:**
- id, name, lastDigits, balance, monthVariation
- Método `getMockAccounts()` con 3 cuentas de ejemplo
**Uso:** Convertir datos de Supabase a objetos Account

### `lib/models/transaction.dart` (72 líneas)
**Propósito:** Modelo de transacción/movimiento  
**Propiedades:**
- id, title, date, amount, type, icon
- Enum TransactionType (expense, income)
- Método `getMockTransactions()` con 7 transacciones
**Uso:** Representar movimientos bancarios del cliente

### `lib/models/operation_action.dart` (58 líneas)
**Propósito:** Modelo de acción de operación  
**Propiedades:**
- id, title, subtitle, icon, iconColor
- Método `getAllActions()` con 5 acciones disponibles
**Uso:** Opciones del modal de operaciones

---

## 🔌 Servicios (NUEVO)

### `lib/services/supabase_service.dart` (120+ líneas) ⭐ NUEVO
**Propósito:** Cliente REST para comunicarse con Supabase PostgreSQL  
**Características:**
- Conexión automática al iniciar la app
- Métodos async para obtener datos
- Manejo de errores con logging
- Headers correctos para autenticación

**Métodos disponibles:**
```dart
static Future<List<Map<String, dynamic>>> getClientes()
static Future<List<Map<String, dynamic>>> getTransacciones()  
static Future<List<Map<String, dynamic>>> getOperaciones()
static Future<List<Map<String, dynamic>>> getTransaccionesPorCliente(String id)
static Future<bool> crearOperacion(Map<String, dynamic> data)
static Future<bool> actualizarEstadoOperacion(String id, String estado)
static Future<bool> testConnection()
```

**Credenciales incluidas:**
- URL: https://etlqpvghtqiqofepukqf.supabase.co
- API Key: eyJhbGci... (anon key - solo lectura/pública)

---

## 🧩 Widgets Reutilizables

### `lib/widgets/account_card.dart` (95 líneas)
**Propósito:** Tarjeta visual de cuenta bancaria  
**Características:**
- Diseño con gradiente oscuro
- Muestra nombre, últimos dígitos, saldo
- Indicador de variación mensual con color
- Ancho fijo de 280px para carrusel

### `lib/widgets/transaction_item.dart` (69 líneas)
**Propósito:** Item de movimiento/transacción en lista  
**Características:**
- Icono coloreado según tipo (gasto/ingreso)
- Nombre y fecha del movimiento
- Importe con color (rojo para gasto, verde para ingreso)
- Padding y spacing optimizados

### `lib/widgets/operation_action_item.dart` (62 líneas)
**Propósito:** Item de acción en el modal de operaciones  
**Características:**
- Icono grande con fondo coloreado
- Título y subtítulo descriptivo
- Flecha de navegación a la derecha
- Efecto InkWell para tap

### `lib/widgets/operation_bottom_sheet.dart` (89 líneas)
**Propósito:** Modal de operaciones (bottom sheet)  
**Características:**
- Ocupa 75% de altura de pantalla
- Bordes superiores redondeados
- Handle visual arrastrable
- Lista de 5 acciones
- Botón "Cancelar" al final
- Método estático `show(context)` para abrir

---

## 🎯 Pantallas (UI)

### `lib/ui/home_screen.dart` (425+ líneas) - ACTUALIZADO
**Propósito:** Pantalla principal de la aplicación  
**Cambios (Supabase):**
- ✅ Lista `_accounts` ahora es dinámica (no final)
- ✅ Lista `_transactions` ahora es dinámica (no final)
- ✅ Nuevo bool `_isLoading` para mostrar indicador
- ✅ Nuevo initState() que llama `_loadDataFromSupabase()`
- ✅ Nuevo método `_loadDataFromSupabase()` (async)
  - Llama SupabaseService.getClientes()
  - Llama SupabaseService.getTransacciones()
  - Convierte Map a Account/Transaction
  - Fallback a _useMockData() si hay error
- ✅ Nuevo método `_useMockData()` para datos fallback
- ✅ Loading indicator (CircularProgressIndicator verde)

**Componentes visuales:**
- Header con gradiente
- Tarjeta "Posición Global"
- Carrusel de cuentas
- 4 acciones rápidas
- Lista de transacciones
- Botón flotante
- Bottom navigation

**Datos usados:**
- Clientes desde Supabase o mock
- Transacciones desde Supabase o mock

---

## 🚀 Punto de Entrada

### `lib/main.dart` (60+ líneas) - ACTUALIZADO
**Propósito:** Inicialización de la aplicación  
**Cambios (Supabase):**
- ✅ main() ahora es async
- ✅ Llamada a `WidgetsFlutterBinding.ensureInitialized()`
- ✅ Inicialización de Supabase con:
  ```dart
  await Supabase.initialize(
    url: 'https://etlqpvghtqiqofepukqf.supabase.co',
    anonKey: 'eyJhbGci...',
  );
  ```
- ✅ Luego ejecuta `runApp(const GlobalFinApp())`

**Configuración:**
- Tema Material Design 3 oscuro
- Color primario: Azul marino
- Color acento: Verde turquesa

---

## 📚 Documentación

### `README.md` (300+ líneas) - ACTUALIZADO
**Secciones principales:**
- Estado actual (✅ PRODUCCIÓN)
- Cómo usar la aplicación
- Componentes del proyecto
- Base de datos Supabase
- Integración con Supabase
- Arquitectura
- Cómo ejecutar en desarrollo
- Cómo desplegar en Vercel

### `INICIO_RAPIDO.md` (200+ líneas) - ACTUALIZADO
**Propósito:** Guía rápida para empezar  
**Contiene:**
- 3 pasos para ejecutar la app
- Vista previa de características
- Sección de carga automática de Supabase
- Configuración Supabase (pre-configurada)
- Archivos clave
- Personalización rápida
- Despliegue en Vercel
- Solución de problemas

### `GUIA_IMPLEMENTACION.md` (400+ líneas) - ACTUALIZADO
**Propósito:** Detalles técnicos completos  
**Contiene:**
- Estructura del proyecto
- Componentes clave (con Supabase)
- Paleta de colores
- Cómo integrar con tu propio backend
- Testing
- Comandos rápidos
- Checklist de funcionalidades
- Solución de problemas
- Despliegue a producción

### `INDICE_ARCHIVOS.md` (ESTE ARCHIVO)
**Propósito:** Descripción de cada archivo  
**Contiene:** Propósito y líneas de código de cada archivo

### `DIAGRAMAS_FLUJOS.md`
**Propósito:** Diagramas visuales de flujos  
**Contiene:** 
- Diagrama de flujo de HomeScreen
- Diagrama de componentes
- Flujo de datos

### `FLUTTER_NO_INSTALADO.md`
**Propósito:** Instrucciones instalación Flutter  
**Para usuarios que no tienen Flutter instalado**

---

## 📊 Resumen de Líneas de Código

```
Configuración:         25 líneas (pubspec.yaml)
Utilidades:            105 líneas (colors, styles)
Modelos:               168 líneas (account, transaction, action)
Servicios:             120+ líneas (supabase_service) ⭐ NUEVO
Widgets Reutilizables: 315 líneas (cards, items, sheet)
Pantallas:             425+ líneas (home_screen) ACTUALIZADO
Punto de Entrada:      60+ líneas (main.dart) ACTUALIZADO
─────────────────────────────────
Total Código:          ~1,200+ líneas
Documentación:         ~1,500+ líneas
```

## 🔄 Flujo de Datos (Actualizado con Supabase)

```
main.dart (inicialización)
    ↓
Supabase.initialize(url, key)
    ↓
runApp(GlobalFinApp)
    ↓
HomeScreen → initState()
    ↓
_loadDataFromSupabase()
    ├─ SupabaseService.getClientes()
    ├─ SupabaseService.getTransacciones()
    ↓
    ├─ Éxito: setState() → Renderiza UI con datos reales ✓
    └─ Error: _useMockData() → setState() → Renderiza UI con mock ⚠️
```

## 🎯 Relaciones entre Componentes

```
lib/main.dart (inicializa Supabase)
    ↓
lib/ui/home_screen.dart
    ├─ Usa: SupabaseService (obtener datos)
    ├─ Usa: Account, Transaction (modelos)
    └─ Contiene:
        ├─ AccountCard (widget)
        ├─ TransactionItem (widget)
        ├─ OperationBottomSheet (widget)
        └─ OperationActionItem (widget)
    
lib/services/supabase_service.dart
    └─ Comunica con: Supabase PostgreSQL

lib/models/
    ├─ Account (usado por HomeScreen)
    ├─ Transaction (usado por HomeScreen)
    └─ OperationAction (usado por OperationActionItem)

lib/utils/
    ├─ app_colors.dart (usado por todos los widgets)
    └─ app_text_styles.dart (usado por todos los widgets)
```

## ⚙️ Cambios Principales (Supabase Integration)

**Archivos creados:**
- ✅ `lib/services/supabase_service.dart` (120+ líneas)

**Archivos modificados:**
- ✅ `lib/main.dart` → Agrega Supabase.initialize()
- ✅ `lib/ui/home_screen.dart` → Agrega _loadDataFromSupabase()
- ✅ `pubspec.yaml` → Agrega supabase_flutter y http

**Archivos sin cambios técnicos (pero conceptualmente actualizados):**
- Documentación: README.md, INICIO_RAPIDO.md, GUIA_IMPLEMENTACION.md

---

**Última actualización:** 28 de Febrero, 2026  
**Versión:** 2.0.0 (con Supabase integrado)  
**Estado:** ✅ Completamente documentado
