FROM microsoft/powershell:centos7
COPY RabbitMQTools /usr/local/share/powershell/Modules/RabbitMQTools/1.3/
COPY mofactory.worker/app.ps1 /mofactory.worker/app.ps1
WORKDIR /mofactory.worker
EXPOSE 5001
CMD ["pwsh", "app.ps1"]