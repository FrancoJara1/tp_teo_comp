PostgreSQL con Docker

Guía rápida para levantar un contenedor de PostgreSQL, configurar usuarios y bases de datos, y ejecutar scripts SQL.

🚀 Requisitos previos

Docker instalado y en ejecución.

1. Levantar PostgreSQL con Docker

Puedes iniciar un contenedor de PostgreSQL ejecutando el siguiente comando en tu terminal (reemplaza las credenciales según tus necesidades):

docker run --name mi-postgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=tu_contrasena \
  -e POSTGRES_DB=mi_base_de_datos \
  -p 5432:5432 \
  -d postgres


Explicación de los parámetros:

--name mi-postgres: Nombre asignado al contenedor.

-e POSTGRES_USER=admin: Usuario administrador por defecto.

-e POSTGRES_PASSWORD=tu_contrasena: Contraseña del administrador.

-e POSTGRES_DB=mi_base_de_datos: Base de datos creada automáticamente al iniciar.

-p 5432:5432: Expone el puerto de Postgres hacia tu máquina local.

-d postgres: Utiliza la imagen oficial de PostgreSQL.

2. Crear un nuevo usuario y base de datos

Si necesitas crear un usuario adicional y otra base de datos desde la línea de comandos, accede a la consola de PostgreSQL dentro del contenedor:

docker exec -it mi-postgres psql -U admin -d mi_base_de_datos


Una vez dentro del prompt de psql, ejecuta las siguientes sentencias SQL:

-- Crear un nuevo usuario
CREATE USER nuevo_usuario WITH ENCRYPTED PASSWORD 'otra_contrasena';

-- Crear una nueva base de datos asignada al usuario
CREATE DATABASE otra_bd OWNER nuevo_usuario;

-- Otorgar privilegios
GRANT ALL PRIVILEGES ON DATABASE otra_bd TO nuevo_usuario;

-- Salir de psql
\q


3. Subir y ejecutar un archivo SQL en el contenedor

Supongamos que tienes un archivo llamado script.sql en tu máquina local que deseas ejecutar dentro del contenedor.

Método A: Copiar y ejecutar en dos pasos

Copiar el archivo desde tu máquina local al contenedor:

docker cp script.sql mi-postgres:/tmp/script.sql


Ejecutar el archivo dentro del contenedor usando psql:

docker exec -it mi-postgres psql -U admin -d mi_base_de_datos -f /tmp/script.sql


Método B: Ejecución directa en una sola línea (Redirección)

Si prefieres no copiar físicamente el archivo al contenedor, puedes enviarlo directamente:

docker exec -i mi-postgres psql -U admin -d mi_base_de_datos < script.sql


🛠️ Comandos útiles

Ver el estado del contenedor:

docker ps


Ver los logs de PostgreSQL (útil para depurar):

docker logs mi-postgres


Detener el contenedor:

docker stop mi-postgres


Iniciar nuevamente el contenedor:

docker start mi-postgres
