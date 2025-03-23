# Pizza Paisa Sustentación

Este repositorio contiene el proyecto **Pizza Paisa**, desarrollado como parte de la formación en el **SENA**, correspondiente al **quinto trimestre**. El objetivo principal del proyecto es la implementación de un sistema para gestionar pedidos de pizzas, utilizando tecnologías modernas tanto en el backend como en el frontend.

---

## Descripción del Proyecto

**Pizza Paisa** es un sistema completo que incluye:

1. **API REST con Seguridad:**
   - Implementada utilizando las mejores prácticas para garantizar la autenticación y la autorización de los usuarios.
   - Incluye protección contra ataques comunes como inyección de SQL y accesos no autorizados.

2. **Frontend Web:**
   - Desarrollado en Angular para consumir la API REST.
   - El avance actual es del **80%**, incluyendo las funcionalidades principales del sistema.

3. **Sistema de Control de Versiones:**
   - Todo el desarrollo se gestiona utilizando Git y GitHub, evidenciando buenas prácticas de versionado, trabajo en equipo y manejo de ramas.

---

## Tecnologías Utilizadas

- **Backend:** Laravel
- **Frontend:** Angular
- **Base de Datos:** MySQL
- **Control de Versiones:** Git / GitHub

---

## Funcionalidades Principales

1. **Gestión de Usuarios:**
   - Registro e inicio de sesión con validación de roles (administrador y cliente).
   
2. **Gestión de Pedidos:**
   - Creación, modificación y cancelación de pedidos.
   - Listado detallado de órdenes.

3. **Gestión de Menús:**
   - Visualización de sabores y combinaciones disponibles.

4. **Consumo de API REST:**
   - Las vistas del frontend consumen los endpoints del backend en tiempo real.

---

## Instalación y Configuración

### Requisitos Previos
- Node.js y npm instalados.
- PHP y Composer instalados.
- MySQL configurado.
- Angular CLI instalado.

### Backend
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/DiegoMonroyx/PizzaPaisaSustentacion.git
   cd PizzaPaisaSustentacion/backend
   ```
2. Instalar dependencias:
   ```bash
   composer install
   ```
3. Configurar variables de entorno:
   - Renombrar `.env.example` a `.env` y configurar la conexión a la base de datos.
4. Ejecutar migraciones y seeders:
   ```bash
   php artisan migrate --seed
   ```
5. Iniciar el servidor:
   ```bash
   php artisan serve
   ```

### Frontend
1. Ir al directorio del frontend:
   ```bash
   cd PizzaPaisaSustentacion/frontend
   ```
2. Instalar dependencias:
   ```bash
   npm install
   ```
3. Iniciar el servidor de desarrollo:
   ```bash
   ng serve
   ```
4. Abrir el navegador en: `http://localhost:4200`

---

## Estado del Proyecto

- **API REST con seguridad:** Completado.
- **Frontend (Angular):** 80% completado.
- **Control de versiones:** Implementado con Git y GitHub.

---

**Desarrollado por:** 
- Diego Monroy
- Deivison Ortega
- Oscar Maluranda
- Samuel Reyes
- Lizeth Torres

Como parte del proceso formativo del SENA, Trimestre 5.
