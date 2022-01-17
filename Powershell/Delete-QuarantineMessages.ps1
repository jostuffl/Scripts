<#
    This script is provided as a sample / example on how to remove messages from Quarantine.
    This is not meant for production workloads, and it is up to the user to fully test it.
    By using this script you agree that the creator is not responsible for any damages, issues, or other problems caused from using this script.

    This script is meant to run on Windows. It will import the Exchange Online Management module,
    Connect to Exchange Online, and remove all quarantine messages. USE WITH CAUTION!

    Required Permissions to use Get-QuarantineMessage (At least one): Security Admin, Security Reader, Transport Hygiene, View-Only Recipients
    Required Permissions to use Delete-QuarantineMessage (At least one): Security Admin, Transport Hygiene
    More information on Exchange Permissions can be found at: https://docs.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps
#>

Import-Module ExchangeOnlineManagement

write-host "Below the script will ask for your credentials. First Username, then Password." -BackgroundColor Black -ForegroundColor Green

# The account you use to sign-in must have the correct permissions to get the quarantine messsages,
# as well as to delete them.
Connect-ExchangeOnline -InlineCredential


$Quarantine = Get-QuarantineMessage | select -ExpandProperty Identity

write-host "This script will delete all Quarantine Messages.`nThere are currently $($Quarantine.count) emails in quarantine." -BackgroundColor Black -ForegroundColor Yellow
write-host "Are you sure you want to delete all $($Quarantine.count)? (y/n)" -BackgroundColor Black -Foregroundcolor Yellow
$Answer = read-host  

if ($Answer -eq "y"){
    Delete-QuarantineMessage -Identities $Quarantine -Identity 000
}

else{
    write-host "User entered 'n' for No, or any other key other than 'y'. Cancelling" -BackgroundColor Black -ForegroundColor Yellow
}

