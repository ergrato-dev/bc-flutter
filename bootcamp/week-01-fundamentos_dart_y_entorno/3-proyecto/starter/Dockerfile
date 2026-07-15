# ponytail: semana 1 es Dart puro (sin Flutter todavía) — misma imagen base
# que el resto del curso (incluye el SDK de Dart), pero CMD/deps usan
# `dart` en vez de `flutter` porque este proyecto no depende del framework.
FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .

CMD ["dart", "test"]
