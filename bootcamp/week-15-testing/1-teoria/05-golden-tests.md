# Golden Tests

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué detecta un golden test que un widget test normal no detecta
- Cómo generar y actualizar la imagen de referencia
- Cómo mantener golden tests estables entre máquinas distintas
- Cuándo vale la pena escribir uno (y cuándo no)

## 📋 Conceptos Clave

### 1. El problema: un widget test no ve el diseño

Un widget test (teoría 03) verifica *qué* widgets existen y *qué* texto muestran — no verifica
*cómo se ven*. Un `Padding` con el valor equivocado, un color que cambió sin querer, un ícono
mal alineado: nada de eso rompe un `find.text(...)`, pero sí rompe el diseño real.

### 2. `matchesGoldenFile` — comparar contra una imagen de referencia

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ItemCard coincide con el golden guardado', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ItemCard(item: Item(id: '1', name: 'Laptop', description: 'Portátil')),
        ),
      ),
    );

    await expectLater(
      find.byType(ItemCard),
      matchesGoldenFile('goldens/item_card.png'),
    );
  });
}
```

La primera vez que corre, no hay imagen para comparar — hay que **generarla explícitamente**.

### 3. Generar y actualizar el golden

```bash
flutter test --update-goldens
```

Este comando sobreescribe (o crea) los archivos `.png` de referencia con el render actual. Se
ejecuta **a propósito**, cuando el diseño cambió intencionalmente — nunca como parte del `flutter
test` normal de CI, porque eso ocultaría regresiones reales en vez de detectarlas.

### 4. Estabilidad entre máquinas

Un golden generado en macOS puede no coincidir píxel a píxel con el mismo test corrido en Linux
(fuentes, antialiasing distintos). Este bootcamp usa Docker (`ghcr.io/cirruslabs/flutter:stable`)
precisamente para esto — generar y verificar los goldens siempre dentro del mismo contenedor
garantiza que todos comparen contra el mismo entorno de renderizado.

```bash
docker compose run --rm flutter flutter test --update-goldens
docker compose run --rm flutter flutter test
```

### 5. Cuándo usar un golden test (y cuándo no)

| Sí tiene sentido | No tiene sentido |
|---|---|
| Un componente visual reutilizable y estable (`ItemCard`, `LoadingRing`) | Una pantalla completa que cambia seguido (más mantenimiento que valor) |
| Verificar que un theme/color se aplicó correctamente | Contenido que depende de datos dinámicos impredecibles (fecha actual, texto de una API) |
| Un `CustomPainter` (semana 12) — el widget test normal no puede verificar píxeles dibujados a mano | Componentes en desarrollo activo (el golden se rompe en cada cambio de diseño) |

### 6. Casos de Uso Móvil

`LoadingRing` (semana 12, `CustomPainter`) es el candidato ideal: un widget test normal no puede
verificar que el arco se dibujó en el ángulo correcto, pero un golden test sí detecta si el
`CustomPainter` cambió su salida visual.

## ⚠️ Errores Comunes

- **Correr `--update-goldens` en cada `flutter test`**: convierte el golden test en un test que
  siempre pasa, sin detectar nada — el propósito es lo contrario.
- **Generar el golden fuera de Docker y verificarlo dentro** (o viceversa): diferencias de
  renderizado entre entornos producen falsos negativos.
- **Golden tests de pantallas completas con datos de red**: cualquier cambio en el mock de datos
  rompe el golden sin que el diseño haya cambiado — preferir componentes aislados con datos
  fijos.

## 📚 Recursos Adicionales

- [Flutter docs — Golden file testing](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
- [Flutter docs — Golden tests cookbook](https://docs.flutter.dev/cookbook/testing/widget/introduction#golden-file-testing)

## ✅ Checklist de Verificación

Antes de continuar, verifica que entiendes:

- [ ] Qué detecta un golden test que un widget test no detecta
- [ ] Cómo y cuándo se actualiza un golden
- [ ] Por qué Docker importa para la estabilidad de los goldens
