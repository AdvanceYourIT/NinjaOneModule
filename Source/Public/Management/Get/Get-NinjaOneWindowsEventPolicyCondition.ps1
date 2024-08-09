
function Get-NinjaOneWindowsEventPolicyCondition {
	<#
        .SYNOPSIS
            Gets detailed information on a single windows event condition for a given policy from the NinjaOne API.
        .DESCRIPTION
            Retrieves the detailed information for a given windows event condition for a given policy id from the NinjaOne v2 API.
        .FUNCTIONALITY
			Windows Event Policy Condition
        .EXAMPLE
            PS> Get-NinjaOneWindowsEventPolicyCondition -policyId 1 -conditionId 1

            Gets the windows event policy condition with id 1 for the policy with id 1.
        .OUTPUTS
            A powershell object containing the response.
        .LINK
            https://docs.homotechsual.dev/modules/ninjaone/commandlets/Get/windowseventpolicycondition
    #>
	[CmdletBinding()]
	[OutputType([Object])]
	[Alias('gnopccf')]
	[MetadataAttribute(
		'/v2/policies/{policy_id}/condition/windows-event/{condition_id}',
		'get'
	)]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Uses dynamic parameter parsing.')]
	Param(
		# The policy id to get the windows event conditions for.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Alias('id')]
		[Int]$policyId,
		# The condition id to get the windows event condition for.
		[Parameter(Mandatory, Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[Int]$conditionId
	)
	begin {
		$CommandName = $MyInvocation.InvocationName
		$Parameters = (Get-Command -Name $CommandName).Parameters
		# Workaround to prevent the query string processor from adding a 'policyid=' parameter by removing it from the set parameters.
		$Parameters.Remove('policyId') | Out-Null
		# Workaround to prevent the query string processor from adding a 'conditionid=' parameter by removing it from the set parameters.
		$Parameters.Remove('conditionId') | Out-Null
		$QSCollection = New-NinjaOneQuery -CommandName $CommandName -Parameters $Parameters
	}
	process {
		try {
			Write-Verbose ('Getting windows event condition {0} for policy {1}.' -f $conditionId, $policyId)
			$Resource = ('v2/policies/{0}/condition/windows-event/{1}' -f $policyId, $conditionId)
			$RequestParams = @{
				Resource = $Resource
				QSCollection = $QSCollection
			}
			$PolicyConditionWindowsEventResults = New-NinjaOneGETRequest @RequestParams
			return $PolicyConditionWindowsEventResults
		} catch {
			New-NinjaOneError -ErrorRecord $_
		}
	}
}