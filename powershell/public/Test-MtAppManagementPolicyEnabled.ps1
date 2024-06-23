﻿<#
 .Synopsis
  Checks if the default app management policy is enabled.

 .Description
  GET /policies/defaultAppManagementPolicy

 .Example
  Test-MtAppManagementPolicyEnabled
#>

Function Test-MtAppManagementPolicyEnabled {
  [CmdletBinding()]
  [OutputType([bool])]
  param()

  if (!(Get-MtLicenseInformation EntraWorkloadID)) {
    Add-MtTestResultDetail -SkippedBecause NotLicensedEntraWorkloadID
    return $null
  }

  $defaultAppManagementPolicy = Invoke-MtGraphRequest -RelativeUri "policies/defaultAppManagementPolicy"
  $result = $defaultAppManagementPolicy.isEnabled -eq 'True'

  if ($result) {
    $resultMarkdown = "Well done. Your tenant has an app management policy enabled."
  } else {
    $resultMarkdown = "Your tenant does not have an app management policy defined."
  }

  Add-MtTestResultDetail -Result $resultMarkdown

  return $result
}