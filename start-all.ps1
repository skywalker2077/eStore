# Script para iniciar todos os serviços do eStore
# Uso: .\start-all.ps1

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "    INICIANDO PROJETO eSTORE" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 1. Iniciar MongoDB
Write-Host "[1/3] Iniciando MongoDB..." -ForegroundColor Yellow
docker-compose up -d mongodb
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ MongoDB iniciado" -ForegroundColor Green
}
else {
    Write-Host "✗ Erro ao iniciar MongoDB" -ForegroundColor Red
    exit 1
}

Start-Sleep -Seconds 3

# 2. Iniciar Backend
Write-Host "`n[2/3] Iniciando Backend..." -ForegroundColor Yellow
Set-Location -Path "$PSScriptRoot\backend"
$backendProcess = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\backend'; yarn start" -PassThru -WindowStyle Hidden
$backendProcess.Id | Out-File -FilePath "$PSScriptRoot\backend.pid" -Encoding UTF8
Write-Host "✓ Backend iniciado (PID: $($backendProcess.Id))" -ForegroundColor Green

Start-Sleep -Seconds 5

# 3. Iniciar Frontend
Write-Host "`n[3/3] Iniciando Frontend..." -ForegroundColor Yellow
Set-Location -Path "$PSScriptRoot\frontend"
$frontendProcess = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\frontend'; yarn start" -PassThru -WindowStyle Hidden
$frontendProcess.Id | Out-File -FilePath "$PSScriptRoot\frontend.pid" -Encoding UTF8
Write-Host "✓ Frontend iniciado (PID: $($frontendProcess.Id))" -ForegroundColor Green

Start-Sleep -Seconds 10

# Verificar status
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "    STATUS DOS SERVIÇOS" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "MongoDB:" -ForegroundColor White
docker ps --filter "name=estore-mongodb" --format "  Status: {{.Status}}"
Write-Host "  URL: mongodb://localhost:27017`n" -ForegroundColor Gray

Write-Host "Backend:" -ForegroundColor White
$backend = netstat -ano | findstr ":3001.*LISTENING"
if ($backend) {
    Write-Host "  Status: Running" -ForegroundColor Green
    Write-Host "  URL: http://localhost:3001" -ForegroundColor Gray
    Write-Host "  PID: $($backendProcess.Id)`n" -ForegroundColor Gray
}
else {
    Write-Host "  Status: NOT RUNNING" -ForegroundColor Red
}

Write-Host "Frontend:" -ForegroundColor White
Write-Host "  Status: Starting..." -ForegroundColor Yellow
Write-Host "  URL: http://localhost:3000" -ForegroundColor Gray
Write-Host "  PID: $($frontendProcess.Id)`n" -ForegroundColor Gray

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nAguarde ~30 segundos para compilação completa do frontend." -ForegroundColor Yellow
Write-Host "Acesse: http://localhost:3000`n" -ForegroundColor Green

Set-Location -Path $PSScriptRoot
