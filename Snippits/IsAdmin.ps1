# Check against group SID ('S-1-5-32-544' = Local Administrators)
[bool]([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -Match  'S-1-5-32-544')

# Check against group name
([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# Use a #Requires statement 
#Requires -RunAsAdministrator
