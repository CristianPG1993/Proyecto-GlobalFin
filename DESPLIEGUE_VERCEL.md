# 🚀 Desplegar GlobalFin en Vercel

## 📱 App Móvil Flutter (Cliente)

La aplicación móvil de GlobalFin está lista para desplegarse en Vercel.

### Pasos para Desplegar:

#### 1️⃣ Desde GitHub (Recomendado)

**A. Hacer commit y push del código:**

```bash
cd /workspaces/Proyecto-GlobalFin

# Agregar archivos
git add "App movil/" vercel.json .vercelignore DESPLIEGUE_VERCEL.md

# Commit
git commit -m "feat: Configurar app Flutter para despliegue en Vercel"

# Push
git push origin main
```

**B. Conectar con Vercel:**

1. Ve a [vercel.com](https://vercel.com) e inicia sesión
2. Click en **"Add New Project"**
3. Importa tu repositorio: `CristianPG1993/Proyecto-GlobalFin`
4. Vercel detectará automáticamente la configuración
5. **Framework Preset**: Other
6. **Build Command**: (se usará del vercel.json)
7. **Output Directory**: `App movil/globalfin_app/build/web`
8. Click en **"Deploy"**

**C. Variables de entorno (opcional):**

Si más adelante conectas con un backend real, puedes agregar:
```
API_URL=https://tu-backend.com/api
```

#### 2️⃣ Desde Vercel CLI

```bash
# Instalar Vercel CLI
npm i -g vercel

# Login
vercel login

# Desplegar (desde la raíz del proyecto)
cd /workspaces/Proyecto-GlobalFin
vercel

# Para producción
vercel --prod
```

### 📋 Verificación del Build

El build ya está compilado en:
```
App movil/globalfin_app/build/web/
```

Contiene:
- ✅ `index.html` - Entrada principal
- ✅ `flutter.js` - Runtime de Flutter
- ✅ `main.dart.js` - Código compilado
- ✅ `assets/` - Fuentes, imágenes, etc.
- ✅ `canvaskit/` - Renderizado Canvas

### 🌐 URL de Producción

Una vez desplegado, tu app estará disponible en:
```
https://globalfin-app.vercel.app
```
(o el dominio que Vercel te asigne)

### 🎯 Características Desplegadas

La app incluye:
- 🏠 **Pantalla Principal** con posición global
- 💳 **Carrusel de Cuentas** (3 cuentas mock)
- 💰 **Acciones Rápidas** (6 operaciones)
- 📊 **Lista de Transacciones** (7 transacciones recientes)
- 🔔 **Notificaciones** y perfil de usuario
- 📱 **Bottom Navigation** con 5 opciones
- 📋 **Bottom Sheet** de operaciones

### ⚙️ Configuración Personalizada

Si necesitas cambiar algo:

**Cambiar puerto de desarrollo:**
```json
// vercel.json
"devCommand": "flutter run -d web-server --web-port 8080"
```

**Agregar variables de entorno:**
```json
// vercel.json
"env": {
  "API_BASE_URL": "https://api.globalfin.com"
}
```

### 🔄 Actualizaciones Automáticas

Vercel re-desplegará automáticamente cuando:
- Hagas `git push` a la rama `main`
- Actualices archivos en la carpeta `App movil/`
- Cambies `vercel.json`

---

## 🖥️ Dashboard JavaFX (Empleados)

El dashboard **NO** se despliega en Vercel (es una app de escritorio).

### Cómo Usar el Dashboard:

**En tu máquina local:**

```bash
# Clonar repositorio
git clone https://github.com/CristianPG1993/Proyecto-GlobalFin.git
cd Proyecto-GlobalFin/dashboard/globalfin-dashboard

# Ejecutar
mvn javafx:run
```

**Requisitos:**
- Java 17+
- Maven 3.6+
- Entorno con interfaz gráfica (Windows, Mac, Linux con X11)

**Distribución a empleados:**

Puedes crear un JAR ejecutable:
```bash
cd dashboard/globalfin-dashboard
mvn clean package

# El JAR estará en:
# target/dashboard-empleados-1.0.0-SNAPSHOT.jar
```

Luego distribuir este JAR a los empleados internos.

---

## 📊 Arquitectura Final

```
┌─────────────────────────────────────┐
│                                     │
│    👥 CLIENTES                      │
│                                     │
│   App Móvil Flutter                 │
│   📱 Vercel (Web)                   │
│   https://globalfin.vercel.app      │
│                                     │
└──────────────┬──────────────────────┘
               │
               │ Future Backend API
               │
┌──────────────▼──────────────────────┐
│                                     │
│    👨‍💼 EMPLEADOS                     │
│                                     │
│   Dashboard JavaFX                  │
│   🖥️  Local (Escritorio)            │
│   mvn javafx:run                    │
│                                     │
└─────────────────────────────────────┘
```

---

## ✅ Checklist de Despliegue

- [ ] Código subido a GitHub
- [ ] Cuenta creada en Vercel
- [ ] Proyecto importado en Vercel
- [ ] Build exitoso
- [ ] App accesible en URL de producción
- [ ] Funcionalidades probadas en producción
- [ ] Dashboard JavaFX probado localmente

---

## 🆘 Troubleshooting

### Build falla en Vercel
- **Problema**: Flutter no está instalado
- **Solución**: Vercel necesita configuración especial. Mejor opción: usar el build pre-compilado

### App no carga correctamente
- **Problema**: Rutas incorrectas
- **Solución**: Verificar que `vercel.json` tiene las rewrites correctas

### Dashboard no se puede desplegar
- **Respuesta**: Correcto. JavaFX es solo para escritorio, no web.

---

## 📚 Recursos

- [Vercel Docs](https://vercel.com/docs)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [JavaFX Documentation](https://openjfx.io/)

---

**¡Listo para desplegar! 🚀**
