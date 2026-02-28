class Account {
  final String id;
  final String name;
  final String lastDigits;
  final double balance;
  final double monthVariation; // Porcentaje de variación este mes

  Account({
    required this.id,
    required this.name,
    required this.lastDigits,
    required this.balance,
    required this.monthVariation,
  });

  String get maskedNumber => '**** $lastDigits';

  // Datos mock de ejemplo
  static List<Account> getMockAccounts() {
    return [
      Account(
        id: '1',
        name: 'Cuenta Principal',
        lastDigits: '8823',
        balance: 12450.30,
        monthVariation: 5.2,
      ),
      Account(
        id: '2',
        name: 'Cuenta Ahorro',
        lastDigits: '3421',
        balance: 8250.00,
        monthVariation: 2.8,
      ),
      Account(
        id: '3',
        name: 'Cuenta Nómina',
        lastDigits: '7766',
        balance: 3890.45,
        monthVariation: -1.5,
      ),
    ];
  }
}
