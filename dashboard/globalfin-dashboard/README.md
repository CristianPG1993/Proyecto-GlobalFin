# GlobalFin Dashboard de Operaciones

Dashboard interno desarrollado en JavaFX para empleados de GlobalFin que gestionan operaciones bancarias.

## 📊 Características Implementadas

### Vista Principal del Dashboard
- ✅ **Barra superior** con logo, menú, búsqueda global y usuario
- ✅ **Panel de métricas KPI** con 4 indicadores clave:
  - Volumen total procesado hoy
  - Número de operaciones pendientes
  - Alertas activas
  - Operaciones fallidas
- ✅ **Tabla de operaciones** con columnas:
  - ID de operación
  - Cliente
  - Importe
  - Estado (con colores)
  - Fecha/Hora
  - Tipo de operación
  - Nivel de riesgo (con colores)
  - Canal
- ✅ **Panel de detalles** contextual a la derecha con:
  - Información completa de la operación seleccionada
  - Datos del cliente
  - Acciones rápidas (revisar, marcar sospechosa, escalar)
  - Campo para notas internas
- ✅ **Filtros** por estado, riesgo y fecha
- ✅ **Datos mock** con 10 operaciones de ejemplo

### Acciones Disponibles
- ✅ Marcar operación como revisada
- ✅ Marcar operación como sospechosa
- ✅ Escalar operación al equipo de fraude
- ✅ Añadir notas internas a operaciones
- ✅ Actualizar datos del dashboard
- ✅ Filtrar y buscar operaciones

## 🏗️ Arquitectura del Proyecto

```
src/main/java/com/globalfin/dashboard/
├── DashboardApp.java                    # Aplicación principal (450+ líneas)
├── model/
│   ├── Operation.java                   # Modelo de operación con enums
│   └── DashboardMetrics.java            # Modelo de métricas KPI
└── data/
    └── MockDataProvider.java            # Proveedor de datos mock

src/main/resources/
└── styles/
    └── dashboard.css                    # Estilos corporativos profesionales
```

## 🎨 Diseño y UX

### Paleta de Colores Corporativa
- **Fondo principal**: Gris claro (#f4f6f8)
- **Barra superior**: Gradiente azul oscuro (#1B263B → #0D1B2A)
- **Tarjetas**: Blanco con bordes grises
- **Acento principal**: Verde turquesa (#2EC4B6)
- **Estados**:
  - Pendiente: Amarillo (#ffc107)
  - Completada: Verde (#28a745)
  - En revisión: Azul (#17a2b8)
  - Rechazada: Gris (#6c757d)
  - Sospechosa: Rojo (#dc3545)
- **Niveles de riesgo**:
  - Bajo: Verde (#28a745)
  - Medio: Amarillo (#ffc107)
  - Alto: Rojo (#dc3545)

### Principios UX Aplicados
- ✅ Información crítica visible de inmediato (métricas KPI)
- ✅ Colores semánticos para estados y riesgos
- ✅ Panel de detalles contextual (sin cambiar de pantalla)
- ✅ Confirmaciones para acciones críticas
- ✅ Feedback inmediato en todas las interacciones
- ✅ Tabla ordenable y seleccionable
- ✅ Diseño responsive y escalable

## 🚀 Cómo Ejecutar

### Requisitos Previos
- JDK 17 o superior
- Maven 3.6+
- JavaFX 21.0.5 (incluido en dependencias)

### Instalación y Ejecución

#### Opción 1: Usando Maven (Recomendado)
```bash
cd dashboard/globalfin-dashboard
mvn clean javafx:run
```

#### Opción 2: Compilar y ejecutar JAR
```bash
cd dashboard/globalfin-dashboard
mvn clean package
java --module-path $PATH_TO_FX --add-modules javafx.controls,javafx.fxml -jar target/dashboard-empleados-1.0.0-SNAPSHOT.jar
```

#### Opción 3: Desde IDE (IntelliJ IDEA / Eclipse)
1. Importar proyecto Maven
2. Esperar a que se descarguen las dependencias
3. Ejecutar `DashboardApp.java`
4. Asegurar que JavaFX está configurado correctamente

### Verificar Instalación de Java
```bash
java -version  # Debe ser 17 o superior
mvn -version   # Debe ser 3.6+
```

## 📊 Datos Mock Incluidos

El dashboard incluye 10 operaciones de ejemplo que demuestran diferentes escenarios:

- **Operaciones Pendientes**: 3 operaciones esperando revisión
- **Operaciones Completadas**: 2 operaciones finalizadas
- **Operaciones en Revisión**: 2 casos bajo análisis
- **Operaciones Sospechosas**: 1 alerta de fraude
- **Operaciones Rechazadas**: 1 transacción denegada

**Datos generados en:** `MockDataProvider.java`

Importes varían desde €230.50 hasta €75,000.00  
Diferentes canales: Web, Móvil, Oficina, Cajero  
Diferentes tipos: Transferencia, Pago, Bizum, Retirada, Ingreso

## 🔌 Preparado para Backend Real

###  Puntos de Integración

La aplicación está estructurada para conectarse fácilmente a un backend:

#### 1. Crear servicio de API
```java
// Ejemplo: src/main/java/com/globalfin/dashboard/service/OperationService.java
public class OperationService {
    private static final String API_URL = "https://api.globalfin.com";
    
    public List<Operation> fetchOperations() {
        // Implementar llamada HTTP con HttpClient
        // Parsear JSON con Gson (ya incluido en dependencias)
    }
    
    public void updateOperationStatus(String operationId, OperationStatus newStatus) {
        // PUT request al backend
    }
}
```

#### 2. Modificar DashboardApp para usar servicio real
```java
// En lugar de:
operationsData = FXCollections.observableArrayList(MockDataProvider.getOperations());

// Usar:
OperationService service = new OperationService();
operationsData = FXCollections.observableArrayList(service.fetchOperations());
```

#### 3. Agregar serialización JSON a modelos
```java
// En Operation.java
public String toJson() {
    return new Gson().toJson(this);
}

public static Operation fromJson(String json) {
    return new Gson().fromJson(json, Operation.class);
}
```

## 🛠️ Comandos Útiles

### Desarrollo
```bash
# Compilar sin ejecutar
mvn clean compile

# Ejecutar con hot reload (requiere configuración adicional)
mvn javafx:run

# Limpiar build anterior
mvn clean

# Ver árbol de dependencias
mvn dependency:tree

# Ejecutar tests (cuando se agreguen)
mvn test
```

### Producción
```bash
# Compilar para distribución
mvn clean package

# Crear ejecutable nativo (requiere jpackage)
jpackage --input target/classes \
  --name GlobalFinDashboard \
  --main-jar dashboard-empleados-1.0.0-SNAPSHOT.jar \
  --main-class com.globalfin.dashboard.DashboardApp
```

## 📝 Próximos Pasos Sugeridos

### Funcionalidades Adicionales
1. **Autenticación**: Login con credenciales de empleado
2. **Filtros avanzados**: Multi-criterio con búsqueda en tiempo real
3. **Exportación**: Generar reportes en PDF/Excel
4. **Gráficos**: Visualización de tendencias con JavaFX Charts
5. **Notificaciones**: Alertas en tiempo real de nuevas operaciones críticas
6. **Historial**: Ver auditoría completa de cambios en cada operación
7. **Multi-usuario**: Chat interno o sistema de comentarios
8. **Permisos**: Roles diferentes (Analista, Supervisor, Admin)

### Mejoras Técnicas
1. **FXML**: Migrar UI a archivos FXML para separación MVC
2. **Base de datos local**: Cacheo con SQLite o H2
3. **Testing**: JUnit + TestFX para tests automatizados
4. **Logging**: SLF4J + Logback para trazabilidad
5. **Configuración**: Archivo properties para URLs y parámetros
6. **Empaquetado**: Instalador nativo con jpackage

## 🧪 Testing

### Estructura de Tests (Sugerida)
```
src/test/java/com/globalfin/dashboard/
├── model/
│   └── OperationTest.java
├── data/
│   └── MockDataProviderTest.java
└── ui/
    └── DashboardAppTest.java (TestFX)
```

### Ejemplo de Test
```java
@Test
public void testOperationStatusChange() {
    Operation op = new Operation(...);
    op.setStatus(OperationStatus.REVIEWED);
    assertEquals(OperationStatus.REVIEWED, op.getStatus());
}
```

## 🆘 Solución de Problemas

### Error: "JavaFX components are missing"
```bash
# Verificar que JavaFX esté en el classpath
mvn dependency:resolve

# Si persiste, agregar manualmente al VM options:
--module-path /path/to/javafx-sdk/lib --add-modules javafx.controls,javafx.fxml
```

### Error: "module java.base does not open to javafx"
```bash
# Actualizar a JDK 17+ que tiene mejor soporte de módulos
# O agregar: --add-opens java.base/java.lang=ALL-UNNAMED
```

### La ventana no se muestra
```bash
# En entornos sin display (como dev containers):
# JavaFX Desktop no funciona, usar Flutter Web para el dashboard
# O configurar X11 forwarding
```

### Errores de compilación
```bash
# Limpiar y recompilar
mvn clean install -U

# Verificar versión de Java
java -version  # Asegurar JDK 17+
```

## 📚 Recursos

### JavaFX
- Documentación oficial: https://openjfx.io/
- JavaFX API Docs: https://openjfx.io/javadoc/21/
- Tutoriales: https://docs.oracle.com/javafx/2/

### Maven
- POM Reference: https://maven.apache.org/pom.html
- JavaFX Maven Plugin: https://github.com/openjfx/javafx-maven-plugin

### Diseño
- Material Design (inspiración): https://m3.material.io
- JavaFX CSS Reference: https://openjfx.io/javadoc/21/javafx.graphics/javafx/scene/doc-files/cssref.html

## 🎯 Estado del Proyecto

- ✅ **Arquitectura base**: Completa
- ✅ **Modelos de datos**: Implementados con enums
- ✅ **Vista principal**: Dashboard funcional
- ✅ **Tabla de operaciones**: Con columnas y acciones
- ✅ **Panel de detalles**: Con información contextual
- ✅ **Acciones de empleados**: Revisar, marcar, escalar
- ✅ **Estilos CSS**: Tema corporativo profesional
- ✅ **Datos mock**: 10 operaciones de ejemplo
- 🔄 **Backend integration**: Preparado, pendiente implementación
- 📅 **Testing**: Pendiente
- 📅 **Autenticación**: Pendiente

---

**Proyecto:** GlobalFin Dashboard Empleados  
**Versión:** 1.0.0-SNAPSHOT  
**Tecnología:** JavaFX 21.0.5 + Java 17  
**Estado:** ✅ Primera versión funcional completada
