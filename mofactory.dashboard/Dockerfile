FROM microsoft/powershell:centos7
COPY dashboard.ps1 /mofactoryui/
RUN pwsh -Command "Install-Module UniversalDashboard -RequiredVersion 1.5.3 -Force"
EXPOSE 5000
CMD ["pwsh", "/mofactoryui/dashboard.ps1"]