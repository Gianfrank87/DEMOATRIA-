param([string] $FreeCADExe)

$ErrorActionPreference = 'Stop'
$repo = Join-Path $PSScriptRoot 'Atria'
$runtime = Join-Path $PSScriptRoot 'work'
$dependencies = Join-Path $runtime 'atria-deps'
$marker = Join-Path $dependencies '.instalado'

if (-not $FreeCADExe) {
    $candidates = @(
        "$env:ProgramFiles\FreeCAD 1.1\bin\freecad.exe"
        "$env:LOCALAPPDATA\Programs\FreeCAD 1.1\bin\freecad.exe"
        "$env:ProgramFiles\FreeCAD\bin\freecad.exe"
    )
    $FreeCADExe = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    if (-not $FreeCADExe) {
        $command = Get-Command freecad.exe -ErrorAction SilentlyContinue
        if ($command) { $FreeCADExe = $command.Source }
    }
}
if (-not $FreeCADExe -or -not (Test-Path -LiteralPath $FreeCADExe -PathType Leaf)) {
    throw 'No se encontro FreeCAD. Instala FreeCAD 1.1 de 64 bits o indica su ruta con -FreeCADExe.'
}
$FreeCADExe = (Resolve-Path -LiteralPath $FreeCADExe).Path
$python = Join-Path (Split-Path $FreeCADExe) 'python.exe'

if (-not (Test-Path -LiteralPath $marker)) {
    if (-not (Test-Path -LiteralPath $python)) { throw 'No se encontro el Python incluido en FreeCAD.' }
    New-Item -ItemType Directory -Path $dependencies -Force | Out-Null
    Write-Host 'Instalando las dependencias de voz de la demo. Este paso requiere Internet.'
    & $python -I -m pip install --disable-pip-version-check --upgrade --target $dependencies 'vosk==0.3.45' 'sounddevice==0.5.6'
    if ($LASTEXITCODE -ne 0) { throw 'No se pudieron descargar las dependencias de voz.' }
    $env:ATRIA_DEMO_DEPENDENCIES = $dependencies
    & $python -I -c "import os, sys; sys.path.insert(0, os.environ['ATRIA_DEMO_DEPENDENCIES']); import vosk, sounddevice"
    if ($LASTEXITCODE -ne 0) { throw 'FreeCAD no pudo importar las dependencias de voz.' }
    New-Item -ItemType File -Path $marker -Force | Out-Null
}

$env:PYTHONPATH = $dependencies
$env:PYTHONDONTWRITEBYTECODE = '1'
$env:ATRIA_MOD_ROOT = $repo
$env:ATRIA_GUI_FREECAD_ROOT = Join-Path $repo 'GUIFreeCad'
$env:ATRIA_INTERFAZ_ROOT = Join-Path $repo 'InterfazATRIA'
$env:ATRIA_DICTIONARY_ROOT = Join-Path $repo 'dictionary'
$env:ATRIA_MODELS_DIR = Join-Path $repo 'models'
$env:ATRIA_AUTOLOAD_WORKBENCH = '1'
$env:ATRIA_AUTO_START_VOICE = '1'
$env:ATRIA_AUTO_PANEL = '1'
$env:ATRIA_FREECAD_PYTHON = $python
$env:FREECAD_USER_DATA = Join-Path $runtime 'FreeCAD-profile'
$modDirectory = Join-Path $env:FREECAD_USER_DATA 'Mod'
New-Item -ItemType Directory -Path $modDirectory -Force | Out-Null
$moduleLink = Join-Path $modDirectory 'Atria'
if (-not (Test-Path -LiteralPath $moduleLink)) {
    New-Item -ItemType Junction -Path $moduleLink -Target $repo | Out-Null
}

# Load this checkout as a FreeCAD module without changing installed add-ons.
Start-Process -FilePath $FreeCADExe -WorkingDirectory $PSScriptRoot
