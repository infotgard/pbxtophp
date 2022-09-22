if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type)
{
$certCallback = @"
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback += 
                    delegate
                    (
                        Object obj, 
                        X509Certificate certificate, 
                        X509Chain chain, 
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
"@
    Add-Type $certCallback
 }
[ServerCertificateValidationCallback]::Ignore()

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

#By default the LDAP Phonebook of Grandstream PBX is phonebook.xml and accessible through port 8090, unless modified purposely.

$webreq = Invoke-WebRequest https://10.54.1.100:8089/phonebook.xml
$webreq.Content |Out-File C:\output.xml
$xmlData = [xml](Get-Content C:\output.xml)

#####FTP

#we specify the directory where all files that we want to upload are contained 
$Dir="C:\"

#If you want to export the XML to a webservice directory so your PHP file can parse it:

Copy-Item -Path C:\output.xml -Destination \\webserveraddress\PBX\output.xml;
