# 🚀 Inicio Rápido - GlobalFin App

## ⚡ Ejecutar el Proyecto en 3 Pasos

### 1️⃣ Navegar al proyecto
```bash
cd "App movil/globalfin_app"
```

### 2️⃣ Instalar dependencias
```bash
flutter pub get
```

### 3️⃣ Ejecutar la app
```bash
flutter run
```

Si tienes múltiples dispositivos:
```bash
flutter devices              # Ver dispositivos disponibles
flutter run -d chrome        # Ejecutar en navegador
flutter run -d <device_id>   # Ejecutar en dispositivo específico
```

---

## 📱 Vista Previa de la App

### Pantalla de Inicio Incluye:
- ✅ Header con "Hola, Cristian" + avatar + notificaciones
- ✅ Tarjeta "Posición Global" con saldo total: **€ 24,590.75**
- ✅ Carrusel de 3 cuentas con gradientes oscuros
- ✅ 4 acciones rápidas (Enviar, Escanear, Recibos, Más)
- ✅ Lista de 7 últimos movimientos con iconos y colores
- ✅ Botón flotante verde "Realizar operación"
- ✅ Bottom navigation con 4 pestañas

### Modal de Operaciones Incluye:
- ✅ 5 acciones: Transferir, Pagar recibo, Bizum, Ingresar cheque, Crear incidencia
- ✅ Cada acción con icono de color, título y descripción
- ✅ Botón "Cancelar" para cerrar

---

## 📂 Archivos Clave

### 🎯 Empezar por aquí:
1. **`lib/main.dart`** → Punto de entrada y tema
2. **`lib/ui/home_screen.dart`** → Pantalla principal (425 líneas)
3. **`README.md`** → Documentación completa

### 🎨 Personalizar estilos:
- **`lib/utils/app_colors.dart`** → Cambiar colores
- **`lib/utils/app_text_styles.dart`** → Cambiar tipografías

### 📦 Modificar datos mock:
- **`lib/models/account.dart`** → Método `getMockAccounts()`
- **`lib/models/transaction.dart`** → Método `getMockTransactions()`

### 🧩 Widgets reutilizables:
- **`lib/widgets/account_card.dart`** → Tarjeta de cuenta
- **`lib/widgets/transaction_item.dart`** → Item de movimiento
- **`lib/widgets/operation_bottom_sheet.dart`** → Modal de operaciones

---

## 🎨 Personalización Rápida

### Cambiar el nombre del usuario:
Editar `lib/ui/home_screen.dart` línea ~120:
```dart
Text(
  'Hola, TU_NOMBRE',  // ← Cambiar aquí
  style: AppTextStyles.headerMedium.copyWith(
    color: AppColors.textLight,
  ),
),
```

### Cambiar color acento (verde → otro color):
Editar `lib/utils/app_colors.dart`:
```dart
static const Color accentGreen = Color(0xFF2EC4B6);  // ← Cambiar HEX aquí
```

### Agregar más cuentas mock:
Editar `lib/models/account.dart` → método `getMockAccounts()`:
```dart
Account(
  id: '4',
  name: 'Cuenta Nueva',
  lastDigits: '1234',
  balance: 5000.00,
  monthVariation: 3.5,
),
```

---

## 🔥 Características de Desarrollo

### Hot Reload
Mientras la app corre, puedes hacer cambios en el código y:
- Presiona **`r`** → Recarga rápida (mantiene estado)
- Presiona **`R`** → Reinicio completo

### Atajos en la terminal:
```
r  → Reload                    q  → Quit
R  → Hot restart               h  → Help
```

---

## ✅ Checklist de Verificación

Antes de ejecutar, verifica que tengas:
- [ ] Flutter SDK instalado (`flutter --version`)
- [ ] Editor de código (VS Code / Android Studio)
- [ ] Dispositivo o emulador conectado (`flutter devices`)
- [ ] Dependencias instaladas (`flutter pub get`)

Si algo falta:
```bash
flutter doctor    # Diagnóstico completo
```

---

## 🐛 Solución Rápida de Problemas

### Error: "No devices found"
```bash
# Android
- Abrir Android Studio
- Tools → Device Manager → Create Device

# iOS (solo en Mac)
open -a Simulator
```

### Error: "Waiting for another flutter command..."
```bash
killall -9 dart
flutter clean
```

### Error en `pubspec.yaml`
```bash
flutter clean
flutter pub get
```

---

## 📚 Documentación Completa

| Archivo | Contenido |
|---------|-----------|
| **README.md** | Documentación general del proyecto |
| **GUIA_IMPLEMENTACION.md** | Guía completa con ejemplos de backend |
| **INDICE_ARCHIVOS.md** | Lista detallada de todos los archivos |

---

## 🎯 Próximos Pasos Recomendados

### Nivel 1: Familiarización (1-2 horas)
1. Ejecutar la app y explorar todas las funcionalidades
2. Leer `home_screen.dart` para entender la estructura
3. Modificar datos mock para ver cambios en tiempo real

### Nivel 2: Personalización (2-4 horas)
1. Cambiar colores en `app_colors.dart`
2. Agregar más cuentas y transacciones mock
3. Modificar textos y mensajes

### Nivel 3: Extensión (5-10 horas)
1. Implementar navegación entre pestañas
2. Crear pantalla de detalle de transacción
3. Agregar animaciones y transiciones

### Nivel 4: Integración (10+ horas)
1. Implementar state management (Provider/Bloc)
2. Conectar con backend real (ver `GUIA_IMPLEMENTACION.md`)
3. Agregar autenticación y seguridad

---

## 💡 Tips Profesionales

### Performance
- Usa `const` en widgets que no cambian
- Evita `setState()` innecesarios
- Usa `ListView.builder` para listas largas

### UX
- Siempre proporciona feedback visual
- Mantén botones >48px de altura
- Usa colores consistentes

### Código limpio
- Separa widgets grandes en componentes
- Usa nombres descriptivos
- Comenta lógica compleja

---

## 🆘 Soporte

### Recursos oficiales:
- Flutter Docs: https://docs.flutter.dev
- Flutter Discord: https://discord.gg/flutter
- Stack Overflow: [flutter] tag

### En este proyecto:
- Ver `README.md` para arquitectura
- Ver `GUIA_IMPLEMENTACION.md` para ejemplos avanzados
- Ver `INDICE_ARCHIVOS.md` para navegación

---

**¡Listo para empezar!** 🎉

Ejecuta `flutter run` y comienza a explorar GlobalFin.
