# Script para parar todos os serviços do eStore
# Uso: .\stop-all.ps1

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "    PARANDO PROJETO eSTORE" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 1. Parar Frontend
Write-Host "[1/3] Parando Frontend..." -ForegroundColor Yellow
$pidFile = "$PSScriptRoot\frontend.pid"
if (Test-Path $pidFile) {
    $processId = Get-Content $pidFile
    taskkill /PID $processId /F /T 2>$null
    Remove-Item $pidFile -Force
    Write-Host "✓ Frontend parado" -ForegroundColor Green
}
else {
    Write-Host "  Nenhum PID salvo, buscando processos..." -ForegroundColor Gray
    $ports = netstat -ano | findstr ":3000.*LISTENING"
    if ($ports) {
        $pids = $ports | ForEach-Object { ($_ -split '\s+')[-1] } | Get-Unique
        foreach ($p in $pids) {
            if ($p -match '^\d+$') {
                taskkill /PID $p /F /T 2>$null
            }
        }
    }
    Write-Host "✓ Frontend parado" -ForegroundColor Green
}

# 2. Parar Backend
Write-Host "`n[2/3] Parando Backend..." -ForegroundColor Yellow
$pidFile = "$PSScriptRoot\backend.pid"
if (Test-Path $pidFile) {
    $processId = Get-Content $pidFile
    taskkill /PID $processId /F /T 2>$null
    Remove-Item $pidFile -Force
    Write-Host "✓ Backend parado" -ForegroundColor Green
}
else {
    Write-Host "  Nenhum PID salvo, buscando processos..." -ForegroundColor Gray
    $ports = netstat -ano | findstr ":3001.*LISTENING"
    if ($ports) {
        $pids = $ports | ForEach-Object { ($_ -split '\s+')[-1] } | Get-Unique
        foreach ($p in $pids) {
            if ($p -match '^\d+$') {
                taskkill /PID $p /F /T 2>$null
            }
        }
    }
    Write-Host "✓ Backend parado" -ForegroundColor Green
}

# 3. Parar MongoDB
Write-Host "`n[3/3] Parando MongoDB..." -ForegroundColor Yellow
docker-compose down
Write-Host "✓ MongoDB parado" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Todos os serviços foram parados!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan
