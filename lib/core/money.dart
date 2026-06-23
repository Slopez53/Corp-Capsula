import 'package:intl/intl.dart';

/// Valor monetario representado SIEMPRE en la unidad mínima (centavos) como
/// entero. Nunca usamos `double` para almacenar dinero: así evitamos el
/// clásico error de centavos por redondeo de coma flotante.
///
/// Toda la aritmética financiera de la app pasa por aquí y está cubierta por
/// pruebas unitarias (`test/core/money_test.dart`).
class Money implements Comparable<Money> {
  /// Cantidad en centavos. Puede ser negativa (p. ej. saldos, ajustes).
  final int cents;

  const Money(this.cents);

  static const Money zero = Money(0);

  /// Construye desde una cantidad en unidad mayor (p. ej. 12.50 -> 1250).
  /// Redondea al centavo más cercano (banker-free, half-away-from-zero).
  factory Money.fromMajor(num major) => Money((major * 100).round());

  /// Parsea texto introducido por el usuario ("1,250.50", "1250.5", "12").
  /// Devuelve `null` si no es un número válido.
  static Money? tryParse(String input) {
    final cleaned = input.trim().replaceAll(',', '');
    if (cleaned.isEmpty) return null;
    final value = num.tryParse(cleaned);
    if (value == null) return null;
    return Money.fromMajor(value);
  }

  /// Valor en unidad mayor (para mostrar/formatear). No usar para cálculos.
  double get major => cents / 100;

  bool get isZero => cents == 0;
  bool get isNegative => cents < 0;
  bool get isPositive => cents > 0;

  Money operator +(Money other) => Money(cents + other.cents);
  Money operator -(Money other) => Money(cents - other.cents);
  Money operator -() => Money(-cents);

  /// Multiplica por una cantidad (p. ej. 2.5 libras) y redondea al centavo.
  /// El redondeo es la regla de negocio del precio de línea.
  Money times(num quantity) => Money((cents * quantity).round());

  bool operator <(Money other) => cents < other.cents;
  bool operator <=(Money other) => cents <= other.cents;
  bool operator >(Money other) => cents > other.cents;
  bool operator >=(Money other) => cents >= other.cents;

  @override
  int compareTo(Money other) => cents.compareTo(other.cents);

  /// Formatea con el símbolo de moneda configurado (por defecto RD$).
  String format({String symbol = r'RD$', int decimals = 2}) {
    final formatter = NumberFormat.currency(
      symbol: '$symbol ',
      decimalDigits: decimals,
    );
    return formatter.format(major);
  }

  @override
  bool operator ==(Object other) => other is Money && other.cents == cents;

  @override
  int get hashCode => cents.hashCode;

  @override
  String toString() => 'Money($cents)';
}
