Invoke-Expression (& { (zoxide init powershell | Out-String) })
if (Get-Alias cd -ErrorAction SilentlyContinue) {
    Remove-Item Alias:cd
}
function _cd { Set-Location @args }
function cd {
    if ($args.Count -eq 0) {
        z
    } else {
        z @args
    }
}
