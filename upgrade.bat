@echo off
setlocal enabledelayedexpansion
:: 保存根目录
set "BASE_DIR=%cd%"

:: 1. 根目录执行 go mod tidy
echo ======================================
echo Processing root directory...
go mod tidy

:: 2. 遍历所有一级子目录，自动检测go.mod并执行
echo.
echo Processing subdirectories...
for /d %%D in (*) do (
    if exist "%%D\go.mod" (
        echo --------------------------------------
        echo Found go.mod in: %%D
        cd /d "%%D"
        go mod tidy
        cd /d "%BASE_DIR%"
    )
)

echo.
echo ======================================
echo All modules tidy completed!
pause