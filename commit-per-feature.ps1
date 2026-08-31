# Interactive script to commit features one-by-one for the ui_ecommerce project
# Usage: open PowerShell, navigate to the repo folder and run:
#   Set-Location 'C:\Users\HP\ui_ecommerce'
#   .\commit-per-feature.ps1
# If execution policy prevents running scripts, run:
#   powershell -ExecutionPolicy Bypass -File .\commit-per-feature.ps1

$repoPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$remoteUrl = 'https://github.com/AlvitoGavinMahardika86/Tugas-Flutter'

Write-Host "Repository path: $repoPath" -ForegroundColor Cyan

# Ensure we're in the expected folder
Set-Location $repoPath

function Run-Command($cmd) {
    Write-Host "\n> $cmd" -ForegroundColor DarkYellow
    $res = & cmd /c $cmd 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Command failed (exit $LASTEXITCODE): $res" -ForegroundColor Red
    } else {
        Write-Host $res
    }
}

# Ensure git is initialized and remote set
if (-not (Test-Path '.git')) {
    Write-Host "Git repo not found. Initializing git..." -ForegroundColor Yellow
    Run-Command "git init"
    Run-Command "git remote add origin $remoteUrl"
} else {
    Write-Host "Git repo found. Ensuring remote URL is set to: $remoteUrl" -ForegroundColor Green
    Run-Command "git remote set-url origin $remoteUrl"
}

# Fetch remote refs (safe)
Run-Command "git fetch origin --prune"

# Helpful pre-checks (format/analyze/test)
Write-Host "\nRunning formatter and analyzer (if Flutter installed) -- this may take a while" -ForegroundColor Cyan
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    Run-Command "flutter format ."
    Run-Command "flutter analyze"
    Write-Host "(Optional) run 'flutter test' manually if you have tests and want to run them now." -ForegroundColor Gray
} else {
    Write-Host "Flutter command not found in PATH. Skipping flutter format/analyze." -ForegroundColor Yellow
}

# Feature blocks: each item has branch, files, commit message
$features = @(
    @{ name = 'wishlist'; branch = 'feat/wishlist-toggle'; files = @('lib\\providers\\app_state.dart','lib\\pages\\wishlist_page.dart','lib\\widgets\\ItemsWidget.dart'); message = 'feat(wishlist): add favorite toggle and wishlist counter' },
    @{ name = 'cart'; branch = 'feat/cart-core'; files = @('lib\\providers\\app_state.dart','lib\\widgets\\CartItemSamples.dart','lib\\widgets\\CartBottomNavbar.dart','lib\\pages\\cart_page.dart'); message = 'feat(cart): add addToCart, quantity controls, select/unselect and subtotal/total logic' },
    @{ name = 'coupons'; branch = 'feat/coupons'; files = @('lib\\data\\dummy_data.dart','lib\\providers\\app_state.dart'); message = 'feat(coupons): implement coupon validation and discount calculation' },
    @{ name = 'checkout'; branch = 'feat/checkout-order'; files = @('lib\\providers\\app_state.dart','lib\\pages\\checkout_page.dart','lib\\models\\order_model.dart'); message = 'feat(checkout): implement placeOrder, order model and notifications' },
    @{ name = 'wallet'; branch = 'feat/wallet'; files = @('lib\\providers\\app_state.dart','lib\\pages\\account_page.dart'); message = 'feat(wallet): add wallet balance, top-up and auto-deduct on wallet payment' },
    @{ name = 'home-ui'; branch = 'ui/home-promo'; files = @('lib\\pages\\home_page.dart','lib\\widgets\\promo_carousel.dart','assets\\images\\logo.jpg','assets\\images\\product.jpg'); message = 'ui(home): add promo carousel, flash deal banner and quick stats' },
    @{ name = 'notifications'; branch = 'feat/notifications'; files = @('lib\\models\\notification_model.dart','lib\\providers\\app_state.dart','lib\\pages\\notifications_page.dart'); message = 'feat(notifications): add notification model and mark-as-read logic' }
)

function Prompt-YesNo($prompt) {
    $ans = Read-Host "$prompt (y/n)"
    return $ans -match '^[Yy]'
}

foreach ($f in $features) {
    Write-Host "\n============================" -ForegroundColor DarkCyan
    Write-Host "Feature: $($f.name)" -ForegroundColor Green
    Write-Host "Branch: $($f.branch)" -ForegroundColor Green
    Write-Host "Suggested files to stage:" -ForegroundColor Cyan
    foreach ($p in $f.files) { Write-Host "  - $p" }

    if (-not (Prompt-YesNo "Proceed to create branch and commit feature '$($f.name)'?")) {
        Write-Host "Skipping feature $($f.name)." -ForegroundColor Yellow
        continue
    }

    # Create and checkout branch
    Run-Command "git checkout -b $($f.branch)"

    # Ask staging mode
    Write-Host "\nStaging options: (A)utomatic staging of listed files, (I)nteractive per-hunk (git add -p), (S)kip this feature" -ForegroundColor Cyan
    $mode = Read-Host "Choose staging mode (A/I/S) [A]"
    if ([string]::IsNullOrWhiteSpace($mode)) { $mode = 'A' }
    $mode = $mode.Substring(0,1).ToUpper()

    if ($mode -eq 'S') {
        Write-Host "Skipping staging for $($f.name). You can revert to main or continue later." -ForegroundColor Yellow
        continue
    }

    if ($mode -eq 'A') {
        # Stage only files that exist in repo
        foreach ($p in $f.files) {
            if (Test-Path $p) {
                Run-Command "git add `"$p`""
            } else {
                Write-Host "File not found, skipping: $p" -ForegroundColor DarkYellow
            }
        }
    } else {
        # Interactive per-hunk for all files that exist
        $existing = @()
        foreach ($p in $f.files) { if (Test-Path $p) { $existing += $p } }
        if ($existing.Count -eq 0) { Write-Host "No listed files found to stage interactively." -ForegroundColor Yellow }
        else { Run-Command "git add -p $($existing -join ' ')" }
    }

    # Commit
    Run-Command "git commit -m \"$($f.message)\""

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Commit failed or nothing to commit. You may need to adjust staging." -ForegroundColor Red
        continue
    }

    # Push
    if (Prompt-YesNo "Push branch '$($f.branch)' to origin now?") {
        Run-Command "git push -u origin $($f.branch)"
    } else {
        Write-Host "Branch created locally: $($f.branch). Remember to push when ready." -ForegroundColor Yellow
    }
}

Write-Host "\nAll feature blocks processed. If you need to abort to main branch, run: git checkout main" -ForegroundColor Green
Write-Host "Script finished." -ForegroundColor Cyan
