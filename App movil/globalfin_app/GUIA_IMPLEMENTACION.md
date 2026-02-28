# GlobalFin App - Guía de Implementación

## 📁 Estructura Completa del Proyecto

```
App movil/globalfin_app/
├── lib/
│   ├── main.dart                          # Punto de entrada + inicialización Supabase
│   ├── ui/
│   │   └── home_screen.dart              # Pantalla principal (con carga de datos real)
│   ├── services/                         # ⭐ NUEVO
│   │   └── supabase_service.dart         # Cliente REST para Supabase
│   ├── widgets/
│   │   ├── account_card.dart             # Tarjeta de cuenta con gradiente
│   │   ├── transaction_item.dart         # Ítem de movimiento
│   │   ├── operation_action_item.dart    # Ítem de acción
│   │   └── operation_bottom_sheet.dart   # Modal de operaciones
│   ├── models/
│   │   ├── account.dart                  # Cuenta bancaria
│   │   ├── transaction.dart              # Transacción/Movimiento
│   │   └── operation_action.dart         # Acción de operación
│   └── utils/
│       ├── app_colors.dart               # Paleta de colores
│       └── app_text_styles.dart          # Estilos de texto
├── pubspec.yaml                          # Dependencias Flutter + Supabase
├── analysis_options.yaml                 # Reglas de linting
└── README.md                             # Documentación completa
```

## 🎨 Componentes Clave Implementados

### 1. HomeScreen (Pantalla Principal - ACTUALIZADA)

**Componentes visuales:**
- ✅ **Header con gradiente** → Avatar + "Hola, [Nombre]" + Notificaciones
- ✅ **Posición Global** → Card blanca con saldo **cargado desde Supabase**
- ✅ **Carrusel de Cuentas** → ListView con datos reales de BD
- ✅ **Acciones Rápidas** → 4 botones circulares
- ✅ **Lista de Movimientos** → Items con datos sincronizados
- ✅ **Loading Indicator** → Muestra progreso entre init y carga
- ✅ **Botón Flotante** → "Realizar operación"
- ✅ **BottomNavigationBar** → 4 pestañas

**Flujo de datos (NUEVO):**
```dart
initState()
  └─> _loadDataFromSupabase()
      ├─> SupabaseService.getClientes()   // Carga async
      └─> SupabaseService.getTransacciones()
          ├─ Éxito → setState() + render datos reales
          └─ Error → _useMockData() + fallback
```

### 2. Servicio Supabase (NUEVO)

**Archivo:** `lib/services/supabase_service.dart`

```dart
class SupabaseService {
  // Credenciales (pre-configuradas)
  static const String url = 'https://etlqpvghtqiqofepukqf.supabase.co';
  static const String anonKey = 'eyJhbGci...';
  
  // Métodos disponibles
  static Future<List<Map<String, dynamic>>> getClientes()
  static Future<List<Map<String, dynamic>>> getTransacciones()
  static Future<List<Map<String, dynamic>>> getOperaciones()
  static Future<List<Map<String, dynamic>>> getTransaccionesPorCliente(id)
  static Future<bool> crearOperacion(data)
  static Future<bool> actualizarEstadoOperacion(id, estado)
}
```

### 3. Modal de Operaciones

Al pulsar "Realizar operación":
- ✅ Bottom sheet ocupa 75% de la pantalla
- ✅ Bordes superiores redondeados
- ✅ Handle visual arrastrable
- ✅ 5 acciones con iconos coloreados
- ✅ Botón "Cancelar" en la parte inferior
- ✅ Feedback con SnackBar al seleccionar

### 4. Sistema de Datos

**Antes (mock):**
```dart
List<Account> _accounts = Account.getMockAccounts();
```

**Ahora (Supabase + fallback):**
```dart
List<Account> _accounts = []; // Vacío inicialmente
bool _isLoading = true;

@override
void initState() {
  _loadDataFromSupabase();
}

Future<void> _loadDataFromSupabase() async {
  try {
    final cliente Data = await SupabaseService.getClientes();
    setState(() {
      _accounts = clientesData.map((c) => Account(...)).toList();
      _isLoading = false;
    });
  } catch (e) {
    _useMockData();
  }
}

void _useMockData() {
  setState(() {
    _accounts = Account.getMockAccounts();
    _isLoading = false;
  });
}
```

## 🎨 Paleta de Colores Fintech

```dart
// Archivo: lib/utils/app_colors.dart

Primarios:
- primaryDark:    #0D1B2A (azul marino oscuro)
- primaryNavy:    #1B263B (azul marino)
- accentGreen:    #2EC4B6 (verde turquesa)

Fondos:
- backgroundLight: #F8F9FA (gris muy claro)
- cardDark:        #1E2A3A (tarjetas oscuras)
- cardLight:       #FFFFFF (tarjetas claras)

Operaciones:
- expense:  #E63946 (rojo para gastos)
- income:   #06D6A0 (verde para ingresos)
```

## 🔌 Cómo Integrar con tu Propio Backend

### Paso 1: Cambiar Credenciales Supabase

**En `lib/main.dart`:**
```dart
await Supabase.initialize(
  url: 'TU_URL_SUPABASE',     // Cambiar aquí
  anonKey: 'TU_ANON_KEY',     // Cambiar aquí
);
```

### Paso 2: Actualizar Tablas si Cambian Nombres

**En `lib/services/supabase_service.dart`:**
```dart
// Cambiar rutas de API
final response = await http.get(
  Uri.parse('$url/rest/v1/tu_tabla_aqui'),  // ← Cambiar
  headers: {...}
);
```

### Paso 3: Modificar Conversión de Datos

**En `lib/ui/home_screen.dart`:**
```dart
_accounts = clientesData.map((cliente) {
  return Account(
    id: cliente['tu_campo_id'] ?? '',      // ← Ajustar campos
    nombre: cliente['tu_campo_nombre'] ?? '',
    balance: double.tryParse(...) ?? 0.0,
  );
}).toList();
```

### Paso 4: Test de Conexión

```bash
cd "App movil/globalfin_app"
flutter run -d chrome

# En la consola F12, deberías ver:
✓ Conexión a Supabase exitosa
✓ Se obtuvieron X clientes
```

## 🧪 Testing (Próximo Paso)

Estructura de tests recomendada:

```
test/
├── unit/
│   ├── models/
│   │   ├── account_test.dart
│   │   └── transaction_test.dart
│   └── services/
│       └── supabase_service_test.dart    # ⭐ NUEVO
├── widget/
│   ├── account_card_test.dart
│   ├── transaction_item_test.dart
│   └── operation_bottom_sheet_test.dart
└── integration/
    └── home_screen_test.dart
```

**Test de Supabase:**
```dart
test('getClientes retorna lista no vacía', () async {
  final clientes = await SupabaseService.getClientes();
  expect(clientes, isNotEmpty);
  expect(clientes[0]['nombre'], isNotNull);
});
```

## 🚀 Comandos Rápidos

```bash
# Navegar al proyecto
cd "App movil/globalfin_app"

# Instalar dependencias (incluyendo Supabase)
flutter pub get

# Ejecutar aplicación
flutter run

# Ejecutar en navegador (recomendado para desarrollo)
flutter run -d chrome

# Hot reload durante desarrollo
# Presiona 'r' en la terminal

# Hot restart (reinicia todo)
# Presiona 'R' en la terminal

# Limpiar y reinstalar
flutter clean && flutter pub get

# Analizar código
flutter analyze

# Formatear código
dart format lib/

# Build para producción (web)
flutter build web --release

# Build para Android
flutter build apk --release

# Build para iOS
flutter build ios --release
```

## 🎯 Checklist de Funcionalidades

### ✅ Completado
- [x] Estructura del proyecto Flutter
- [x] Modelos de datos (Account, Transaction, OperationAction)
- [x] Widgets reutilizables (4 componentes)
- [x] HomeScreen completa con todos los elementos
- [x] Modal de operaciones con 5 acciones
- [x] Sistema de colores y estilos
- [x] Tema Material Design 3 configurado
- **[x] Integración Supabase** ⭐ NUEVO
- **[x] Carga automática de datos reales** ⭐ NUEVO
- **[x] Fallback a datos mock** ⭐ NUEVO
- [x] Datos mock como respaldo

### 📋 Pendiente (Sugerencias)
- [ ] Navegación completa entre secciones
- [ ] Pantalla de detalle de transacción
- [ ] Flujos completos de operaciones
- [ ] Autenticación con JWT personalizado
- [ ] Sincronización offline-first
- [ ] State management avanzado (Provider/Bloc)
- [ ] Tests unitarios y de integración
- [ ] Animaciones y transiciones
- [ ] Localización (i18n)
- [ ] Tema oscuro

## 📱 Capturas de Pantalla Disponibles

Wireframes en: `App movil/`
- `low fidelity home.png` - Estructura base
- `low fidelity realizar operacion.png` - Modal
- `high fidelity inicio app.png` - Versión estilizada
- `high fidelity app.png` - Versión final

## 🆘 Solución de Problemas Comunes

### Error: "Conexión a Supabase rechazada"
**Causes posibles:**
- Credenciales incorrectas en main.dart
- Base de datos Supabase no activa
- Sin conectividad a internet

**Solución:**
```bash
# La app automáticamente usa datos mock
# Verifica en consola: ⚠ Error cargando desde Supabase
# Usa datos mock como fallback
```

### Error: "No se cargan datos reales"
**Posibles causas:**
1. Nombres de tablas incorrectos (clientes, transacciones)
2. Tabla vacía en Supabase
3. Permisos RLS demasiado restrictivos

**Solución:**
```bash
# Verifica en Supabase:
# 1. Ir a SQL Editor
# 2. SELECT * FROM clientes; -- Debe retornar registros
# 3. Verificar RLS: deshabilitar para desarrollo
```

### Error: "SDK version"
```bash
flutter --version          # Ver versión
flutter upgrade            # Actualizar
```

### Hot reload no funciona
```bash
# Presiona 'R' para restart completo
# Si persiste, parar y reiniciar:
flutter run
```

## 📚 Recursos de Aprendizaje

- **Flutter Docs**: https://docs.flutter.dev
- **Supabase Docs**: https://supabase.com/docs
- **Material Design 3**: https://m3.material.io
- **Dart Language**: https://dart.dev
- **Flutter Widget Catalog**: https://docs.flutter.dev/ui/widgets

## 🔐 Seguridad en Producción

**Para deploy a producción:**

1. ✅ Usar **anon key** público (solo lectura) - ACTUAL
2. ✅ Configurar **RLS policies** en Supabase
3. ✅ Validar datos en el servidor (no confiar en cliente)
4. ✅ Usar **HTTPS** (siempre)
5. ⚠️ NO incluir credenciales privadas en código
6. ⚠️ NO exponer URL privada de BD

## 🌐 Despliegue en Producción

### Vercel (Recomendado - Actualizado)

La app se **despliegue automáticamente en Vercel** con estos pasos:

```bash
# 1. Compilar build de web
flutter build web --release

# 2. Verificar que build esté en /public/
ls public/             # Debe mostrar index.html

# 3. Commit y push
git add .
git commit -m "feat: Actualización Supabase"
git push origin main   # Vercel auto-deploya

# 4. Acceder en navegador
# https://proyecto-globalfin.vercel.app
```

**Build incluye:**
- ✅ Código compilado (minificado)
- ✅ Assets (imágenes, fonts)
- ✅ Credenciales Supabase (anon key - public OK)
- ✅ Fallback a datos mock

## 👥 Contribuir

Para extender este proyecto:

1. **Crear nuevas pantallas** en `lib/ui/`
2. **Agregar servicios** en `lib/services/` (ej: auth, payments)
3. **Nuevos widgets** en `lib/widgets/`
4. **Modelos** en `lib/models/`
5. **Mantener paleta de colores** consistente

**Workflow sugerido:**
```bash
git checkout -b feature/nueva-funcionalidad
# ... desarrollar ...
git add .
git commit -m "feat: descripción"
git push origin feature/nueva-funcionalidad
# Crear PR en GitHub
```

---

**Proyecto:** GlobalFin Mobile App  
**Versión:** 2.0.0 (con Supabase integrado)  
**Framework:** Flutter 3.41.2+  
**Base de Datos:** Supabase PostgreSQL  
**Deploy:** Vercel (automático)  
**Estado:** ✅ Producción lista
