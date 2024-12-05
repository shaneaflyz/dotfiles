Set-Alias -Name cd -Value __zoxide_z -Force -Option AllScope
Remove-Item Alias:ls -Force

function ls {
    eza @Args --icons=always
}
#    eza.exe --icons=always --long --no-filesize --no-time --no-time --no-user --no-permissions --color=always $Path
#}
Invoke-Expression (& { (zoxide init powershell | Out-String) })
