import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../services/supabase_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/account_card.dart';
import '../widgets/transaction_item.dart';
import '../widgets/operation_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Account> _accounts = [];
  List<Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDataFromSupabase();
  }

  Future<void> _loadDataFromSupabase() async {
    try {
      // Intentar cargar desde Supabase
      final clientesData = await SupabaseService.getClientes();
      final transaccionesData = await SupabaseService.getTransacciones();

      if (clientesData.isNotEmpty) {
        // Convertir clientes a cuentas
        setState(() {
          _accounts = clientesData.map((cliente) {
            return Account(
              id: cliente['id'] ?? '',
              nombre: '${cliente['nombre'] ?? ''} ${cliente['apellido'] ?? ''}',
              tipo: 'Cuenta Principal',
              balance: double.tryParse(cliente['saldo']?.toString() ?? '0') ?? 0.0,
              icono: Icons.account_balance_wallet,
              color: AppColors.primary,
            );
          }).toList();
        });
        print('✓ Datos de clientes cargados desde Supabase (${_accounts.length} cuentas)');
      } else {
        // Usar datos mock si no hay datos en Supabase
        _useMockData();
      }

      if (transaccionesData.isNotEmpty) {
        // Convertir transacciones
        setState(() {
          _transactions = transaccionesData.map((trx) {
            return Transaction(
              id: trx['id'] ?? '',
              descripcion: trx['descripcion'] ?? 'Transacción',
              monto: double.tryParse(trx['monto']?.toString() ?? '0') ?? 0.0,
              fecha: trx['fecha'] ?? DateTime.now().toString(),
              tipo: trx['tipo'] ?? 'Transfer',
            );
          }).toList();
        });
        print('✓ Transacciones cargadas desde Supabase (${_transactions.length})');
      } else {
        setState(() {
          _transactions = Transaction.getMockTransactions();
        });
      }
    } catch (e) {
      print('⚠ Error al cargar desde Supabase: $e');
      _useMockData();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _useMockData() {
    setState(() {
      _accounts = Account.getMockAccounts();
      _transactions = Transaction.getMockTransactions();
    });
    print('⚠ Usando datos mock (Supabase no disponible)');
  }

  double get _totalBalance {
    return _accounts.fold(0, (sum, account) => sum + account.balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Header con bienvenida
                SliverToBoxAdapter(
                  child: _buildHeader(),
                ),
                // Posición global
                SliverToBoxAdapter(
                  child: _buildGlobalPosition(),
                ),
                // Sección de cuentas
                SliverToBoxAdapter(
                  child: _buildAccountsSection(),
                ),
                // Acciones rápidas
                SliverToBoxAdapter(
                  child: _buildQuickActions(),
                ),
                // Últimos movimientos
                SliverToBoxAdapter(
                  child: _buildMovementsHeader(),
                ),
                // Lista de movimientos
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < _transactions.length) {
                        return TransactionItem(transaction: _transactions[index]);
                      }
                      // Espacio extra al final para el botón flotante
                      return const SizedBox(height: 80);
                    },
                    childCount: _transactions.length + 1,
                  ),
                ),
              ],
            ),
            // Botón flotante "Realizar operación"
            Positioned(
              bottom: 80, // Encima del BottomNavigationBar
              left: 0,
              right: 0,
              child: Center(
                child: _buildOperationButton(),
              ),
            ),
            // Indicador de carga
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGreen),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark,
            AppColors.primaryNavy,
          ],
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accentGreen, width: 2),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Texto de bienvenida
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hola, Cristian',
                  style: AppTextStyles.headerMedium.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
                Text(
                  'Bienvenido de nuevo',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Icono de notificaciones
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notificaciones'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textLight,
                  size: 28,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryDark, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalPosition() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Posición Global',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '€ ${_totalBalance.toStringAsFixed(2)}',
            style: AppTextStyles.balanceLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tus Cuentas',
                style: AppTextStyles.headerMedium,
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ver todas las cuentas'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Text(
                  'Ver todas',
                  style: AppTextStyles.buttonSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _accounts.length,
            itemBuilder: (context, index) {
              return AccountCard(account: _accounts[index]);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.send, 'label': 'Enviar'},
      {'icon': Icons.qr_code_scanner, 'label': 'Escanear'},
      {'icon': Icons.receipt, 'label': 'Recibos'},
      {'icon': Icons.more_horiz, 'label': 'Más'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((action) {
          return _buildQuickActionItem(
            icon: action['icon'] as IconData,
            label: action['label'] as String,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickActionItem({required IconData icon, required String label}) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(label),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.accentGreen,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Últimos movimientos',
            style: AppTextStyles.headerMedium,
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filtros'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(
              Icons.tune,
              color: AppColors.textSecondary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        onPressed: () {
          OperationBottomSheet.show(context);
        },
        icon: const Icon(Icons.add, size: 24),
        label: const Text('Realizar operación'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 8,
          shadowColor: AppColors.accentGreen.withOpacity(0.5),
          minimumSize: const Size(200, 56),
        ).copyWith(
          textStyle: MaterialStateProperty.all(AppTextStyles.buttonPrimary),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.cardLight,
        selectedItemColor: AppColors.accentGreen,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.bodySmall,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Movimientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            activeIcon: Icon(Icons.payment),
            label: 'Pagos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
