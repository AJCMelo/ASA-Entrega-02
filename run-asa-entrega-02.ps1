<#
.SYNOPSIS
  Automação para ASA-Entrega-02: atualiza DNS, (re)cria containers e ajusta hosts do Windows.
.NOTES
  Rodar **como Administrador**.
#>

# 1) Verifica se é administrador
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error " Execute este script como Administrador!"
    Exit 1
}

# 2) Caminhos
$projectPath = "C:\Users\Ana_Júlia\DISCIPLINAS\ASA\ASA 2025.1\Entrega-02"
$zoneFile    = Join-Path $projectPath "dns\db.asa.br"
$hostsFile   = "C:\Windows\System32\drivers\etc\hosts"

# 3) Atualiza zona DNS (db.asa.br)
Write-Host "Atualizando db.asa.br..."
$content = Get-Content $zoneFile -Raw

# 3.1) Incrementa serial
$content = $content -creplace '(\(\s*)(\d+)(\s*; serial)', {
    "$($Matches[1])$([int]$Matches[2] + 1)$($Matches[3])"
}

# 3.2) Adiciona A-record para asa.br se faltar
if ($content -notmatch '^\s*@\s+IN\s+A\s+10\.6\.0\.20') {
    $content = $content -replace '(@\s+IN\s+NS\s+ns\.asa\.br\.)',
        "$&`r`n@       IN  A   10.6.0.20    ; apex record"
}

# Grava o arquivo
Set-Content -Path $zoneFile -Value $content -Encoding ASCII
Write-Host "db.asa.br atualizado."

# 4) Reconstrói só o DNS
Push-Location $projectPath
docker-compose up -d --no-deps --build dns

# 5) Para e limpa tudo
docker-compose down
docker network prune -f

# 6) Sobe toda infraestrutura
docker-compose up -d --build

# 7) Flusha cache DNS do Windows
Write-Host "Limpando cache DNS..."
ipconfig /flushdns | Out-Null

# 8) Ajusta hosts se necessário
Write-Host "Ajustando hosts..."
$pattern = '^\s*127\.0\.0\.1\s+asa\.br'
if (-not (Select-String -Path $hostsFile -Pattern $pattern)) {
    Add-Content -Path $hostsFile -Value "`r`n127.0.0.1    asa.br"
    Write-Host " hosts atualizado."
} else {
    Write-Host "hosts já contém asa.br"
}

Pop-Location
Write-Host "`Pronto! Acesse: http://asa.br/web01 e http://asa.br/web02"
