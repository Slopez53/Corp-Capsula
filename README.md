# 🥐 Corp Capsula — Gestión integral para panadería

Aplicación **offline-first multiplataforma** (Flutter) para la operación diaria de
una panadería: inventario, ventas (vendedor/público/nuevo), crédito y cierre de
caja. Pensada para usarse a diario para tomar decisiones de dinero, no como un
MVP de juguete.

> Estado: **Fase 1 (MVP)** completada. Ver el plan por fases más abajo.

---

## Cómo correr

Requisitos: Flutter (canal stable, Dart ≥ 3.12).

```bash
flutter pub get
flutter run -d chrome      # web (plataforma priorizada)
flutter test               # pruebas (incluye la lógica financiera)
flutter build web --release
```

Plataformas habilitadas: **web** (prioridad), Windows y Android. macOS/iOS/Linux
se pueden añadir con `flutter create --platforms=...` sin tocar la lógica.

---

## Decisiones de arquitectura (ADR resumido)

| Decisión | Elección | Por qué |
|---|---|---|
| Framework | **Flutter 3.44 / Dart 3.12** | Una sola base de código para web/escritorio/móvil con animación intensiva (liquid glass). |
| Estado | **Riverpod** | Escalable, testeable, sin `BuildContext` para la lógica. |
| Persistencia | **Drift (SQLite tipado)** | Offline-first: registrar una venta nunca depende de internet. |
| Web runtime | **SQLite-WASM** (`web/sqlite3.wasm` + `web/drift_worker.js`) | Permite Drift en el navegador (OPFS/IndexedDB). |
| Dinero | **Entero en centavos** (`core/money.dart`) | Evita el error de centavos de coma flotante. Cubierto por pruebas. |
| Capas | **UI → providers → domain → data** | Agregar funciones sin reescribir. La lógica financiera es pura y testeable. |
| Migraciones | **Versionadas desde v1** (esquema completo) | Actualizar el esquema sin perder historial de ventas/gastos. |

### Reglas de negocio clave (Fase 0, aprobadas)

- **Pago mixto**: cada venta tiene `estadoPago` (pagado / parcial / crédito). Lo
  no pagado genera automáticamente una **deuda por cobrar** ligada a la venta.
- **Precios fotografiados**: el precio de cada línea se guarda en el momento de
  la venta; cambiar un precio luego no altera reportes pasados.
- **Doble precio** por producto: vendedor (mayorista) y público (detalle); el
  precio aplicado es editable caso por caso.
- **Público anónimo**: una venta sin cliente (`clienteId = null`) es válida.
- **Soft-delete** (`deletedAt`) en las tablas de negocio (papelera).
- **Auditoría de precios**: todo cambio de precio/costo queda en `historial_precios`.

> ⚠️ **Cifrado en web**: SQLCipher (cifrado en reposo) es nativo y entra en la
> Fase 4 con las builds de escritorio/móvil. En web se cifrarán a nivel de
> aplicación los campos financieros sensibles. La arquitectura en capas permite
> ese cambio sin reescribir.

---

## Estructura del proyecto

```
lib/
  core/
    money.dart              # Tipo Money (centavos) — núcleo financiero, testeado
    theme/                  # Tokens de diseño + temas claro/oscuro
    widgets/glass_card.dart # Superficie "liquid glass"
  domain/
    pricing.dart            # Precios, totales, estado de pago — puro y testeado
    validators.dart         # Validación de formularios — puro y testeado
  data/database/
    tables.dart             # Esquema (14 entidades)
    database.dart           # AppDatabase, migraciones, consultas y transacciones
    connection.dart         # Conexión multiplataforma (nativo/web)
  providers/providers.dart  # Riverpod: BD, streams, carrito de venta (POS)
  features/                 # shell · inventario · clientes · ventas · cierre
test/                       # core/ domain/ data/  (28 pruebas)
```

---

## Plan por fases

| Fase | Contenido | Estado |
|---|---|---|
| 0 | Esquema de datos + reglas de negocio | ✅ |
| 1 (MVP) | Inventario + venta diaria (vendedor/público/nuevo) + crédito + cierre + pruebas financieras | ✅ |
| 2 | Gastos (fijo/variable/merma) · deudas + pagos parciales · reportes mensuales con comparativo · anomalías | ⬜ |
| 3 | Visualización tabla↔gráfico (fl_chart) · liquid glass pulido · animaciones · layouts adaptativos | ⬜ (base lista) |
| 4 | Seguridad (PIN/biometría, SQLCipher, backups) · builds nativas · nube opcional · roles | ⬜ |

---

## Qué entra y qué no en la Fase 1

**Incluido y verificado:**
- CRUD de inventario con doble precio, costo, stock mínimo y alerta visual.
- Historial de precios automático al editar.
- Clientes (vendedor fijo / ocasional / nuevo) con alta rápida desde la venta.
- Registro de venta tipo POS: precio automático por tipo de comprador, editable
  por línea, cantidades con +/−, venta a crédito (descuenta stock igual).
- Cierre del día: total vendido/cobrado/crédito, desglose por producto y por
  tipo de comprador.
- 28 pruebas (núcleo de dinero, lógica de precios y transacciones de BD).

**Aún no (fases siguientes):** reportes mensuales, gastos/merma, gráficos,
biometría/cifrado fuerte, sincronización en la nube y roles de usuario.

El tema de e-commerce Gatsby anterior se archivó en `legacy-gatsby-theme/`.
