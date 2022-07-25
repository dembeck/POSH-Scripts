function Get-GeoLocation
{
    <#
    .SYNOPSIS
        Gets location data from the Windows location service.

    .DESCRIPTION
        Gets location data from the Windows location service.

    .PARAMETER Property
        Select which properties should be returned. Default is all.
        Accepted values are:
            Latitude, Longitude, Altitude, HorizontalAccuracy, VerticalAccuracy,
            Speed, Course, IsUnknown

    .EXAMPLE
        PS C:\> Get-GeoLocation

            Latitude           : 40.6026875597371
            Longitude          : -120.957221641254
            Altitude           : 0
            HorizontalAccuracy : 65
            VerticalAccuracy   : NaN
            Speed              : NaN
            Course             : NaN
            IsUnknown          : False

    .EXAMPLE
        PS C:\> Get-GeoLocation -Property Latitude, Longitude

            Latitude         Longitude
            --------         ---------
            40.6026875597371 -120.957221641254
    #>

    [OutputType([object])]
    [CmdletBinding()]

    param (
        [Parameter()]
        [ValidateSet(
            'Altitude',
            'Course',
            'HorizontalAccuracy',
            'IsUnknown',
            'Latitude',
            'Longitude',
            'Speed',
            'VerticalAccuracy',
            IgnoreCase = $true)]
        [string[]]$Property
    )

    begin
    {
        #Required to access System.Device.Location namespace
        Add-Type -AssemblyName System.Device

        #Create the required object
        $GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher

        # Sleep Time
        $sleepTime = '2'
    }

    process
    {
        # Start resolving current location
        $GeoWatcher.Start()

        while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied'))
        {
            $count = 0
            do
            {
                # Wait for discovery.
                Start-Sleep -Seconds $sleepTime

                # Keep count of how many loop we do
                $count ++
                Write-Verbose "Attempt Number:`t$count"
                Write-Verbose "Waiting Time:  `t$($count * $sleepTime)"

            } until ( ($GeoWatcher.Position.Location.Latitude -gt 0) -or ($count -ge 30) )
        }


        if ($GeoWatcher.Permission -eq 'Denied')
        {
            Write-Error -Message 'Access to Location Information is Denied.'
        }
        else
        {

            if ($Property)
            {
                $returnObject = $GeoWatcher.Position.Location | Select-Object -Property $Property
            }
            else
            {
                $returnObject = $GeoWatcher.Position.Location
            }
        }
    }

    end
    {
        return $returnObject
    }
}
