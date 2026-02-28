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
- ✅ Tarjeta "Posición Global" con saldo total **cargado desde Supabase**
- ✅ Carrusel de 3+ cuentas con datos reales
- ✅ 4 acciones rápidas (Enviar, Escanear, Recibos, Más)
- ✅ Lista de movimientos con datos **sincronizados en tiempo real**
- ✅ Botón flotante verde "Realizar operación"
- ✅ Bottom navigation con 4 pestañas

### 🔄 Loading Automático (Nuevo)
Cuando abres la app:
1. Se muestra un indicador de carga ⏳
2. La app conecta a Supabase automáticamente
3. Carga clientes y transacciones en tiempo real
4. Fallback automático a datos mock si la conexión falla

**En la consola verás:**
```
✓ Conexión a Supabase exitosa
✓ Se obtuvieron 10 clientes
✓ Se cargaron 10 transacciones
```

---

## ⚙️ Configuración Supabase

La app está **pre-configurada** con credenciales de Supabase en `main.dart`:

```dart
await Supabase.initialize(
  url: 'https://etlqpvghtqiqofepukqf.supabase.co',
  anonKey: 'eyJhbGci...', // Token JWT incluido
);
```

**No necesitas hacer nada, funciona automáticamente.**

---

## 📂 Archivos Clave

### 🎯 Empezar por aquí:
1. **`lib/main.dart`** → Punto de entrada + Supabase init
2. **`lib/ui/home_screen.dart`** → Pantalla principal (ahora con datos reales)
3. **`lib/services/supabase_service.dart`** → Conexión a BD
4. **`README.md`** → Documentación completa

### 🎨 Personalizar estilos:
- **`lib/utils/app_colors.dart`** → Cambiar colores
- **`lib/utils/app_text_styles.dart`** → Cambiar tipografías

### 🗄️ Cambiar datos (Supabase):
Para agregar/editar clientes y transacciones:
- Ir a: https://supabase.com → Login → Proyecto → SQL Editor
- Tablas disponibles: `clientes`, `transacciones`, `operaciones`
- **Importante:** Los cambios se sincronizan automáticamente en la app

**Ejemplo: Agregar un nuevo cliente**
```sql
INSERT INTO clientes (nombre, apellido, saldo, estado)
VALUES ('Juan', 'García', 50000, 'activo');
```

### 📦 Fallback a datos mock:
Si necesitas datos de prueba sin Supabase:
- Editar `lib/models/account.dart` → método `getMockAccounts()`
- Editar `lib/models/transaction.dart` → método `getMockTransactions()`

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

### Cambiar URL o credenciales Supabase:
**Importante:** Las credenciales actuales son públicas (anon key), solo lectura.

Editar `lib/main.dart`:
```dart
await Supabase.initialize(
  url: 'TU_URL_SUPABASE',
  anonKey: 'TU_ANON_KEY',
);
```

---

## 🌐 Despliegue en Producción

La app se **desplega automáticamente en Vercel** cuando haces `git push`:

```bash
git status                  # Ver cambios
git add .
git commit -m "Tus cambios"
git push origin main        # Deploy automático ✅
```

Ver en el navegador: https://proyecto-globalfin.vercel.app

---

## 🚨 Solución de Problemas

### "No se puede conectar a Supabase"
**Solución:** La app automáticamente usa datos mock. Verifica:
1. ¿Tienes conexión a internet?
2. ¿Las credenciales en main.dart son correctas?
3. ¿La base de datos Supabase está activa?

### "Datos vacíos / No se cargan"
**Solución:** Verifica la consola (F12):
```
// Debe mostrar:
✓ Se obtuvieron 10 clientes
✓ Se cargaron X transacciones

// Si ves error, comprueba:
1. Los nombres de las tablas (clientes, transacciones)
2. Permisos RLS en Supabase
3. Clave JWT válida
```

### "Flutter no se encuentra"
Ver archivo: `FLUTTER_NO_INSTALADO.md`

---

## 📚 Documentación Completa

- **README.md** → Visión general y arquitectura
- **GUIA_IMPLEMENTACION.md** → Detalles técnicos
- **INDICE_ARCHIVOS.md** → Descripción de cada archivo
- **DIAGRAMAS_FLUJOS.md** → Flujo de datos y componentes
- Carpeta app → Supabase integration details

---

**Última actualización:** 28 de Febrero, 2026  
**Estado:** ✅ Completamente funcional con Supabase
