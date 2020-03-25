configuration Sample_xDscWebService 
{ 
    param  
    ( 
            [string[]]$NodeName = 'localhost', 
            #[ValidateNotNullOrEmpty()] 
            #[string] $certificateThumbPrint,
            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string] $RegistrationKey 
     ) 


     Import-DSCResource -ModuleName xPSDesiredStateConfiguration 
     Import-DSCResource -ModuleName PSDesiredStateConfiguration 


     Node $NodeName 
     { 
         WindowsFeature DSCServiceFeature 
         { 
             Ensure = "Present" 
             Name   = "DSC-Service"             
         } 

         xDscWebService PSDSCPullServer 
         { 
             Ensure                  = "Present" 
             EndpointName            = "PSDSCPullServer" 
             Port                    = '8443' 
             PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer"  
             CertificateThumbPrint   = "35b04a6c732b57ca4b344781b270b83f95987930"
             ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" 
             ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"             
             State                   = "Started" 
             DependsOn               = "[WindowsFeature]DSCServiceFeature"       
             UseSecurityBestPractices = $true     
             RegistrationKeyPath     = "$env:PROGRAMFILES\WindowsPowerShell\DscService"             
             AcceptSelfSignedCertificates = $true
         } 

        File RegistrationKeyFile
        {
            Ensure          ='Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents        = '885DB204-C37E-11E9-A80E-000D3A73F9E1'
        }
    }
}

$RegKey = (New-Guid).Guid
Sample_xDscWebService -RegistrationKey $RegKey

Start-DscConfiguration -Path .\Sample_xDscWebService -Wait -Verbose -Force

Start-Process 'https://localhost:8443/PSDSCPullServer.svc'