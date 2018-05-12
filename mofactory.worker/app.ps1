#Import-Module C:\test\mofactory\src\mofactory.builder\RabbitMQTools\RabbitMQTools.psd1
Import-Module RabbitMQTools
$SecureString = "guest" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = [System.management.automation.PSCredential]::new('guest',$SecureString)
$ExchangeName = "Ex1"
$QueueName = 'Qu1'
$RoutingKey = 'Rk1'

$RabbitMQUp = $false
while(-not $RabbitMQUp) {
    try {
        irm http://172.16.0.1:15672 -ea stop
        $RabbitMQUp = $true
    }
    catch {
        Write-warning "RabbitMQ not available..."
        Start-Sleep -Seconds 3
    }
}

$Params = @{
    BaseUri = "http://172.16.0.1:15672"
    Credential = $Credentials
    VirtualHost = '/'
}

Add-RabbitMQExchange @Params -name $ExchangeName -Type fanout -Durable
Add-RabbitMQQueue @Params -Name $QueueName -Durable
Add-RabbitMQQueueBinding @Params -ExchangeName $ExchangeName -Name $QueueName -RoutingKey $RoutingKey

While ($true) {
    Get-RabbitMQMessage @Params -Name $QueueName -Remove
    #Get-RabbitMQMessage -BaseUri "http://localhost:15672" -Credentials $Credentials -VirtualHost / -Name 'blah' -count 1 -Remove
    Write-Host "sleep 5"
    Start-Sleep -Seconds 5
    #$IncomingData = $Incoming.payload | ConvertFrom-Json

    #Get-RabbitMQMessage @params -VirtualHost / -Name $QueueName -count 1
 

    #$IncomingData
 
    #There are better ways to handle this, illustrative purposes only : )
}