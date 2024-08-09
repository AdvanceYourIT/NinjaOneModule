
function Get-NinjaOnePolicyConditionsWindowsEvent {
	<#
        .SYNOPSIS
            Gets windows event conditions for a given policy from the NinjaOne API.
        .DESCRIPTION
            Retrieves the windows event conditions for a given policy id from the NinjaOne v2 API.
        .FUNCTIONALITY
			Windows Event Policy Conditions
        .EXAMPLE
            PS> Get-NinjaOnePolicyConditionsWindowsEvent -policyId 1

            Gets the windows event policy conditions for the policy with id 1.
        .OUTPUTS
            A powershell object containing the response.
        .LINK
            https://docs.homotechsual.dev/modules/ninjaone/commandlets/Get/windowseventpolicyconditions
    #>
	[CmdletBinding()]
	[OutputType([Object])]
	[Alias('gnopccf')]
	[MetadataAttribute(
		'/v2/policies/{policy_id}/condition/windows-event',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The policy id to get the windows event conditions for.
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
			Write-Verbose ('Getting windows event conditions for policy {0}.' -f $policyId)
			$Resource = ('v2/policies/{0}/condition/windows-event' -f $policyId)
			$RequestParams = @{
				Resource = $Resource
				QSCollection = $QSCollection
			}
			$PolicyConditionsWindowsEventResults = New-NinjaOneGETRequest @RequestParams
			if ($PolicyConditionsWindowsEventResults) {
				return $PolicyConditionsWindowsEventResults
			} else {
				throw ('No windows event conditions found for policy {0}.' -f $policyId)
			}
		} catch {
			New-NinjaOneError -ErrorRecord $_
		}
	}
}