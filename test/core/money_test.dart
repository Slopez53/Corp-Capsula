import 'package:corp_capsula/core/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Money — construcción y parseo', () {
    test('fromMajor convierte a centavos y redondea al centavo', () {
      expect(Money.fromMajor(12.50).cents, 1250);
      expect(Money.fromMajor(12).cents, 1200);
      expect(Money.fromMajor(0.1).cents, 10);
      // Redondeo half-away-from-zero.
      expect(Money.fromMajor(0.125).cents, 13);
    });

    test('tryParse acepta separadores de miles y decimales', () {
      expect(Money.tryParse('1,250.50')!.cents, 125050);
      expect(Money.tryParse('1250')!.cents, 125000);
      expect(Money.tryParse('  12.5 ')!.cents, 1250);
    });

    test('tryParse rechaza entradas inválidas', () {
      expect(Money.tryParse(''), isNull);
      expect(Money.tryParse('abc'), isNull);
      expect(Money.tryParse('12.3.4'), isNull);
    });
  });

  group('Money — aritmética exacta (sin error de centavos)', () {
    test('suma y resta', () {
      expect((Money(1050) + Money(2075)).cents, 3125);
      expect((Money(5000) - Money(1299)).cents, 3701);
    });

    test('0.1 + 0.2 == 0.3 exacto (lo que falla con double)', () {
      final suma = Money.fromMajor(0.1) + Money.fromMajor(0.2);
      expect(suma.cents, 30);
      expect(suma, Money.fromMajor(0.3));
    });

    test('times redondea al centavo más cercano', () {
      // 33 centavos × 3 = 99
      expect(Money(33).times(3).cents, 99);
      // 1000 centavos × 2.5 libras = 2500
      expect(Money(1000).times(2.5).cents, 2500);
      // 1033 × 1.5 = 1549.5 -> 1550
      expect(Money(1033).times(1.5).cents, 1550);
    });

    test('negación y signo', () {
      expect((-Money(500)).cents, -500);
      expect(Money(-1).isNegative, isTrue);
      expect(Money.zero.isZero, isTrue);
    });
  });

  group('Money — comparación', () {
    test('operadores de orden', () {
      expect(Money(100) < Money(200), isTrue);
      expect(Money(200) >= Money(200), isTrue);
      expect(Money(300) > Money(200), isTrue);
    });

    test('igualdad por valor', () {
      expect(Money(1250), Money(1250));
      expect(Money(1250).hashCode, Money(1250).hashCode);
    });
  });

  group('Money — formato', () {
    test('formatea con símbolo y dos decimales por defecto', () {
      expect(Money(125050).format(), r'RD$ 1,250.50');
      expect(Money(0).format(), r'RD$ 0.00');
    });
  });
}
