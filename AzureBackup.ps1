
#Variables for common values

$NameResourceGroup = "AAA-Production"
$NameRecoveryServicesVault = "A123RecoveryServicesVault"
$location = "WestUS2"
$NamePolocy = "DefaultPolicy"
$vmName = "AAA-Prod-SVR1"
$FriendlyName = "AAAProdSVR1"

#Create a recovery services vaults

New-AzureRmRecoveryServicesVault `
    -ResourceGroupName $NameResourceGroup `
    -Name $NameResourceGroup `
    -Location $location

#Create a recovery services vaults

Get-AzureRmRecoveryServicesVault `
    -Name $NameRecoveryServicesVault | Set-AzureRmRecoveryServicesVaultContext

# Enable backup for an Azure VM

$policy = Get-AzureRmRecoveryServicesBackupProtectionPolicy -Name $NamePolocy
Enable-AzureRmRecoveryServicesBackupProtection `
    -ResourceGroupName $NameResourceGroup `
    -Name $vmName `
    -Policy $policy

# Start a backup job

$backupcontainer = Get-AzureRmRecoveryServicesBackupContainer `
    -ContainerType "AzureVM" `
    -FriendlyName $FriendlyName

$item = Get-AzureRmRecoveryServicesBackupItem -Container $backupcontainer
    -WorkloadType "AzureVM"
    
Backup-AzureRmRecoveryServicesBackupItem -Item $item

