echo off
setlocal

:: 7z.exe のパス（7-Zipインストールパスに応じて変更）
set ZIP_EXE="C:\Program Files\7-Zip\7z.exe"

:: 解凍先フォルダ
set DEST_DIR="C:\Users\EIDAI-20240217-2\Downloads"

:: ZIPファイル名（拡張子除く）
for %%I in (%1) do set ZIPNAME=%%~nI

:: 仮のリストファイルでルート構造を調べる
%ZIP_EXE% l %1 > temp_list.txt

:: ルートフォルダがあるか調べる（"/"で終わる行が1つだけ）
findstr /R "^[^\\]*\\$" temp_list.txt | find /C /V "" > temp_count.txt
set /p COUNT=<temp_count.txt

if %COUNT% GEQ 1 (
    echo [INFO] ルートフォルダあり → そのまま解凍
    %ZIP_EXE% x %1 -o"%DEST_DIR%" -y
) else (
    echo [INFO] ルートフォルダなし → ZIP名のフォルダに解凍
    %ZIP_EXE% x %1 -o"%DEST_DIR%\%ZIPNAME%" -y
)

del temp_list.txt
del temp_count.txt

echo 解凍完了。
pause
