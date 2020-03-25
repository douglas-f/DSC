[DscLocalConfigurationManager()]
Configuration LcmConfig {
    Node dev-node-01{
        Settings {
            RefreshMode = "pull"
            RefreshFrequencyMins = "30"
            AllowModuleOverwrite = $true
            RebootNodeIfNeeded = $true
            ConfigurationModeFrequencyMins = "15"
            ConfigurationMode = "ApplyAndAutoCorrect"
            
            
        }
        ConfigurationRepositoryWeb PullServer {
            ServerURL = 'https://prd-push-01:8443/PSDSCPullServer.svc'
            RegistrationKey = '894de15f-d5db-47a9-9a48-546a814713ba'
            ConfigurationNames = @('BaseOs')
        }

        ResourceRepositoryWeb PullServerModules {
            ServerURL = 'https://prd-push-01:8443/PSDSCPullServer.svc'
            AllowUnsecureConnection = $false
            RegistrationKey = '894de15f-d5db-47a9-9a48-546a814713ba'
        }

        ReportServerWeb ReportManager
        {
            ServerUrl = 'https://prd-push-01:8443/PSDSCPullServer.svc'
            RegistrationKey = '894de15f-d5db-47a9-9a48-546a814713ba'
        }
    }

}