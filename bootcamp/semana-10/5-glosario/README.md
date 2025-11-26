# 📖 Glosario - Semana 10

## Deployment, CI/CD y Producción

Términos esenciales para el despliegue y mantenimiento de aplicaciones Flutter en producción.

---

## A

### AAB (Android App Bundle)

Formato de publicación de Android (.aab) que permite a Google Play generar APKs optimizados para cada dispositivo. Reduce el tamaño de descarga hasta un 35%.

### Alpha Testing

Primera fase de testing con usuarios internos antes del beta testing público.

### Analytics

Recopilación y análisis de datos sobre el comportamiento de los usuarios en la aplicación.

### AOT (Ahead-Of-Time) Compilation

Compilación anticipada del código Dart a código nativo antes de la ejecución. Usado en builds de release para mejor rendimiento.

### APK (Android Package Kit)

Formato de paquete para distribuir e instalar aplicaciones Android (.apk).

### App Bundle

Ver **AAB (Android App Bundle)**.

### App Distribution

Servicio de Firebase para distribuir versiones de prueba de la aplicación a testers.

### App Store Connect

Portal de Apple para gestionar aplicaciones iOS en el App Store.

### Artifact

Archivo resultante de un proceso de build (APK, AAB, IPA) que se puede distribuir o desplegar.

---

## B

### Beta Testing

Fase de testing con usuarios externos seleccionados antes del lanzamiento público.

### Build Number

Número incremental que identifica cada build específico (ej: 1, 2, 3...).

### Build Variant

Configuración específica de build (debug, release, profile) con diferentes características.

### Bundle ID

Identificador único de una aplicación iOS (ej: com.company.appname).

---

## C

### CD (Continuous Delivery/Deployment)

Práctica de automatizar la entrega o despliegue de software a producción.

### CI (Continuous Integration)

Práctica de integrar código frecuentemente con validación automática mediante tests.

### CI/CD Pipeline

Flujo automatizado que compila, prueba y despliega código automáticamente.

### Code Signing

Proceso de firmar digitalmente una aplicación para verificar su autenticidad.

### Codemagic

Plataforma de CI/CD especializada en aplicaciones Flutter.

### Crashlytics

Servicio de Firebase para recopilar y analizar crashes de la aplicación.

### Custom Trace

Medición manual de rendimiento definida por el desarrollador en Firebase Performance.

---

## D

### dart-define

Parámetro de compilación para pasar variables de entorno en tiempo de build.

### Debug Build

Versión de la aplicación con símbolos de debug, assertions y hot reload habilitados.

### Deferred Components

Funcionalidad para cargar partes de la aplicación bajo demanda, reduciendo el tamaño inicial.

### Deploy

Proceso de publicar una aplicación en un entorno (testing, staging, producción).

### DevOps

Cultura y prácticas que unifican desarrollo (Dev) y operaciones (Ops).

### Distribution Certificate

Certificado de Apple requerido para distribuir aplicaciones iOS.

---

## E

### Environment

Configuración específica para diferentes contextos (development, staging, production).

### Entry Point

Archivo principal de entrada de la aplicación (main.dart, main_dev.dart, etc.).

---

## F

### Fastlane

Herramienta de automatización para builds, screenshots y deployment de apps móviles.

### Feature Flag

Configuración remota que permite activar/desactivar funcionalidades sin actualizar la app.

### Firebase

Plataforma de Google con servicios de backend para aplicaciones móviles.

### Flavor

Configuración de build que permite crear diferentes versiones de la misma app (dev, staging, prod).

### Frame Rate

Cantidad de frames renderizados por segundo (objetivo: 60 FPS).

---

## G

### GitHub Actions

Plataforma de CI/CD integrada en GitHub para automatizar workflows.

### Google Play Console

Portal de Google para gestionar aplicaciones Android en Play Store.

### Golden Test

Test visual que compara widgets renderizados contra imágenes de referencia.

---

## H

### Hot Reload

Recarga rápida del código en desarrollo sin perder el estado de la aplicación.

### HTTP Trace

Medición automática de rendimiento de llamadas de red en Firebase Performance.

---

## I

### IPA (iOS App Store Package)

Formato de archivo para distribuir aplicaciones iOS (.ipa).

### Integration Test

Test que verifica la interacción entre múltiples componentes o el flujo completo de la app.

---

## J

### Jank

Interrupciones visibles en la fluidez de la UI cuando los frames tardan más de 16ms.

### JIT (Just-In-Time) Compilation

Compilación en tiempo de ejecución. Usado en modo debug para hot reload.

### Job

Unidad de trabajo en un workflow de CI/CD.

---

## K

### Keystore

Archivo que contiene claves privadas para firmar aplicaciones Android (.jks/.keystore).

### Key Alias

Nombre identificador de una clave dentro de un keystore.

---

## L

### Lint

Análisis estático del código para detectar errores y enforcing de estilo.

### Listing

Página de la aplicación en una tienda (descripción, screenshots, etc.).

---

## M

### Metadata

Información descriptiva de la app (nombre, descripción, categoría, etc.).

### Migration

Proceso de actualizar esquemas de base de datos entre versiones.

### Minification

Proceso de reducir el tamaño del código eliminando espacios y renombrando variables.

### Monitoring

Observación continua del comportamiento y rendimiento de la aplicación en producción.

---

## N

### Native Splash

Pantalla de carga nativa que se muestra mientras Flutter inicializa.

---

## O

### Obfuscation

Proceso de ofuscar el código para dificultar la ingeniería inversa.

### OTA (Over-The-Air) Update

Actualización de la aplicación sin pasar por la tienda (limitado en Flutter).

---

## P

### Package Name

Identificador único de una aplicación Android (ej: com.company.appname).

### Performance Overlay

Superposición visual que muestra métricas de rendimiento en tiempo real.

### Pipeline

Ver **CI/CD Pipeline**.

### Play Console

Ver **Google Play Console**.

### Profile Build

Versión de la aplicación optimizada para análisis de rendimiento.

### Profiling

Proceso de analizar el rendimiento de la aplicación para identificar cuellos de botella.

### Provisioning Profile

Archivo de Apple que autoriza la ejecución de una app en dispositivos específicos.

---

## Q

### QA (Quality Assurance)

Proceso de asegurar la calidad del software mediante testing y revisión.

---

## R

### Release Build

Versión optimizada de la aplicación para distribución a usuarios finales.

### Release Notes

Notas que describen los cambios y mejoras en cada versión.

### Remote Config

Servicio para modificar el comportamiento de la app sin publicar actualizaciones.

### Runner

Máquina virtual o servidor que ejecuta los jobs de CI/CD.

---

## S

### Secrets

Información sensible (API keys, passwords) almacenada de forma segura en CI/CD.

### SemVer (Semantic Versioning)

Sistema de versionado que usa formato MAJOR.MINOR.PATCH (ej: 1.2.3).

### Shader

Programa que se ejecuta en la GPU para renderizar gráficos.

### Shader Warmup

Pre-compilación de shaders para evitar jank en el primer frame.

### Signing Key

Clave criptográfica usada para firmar aplicaciones.

### Split APK

APKs separados por arquitectura (arm64, x86) para reducir tamaño.

### Staging

Entorno de pre-producción para testing final antes del release.

### Step

Acción individual dentro de un job de CI/CD.

### Store Listing

Ver **Listing**.

---

## T

### TestFlight

Plataforma de Apple para distribución de versiones beta de iOS.

### Timeline

Vista en DevTools que muestra la secuencia temporal de frames y eventos.

### Trace

Medición de rendimiento en un periodo específico de tiempo.

### Tree Shaking

Eliminación automática de código no utilizado durante la compilación.

---

## U

### Unit Test

Test que verifica el comportamiento de una unidad individual de código.

### Upload Key

Clave usada para firmar app bundles antes de subirlos a Play Store.

---

## V

### Version Code

Número entero que identifica la versión de la app (usado internamente).

### Version Name

Cadena que representa la versión visible para usuarios (ej: "1.2.3").

---

## W

### Widget Test

Test que verifica el comportamiento y renderizado de widgets Flutter.

### Workflow

Conjunto de jobs y steps que definen un proceso de CI/CD.

---

## Y

### YAML

Formato de archivo usado para configurar workflows de CI/CD (.yml/.yaml).

---

## 🔗 Navegación

| ⬅️ Anterior                                | 🏠 Índice                 | Siguiente ➡️           |
| ------------------------------------------ | ------------------------- | ---------------------- |
| [Webgrafía](../4-recursos/05-webgrafia.md) | [Semana 10](../README.md) | [Assets](../0-assets/) |
