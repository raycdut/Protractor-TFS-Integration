param(
	[string]$protractorConfig
)

$webdriverManager = $env:APPDATA + "\npm\webdriver-manager.cmd"
$protractor = $env:APPDATA + "\npm\protractor.cmd"

if (Test-Path $protractor) {
    Write-Host "Protractor is already installed. No work do do!"
}
else
{
	Write-Host "Missing dependencies - installing protractor and webdriver manager"
    npm install protractor -g
    npm install webdriver-manager -g
	Invoke-Expression ("$webdriverManager update")
}

$configFolder = split-path $protractorConfig
Invoke-Expression ("cd ""$configFolder""")
npm install protractor-trx-reporter --save-dev    

# this is only temporary as soon the protractor-trx-reporter is updated this can be removed
npm install grunt --save-dev    