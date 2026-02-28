# 🚀 Desplegar GlobalFin en Vercel

**Estado Actual**: ✅ Desplegado y sincronizado con Supabase

## 📱 App Móvil Flutter en Vercel

La aplicación Flutter está compilada y lista para despliegue automático en Vercel.

### ✨ Características Desplegadas

- 🏠 **Pantalla Principal** - Carga datos reales de Supabase
- 💳 **Carrusel de Cuentas** - Clientes desde BD
- 💰 **Operaciones Rápidas** - 6 acciones disponibles
- 📊 **Transacciones** - Lista actualizada en tiempo real
- 🔔 **Notificaciones** - Perfil de usuario
- 📱 **Bottom Navigation** - 5 secciones
- 🔄 **Loading Indicator** - Mientras carga de Supabase
- ⚠️ **Fallback Automático** - Datos mock si falla BD

### 🌐 Despliegue Automático

**Vercel detecta cambios automáticamente cuando hagas:**

```bash
git push origin main
```

El despliegue se inicia automáticamente y publica en:
```
https://tu-dominio-vercel.vercel.app
```

### 📋 Verificación del Build

El build ya está listo en:
```
/workspaces/Proyecto-GlobalFin/public/
```

Contiene:
- ✅ `index.html` - Punto de entrada
- ✅ `flutter.js` - Runtime de Flutter
- ✅ `flutter_bootstrap.js` - Bootstrap
- ✅ `assets/` - Fuentes e imágenes
- ✅ `canvaskit/` - Motor de renderizado

### 🔌 Conexión con Supabase

**En producción, la app conecta a:**

```
URL: https://etlqpvghtqiqofepukqf.supabase.co
Método: REST API
Autenticación: API Key (anon)
```

**Datos que carga:**
- Clientes (10 registros)
- Transacciones (10 registros)
- Operaciones (10 registros)

### 📝 Archivos de Configuración

**`vercel.json`** - Configuración de build y deploy

```json
{
  "buildCommand": "",
  "outputDirectory": "public",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

**`.vercelignore`** - Archivos ignorados en deploy

```
dashboard/
App movil/globalfin_app/build/
App movil/globalfin_app/.dart_tool/
node_modules/
.git/
```

### 📜 Historial de Despliegues

Vercel almacena el historial completo de todos los despliegues.

Para ver:
1. Ve a tu dashboard de Vercel
2. Selecciona "Deployments"
3. Visualiza historial, logs y rollbacks

### ♻️ Realizar Rollback

Si algo falla:

```bash
# En Vercel Dashboard:
1. Deployments tab
2. Selecciona despliegue anterior
3. Click "Redeploy"
```

### 🔄 Flujo de Actualización

```
Git Commit  →  Git Push  →  GitHub  →  Vercel Webhook  →  Build  →  Deploy
   Local        main branch   Remote    Auto trigger      (1-2 min)  Live
```

### 📊 Monitoreo y Logs

**En Vercel Dashboard:**

1. **Build Logs** - Errores de compilación
2. **Runtime Logs** - Errores en ejecución
3. **Analytics** - Visitantes, performance
4. **Edge Network** - Velocidad de carga

---

## 🖥️ Dashboard JavaFX (No en Vercel)

El dashboard **no se despliega en Vercel** porque es una aplicación de escritorio.

### Distribución local

**Requisitos:**
- Java 17+
- Maven 3.6+
- Interfaz gráfica

### Ejecutar localmente

```bash
git clone https://github.com/CristianPG1993/Proyecto-GlobalFin.git
cd Proyecto-GlobalFin/dashboard/globalfin-dashboard
mvn javafx:run
```

### Distribución a empleados

**Crear JAR ejecutable:**

```bash
cd dashboard/globalfin-dashboard
mvn clean package
```

**Archivo generado:**
```
target/dashboard-empleados.jar
```

**Ejecutar JAR:**
```bash
java -jar target/dashboard-empleados.jar
```

## 🗄️ Base de Datos (Supabase Cloud)

**Ya está en la nube y accesible desde cualquier lugar.**

### URL
```
https://etlqpvghtqiqofepukqf.supabase.co
```

### Acceso a Datos

**Desde la app Flutter (Vercel):**
- ✅ Conecta automáticamente a Supabase
- ✅ Carga clientes y transacciones reales
- ✅ Si falla, muestra datos mock

**Desde el dashboard (Local):**
- ✅ Conecta automáticamente a Supabase
- ✅ Carga operaciones reales
- ✅ Si falla, muestra datos mock

### 🔐 Credenciales

```
Anon Key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
(Incluida en código fuente - OK para anon key pública)
```

### 📋 Tablas

1. **clientes** (10 registros)
   - id, nombre, apellido, email, telefono, saldo, estado

2. **operaciones** (10 registros)
   - id, id_cliente, monto, tipo, estado, nivel_riesgo, canal

3. **transacciones** (10 registros)
   - id, id_cliente, id_operacion, monto, tipo, descripcion

---

## 📊 Arquitectura Final en Producción

```
┌──────────────────────────────────────────┐
│     Clientes (Navegador Web)             │
│     https://tu-vercel-app.vercel.app     │
│     📱 App Flutter Compilada             │
│     ✅ Carga desde Supabase              │
│     ✅ Material Design 3                 │
│     ✅ Responsive Design                 │
└────────────────┬─────────────────────────┘
                 │
                 │ REST API (HTTPS)
                 ├─────────────────────────────────────────────────┐
                 │                                                 │
    ┌────────────▼──────────────────────────┐    ┌──────────────▼────────────┐
    │ Supabase PostgreSQL (Producción)      │    │ Dashboard JavaFX    │
    │ https://supabase.co                   │    │ 👨‍💼 Empleados (Local)    │
    │ ✅ 30 registros de prueba             │    │ mvn javafx:run      │
    │ ✅ Row Level Security (RLS)           │    │ ✅ Carga real time  │
    │ ✅ REST API automático                │    └─────────────────────────┘
    │ ✅ Backups automáticos                │
    └──────────────────────────────────────┘
```

---

## ✅ Checklist de Validación

- [x] Build Flutter compilado en `/public`
- [x] `vercel.json` configurado correctamente
- [x] `.vercelignore` actualizado
- [x] Supabase conectado desde función REST
- [x] App cargando clientes desde BD
- [x] Fallback a datos mock si falla
- [x] Despliegue automático activado
- [x] Dashboard funciona localmente
- [x] Dashboard conecta a Supabase
- [x] Documentación actualizada

---

## 🆘 Troubleshooting

### La app no carga datos de Supabase

**Síntomas:** Muestra datos mock permanentemente

**Soluciones:**
1. Verifica conexión a internet
2. Revisa Supabase Dashboard - ¿Tablas existen?
3. Verifica headers en request (apikey)
4. Mira console del navegador (F12)

### Vercel muestra error 404

**Soluciones:**
1. Verifica `vercel.json` - rewrites correctos
2. Verifica `outputDirectory: "public"`
3. Reconstruye: `flutter build web`
4. Actualiza `/public` con nuevo build

### Dashboard no conecta a Supabase localmente

**Soluciones:**
1. Verifica conexión a internet
2. Revisa que tienes Java 17+
3. Revisa Maven está instalado
4. Mira logs de Maven para errores

---

## 📈 Próximos Pasos

1. **Monitoreo en Producción**
   - Configurar alertas en Vercel
   - Monitorear errores con Sentry

2. **Optimizaciones**
   - Caché de datos
   - Compresión de imágenes
   - Lazy loading de datos

3. **Autenticación**
   - Login con Supabase Auth
   - Roles y permisos
   - Refresh tokens

4. **Nuevas Características**
   - Notificaciones push
   - Chat en tiempo real
   - Gráficos y reportes

---

**Última actualización**: 28 de Febrero, 2026  
**Estado**: ✅ En Producción
