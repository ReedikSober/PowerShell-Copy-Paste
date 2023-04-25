$path = "Insert path to the local folder containing your files to be copied"
$destination = "Insert the destination on the cloud where the files should be pasted"
$filesCopied = 0
foreach ($i in Get-ChildItem -Path $path -Recurse -Exclude "__MACOSX") {
    if (-not $i.PSIsContainer) {
        $destinationFile = Join-Path -Path $destination -ChildPath $i.FullName.Substring($path.Length + 1)
        $destinationFolder = Split-Path -Path $destinationFile -Parent
        if (-not(Test-Path -Path $destinationFolder -PathType Container)) {
            try {
                New-Item -Path $destinationFolder -ItemType "Directory" -Force | Out-Null
            }
            catch {
                throw $_.Exception.Message
            }
        }
        if (-not(Test-Path -Path $destinationFile -PathType Leaf) -or $i.LastWriteTime -gt (Get-Item -Path $destinationFile).LastWriteTime) {
            try {
                Copy-Item -Path $i.FullName -Destination $destinationFile -Recurse
                $filesCopied++
            }
            catch {
                throw $_.Exception.Message
            }
        }
    }
}
if ($filesCopied -gt 0) {
    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null
    [System.Windows.Forms.MessageBox]::Show("$filesCopied files were copied.", "Copy Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}
