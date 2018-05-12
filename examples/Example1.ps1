
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

Add-RabbitMQExchange @Params -name $ExchangeName -Type fanout -Durable
Add-RabbitMQQueue @Params -Name $QueueName -Durable
Add-RabbitMQQueueBinding @Params -ExchangeName $ExchangeName -Name $QueueName -RoutingKey $RoutingKey

1..30 | %{
    Add-RabbitMQMessage @params -ExchangeName $ExchangeName -RoutingKey $RoutingKey -Payload "Hello"
}