Import-Module -Name UniversalDashboard
Import-Module C:\Test\mofactory\MoFactory\mofactory.builder\RabbitMQTools\RabbitMQTools.psd1

#Start-UDDashboard -Content { 
#    New-UDDashboard -Title "Server Performance Dashboard" -Color '#FF050F7F' -Content { 
#        New-UDTable -Title "Server Information" -Headers @("Name", "CommandLine", "Status") -Endpoint {
#            Get-Service | Select-Object Name,CommandLine,Status | Out-UDTableData -Property @("Name", "CommandLine", "Status")
#        }
#    }
#} -Port 5000 -Wait

$SecureString = "guest" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = [System.management.automation.PSCredential]::new('guest',$SecureString)
$ExchangeName = "Ex1"
$QueueName = 'Qu1'
$RoutingKey = 'Rk1'

$Params = @{
    BaseUri = "http://localhost:15672"
    Credential = $Credentials
    VirtualHost = '/'
}

Get-UDDashboard | Stop-UDDashboard
 
Start-UDDashboard -Content { 
    New-UDDashboard -Title "mofactory" -Content {
        New-UDMonitor -Title "Queue" -Type Line -Endpoint {
            (Get-RabbitMQQueue @Params | Where-Object {$_.Name -eq $QueueName}).Messages | Out-UDMonitorData
        }
    }
} -Port 5000 -AutoReload #-Wait