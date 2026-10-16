# PostgreSQL con Docker

Guía rápida para levantar un contenedor de PostgreSQL, configurar usuarios y bases de datos, y ejecutar scripts SQL.

## 🚀 Requisitos previos

- [Docker](https://docs.docker.com/get-docker/) instalado y en ejecución.

---

## 1. Levantar PostgreSQL con Docker

Ejecutá el siguiente comando en la terminal para crear e iniciar un contenedor de PostgreSQL. Reemplazá las credenciales según tus necesidades.

```bash
docker run --name mi-postgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=tu_contrasena \
  -e POSTGRES_DB=mi_base_de_datos \
  -p 5432:5432 \
  -d postgres
```

**Descripción de los parámetros:**

- `--name mi-postgres`: asigna un nombre al contenedor.
- `-e POSTGRES_USER=admin`: define el usuario administrador.
- `-e POSTGRES_PASSWORD=tu_contrasena`: establece la contraseña del usuario.
- `-e POSTGRES_DB=mi_base_de_datos`: crea una base de datos inicial.
- `-p 5432:5432`: expone el puerto de PostgreSQL en la máquina local.
- `-d postgres`: ejecuta la imagen oficial de PostgreSQL en segundo plano.

## 2. Crear un usuario y una base de datos

Para crear un usuario adicional y una nueva base de datos, ingresá a la consola de PostgreSQL dentro del contenedor:

```bash
docker exec -it mi-postgres psql -U admin -d mi_base_de_datos
```

Una vez dentro de `psql`, ejecutá las siguientes sentencias SQL:

```sql
-- Crear un nuevo usuario
CREATE USER nuevo_usuario
WITH ENCRYPTED PASSWORD 'otra_contrasena';

-- Crear una base de datos asignada al usuario
CREATE DATABASE otra_bd OWNER nuevo_usuario;

-- Otorgar privilegios sobre la base de datos
GRANT ALL PRIVILEGES ON DATABASE otra_bd TO nuevo_usuario;
```

Para salir de la consola, ejecutá:

```sql
\q
```
Ejecutá el siguiente comando para conectarte a la nueva base de datos con el usuario creado:

```bash
docker exec -it mi-postgres psql -U nuevo_usuario -d otra_bd
```

## 3. Ejecutar un archivo SQL en el contenedor

Si tenés un archivo llamado `script.sql` en tu máquina local, podés ejecutarlo de las siguientes maneras.

### Método A: Copiar el archivo al contenedor

Primero, copiá el archivo al contenedor:

```bash
docker cp script.sql mi-postgres:/tmp/script.sql
```

Luego, ejecutalo utilizando `psql`:

```bash
docker exec -it mi-postgres \
  psql -U admin -d mi_base_de_datos -f /tmp/script.sql
```

### Método B: Ejecutar el archivo directamente

También podés ejecutar el archivo sin copiarlo previamente al contenedor:

```bash
docker exec -i mi-postgres \
  psql -U admin -d mi_base_de_datos < script.sql
```

> **Nota:** Ejecutá estos comandos desde el directorio donde se encuentra `script.sql`, o indicá la ruta correspondiente al archivo.

## 🛠️ Comandos útiles

### Ver los contenedores en ejecución

```bash
docker ps
```

### Consultar los logs de PostgreSQL

Útil para verificar el inicio del servicio o detectar errores.

```bash
docker logs mi-postgres
```

### Detener el contenedor

```bash
docker stop mi-postgres
```

### Iniciar nuevamente el contenedor

```bash
docker start mi-postgres
```

### Acceder nuevamente a PostgreSQL

```bash
docker exec -it mi-postgres psql -U admin -d mi_base_de_datos
```

---
