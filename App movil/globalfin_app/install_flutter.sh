#!/bin/bash
# Script de instalación de Flutter en el dev container
# Tiempo estimado: 5-10 minutos

set -e

echo "🚀 Instalando Flutter SDK en el dev container..."
echo ""

# 1. Instalar dependencias
echo "📦 [1/5] Instalando dependencias..."
sudo apt-get update -qq > /dev/null 2>&1
sudo apt-get install -y -qq git curl xz-utils zip unzip libglu1-mesa > /dev/null 2>&1

# 2. Descargar Flutter
echo "⬇️  [2/5] Descargando Flutter SDK (esto puede tardar unos minutos)..."
cd /tmp
if [ ! -d "flutter" ]; then
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 > /dev/null 2>&1
fi

# 3. Mover a ubicación permanente
echo "📁 [3/5] Instalando Flutter en /opt/flutter..."
sudo mv /tmp/flutter /opt/flutter 2>/dev/null || sudo rm -rf /opt/flutter && sudo mv /tmp/flutter /opt/flutter

# 4. Agregar al PATH
echo "🔧 [4/5] Configurando PATH..."
export PATH="$PATH:/opt/flutter/bin"
echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc

# 5. Ejecutar flutter doctor
echo "🩺 [5/5] Verificando instalación..."
/opt/flutter/bin/flutter --version
echo ""
/opt/flutter/bin/flutter doctor

echo ""
echo "✅ Flutter instalado correctamente!"
echo ""
echo "🔄 Recarga el terminal con: source ~/.bashrc"
echo "📱 Luego ejecuta: cd /workspaces/Proyecto-GlobalFin/App\\ movil/globalfin_app && flutter pub get && flutter run -d web-server --web-port 8080"
echo ""
