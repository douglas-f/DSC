# Sample PoC configuration
Configuration BaseOS{

	Import-DscResource -ModuleName PSDesiredStateConfiguration
	Import-DscResource -ModuleName ComputerManagementDsc 
	Import-DscResource -ModuleName xWindowsUpdate
	#Import-DscResource -ModuleName DSCR_MSLicense

	Node BaseOS {

		Timezone Central {
			IsSingleInstance = 'yes'
			TimeZone = 'Central Standard Time'
		}

		xHotfix HotfixInstall {
			Ensure = "Present"
			Path = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2019/08/windows10.0-kb4512534-x64_65e8f81eb12cbd70bf426d62f98e77b4cd2f4c28.msu"
			ID = "kb4512534"
		}
<#
		cWindowsLicense Server2019 {
			ProductKey = ""
			Activate = $true 
		}
#>
		Package AzureCliExample {
			Ensure = "Present"
			Name = "AzureCLI"
			Path = "C:\windows\Temp\azure-cli-2.0.7.1.msi"
			ProductId = "ACBAF9A5-7590-4D88-9836-5664507B725A"
		}

	}
}

#BaseOS -ComputerName $Node