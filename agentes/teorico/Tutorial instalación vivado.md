# Guía de instalación de Vivado (lab 1)

**Aclaración:** Para el proceso de instalación el programa necesita 62 Gb libres, pero el programa finalmente ocupa 36 Gb.

## 1. Descargar el instalador

Descargar el instalador. Es necesario tener una cuenta de AMD tanto para bajar el instalador como a la hora de instalarlo:

- **Linux:** *AMD Unified Installer for FPGAs & Adaptive SoCs 2024.2: Linux Self Extracting Web Installer*
- **Windows:** *AMD Unified Installer for FPGAs & Adaptive SoCs 2024.2: Windows Self Extracting Web Installer*

(Ambos son enlaces al sitio de descargas de AMD/Xilinx.)

### Darle permisos de ejecución (solo para Linux)

```
$ chmod +x FPGAs_AdaptiveSoCs_Unified_2024.2_1113_1001_Lin64.bin
```

### Ejecutar el instalador

- **En Linux:**
  ```
  $ sudo ./FPGAs_AdaptiveSoCs_Unified_2024.2_1113_1001_Lin64.bin
  ```
- **En Windows:** hacer doble click en el archivo instalador que bajaron.

Una vez iniciado el instalador…

## 2. Pantalla de bienvenida (Welcome)

**Captura:** Ventana *"AMD Unified Installer for FPGAs & Adaptive SoCs 2024.2 - Welcome"*.

- En el panel izquierdo se ve el logo "AMD Unified Installer for FPGAs & Adaptive SoCs" y el logo de AMD abajo a la izquierda.
- El panel derecho ("Welcome") contiene un texto de bienvenida que indica que el programa permite instalar productos de AMD incluyendo Vitis, Vivado Design Environment, Lab Edition, Bootgen, HW_Server, PetaLinux, Power Design Manager y Documentation Navigator.
- Lista los sistemas operativos soportados para 2024.2: Red Hat Enterprise Linux 7.9 64-bit (no soportado para PetaLinux), Red Hat Enterprise Linux 8.8–8.10, 9.2–9.4 64-bit (no soportado para PetaLinux), CentOS Linux 7.9 64-bit (no soportado para PetaLinux), SUSE Enterprise Linux 15.4 64-bit (no soportado para PetaLinux), Amazon Linux 2 AL2 LTS 64-bit (no soportado para PetaLinux), Ubuntu Linux 20.04.5–20.04.6, 22.04.1–22.04.4 y 24.04 LTS 64-bit, AlmaLinux 8.7, 8.10, 9.1, 9.4 64-bit.
- Nota: puede ser necesario instalar librerías adicionales (ver sección "Checking Required Libraries" de UG973). Los productos individuales pueden requerir un subconjunto menor de esta lista.
- Nota: esta versión requiere actualizar las herramientas del servidor de licencias a la versión Flex 11.17.2; confirmar con el administrador de licencias que la versión correcta está instalada y disponible antes de correr las herramientas.
- Nota: este instalador no instala los drivers de cable en Linux; deben instalarse por separado, con privilegios de administrador.
- En texto rojo: para reducir el tiempo de instalación se recomienda deshabilitar cualquier antivirus antes de continuar, y deshabilitar cualquier configuración de ahorro de energía (modo de suspensión automática) de la máquina mientras corre el instalador.
- Botones abajo a la derecha: **Preferences**, **< Back** (deshabilitado), **Next >** (marcado/resaltado con un círculo verde — es el botón a presionar), **Cancel**.

➡️ Presionar **Next**.

## 3. Inicio de sesión (Select Install Type)

Iniciar sesión y dejar seleccionada la opción *Download and install Now*.

**Captura:** Ventana *"Select Install Type"*, sección "User Authentication":

- Texto: "Please provide your AMD user account credentials to download the required files. If you don't have an account, please create one. If you forgot your password, you can reset it here."
- Campo **E-mail Address** (con flecha verde señalándolo): completar con el email de la cuenta AMD.
- Campo **Password** (con flecha verde señalándolo): completar con la contraseña.
- Radio button **"Download and Install Now"** — seleccionado (con flecha verde señalándolo). Descripción: "Select your desired device and tool installation options and the installer will download and install just what is required."
- Radio button **"Download Image (Install Separately)"** — no seleccionado, aparece en gris/deshabilitado. Descripción: "The installer will download an image containing all devices and tool options for later installation. Use this option if you need to install a full image on a network drive or allow different users maximum flexibility when installing."
- Botones abajo: **< Back**, **Next >** (resaltado con círculo verde), **Cancel**.

➡️ Completar credenciales, dejar tildada "Download and Install Now" y presionar **Next**.

## 4. Elegir la herramienta Vivado (Select Product to Install)

**Captura:** Ventana *"Select Product to Install"*. Lista de radio buttons, cada uno con una descripción:

- **Vitis** — Vitis Core Development Kit para desarrollo de software y aceleración de aplicaciones embebidas en plataformas AMD. Incluye Vitis Model Composer, etc.
- **Vivado** ← seleccionar esta opción (marcada con flecha verde). Descripción: "Includes the full complement of Vivado Design Suite tools for design, including C-based design with Vitis High-Level Synthesis, implementation, verification, and device programming. Complete device support, cable driver, and Document Navigator included. Users can also select to install the Vitis Model Composer to design for AI Engines and Programmable Logic in MATLAB and Simulink. There is an option to install Power Design Manager for power estimation of Versal, UltraScale+, and Kria products."
- **Vitis Embedded Development** — paquete standalone de desarrollo de software embebido para crear, compilar, depurar y optimizar aplicaciones de software para procesadores FPGA de AMD.
- **BootGen** — instala Bootgen para crear imágenes booteables para SoCs y FPGAs de AMD.
- **Lab Edition** — producto standalone que incluye solamente Vivado Design Programmer, Vivado Logic Analyzer y UpdateMEM tools.
- **Hardware Server** — instala hardware server y drivers de cable JTAG para debugging remoto.

Botones abajo: **< Back**, **Next >** (resaltado con círculo verde), **Cancel**.

➡️ Seleccionar **Vivado** y presionar **Next**.

## 5. Elegir la edición (Select Edition to Install)

Elegir la opción *Vivado ML Standard*.

**Captura:** Ventana *"Select Edition to Install"*, dos radio buttons:

- **Vivado ML Standard** ← seleccionar esta opción (marcada con flecha verde). Descripción: "Vivado ML Standard Edition is the no-cost, device limited version of the Vivado ML Enterprise edition. Users can add Vitis Model Composer which is an AMD toolbox for MATLAB and Simulink to design for AI Engines and Programmable Logic. If you have been using AMD System Generator for DSP, you can continue development using Vitis Model Composer. There is an option to install Power Design Manager for power estimation of Versal, UltraScale+, and Kria products."
- **Vivado ML Enterprise** — no seleccionar. Descripción: "Vivado ML Enterprise Edition includes the full complement of Vivado Design Suite tools for design, including C-based design with Vitis HLS, implementation, verification, and device programming. Complete device support, cable driver, and documentation navigator are included. Users can add Vitis Model Composer which is an AMD toolbox for MATLAB and Simulink to design for AI Engines and Programmable Logic. If you have been using AMD System Generator for DSP, you can continue development using Vitis Model Composer. There is an option to install Power Design Manager for power estimation of Versal, UltraScale+, and Kria products."

Botones abajo: **< Back**, **Next >** (resaltado con círculo verde), **Cancel**.

➡️ Seleccionar **Vivado ML Standard** y presionar **Next**.

## 6. Elegir componentes a instalar (customización)

Elegir las opciones tal como se muestra en la siguiente imagen.

**Captura (Linux):** Ventana *"Vivado ML Standard"*, con un árbol de checkboxes ("Customize your installation by (de)selecting items in the tree below. Moving cursor over selections below provide additional information."):

- **Design Tools** (tildado, expandido)
  - **Vivado Design Suite**
    - **Vivado** — tildado
    - **Vitis HLS** — tildado
  - **Vitis Networking P4** — tildado
  - Vitis Model Composer/Toolbox for MATLAB and Simulink (Includes the functionality of System Generator for DSP) — **sin tildar**
  - Vitis Embedded Development — **sin tildar**
  - Power Design Manager (PDM) — **sin tildar**
  - **DocNav** — tildado
- **Devices**
  - Install Devices for Kria SOMs and Starter Kits — **sin tildar**
  - **Production Devices** (tildado, expandido)
    - SoCs — **sin tildar**
    - **7 Series (limited support)** — tildado, expandido:
      - Artix-7 — tildado
      - Kintex-7 — tildado
      - Spartan-7 — tildado
      - Virtex-7 — sin tildar
    - UltraScale (limited support) — sin tildar
    - UltraScale+ (limited support) — sin tildar
    - Versal ACAP — sin tildar
  - Engineering Sample Devices — deshabilitado/gris
- **Installation Options** — tildado. Nota debajo: "NOTE: Cable Drivers are not installed on Linux. Please follow the instructions in UG973 to install Linux cable drivers."

Al pie: **Download Size: 15.67 GB**, **Disk Space Required: 61.82 GB**. Botón **Reset to Defaults** a la derecha.

Botones abajo: **< Back**, **Next >** (resaltado con círculo verde), **Cancel**.

### En Windows se ve un poco diferente

**Captura (Windows):** Misma ventana *"Vivado ML Standard"*, mismo árbol de opciones (Design Tools → Vivado Design Suite → Vivado y Vitis HLS tildados; Vitis Model Composer, Vitis Embedded Development y Power Design Manager sin tildar; DocNav tildado; Devices → Production Devices → 7 Series con Artix-7, Kintex-7 y Spartan-7 tildados, Virtex-7 sin tildar; UltraScale, UltraScale+ y Versal ACAP sin tildar), pero con una diferencia importante en **Installation Options**:

- **Install Cable Drivers (You MUST disconnect all Xilinx Platform Cable USB II cables before proceeding)** — tildado (en Windows sí se instalan los drivers de cable desde el instalador).

Al pie: **Download Size: 15.31 GB**, **Disk Space Required: 57.39 GB**.

Botones abajo: **< Back**, **Next >**, **Cancel**.

➡️ Dejar la selección de componentes como se describió y presionar **Next**.

## 7. Aceptar los términos y condiciones (Accept License Agreements)

**Captura:** Ventana *"Accept License Agreements"* ("Please read the following terms and conditions and indicate that you agree by checking the I Agree checkboxes."). Contiene cuatro bloques, cada uno con un checkbox **I Agree** que hay que tildar (todos aparecen marcados con flecha verde señalándolos):

1. **End User License Agreement for Vivado** — checkbox "I Agree" tildado.
2. **End User License Agreement for DocNav** — checkbox "I Agree" tildado.
3. **Third Party Software End User License Agreement for DocNav** — checkbox "I Agree" tildado.
4. **Third Party Software End User License Agreement for Vivado** — checkbox "I Agree" tildado.

Cada bloque tiene el texto: "By checking 'I Agree' below, or OTHERWISE ACCESSING, DOWNLOADING, INSTALLING OR USING THE SOFTWARE, I AGREE on behalf of licensee to be bound by the agreement, which can be viewed by clicking here" (con un link "clicking here").

Botones abajo: **< Back**, **Next >** (resaltado con círculo verde), **Cancel**.

➡️ Tildar los cuatro checkboxes "I Agree" y presionar **Next**.

## 8. Elegir el directorio de instalación (Select Destination Directory)

**Captura (Linux):** Ventana *"Select Destination Directory"* ("Choose installation options such as location and shortcuts."), dividida en dos columnas:

**Columna izquierda — "Installation Options":**
- Campo **"Select the installation directory"**: `/opt/Xilinx` (con flecha verde señalando el campo), con botón de exploración "…" al lado.
- **Installation Location(s):**
  - `/opt/Xilinx/Vivado/2024.2`
  - `/opt/Xilinx/Vitis_HLS/2024.2`
  - `/opt/Xilinx/DocNav`
- **Download location:** `/opt/Xilinx/Downloads/Vivado_2024.2`
- **Disk Space Required:**
  - Download Size: 15.67 GB
  - Disk Space Required: 61.82 GB
  - Final Disk Usage: 35.9 GB
  - Disk Space Available: 289.62 GB

**Columna derecha — "Select shortcut and file association options":**
- Checkbox **"Create program group entries"** — tildado, con campo de texto al lado con el valor **"Xilinx Design Tools"**.
- Checkbox **"Create desktop shortcuts"** — tildado.

Botones abajo: **< Back**, **Next >** (resaltado con círculo verde), **Cancel**.

### En Windows se ve un poco diferente

**Captura (Windows):** Misma ventana *"Select Destination Directory"*:

**Columna izquierda:**
- Campo de directorio de instalación: `C:\Xilinx`
- **Installation Location(s):**
  - `C:\Xilinx\Vivado\2024.2`
  - `C:\Xilinx\Vitis_HLS\2024.2`
  - `C:\Xilinx\DocNav`
- **Download Location:** `C:\Xilinx\Downloads\Vivado_2024.2`
- **Disk Space Required:**
  - Download Size: 15.31 GB
  - Disk Space Required: 57.39 GB
  - Final Disk Usage: 32.40 GB
  - Disk Space Available: 88.61 GB

**Columna derecha:**
- Checkbox **"Create program group entries"** — tildado, con campo de texto **"Xilinx Design Tools"**.
- Checkbox **"Create desktop shortcuts"** — tildado.
- Checkbox **"Create file associations"** — tildado.
- Sección "Apply shortcut & file association selections to": radio button **"Current user"** — seleccionado; radio button **"All users"** — no seleccionado.

Botones abajo: **< Back**, **Next >**, **Cancel**.

➡️ Dejar los valores por defecto y presionar **Next**.

## 9. Continuar con la instalación (Installation Summary)

**Captura:** Ventana *"Installation Summary"*, panel izquierdo con logo AMD Unified Installer for FPGAs & Adaptive SoCs. Panel derecho con el resumen:

- **Edition:** Vivado ML Standard
- **Devices:** Production Devices (7 Series)
- **Design Tools:** Vivado Design Suite (Vivado, Vitis HLS); DocNav
- **Installation location:**
  - `/opt/Xilinx/Vivado/2024.2`
  - `/opt/Xilinx/Vitis_HLS/2024.2`
  - `/opt/Xilinx/DocNav`
- **Download location:** `/opt/Xilinx/Downloads/Vivado_2024.2`
- **Disk Space Required:**
  - Download Size: 15.67 GB
  - Disk Space Required: 61.82 GB
  - Final Disk Usage: 35.9 GB

Botones abajo a la derecha: **Preferences**, **< Back**, **Install** (este es el botón a presionar para arrancar la instalación), **Cancel**.

➡️ Revisar el resumen y presionar **Install**.

## 10. Esperar que se descargue la herramienta y se instale

**Captura:** Ventana *"Installation Progress"*. Panel izquierdo con tres barras de progreso apiladas:

1. **"Downloading files (5.41 GB / 16.37 GB)"** — con texto **"20 minutes left at 11 MB/sec."** y su barra de progreso activa (esta es la etapa en curso en la captura).
2. **"Install…"** — barra de progreso todavía inactiva/gris (etapa siguiente, aún no comenzó).
3. **"Final Processing…"** — barra de progreso todavía inactiva/gris (última etapa, aún no comenzó).

Panel derecho: imagen publicitaria de **AMD Vitis** con el eslogan **"Unlocking a new design experience for all developers"**.

Botones abajo: **< Back** (deshabilitado), **Install** (deshabilitado, ya en curso), **Cancel**.

Este proceso puede tardar bastante (descarga de varios GB más instalación). Solo hay que esperar a que termine.

## 11. Verificar el funcionamiento corriendo la herramienta

- **En Linux:**
  ```
  $ /opt/Xilinx/Vivado/2024.2/bin/vivado
  ```
  Por defecto la herramienta se instala en:
  ```
  $ /tool/Xilinx/Vivado/2024.2/bin/vivado
  ```
- **En Windows:** hacer doble click en el ícono del programa (Vivado).

## 12. Instalar los drivers (Linux)

```
$ sudo /opt/Xilinx/Vivado/2024.2/data/xicom/cable_drivers/lin64/install_script/install_drivers/install_drivers
```

Verificar si se instalaron correctamente:

```
ls -al /etc/udev/rules.d
```

Deberían existir, al menos, estos dos archivos:

```
52-digilent-usb.rules
52-xilinx-pcusb.rules
```

## Problemas comunes

Si cuando lo ejecutan aparece el siguiente error (Linux):

```
/bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8) terminate called after throwing an instance of 'std::runtime_error' what(): locale::facet::_S_create_c_locale name not valid
```

Significa que el Linux que están usando no tiene configurado el Locale en inglés. Para eso tienen que probar qué locales tienen con el comando:

```
$ locale -a
```

Y luego agregar los locale en_US:

```
$ sudo locale-gen en_US
$ sudo locale-gen en_US.utf8
$ sudo update-locale
```
