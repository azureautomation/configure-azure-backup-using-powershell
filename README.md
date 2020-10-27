Configure Azure Backup - using PowerShell
=========================================

            

This script will help you to configure your Azure hosted VM backups through PowerShell. 


If you are configuring this for the first time then you need to register your Recovery Service provider with your subscription. For that you can run the below command.

 Then you can check whether the Providers registered successfully. For that run the below command.


 Rather than creating the services one by one, you can run the attached ps1 file to create the Backup job. The details are mentioned below.




1. **NameResourceGroup - **Give the resource group name. you can give an existing resource group name or else create a ResourceGroup first.


2. **Location **- Give the correct Location name where you going to host your services. E.g. Australia East, UK South


**3. VmName -** Server Names .This is case Sensitive and make sure to give the VM name which you want to enable the protection.** **


4. **NameRecoveryServicesVault** – Give name for the Recovery service Vault


5. **NamePolocy **- Give a name for the Backup Policy


**6. FriendlyName** - Friendly name for the backup Container** **


** **


Rest of the variables you can keep as it is and if there is any requirement to change the backup schedule you can edit that by go into the Backup policy.


You can copy paste the below scrip into the PowerShell and run to create the backup job.


** **


 


**PowerShell Script**


----------------------------------------------------------------------------------------------------------------------


#Variables for common values


$NameResourceGroup = 'AAA-Production'


$NameRecoveryServicesVault = 'A123RecoveryServicesVault'


$location = 'WestUS2'


$NamePolocy = 'DefaultPolicy'


$vmName = 'AAA-Prod-SVR1'


$FriendlyName = 'AAAProdSVR1'


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


-ContainerType 'AzureVM' `


-FriendlyName $FriendlyName


$item = Get-AzureRmRecoveryServicesBackupItem -Container $backupcontainer


-WorkloadType 'AzureVM'


Backup-AzureRmRecoveryServicesBackupItem -Item $item


** **


**---------------------------------------------------------------------------------------------------------**


Once this is completed, you can run the below mentioned Command to check the status of the backup job.


 


        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
