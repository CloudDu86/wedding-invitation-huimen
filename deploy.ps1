[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Set-Location $PSScriptRoot

$projectName = "wedding-invitation-huimen"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   回门宴邀请函 Cloudflare Pages 一键部署" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查 Node.js 环境
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "未检测到 Node.js 环境，请先安装 Node.js" -ForegroundColor Red
    pause
    exit 1
}

# 2. 检查 Cloudflare 登录状态
Write-Host "[1/3] 检查 Cloudflare 账号登录状态..." -ForegroundColor Cyan
$whoami = npx wrangler whoami 2>&1 | Out-String
if ($whoami -match "You are not authenticated") {
    Write-Host ""
    Write-Host "尚未登录 Cloudflare 账号。" -ForegroundColor Yellow
    Write-Host "即将打开浏览器进行授权，请在弹出的网页中点击【Allow / 允许】..." -ForegroundColor Yellow
    Write-Host ""

    # 释放可能被占用的 8976 端口
    $conn = Get-NetTCPConnection -LocalPort 8976 -ErrorAction SilentlyContinue
    if ($conn) {
        Stop-Process -Id $conn.OwningProcess -Force -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    }

    npx wrangler login
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "登录未完成或已取消。" -ForegroundColor Red
        Write-Host "提示: 您也可以直接在 Cloudflare 官网网页端拖拽上传部署（查看 README.md）。" -ForegroundColor Gray
        pause
        exit 1
    }
}
Write-Host "Cloudflare 账号已就绪！" -ForegroundColor Green

# 3. 检查 / 创建 Pages 项目
Write-Host ""
Write-Host "[2/3] 检查 / 初始化 Pages 项目 [$projectName] ..." -ForegroundColor Cyan
npx wrangler pages project create $projectName --production-branch main 2>$null

# 4. 上传部署
Write-Host ""
Write-Host "[3/3] 正在上传文件并部署到 Cloudflare 全球边缘网络..." -ForegroundColor Cyan
npx wrangler pages deploy . --project-name $projectName --branch main --commit-dirty=true

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "部署失败，请查看上方报错信息。" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  恭喜！部署完成！" -ForegroundColor Green
Write-Host ""
Write-Host "  全球访问地址:" -ForegroundColor White
Write-Host "     https://$projectName.pages.dev" -ForegroundColor Cyan
Write-Host ""
Write-Host "  提示:" -ForegroundColor Gray
Write-Host "  1. 可以在微信或浏览器中直接打开上方链接访问。" -ForegroundColor Gray
Write-Host "  2. 如有自己的域名，可在 Cloudflare 控制台 -> Pages -> 自定义域 中免费绑定。" -ForegroundColor Gray
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
