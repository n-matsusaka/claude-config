# コラボハウス Claude Code 初期セットアップスクリプト（PowerShell版）
# 使い方: irm https://raw.githubusercontent.com/n-matsusaka/claude-config/master/setup.ps1 | iex

Write-Host "=== Claude Code セットアップ ===" -ForegroundColor Cyan
Write-Host ""

$h = $env:USERPROFILE

# ~/.claude ディレクトリの作成
$claudeDir = "$h\.claude\skills"
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
}
Write-Host "[1/4] .claude ディレクトリ OK"

# claude-config
$configDir = "$h\claude-config"
if (Test-Path "$configDir\.git") {
    Write-Host "[2/4] claude-config 最新化中..."
    Push-Location $configDir
    git pull origin master
    Pop-Location
} else {
    Write-Host "[2/4] claude-config クローン中..."
    git clone https://github.com/n-matsusaka/claude-config.git $configDir
}

# claude-template
$templateDir = "$h\_template"
if (Test-Path "$templateDir\.git") {
    Write-Host "[3/4] claude-template 最新化中..."
    Push-Location $templateDir
    git pull origin master
    Pop-Location
} else {
    Write-Host "[3/4] claude-template クローン中..."
    git clone https://github.com/n-matsusaka/claude-template.git $templateDir
}

# グローバル設定を配置
Write-Host "[4/4] 設定ファイル配置中..."
Copy-Item "$configDir\CLAUDE.md" "$h\.claude\CLAUDE.md" -Force
$skillsSrc = "$configDir\skills\*"
if (Test-Path $skillsSrc) {
    Copy-Item $skillsSrc "$h\.claude\skills\" -Recurse -Force
}

Write-Host ""
Write-Host "=== セットアップ完了 ===" -ForegroundColor Green
Write-Host ""
Write-Host "  ~/.claude/CLAUDE.md  ... 共通ルール"
Write-Host "  ~/.claude/skills/    ... 共通スキル"
Write-Host "  ~/_template/         ... テンプレート"
Write-Host ""
Write-Host "新プロジェクト作成: Claude Codeで「新プロジェクト作って」"