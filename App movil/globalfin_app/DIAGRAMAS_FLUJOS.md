# Diagramas de flujos principales - GlobalFin

Este documento reúne los flujos más importantes de la aplicación para facilitar su comprensión funcional y técnica.

## 1) Arranque de la aplicación

```mermaid
flowchart TD
    A[Inicio main] --> B[Inicializar Flutter binding]
    B --> C[Configurar barra de estado]
    C --> D[Ejecutar runApp]
    D --> E[Construir MaterialApp]
    E --> F[Aplicar ThemeData]
    E --> G[Mostrar HomeScreen]
```

## 2) Flujo principal de Home

```mermaid
flowchart TD
    A[HomeScreen build] --> B[Cargar datos mock: accounts y transactions]
    B --> C[Calcular totalBalance]
    C --> D[Render UI]
    D --> E[Header y notificaciones]
    D --> F[Posicion Global]
    D --> G[Carrusel de cuentas]
    D --> H[Acciones rapidas]
    D --> I[Lista de ultimos movimientos]
    E --> E1[Tap notificaciones]
    E1 --> E2[SnackBar Notificaciones]
    H --> H1[Tap accion rapida]
    H1 --> H2[SnackBar con label]
    I --> I1[Tap filtros]
    I1 --> I2[SnackBar Filtros]
```

## 3) Flujo de "Realizar operación" (Bottom Sheet)

```mermaid
sequenceDiagram
    participant U as Usuario
    participant H as HomeScreen
    participant B as OperationBottomSheet
    participant M as ModalBottomSheet
    participant A as OperationActionItem

    U->>H: Tap Realizar operacion
    H->>M: showModalBottomSheet(...)
    M->>B: Construir OperationBottomSheet
    B->>B: Cargar OperationAction.getAllActions()
    U->>A: Tap accion (Transferir/Pagar/Bizum/...)
    A->>B: onTap()
    B->>M: Navigator.pop()
    B-->>U: SnackBar Navegando a accion
    U->>B: Tap Cancelar
    B->>M: Navigator.pop()
```

## 4) Estados de navegación inferior

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
