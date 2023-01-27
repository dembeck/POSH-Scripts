# Microsoft, AMD, Nvidia, are all sleeping on Windows 11 MPO display issues

###### [Sayan Sen](https://www.neowin.net/profile/649440-sayan-sen/) · Jan 16, 2023 20:34 EST | Source: [Neowin](https://www.neowin.net/news/microsoft-amd-nvidia-are-all-sleeping-on-windows-11-mpo-display-issues/)

While there are plenty of bugs and issues on both Windows 10 and 11, one of the most recurring problems that plague user PCs is related to MPO or Multiplane Overlay. The feature was introduced by Microsoft in Windows 8.1 via Windows Display Driver Module (WDDM) 1.3. When executing multiple frame buffers, MPO was meant to reduce CPU and GPU overhead with the help of a fixed-function hardware unit in the display controller as opposed to using up shader cycles.

However, the feature has often been plagued with issues. And although Microsoft has in the past dealt with problems and bugs related to MPO and other Desktop Window Manager (DWM) features, in recent times with Windows 11, the issue seems to have mostly been ignored by hardware vendors like AMD and Nvidia, as well as software giant Microsoft.

Plenty of forum posts and threads online are from users who fixed seemingly their display issues by disabling MPO. In fact, Nvidia had once issued a hotfix that recommended disabling the option via a registry tweak. The classic symptoms generally include stuttering, black screen or white screen issues, flickering, among others, in Windows, as well as in browsers like Chrome or Edge. It is possible that some enterprise software display issues, like the one where the Citrix workspace mouse cursor goes white, could also be fixed. Some users say driver timeout issues were fixed too.

While not every display-related bug is due to MPO, disabling the option could come in handy if you have been unable to resolve the issue by other means. To disable MPO, head over to the Display Window Manager (DWM) registry address below and add the "`OverlayTestMode`" DWORD value `00000005`.

```powershell
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm
"OverlayTestMode"=dword:00000005
```

Steps:

1. Run "`Regedit`" or "`regedit.msc`" or Registry Editor app as admin
2. Go to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm`
3. Right-click > New > DWORD 32-bit value
4. Name the new DWORD value "`OverlayTestMode`"
5. Modify `OverlayTestMode` DWORD value by right-clicking
6. Enter value data "`00000005`", and close Regedit
7. A system restart may be necessary for the change to take effect

To restore MPO in case you encounter any issues after this, simply delete the OverlayTestMode DWORD you created. However, if internet voices are to be believed, then disabling the feature certainly seems to magically cure a lot of the problems out there.

```powershell
# Display the current value and status of Multiplane Overlay (MPO)
@{
	Exists = ($null -ne ($MPO = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Dwm').OverlayTestMode) )
	Status = '5' -eq $MPO
	Value = if ($null -eq $MPO) {'NotSet'} else {$MPO}
}
```

```powershell
# Disable Multiplane Overlay (MPO)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Dwm' -Name 'OverlayTestMode' -Type 'DWord' -Value '5' -Force
```

```powershell
# Restore Multiplane Overlay (MPO) to the default setting.
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Dwm'  -Name 'OverlayTestMode' -Force
```
