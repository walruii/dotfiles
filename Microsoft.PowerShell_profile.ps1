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

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor
Set-PSReadLineKeyHandler -Key "Shift+Tab" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function NextHistory
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function PreviousHistory
