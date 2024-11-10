$targetdir = "C:\"
#                          再帰  エラー無視(ファイル権限、破損などすべて)               (Where-Object)拡張子絞り込み         (Select-Object)絶対パスを選択                  txtファイルへ出力
Get-ChildItem $targetdir  -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in ".png", ".jpeg" } | Select-Object -ExpandProperty FullName | Out-File ".\master.txt"
#$_ は、PowerShell の パイプライン（Pipeline） で使用される特殊な変数です。$_ は、パイプライン内の現在のオブジェクトを指します。