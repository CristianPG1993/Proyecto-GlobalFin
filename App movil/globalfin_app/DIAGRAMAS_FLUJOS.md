# Diagramas de flujos principales - GlobalFin

Este documento reúne los flujos más importantes de la aplicación para facilitar su comprensión funcional y técnica.

## 1) Arranque de la aplicación (CON SUPABASE)

```mermaid
flowchart TD
    A[Inicio main] --> B[WidgetsFlutterBinding.ensureInitialized]
    B --> C["Supabase.initialize(url, key)"] 
    C --> D[Ejecutar runApp]
    D --> E[Construir MaterialApp]
    E --> F[Aplicar ThemeData]
    E --> G[Mostrar HomeScreen]
    G --> H["initState() → _loadDataFromSupabase()"]
```

## 2) Flujo de Carga de Datos (NUEVO - Supabase)

```mermaid
flowchart TD
    A["HomeScreen initState()"] --> B["_loadDataFromSupabase()"]
    B --> C["Mostrar loading spinner"]
    C --> D["SupabaseService.getClientes()"]
    D --> E{Error?}
    E -->|No| F["_accounts = lista de clientes"]
    E -->|Sí| G["_useMockData()"]
    F --> H["SupabaseService.getTransacciones()"]
    H --> I{Error?}
    I -->|No| J["_transactions = lista de transacciones"]
    I -->|Sí| G
    G --> K["setState()"]
    J --> K
    K --> L["Renderizar UI con datos"]
    L --> M{¿De dónde vinieron?}
    M -->|Supabase| N["✓ Datos reales"]
    M -->|Mock| O["⚠ Datos fallback"]
    N --> P["Ocultar loading spinner"]
    O --> P
```

## 3) Flujo principal de Home (CON DATOS DINÁMICOS)

```mermaid
flowchart TD
    A["HomeScreen build()"] --> B{¿_isLoading?}
    B -->|Sí| C["Mostrar CircularProgressIndicator"]
    B -->|No| D["Render UI normal"]
    C --> E["Esperar carga de Supabase"]
    E --> D
    D --> F["Header y notificaciones"]
    D --> G["Posición Global con saldo real"]
    D --> H["Carrusel de cuentas reales"]
    D --> I["Acciones rápidas"]
    D --> J["Lista de movimientos reales"]
    F --> F1["Tap notificaciones"]
    F1 --> F2["SnackBar Notificaciones"]
    H --> H1["Tap acción rápida"]
    H1 --> H2["SnackBar con label"]
    J --> J1["Tap filtro"]
    J1 --> J2["SnackBar Filtros"]
```

## 4) Flujo de "Realizar operación" (Bottom Sheet)

```mermaid
sequenceDiagram
    participant U as Usuario
    participant H as HomeScreen
    participant B as OperationBottomSheet
    participant M as ModalBottomSheet
    participant A as OperationActionItem

    U->>H: Tap Realizar operación
    H->>M: showModalBottomSheet(...)
    M->>B: Construir OperationBottomSheet
    B->>B: Cargar OperationAction.getAllActions()
    U->>A: Tap acción (Transferir/Pagar/Bizum/...)
    A->>B: onTap()
    B->>M: Navigator.pop()
    B-->>U: SnackBar Navegando a acción
    U->>B: Tap Cancelar
    B->>M: Navigator.pop()
```

## 5) Flujo Híbrido: Supabase con Fallback (NUEVO)

```mermaid
flowchart TD
    A["Inicio carga de datos"] --> B["Try"]
    B --> C["Conectar a Supabase"]
    C --> D{Conexión OK?}
    D -->|Sí| E["Fetch getClientes()"]
    D -->|No| F["Catch exception"]
    E --> G{Respuesta OK?}
    G -->|Sí| H["Convertir JSON → Account"]
    G -->|No| F
    H --> I["setState() con datos reales"]
    F --> J["Usar getMockAccounts()"]
    J --> K["setState() con datos mock"]
    I --> L["🟢 Datos de Supabase"]
    K --> M["🟡 Datos Mock (Fallback)"]
    L --> N["Render UI"]
    M --> N
    N --> O["Usuario ve datos (real o mock)"]
```

## 6) Estados de navegación inferior

```mermaid
stateDiagram-v2
    [*] --> Inicio
    Inicio --> Movimientos: Tap item 1
    Inicio --> Pagos: Tap item 2
    Inicio --> Perfil: Tap item 3
    Movimientos --> Inicio: Tap item 0
    Movimientos --> Pagos: Tap item 2
    Movimientos --> Perfil: Tap item 3
    Pagos --> Inicio: Tap item 0
    Pagos --> Movimientos: Tap item 1
    Pagos --> Perfil: Tap item 3
    Perfil --> Inicio: Tap item 0
    Perfil --> Movimientos: Tap item 1
    Perfil --> Pagos: Tap item 2
```

## 7) Componentes de HomeScreen (ARQUITECTURA)

```mermaid
graph TD
    A["HomeScreen"]
    A --> B["Header"]
    A --> C["Posición Global"]
    A --> D["Carrusel Cuentas"]
    A --> E["Acciones Rápidas"]
    A --> F["Mov. Recientes"]
    A --> G["Bottom Nav"]
    A --> H["Loading Spinner"]
    
    D --> D1["AccountCard x3"]
    E --> E1["Botón Enviar"]
    E --> E2["Botón Escanear"]
    E --> E3["Botón Recibos"]
    E --> E4["Botón Más"]
    F --> F1["TransactionItem x7"]
    
    B -.->|Data| I["SupabaseService"]
    D -.->|Data| I
    F -.->|Data| I
    
    I -.->|Clientes| J["Supabase BD"]
    I -.->|Transacciones| J
```

## 8) Flujo de Sincronización (DETALLADO)

```mermaid
sequenceDiagram
    participant App as Flutter App
    participant Supabase as Supabase REST API
    participant BD as PostgreSQL

    App->>App: initState()
    App->>App: _loadDataFromSupabase()
    App->>App: setState(Loading=true)
    
    App->>Supabase: GET /rest/v1/clientes (con apikey)
    Supabase->>BD: SELECT * FROM clientes
    BD-->>Supabase: 10 rows
    Supabase-->>App: JSON response
    
    App->>App: Convertir JSON -> Accounts
    App->>Supabase: GET /rest/v1/transacciones
    Supabase->>BD: SELECT * FROM transacciones
    BD-->>Supabase: 10 rows
    Supabase-->>App: JSON response
    
    App->>App: Convertir JSON -> Transactions
    App->>App: setState(Loading=false, datos reales)
    App->>App: Rebuild UI
    App-->>User: Mostrar datos
```

---

## 📋 Referencias Rápidas

- **Diagrama 1:** Cómo inicia la app con Supabase
- **Diagrama 2:** Flujo de carga de datos (lo más importante)
- **Diagrama 3:** Renderizado de UI con datos cargados
- **Diagrama 4:** Modal de operaciones (interactividad)
- **Diagrama 5:** Patrón try-catch-fallback (resiliencia)
- **Diagrama 6:** Estados del bottom nav (navegación)
- **Diagrama 7:** Estructura de componentes (arquitectura)
- **Diagrama 8:** Sincronización detallada (técnica)

---

**Última actualización:** 28 de Febrero, 2026  
**Estado:** ✅ Actualizado con Supabase Integration
