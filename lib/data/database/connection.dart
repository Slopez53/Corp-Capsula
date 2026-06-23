import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Abre la conexión a la base local. `drift_flutter` resuelve el backend según
/// la plataforma:
///  - Nativo (Windows/Android/iOS/macOS/Linux): SQLite en el directorio de la
///    app vía `sqlite3_flutter_libs`. En Fase 4 aquí entra SQLCipher.
///  - Web: SQLite compilado a WebAssembly (`sqlite3.wasm` + `drift_worker.js`,
///    en `web/`), persistido por el navegador (OPFS/IndexedDB).
QueryExecutor openConnection() {
  return driftDatabase(
    name: 'corp_capsula',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
