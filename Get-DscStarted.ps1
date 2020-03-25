# turn IE enhanced config off

Install-WindowsFeature DSC-Service -IncludeManagementTools # server OS only
Install-Module xpsdesiredstateconfiguration
Install-Module xWebAdministration
install-module xwindowsupdate
Install-Module ComputerManagementDsc
Install-Module DSCR_MSLicense

#create and assign cert (self signed needs to go in localhost personal)
run pullserver.ps1


# creating a mof
# . .\baseos.ps1
# .\baseos.ps1
# baseos 

# create zip and upload to C:\Program Files\WindowsPowerShell\DscService\Modules on pull server
# execute 
New-DscChecksum -Path .\ComputerManagementDsc_6.5.0.0.zip
New-DscChecksum -Path .\DSCR_MSLicense_0.9.1.zip
New-DscChecksum -Path .\xPSDesiredStateConfiguration_8.9.0.0.zip
New-DscChecksum -Path .\xWindowsUpdate_2.8.0.0.zip
