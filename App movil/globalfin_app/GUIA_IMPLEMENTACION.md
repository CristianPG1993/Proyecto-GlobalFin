# GlobalFin App - Guía de Implementación

## 📁 Estructura Completa del Proyecto

```
App movil/globalfin_app/
├── lib/
│   ├── main.dart                          # Punto de entrada + tema
│   ├── ui/
│   │   └── home_screen.dart              # Pantalla principal (380 líneas)
│   ├── widgets/                          # Componentes reutilizables
│   │   ├── account_card.dart             # Tarjeta de cuenta con gradiente
│   │   ├── transaction_item.dart         # Ítem de movimiento
│   │   ├── operation_action_item.dart    # Ítem de acción
│   │   └── operation_bottom_sheet.dart   # Modal de operaciones
│   ├── models/                           # Modelos de datos
│   │   ├── account.dart                  # Cuenta bancaria
│   │   ├── transaction.dart              # Transacción/Movimiento
│   │   └── operation_action.dart         # Acción de operación
│   └── utils/                            # Utilidades
│       ├── app_colors.dart               # Paleta de colores
│       └── app_text_styles.dart          # Estilos de texto
├── pubspec.yaml                          # Dependencias Flutter
├── analysis_options.yaml                 # Reglas de linting
└── README.md                             # Documentación completa
```

## 🎨 Componentes Clave Implementados

### 1. HomeScreen (Pantalla Principal)

Componentes visuales:
- ✅ **Header con gradiente** → Avatar + "Hola, [Nombre]" + Notificaciones
- ✅ **Posición Global** → Card blanca con saldo total grande
- ✅ **Carrusel de Cuentas** → ListView horizontal, tarjetas oscuras con gradiente
- ✅ **Acciones Rápidas** → 4 botones circulares (Enviar, Escanear, Recibos, Más)
- ✅ **Lista de Movimientos** → Items con icono + texto + importe coloreado
- ✅ **Botón Flotante** → "Realizar operación" con sombra y elevación
- ✅ **BottomNavigationBar** → 4 pestañas (Inicio activo)

### 2. Modal de Operaciones

Al pulsar "Realizar operación":
- ✅ Bottom sheet ocupa 75% de la pantalla
- ✅ Bordes superiores redondeados
- ✅ Handle visual arrastrable
- ✅ 5 acciones con iconos coloreados
- ✅ Botón "Cancelar" en la parte inferior
- ✅ Feedback con SnackBar al seleccionar

### 3. Sistema de Datos Mock

Datos incluidos:
- **3 cuentas** con saldos y variación mensual
- **7 transacciones** (mix de gastos e ingresos)
- **5 acciones** disponibles en el modal

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

## 💡 Código de Ejemplo: Abrir Modal

```dart
// En cualquier widget con BuildContext:

import 'package:globalfin_app/widgets/operation_bottom_sheet.dart';

ElevatedButton(
  onPressed: () {
    OperationBottomSheet.show(context);
  },
  child: Text('Realizar operación'),
)
```

## 🔌 Cómo Extender con Backend Real

### Paso 1: Crear Servicio de API

```dart
// lib/services/account_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';

class AccountService {
  static const String baseUrl = 'https://api.globalfin.com';

  Future<List<Account>> fetchAccounts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/accounts'),
      headers: {'Authorization': 'Bearer TOKEN'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Account.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar cuentas');
    }
  }
}
```

### Paso 2: Modificar Modelo Account

```dart
// Agregar en lib/models/account.dart

  // Factory para parsear JSON desde API
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      name: json['name'] as String,
      lastDigits: json['last_digits'] as String,
      balance: (json['balance'] as num).toDouble(),
      monthVariation: (json['month_variation'] as num).toDouble(),
    );
  }

  // Convertir a JSON para enviar a API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_digits': lastDigits,
      'balance': balance,
      'month_variation': monthVariation,
    };
  }
```

### Paso 3: Usar en HomeScreen con FutureBuilder

```dart
// En home_screen.dart

FutureBuilder<List<Account>>(
  future: AccountService().fetchAccounts(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    final accounts = snapshot.data ?? [];
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountCard(account: accounts[index]);
      },
    );
  },
)
```

## 📦 Dependencias a Agregar (Futuro)

Para conectar con backend real, agregar en `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # HTTP
  http: ^1.1.0
  
  # State Management
  provider: ^6.1.0
  # O alternativamente:
  # flutter_bloc: ^8.1.0
  # riverpod: ^2.4.0
  
  # Almacenamiento local
  shared_preferences: ^2.2.0
  
  # Secure storage (tokens)
  flutter_secure_storage: ^9.0.0
  
  # JSON serialization
  json_annotation: ^4.8.0

dev_dependencies:
  # JSON code generation
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
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
│       └── account_service_test.dart
├── widget/
│   ├── account_card_test.dart
│   ├── transaction_item_test.dart
│   └── operation_bottom_sheet_test.dart
└── integration/
    └── home_screen_test.dart
```

## 🚀 Comandos Rápidos

```bash
# Navegar al proyecto
cd "App movil/globalfin_app"

# Instalar dependencias
flutter pub get

# Ejecutar app
flutter run

# Ejecutar en dispositivo específico
flutter run -d chrome          # Web
flutter run -d "iPhone 15"     # iOS Simulator
flutter run -d emulator-5554   # Android Emulator

# Hot reload durante desarrollo
# Presiona 'r' en la terminal mientras corre

# Hot restart completo
# Presiona 'R' en la terminal

# Limpiar build
flutter clean && flutter pub get

# Analizar código
flutter analyze

# Formatear código
dart format lib/

# Build para producción
flutter build apk --release     # Android
flutter build ios --release     # iOS
flutter build web --release     # Web
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
- [x] Datos mock para demostración
- [x] Navegación bottom bar
- [x] Feedback visual en interacciones

### 📋 Pendiente (Sugerencias)
- [ ] Navegación completa entre secciones
- [ ] Pantalla de detalle de transacción
- [ ] Flujos completos de operaciones
- [ ] Autenticación y login
- [ ] Integración con backend
- [ ] State management (Provider/Bloc)
- [ ] Tests unitarios y de integración
- [ ] Animaciones y transiciones
- [ ] Localización (i18n)
- [ ] Modo oscuro

## 📱 Capturas de Pantalla Disponibles

Wireframes en: `App movil/`
- `low fidelity home.png`
- `low fidelity reealizar operacion.png`
- `high fidelity inicio app.png`
- `high fidelity app.png`

## 🆘 Solución de Problemas Comunes

### Error: "SDK version"
```bash
# Asegúrate de tener Flutter 3.0+
flutter --version
flutter upgrade
```

### Error: "Gradle build failed" (Android)
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error: "CocoaPods not installed" (iOS)
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
```

### Hot reload no funciona
```bash
# Restart completo
Presiona 'R' en la terminal

# Si persiste, parar y reiniciar
flutter run
```

## 📚 Recursos de Aprendizaje

- **Flutter Docs**: https://docs.flutter.dev
- **Material Design 3**: https://m3.material.io
- **Dart Language**: https://dart.dev
- **Flutter Widget Catalog**: https://docs.flutter.dev/ui/widgets
- **Flutter Layout Cheat Sheet**: https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

## 👥 Contribuir

Este es un proyecto base modular. Para extenderlo:

1. Crear nuevas pantallas en `lib/ui/`
2. Agregar widgets reutilizables en `lib/widgets/`
3. Definir modelos en `lib/models/`
4. Crear servicios en `lib/services/`
5. Mantener la paleta de colores consistente

---

**Proyecto:** GlobalFin Mobile App  
**Versión:** 1.0.0  
**Framework:** Flutter 3.0+  
**Estado:** ✅ Primera versión funcional completada
