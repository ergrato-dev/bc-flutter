# ponytail: Flutter CLI (analyze/test/build) preinstalled via cirruslabs image —
# no reinventamos la instalación manual del SDK + Android cmdline-tools.
# Este contenedor NO renderiza GUI: sirve para analyze/test/build headless y CI,
# no para `flutter run` en un emulador/simulador (ver docs/docker-setup.md).
FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get

COPY . .

CMD ["flutter", "test"]
