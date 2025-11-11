# Script para manter o frontend rodando em background
# Uso: .\start-frontend.ps1

Write-Host "Iniciando Frontend React em background..." -ForegroundColor Green

# Navegar para o diretório do frontend
Set-Location -Path "$PSScriptRoot\frontend"

# Iniciar processo em background usando Start-Process
$process = Start-Process -FilePath "yarn" -ArgumentList "start" -PassThru -WindowStyle Hidden

Write-Host "`nFrontend iniciado!" -ForegroundColor Green
Write-Host "PID: $($process.Id)" -ForegroundColor Cyan
Write-Host "URL: http://localhost:3000" -ForegroundColor Cyan
Write-Host "`nPara parar: taskkill /PID $($process.Id) /F /T" -ForegroundColor Yellow

# Salvar PID em arquivo
$process.Id | Out-File -FilePath "$PSScriptRoot\frontend.pid" -Encoding UTF8

Write-Host "`nPID salvo em frontend.pid" -ForegroundColor Gray
