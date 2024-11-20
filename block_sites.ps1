# Vérifier et ajuster la politique d'exécution pour ce processus uniquement
If ((Get-ExecutionPolicy -Scope Process) -ne "Bypass") {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
}


# Chemin vers le fichier hosts
$hostsFile = "C:\Windows\System32\drivers\etc\hosts"

# Sites à gérer
$sites = @(
    "127.0.0.1 www.twoplayergames.org",
    "127.0.0.1 www.crazygames.com",
    "127.0.0.1 www.crazygames.fr"
    "127.0.0.1 poki.com"
    "127.0.0.1 www.poki.com"
    "127.0.0.1 poki.com/fr"
    "127.0.0.1 playhop.com"
    "127.0.0.1 www.1001games.com"
)

# Fonction pour bloquer des sites
function Block-Sites {
    try {
        # Lire le contenu actuel du fichier hosts
        $currentHosts = Get-Content $hostsFile -ErrorAction Stop

        # Ajouter les lignes si elles n'existent pas déjà
        foreach ($site in $sites) {
            if (-not ($currentHosts -contains $site)) {
                Add-Content -Path $hostsFile -Value $site
                Write-Host "Site bloqué : $site" -ForegroundColor Green
            } else {
                Write-Host "Le site est déjà bloqué : $site" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "Erreur lors de la modification du fichier hosts. Assurez-vous d'avoir les droits d'administrateur." -ForegroundColor Red
    }
}

Block-Sites
