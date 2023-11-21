# VSCode + Docker para el desarrollo en Odoo con completado inteligente

1. Instalar VSCode de su página oficial - <https://code.visualstudio.com>
2. Instalar las extensiones necesarias para el trabajo en Odoo
   - Python Support - <https://marketplace.visualstudio.com/items?itemName=donjayamanne.python-extension-pack>
   - Odoo Support - <https://marketplace.visualstudio.com/items?itemName=trinhanhngoc.vscode-odoo>
   - Odoo Snippets Final (Opcional) - <https://marketplace.visualstudio.com/items?itemName=mjavint.mjavint-odoo-snippets>
3. Crear el espacio de trabajo importando el código fuente de Odoo
4. Configurar y modificar el fichero pyrightconfig.json
5. Compilar la imagen de docker con el fichero Dockerfile
6. Configurar las variables en el .env
7. Configurar el debug en vscode

Instalaciones extras para manejar este repositorio

1. Instalar `direnv`
- `direnv` es una ingeniosa extensión de código abierto para su shell en un sistema operativo UNIX como Linux y macOS. Se compila en un solo ejecutable estático y admite shells como bash, zsh, tcsh y fish.

*  Mac
```sh
   brew install direnv
```
* Linux
```sh
$ sudo apt install direnv	#Debian,Ubuntu and Mint
$ sudo dnf install direnv	#Fedora
```

* Conectar `direnv` a Bash Shell ~/.bashrc

```bash
eval "$(direnv hook bash)"
```
* Dar permiso a direnv 
```sh
direnv allow
```
* Revocar permiso a direnv
```bash
$  direnv deny .  #en directorio actual
$  direnv deny /path/to/.envrc
$  man direnv
```
