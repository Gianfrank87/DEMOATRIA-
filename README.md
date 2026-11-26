# Demo Atria · Una casa por voz

Demostración para **FreeCAD 1.1 de 64 bits en Windows**. Atria permite crear un piso de medidas dictadas, levantar cuatro paredes y agregar puerta, ventanas y techo a dos aguas.

1. Descargá el repositorio con **Code → Download ZIP** y extraé la carpeta completa.
2. Instalá FreeCAD 1.1 si todavía no lo tenés. Cerrá cualquier ventana de FreeCAD y hacé doble clic en **Abrir-DemoATRIA.cmd**. La primera vez necesita Internet para descargar las librerías de voz. Los modelos de reconocimiento están incluidos.
3. Esperá que el panel de Atria indique **Micrófono activo**. Decí **«Crear piso de cuatro por cuatro»**. Cuando aparezca el cartel, decí **«Quince centímetros»** y después **«Aceptar»**.
4. Seguí con las paredes, aberturas y techo según la [guía de la demo](outputs/Guia-Demo-Casa.html). La guía se puede abrir en el navegador desde la carpeta que extrajiste.

La [casa de ejemplo](outputs/Casa-Demo-4x4.FCStd) se puede abrir directamente en FreeCAD. Al decir **«Guardar casa»**, el modelo nuevo queda dentro de `outputs` en la carpeta de la demo.

El lanzador busca FreeCAD en las rutas habituales. Si lo instalaste en otra carpeta, podés indicarle la ruta desde PowerShell con `-FreeCADExe` y la ubicación de `freecad.exe`.

El código de Atria proviene de [DAv-Project-Team-UADER/Atria](https://github.com/DAv-Project-Team-UADER/Atria), revisión `758443faf61dce2a3ca84bc448921658f2be9007`. La licencia del proyecto se incluye en [Atria/LICENSE](Atria/LICENSE).

## Guion completo 2D y 3D

Abrí [el guion de la jornada](outputs/Guion-Demo-Atria-2D-y-3D.html) para seguir el recorrido desde el primer documento. La [fachada de ejemplo](outputs/Casa-Demo-2D.FCStd) está lista para abrir en FreeCAD.
