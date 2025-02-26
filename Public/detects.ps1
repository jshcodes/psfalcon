function Edit-FalconDetection {
    [CmdletBinding(DefaultParameterSetName =  '/detects/entities/detects/v2:patch')]
    param(
        [Parameter(ParameterSetName = '/detects/entities/detects/v2:patch', Mandatory = $true, Position = 1)]
        [ValidatePattern('^ldt:\w{32}:\d+$')]
        [array] $Ids,

        [Parameter(ParameterSetName = '/detects/entities/detects/v2:patch', Position = 2)]
        [ValidateSet('new', 'in_progress', 'true_positive', 'false_positive', 'ignored', 'closed', 'reopened')]
        [string] $Status,

        [Parameter(ParameterSetName = '/detects/entities/detects/v2:patch', Position = 3)]
        [ValidatePattern('^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$')]
        [string] $AssignedToUuid,

        [Parameter(ParameterSetName = '/detects/entities/detects/v2:patch', Position = 4)]
        [string] $Comment,

        [Parameter(ParameterSetName = '/detects/entities/detects/v2:patch', Position = 5)]
        [boolean] $ShowInUi
    )
    begin {
        $Fields = @{
            AssignedToUuid = 'assigned_to_uuid'
            ShowInUi       = 'show_in_ui'
        }
        $Param = @{
            Command  = $MyInvocation.MyCommand.Name
            Endpoint = $PSCmdlet.ParameterSetName
            Inputs   = Update-FieldName -Fields $Fields -Inputs $PSBoundParameters
            Format   = @{
                Body = @{
                    root = @('show_in_ui', 'comment', 'assigned_to_uuid', 'status', 'ids')
                }
            }
        }
    }
    process {
        Invoke-Falcon @Param
    }
}
function Get-FalconDetection {
    [CmdletBinding(DefaultParameterSetName = '/detects/queries/detects/v1:get')]
    param(
        [Parameter(ParameterSetName = '/detects/entities/summaries/GET/v1:post', Mandatory = $true, Position = 1)]
        [ValidatePattern('^ldt:\w{32}:\d+$')]
        [array] $Ids,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get', Position = 1)]
        [string] $Filter,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get', Position = 2)]
        [string] $Query,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get', Position = 3)]
        [string] $Sort,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get', Position = 4)]
        [ValidateRange(1,5000)]
        [int] $Limit,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get', Position = 5)]
        [int] $Offset,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get')]
        [switch] $Detailed,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get')]
        [switch] $All,

        [Parameter(ParameterSetName = '/detects/queries/detects/v1:get')]
        [switch] $Total
    )
    begin {
        $Fields = @{
            Query = 'q'
        }
        $Param = @{
            Command  = $MyInvocation.MyCommand.Name
            Endpoint = $PSCmdlet.ParameterSetName
            Inputs   = Update-FieldName -Fields $Fields -Inputs $PSBoundParameters
            Format   = @{
                Query = @('filter', 'q', 'sort', 'limit', 'offset')
                Body  = @{
                    root = @('ids')
                }
            }
            Max      = 1000
        }
    }
    process {
        Invoke-Falcon @Param
    }
}