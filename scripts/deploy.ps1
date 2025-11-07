# Exemple: installation silencieuse avec winget (Windows 10/11 récent)
$pkgs = @(
  @{ id = "Mozilla.Firefox" },
  @{ id = "VideoLAN.VLC" },
  @{ id = "7zip.7zip" }
)

foreach ($p in $pkgs) {
  winget install --id $($p.id) --silent --accept-source-agreements --accept-package-agreements --disable-interactivity || $true
}
