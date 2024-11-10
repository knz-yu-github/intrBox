# コピー元の絶対パス一覧ファイル(精査後のログファイル)
$fileList = ".\output.txt"
# コピー先のディレクトリ（例: C:\copy）
$destination = ".\copy"
# エラーメッセージなど保存用
$logFile = ".\log.txt"

# ツール実行日時など
$logMessage = "ツール実行日時: $(Get-Date)"
$logMessage | Out-File $logFile -Append -Encoding utf8

# テキストファイルを1行ずつ読み込む
Get-Content $fileList | ForEach-Object {
    $sourcePath = $_  # 各行
    try {
        # 更新日時取得
        $date = (Get-ItemProperty $sourcePath).LastWriteTime
        $testpath = (Test-Path $sourcePath)
        # コピー元が存在する場合にコピー
        if ($testpath -and ($date.Year -eq 2024)) {
            # Test-Pathでファイル存在確認 AND 2024年か確認
            # コピー処理 (読み取り専用ファイルにも対応、エラー無視)
            Copy-Item -Path $sourcePath -Destination $destination -ErrorAction Stop
            # ログメッセージ作成
            $logMessage = "Success; $sourcePath; $(Get-Date); Detail:[TestPath=$testpath][date=$date]"
        } else {
            # ファイルが存在しない、または更新日時が2024年でない場合
            $logMessage = "Skipped; $sourcePath; $(Get-Date); Detail:[TestPath=$testpath][date=$date]"
        }
    }
    catch {
        # エラー時のログメッセージ作成
        $logMessage = "Failure; $sourcePath; $(Get-Date); ErrMsg: " + ($_.Exception.Message)
    }
    # ログに記録 (Appendオプションを付けてファイルに追記)
    $logMessage | Out-File $logFile -Append -Encoding utf8
}
