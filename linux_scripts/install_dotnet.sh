curl -fsSL https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -o packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get install -y apt-transport-https &&  apt-get update && apt-get install -y dotnet-sdk-6.0
apt-get install -y apt-transport-https &&  apt-get update && apt-get install -y aspnetcore-runtime-6.0