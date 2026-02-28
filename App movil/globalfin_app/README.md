# GlobalFin App - Aplicación Móvil

Primera versión funcional de la app móvil bancaria GlobalFin desarrollada en Flutter.

## 📱 Características Implementadas

### Pantalla de Inicio (Home)
- ✅ Header con avatar, bienvenida y notificaciones
- ✅ Bloque de posición global con total de saldos
- ✅ Carrusel horizontal de tarjetas de cuenta
  - Nombre de cuenta
  - Últimos 4 dígitos (enmascarados)
  - Saldo actual
  - Variación mensual con indicador
- ✅ Acciones rápidas (Enviar, Escanear, Recibos, Más)
- ✅ Lista de últimos movimientos con:
  - Icono por categoría
  - Nombre del comercio/operación
  - Fecha
  - Importe (rojo para gastos, verde para ingresos)
- ✅ Botón flotante "Realizar operación"
- ✅ Barra de navegación inferior (4 secciones)

### Modal "Realizar Operación"
- ✅ Bottom sheet con bordes redondeados
- ✅ Lista de 5 acciones principales:
  - Transferir dinero
  - Pagar recibo
  - Enviar Bizum
  - Ingresar cheque
  - Crear incidencia
- ✅ Cada acción con icono coloreado, título y subtítulo
- ✅ Botón "Cancelar" para cerrar
- ✅ Feedback visual al seleccionar

## 🏗️ Arquitectura del Proyecto

```
lib/
├── main.dart                       # Punto de entrada y configuración del tema
├── ui/
│   └── home_screen.dart           # Pantalla principal con todos los componentes
├── widgets/
│   ├── account_card.dart          # Tarjeta de cuenta con gradiente
│   ├── transaction_item.dart      # Ítem de movimiento/transacción
│   ├── operation_action_item.dart # Ítem de acción en el modal
│   └── operation_bottom_sheet.dart # Modal de operaciones
├── models/
│   ├── account.dart               # Modelo de cuenta bancaria
│   ├── transaction.dart           # Modelo de transacción
│   └── operation_action.dart      # Modelo de acción de operación
└── utils/
    ├── app_colors.dart            # Paleta de colores fintech
    └── app_text_styles.dart       # Estilos de texto reutilizables
```

## 🎨 Diseño y UX

### Paleta de Colores
- **Primarios**: Azul marino oscuro (`#0D1B2A`, `#1B263B`)
- **Acento**: Verde turquesa (`#2EC4B6`)
- **Fondos**: Gris claro (`#F8F9FA`)
- **Gastos**: Rojo (`#E63946`)
- **Ingresos**: Verde (`#06D6A0`)

### Principios UX Aplicados
- ✅ Contraste adecuado de textos
- ✅ Botones con altura mínima de 48px
- ✅ Feedback visual en todas las interacciones
- ✅ Tipografía legible (tamaños grandes para cantidades)
- ✅ Espaciado consistente
- ✅ Sombras sutiles para jerarquía visual

## 🚀 Cómo Ejecutar

### Requisitos Previos
- Flutter SDK 3.0 o superior
- Dart 3.0 o superior
- Android Studio / Xcode (para simuladores)
- VS Code con extensión de Flutter (opcional)

### Instalación

1. **Clonar el repositorio**
```bash
cd "App movil/globalfin_app"
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar en modo debug**
```bash
flutter run
```

4. **Ejecutar en dispositivo específico**
```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device_id>
```

### Comandos Útiles

```bash
# Verificar instalación de Flutter
flutter doctor

# Limpiar el proyecto
flutter clean

# Compilar para release (Android)
flutter build apk --release

# Compilar para release (iOS)
flutter build ios --release

# Analizar código
flutter analyze
```

## 📊 Datos Mock

La aplicación incluye datos de ejemplo para demostración:
- **3 cuentas bancarias** con diferentes saldos y variaciones
- **7 transacciones** recientes (gastos e ingresos)
- **5 acciones** de operación en el bottom sheet

Los datos se cargan desde los métodos estáticos:
- `Account.getMockAccounts()`
- `Transaction.getMockTransactions()`
- `OperationAction.getAllActions()`

## 🔌 Preparado para Backend

La estructura del proyecto está lista para conectarse a un backend:

1. **Modelos**: Ya definidos con propiedades claras
2. **Separación de lógica**: UI separada de datos
3. **Agregar servicios**: Crear carpeta `lib/services/` para APIs
4. **State management**: Preparado para agregar Provider/Bloc/Riverpod

### Ejemplo de integración futura:
```dart
// lib/services/account_service.dart
class AccountService {
  Future<List<Account>> fetchAccounts() async {
    // Llamada a API REST
  }
}
```

## 📝 Próximos Pasos Sugeridos

1. **Navegación completa**: Implementar las 4 secciones del bottom nav
2. **Detalle de transacción**: Pantalla al tocar un movimiento
3. **Flujos de operación**: Pantallas para cada acción del modal
4. **Autenticación**: Login y biometría
5. **State management**: Implementar Provider o Bloc
6. **Integración API**: Conectar con backend real
7. **Testing**: Unit tests y widget tests
8. **Animaciones**: Transiciones suaves entre pantallas

## 🛠️ Tecnologías Utilizadas

- **Flutter 3.0+**: Framework multiplataforma
- **Material Design 3**: Sistema de diseño
- **Dart 3.0+**: Lenguaje de programación

## 📄 Licencia

Este es un proyecto educativo/demostrativo de GlobalFin.
