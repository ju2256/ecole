# deploy.ps1 — compatible PowerShell 5.1

# Journalisation simple
function Write-Log([string]$m){ $ts=(Get-Date).ToString('yyyy-MM-dd HH:mm:ss'); Write-Host "[$ts] $m" }

function Invoke-Native {
    param(
        [Parameter(Mandatory)] [string]$FilePath,
        [string[]]$Args
    )
    $p = Start-Process -FilePath $FilePath -ArgumentList $Args -Wait -PassThru -NoNewWindow
    return $p.ExitCode
}

# Exemple avec winget (si installé sur le poste)
$packages = @(
    @{ Id = "Mozilla.Firefox" },
    @{ Id = "VideoLAN.VLC" },
    @{ Id = "7zip.7zip" }
)

foreach ($pkg in $packages) {
    $args = @(
        'install','--id', $pkg.Id,
        '--silent','--accept-source-agreements','--accept-package-agreements','--disable-interactivity'
    )
    Write-Log "Installation de $($pkg.Id) ..."
    $code = Invoke-Native -FilePath 'winget.exe' -Args $args
    if ($code -ne 0) {
        Write-Warning "Echec de $($pkg.Id) (ExitCode=$code). On continue."
        continue
    }
    Write-Log "OK: $($pkg.Id)"
}
