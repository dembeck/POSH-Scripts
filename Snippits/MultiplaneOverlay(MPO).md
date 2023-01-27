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


# NVIDIA SUPPORT

###### Updated  09/29/2021 01:16 PM | Source: [NVIDIA Knowledgebase](https://nvidia.custhelp.com/app/answers/detail/a_id/5157/~/after-updating-to-nvidia-game-ready-driver-461.09-or-newer,-some-desktop-apps)

### After updating to NVIDIA Game Ready Driver 461.09 or newer, some desktop apps may flicker or stutter when resizing the window on some PC configurations


NVIDIA is currently investigating end user reports that after updating to NVIDIA Game Ready Driver 461.09 or newer, Google Chrome may display flicker on some PC configurations.

#### Workaround:

Users who are experiencing this issue may download the registry file "[mpo_disable.reg](https://nvidia.custhelp.com/ci/fattach/get/824301808/0/filename/mpo_disable.reg)" from the  Attachments  section below and proceed to double-click on the file to add it to your system registry. This registry file will disable multiplane overlay. After adding the registry file, reboot your PC to complete the changes. If the flicker persists, you may restore multiplane overlay by downloading the file "[mpo_restore.reg](https://nvidia.custhelp.com/ci/fattach/get/824301809/0/filename/mpo_restore.reg)" and then proceed to double-click on the file to add it to your registry.

#### Attachments

-   [mpo_disable.reg](https://nvidia.custhelp.com/ci/fattach/get/824301808/0/session/L2F2LzEvdGltZS8xNjc0ODU3MDIwL2dlbi8xNjc0ODU3MDIwL3NpZC9mVThGd3Z6S0g5U2ZhRGRwU3A1UWFKc1g0ejBxUXV4bXhiSWpwZlhQYSU3RXlFZTczcldMQ2NwYnlQMHNFY1hUQSU3RTMwVlVGc0g5bjdneGVMWFFCWGtMYXUwU0ZYNjI0TU1CdEJtWHZJRTUxclFiblY5cG5IWXV5VGJBJTIxJTIx/filename/mpo_disable.reg) (252 bytes)
-   [mpo_restore.reg](https://nvidia.custhelp.com/ci/fattach/get/824301809/0/session/L2F2LzEvdGltZS8xNjc0ODU3MDIwL2dlbi8xNjc0ODU3MDIwL3NpZC9mVThGd3Z6S0g5U2ZhRGRwU3A1UWFKc1g0ejBxUXV4bXhiSWpwZlhQYSU3RXlFZTczcldMQ2NwYnlQMHNFY1hUQSU3RTMwVlVGc0g5bjdneGVMWFFCWGtMYXUwU0ZYNjI0TU1CdEJtWHZJRTUxclFiblY5cG5IWXV5VGJBJTIxJTIx/filename/mpo_restore.reg) (226 bytes)


#### File Contents

- ##### mpo_disable.reg
```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm]
"OverlayTestMode"=dword:00000005
```

- ##### mpo_restore.reg
```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm]
"OverlayTestMode"=-
```
