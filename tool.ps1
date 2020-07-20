# get datafile of bib_ids
$list = Get-Content "*.csv"

# set parameters
#$marcbase = 'http://alto-mis:8083/TalisSOA/api/resources/bib-record/'
$isbnbase = 'http://alto-mis:8083/TalisSOA/api/resources/bib-records?filter-isbns='
$outputFile = 'e-'
$suff = '.mrc'

# authenticate operator
$cred = Get-Credential

foreach($isbn in $list)
    {
    $URI = $isbnbase + $isbn
    Write-Output $URI
                #grab the work id for the isbn (line-by-line)
                Invoke-WebRequest -Uri $uri -Credential $cred | Select-Object -ExpandProperty content | Out-File output.xml
                [xml]$xml = Get-Content output.xml
                $workid = $xml.{bib-records}.{bib-record}.id
                $marc = $xml.{bib-records}.{bib-record}.uri

                #pull the marc record for the work id found above
                $output = $outputFile + $workid + $suff
    (Invoke-WebRequest -Uri $marc -Credential $cred -Headers @{"accept"="application/marc"; "accept-Encoding"="UTF-8"} -OutFile $output)
                
                #write work_id to logfile
                Add-Content -Path marclist.txt -Value "ISBN:$isbn BIB:$workid"
                
                Start-Sleep -s 2
    }