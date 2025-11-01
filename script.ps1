#Deve ser executado como Administrador do PowerShell
function Remove-WindowsApp {
    param (
        [Parameter(Mandatory=$true)]
        [string]$PackageName,
        
        [switch]$AllUsers
    )

    Write-Host "Processando... '$PackageName'..."

    # 1. Encontra o app
    $appPackage = Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*$PackageName*" }

    if ($null -eq $appPackage) {
        Write-Warning "  -> Nenhum app encontrado contendo o termo '$PackageName'. Pulando."
        return
    }

    Write-Host "  -> Pacotes encontrados:"
    $appPackage | Select-Object Name, PackageFullName | Format-Table -AutoSize

    # 2. Remove o aplicativo
    try {
        Write-Host "  -> Removendo para todos os usuarios..."
        $appPackage | Remove-AppxPackage -AllUsers -ErrorAction Stop
        
        Write-Host "  -> SUCESSO: '$PackageName' removido." -ForegroundColor Green
    }
    catch {
        Write-Error "  -> FALHA ao remover '$PackageName'. Detalhes: $($_.Exception.Message)"
        Write-Host "  -> Verifique se o PowerShell esta rodando como Administrador." -ForegroundColor Yellow
    }
}

$AppsParaRemover = @(
    "XboxApp",        # Aplicativo Xbox
    "Clima",    # Clima
    "GrooveMusic",      # Música Groove/Media Player
    "SolitaireCollection", # Jogos de Paciência
    "OneConnect",     # Aplicativo de Conexão do Console Xbox
    "Microsoft.GetHelp", # Aplicativo de Ajuda
    "Microsoft.Microsoft3DViewer", # Visualizador 3D
    "Microsoft.MicrosoftOfficeHub", # Hub do Office
    "Microsoft.MicrosoftSolitaireCollection", # Coleção de Paciência
    "Microsoft.MSPaint", # Paint
    "Microsoft.News", # Notícias
    "Microsoft.People", # Pessoas
    "Microsoft.SkypeApp", # Skype
    "Microsoft.Wallet", # Carteira
    "Microsoft.WindowsMaps", # Mapas
    "Microsoft.WindowsSoundRecorder", # Gravador de Som
    "Microsoft.XboxGameCallableUI", # Interface de Jogos Xbox
    "Microsoft.XboxIdentityProvider", # Provedor de Identidade Xbox
    "Microsoft.YourPhone", # Seu Telefone
    "Microsoft.ZuneVideo", # Filmes e TV
    "3DBuilder", # Construtor 3D
    "CandyCrush", # Candy Crush Saga
    "Flipboard", # Flipboard
    "GrooveMusic", # Groove Música
    "MailAndCalendar", # Correio e Calendário
    "MixedRealityPortal", # Portal de Realidade Mista
    "People", # Pessoas
    "Sports", # Esportes
    "VoiceRecorder", # Gravador de Voz
    "Weather", # Clima
    "WindowsAlarms", # Alarmes e Relógio
    "WindowsFeedbackHub", # Hub de Feedback do Windows
    "WindowsMaps", # Mapas do Windows
    "Microsoft.OneDrive" # OneDrive

    # Adicione outros termos conforme necessário!
)

Write-Host "Iniciando rotina de limpeza de Bloatware do Windows 11..." -ForegroundColor Cyan
Write-Host "ATENÇAO: Este script sera executado com o parametro -AllUsers, exigindo permissoes de Administrador." -ForegroundColor Yellow
Write-Host "====================================================================="

foreach ($App in $AppsParaRemover) {
    Remove-WindowsApp -PackageName $App -AllUsers
}

Write-Host "====================================================================="
Write-Host "Rotina de limpeza concluida." -ForegroundColor Cyan