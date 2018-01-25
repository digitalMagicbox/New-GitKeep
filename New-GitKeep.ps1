# 空のフォルダに.gitkeepファイルを作成する 

Param(
  [string]$path="." # .gitkeepファイルを作成するパス
)

if( [String]::IsNullOrEmpty($path) ){
  # 空のときはカレントにする
  $path = "."
}

if(Test-Path $path){
  # 指定のパス配下の一覧を取得する。
  $collection=Get-ChildItem $path -Recurse 
  foreach ($item in $collection) {
    # $itemがディレクトリでファイル数とディレクトリ数が0個の場合に　.gitkeepファイルを作成する。
    if ($item.PSIsContainer -and !$item.GetFiles().Count -and !$item.GetDirectories().Count){
      $gitkeep=Join-Path $item.FullName .gitkeep
      New-Item $gitkeep -Force -type file
    }
  }
  exit 0
}
else {
  Write-Host $path is not found! 
  exit 1
}