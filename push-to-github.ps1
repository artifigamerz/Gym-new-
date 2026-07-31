# Push Fitness Arena project to GitHub
# Repo: https://github.com/artifigamerz/Gym-new-

$ErrorActionPreference = "Stop"
$projectPath = "C:\Users\m_ran\Projects\Modern-Premium-Fully"
$remoteUrl = "https://github.com/artifigamerz/Gym-new-.git"

# Find git
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    $gitCandidates = @(
        "C:\Program Files\Git\cmd\git.exe",
        "C:\Program Files\Git\bin\git.exe"
    )
    foreach ($candidate in $gitCandidates) {
        if (Test-Path $candidate) {
            $git = $candidate
            break
        }
    }
}

if (-not $git) {
    Write-Host "Git is not installed." -ForegroundColor Red
    Write-Host "Install from: https://git-scm.com/download/win"
    Write-Host "Then run this script again."
    exit 1
}

Set-Location $projectPath

Write-Host "Checking repository..." -ForegroundColor Cyan
& $git status

# Set GitHub as origin (keeps existing history)
$remotes = & $git remote
if ($remotes -contains "origin") {
    & $git remote set-url origin $remoteUrl
} else {
    & $git remote add origin $remoteUrl
}

Write-Host "Staging changes..." -ForegroundColor Cyan
& $git add -A

$status = & $git status --porcelain
if ($status) {
    & $git commit -m "Add Fitness Arena site with Google Form contact integration"
}

Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
Write-Host "If prompted, sign in with your GitHub username and a Personal Access Token (not password)."
Write-Host "Create a token at: https://github.com/settings/tokens"

& $git branch -M main
& $git push -u origin main

Write-Host ""
Write-Host "Done! View your repo at: https://github.com/artifigamerz/Gym-new-" -ForegroundColor Green
