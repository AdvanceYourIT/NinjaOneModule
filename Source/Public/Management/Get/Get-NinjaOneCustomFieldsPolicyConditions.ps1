
function Get-NinjaOneCustomFieldsPolicyConditions {
	<#
        .SYNOPSIS
            Gets custom field conditions for a given policy from the NinjaOne API.
        .DESCRIPTION
            Retrieves the custom field conditions for a given policy id from the NinjaOne v2 API.
        .FUNCTIONALITY
			Custom Field Policy Conditions
        .EXAMPLE
            PS> Get-NinjaOneCustomFieldsPolicyConditions -policyId 1

            Gets the custom field policy conditions for the policy with id 1.
        .OUTPUTS
            A powershell object containing the response.
        .LINK
            https://docs.homotechsual.dev/modules/ninjaone/commandlets/Get/customfieldspolicyconditions
    #>
	[CmdletBinding()]
	[OutputType([Object])]
	[Alias('gnopccf')]
	[MetadataAttribute(
		'/v2/policies/{policy_id}/condition/custom-fields',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The policy id to get the custom field conditions for.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('id')]
		[Int]$policyId
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		$Parameters = (Get-Command -Name $CommandName).Parameters
		# Workaround to prevent the query string processor from adding a 'policyid=' parameter by removing it from the set parameters.
		$Parameters.Remove('policyId') | Out-Null
		$QSCollection = New-NinjaOneQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			Write-Verbose ('Getting custom field conditions for policy {0}.' -f $policyId)
			$Resource = ('v2/policies/{0}/condition/custom-fields' -f $policyId)
			$RequestParams = @{
				Resource = $Resource
				QSCollection = $QSCollection
			}
			$PolicyConditionsCustomFieldsResults = New-NinjaOneGETRequest @RequestParams
			if ($PolicyConditionsCustomFieldsResults) {
				return $PolicyConditionsCustomFieldsResults
			} else {
				throw ('No custom fields conditions found for policy {0}.' -f $policyId)
			}
		} catch {
			New-NinjaOneError -ErrorRecord $_
		}
	}
}