# Proyecto Integrador BD – Consola (Java + Gradle)

Aplicación de consola en Java que se conecta a MySQL para gestionar usuarios y reclamos. Incluye un menú interactivo para:

- Insertar usuario
- Eliminar reclamo por ID (y sus rellamados)
- Listar reclamos por usuario con cantidad de rellamados

---

## Requisitos

- Java 17+ (probado con JDK 24/25)
- MySQL en `localhost:3306` con la base `proyectobd`
- Credenciales por defecto en `src/main/java/org/example/dbConnection.java`:
- Gradle Wrapper (incluido: `gradlew`, `gradlew.bat`)
- Conector MySQL ya referenciado: `Libraries/mysql-connector-j-9.5.0.jar`

> Si usas otras credenciales o puerto, ajusta `dbConnection.java` o crea variables de entorno y modifícalo para leerlas.

---

## Cómo ejecutar

### Windows (PowerShell o CMD)
```bash
# Desde la carpeta del proyecto
./gradlew.bat run
```

### Linux / macOS (Bash/Zsh)
```bash
# Asegúrate de dar permisos de ejecución al wrapper si hace falta
chmod +x gradlew

# Desde la carpeta del proyecto
./gradlew run
```

### Consejos para la consola
- Para que la salida sea limpia (sin barra de progreso), el proyecto incluye `gradle.properties` con:
```properties
org.gradle.console=plain
org.gradle.jvmargs=--enable-native-access=ALL-UNNAMED
```
- También puedes forzarlo ad-hoc:
```bash
./gradlew run --console=plain
```

---

## Uso rápido (interactivo)
Al ejecutar se mostrará un menú como este:

```text
=== Menu ===
1) Insertar usuario
2) Eliminar reclamo
3) Listar reclamos por usuario (con cantidad de rellamados)
0) Salir
Opcion:
```

- Escribe `1`, `2`, `3` o `0` y presiona Enter.
- El programa solicitará los datos necesarios (por ejemplo, nombre y dirección para insertar usuario).

### Ejecución no interactiva (para probar rápidamente)
Puedes “inyectar” entradas por stdin:

- Windows (PowerShell):
```powershell
"1`nJuan`nCalle 123`n0`n" | ./gradlew.bat run --console=plain
```

- Linux/macOS:
```bash
printf "1\nJuan\nCalle 123\n0\n" | ./gradlew run --console=plain
```

---

## Estructura del proyecto

- `src/main/java/org/example/Main.java`: Punto de entrada. Muestra menú y orquesta las operaciones.
- `src/main/java/org/example/dbConnection.java`: Maneja la conexión JDBC a MySQL.
- `src/main/java/org/example/dao/*.java`: DAOs para usuarios y reclamos.
- `src/main/java/org/example/model/ReclamoResumen.java`: DTO para listados.
- `build.gradle`: Configuración Gradle. Incluye el `application` plugin y referencia al JAR del conector MySQL.
- `Libraries/mysql-connector-j-9.5.0.jar`: Driver JDBC de MySQL.

---

## Problemas comunes y soluciones

- «No suitable driver found for jdbc:mysql://…»
  - Asegúrate de que existe `Libraries/mysql-connector-j-9.5.0.jar` y que el nombre coincide con `build.gradle`.
  - Si cambiaste la versión del conector, ajusta la línea `implementation files('Libraries/mysql-connector-j-9.5.0.jar')` en `build.gradle`.

- Advertencia Gradle sobre “restricted method / native access”
  - Ya está mitigada con `org.gradle.jvmargs=--enable-native-access=ALL-UNNAMED` en `gradle.properties`.

- EOF / app se cierra al ejecutar desde herramientas sin stdin
  - El programa maneja EOF y saldrá con un mensaje elegante. Ejecuta desde una consola interactiva o usa redirección como se muestra arriba.

- Error de conexión
  - Verifica host/puerto, base `proyectobd`, usuario y password en `dbConnection.java`.
  - Confirma que MySQL está levantado y accesible.

---

## Scripts útiles

- Limpiar y compilar
```bash
./gradlew clean build
```

- Ejecutar con consola “plain”
```bash
./gradlew run --console=plain
```

---

## Licencia
Proyecto académico/educativo. Úsalo y modifícalo libremente con atribución.
