# コピー元の相対パスが書かれたテキストファイルのパス
$fileList = ".\output.txt"

# コピー先のディレクトリ（例: C:\Backup）
$destination = ".\copy"

# テキストファイルを1行ずつ読み込む
#Get-Content は、PowerShell のコマンドレットで、ファイルやその他のコンテンツ（例えば、テキストファイル、CSVファイル、ログファイルなど）の内容を読み取るために使用されます。
Get-Content $fileList | ForEach-Object {
    $sourcePath = $_  # 各行
    #更新日時取得 
    $date = (Get-ItemProperty $sourcePath).LastWriteTime

    Write-Host $date
}
