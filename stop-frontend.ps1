# Script para parar o frontend
# Uso: .\stop-frontend.ps1

Write-Host "Parando Frontend React..." -ForegroundColor Yellow

$pidFile = "$PSScriptRoot\frontend.pid"

if (Test-Path $pidFile) {
    $pid = Get-Content $pidFile
    Write-Host "Encerrando processo PID: $pid" -ForegroundColor Gray
    
    try {
        taskkill /PID $pid /F /T 2>$null
        Write-Host "Frontend parado com sucesso!" -ForegroundColor Green
        Remove-Item $pidFile -Force
    }
    catch {
        Write-Host "Erro ao parar o processo. Pode já ter sido encerrado." -ForegroundColor Red
    }
}
else {
    Write-Host "Nenhum PID encontrado. Buscando processos node na porta 3000..." -ForegroundColor Gray
    
    $ports = netstat -ano | findstr ":3000.*LISTENING"
    if ($ports) {
        $pids = $ports | ForEach-Object { ($_ -split '\s+')[-1] } | Get-Unique
        foreach ($p in $pids) {
            if ($p -match '^\d+$') {
                Write-Host "Matando PID: $p" -ForegroundColor Gray
                taskkill /PID $p /F /T 2>$null
            }
        }
        Write-Host "Frontend parado!" -ForegroundColor Green
    }
    else {
        Write-Host "Nenhum processo encontrado na porta 3000." -ForegroundColor Gray
    }
}
