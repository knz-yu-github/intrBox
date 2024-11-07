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
    #YYYY切り出し
    #$date = [string]$date.Substring(6,4)
    #2024-11-07 15:30:45
    #環境によって　取得値が違うかもしれないので、先にテストする。

    # コピー元が存在する場合にコピー
    if ((Test-Path $SourcePath) -and ($date.Year -eq 2024)) {
        #Test-Pathでファイル存在確認 AND 2024か確認
        #コピー処理                                     -Forceで読み取り専用もok     エラー無視
        Copy-Item -Path $sourcePath -Destination $destination -ErrorAction SilentlyContinue
    } else {
        #pass
    }
}
