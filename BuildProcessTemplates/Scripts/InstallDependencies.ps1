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
	# The following code is a workaround for >Invoke-Expression "$webdriverManager update"<
    # At the moment the update get the files but everything is corrupt. Therefore we download it manually.
    # As soon the update is fixed this can be replaced.
    $urlChromeDriver = "https://chromedriver.storage.googleapis.com/2.10/chromedriver_win32.zip"
    $urlSelenium = "http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar"
    
    $seleniumFolder = $env:APPDATA + "\npm\node_modules\webdriver-manager\selenium"

    $destinationChromeDriver = $seleniumFolder + "\chromedriver_2.10.zip"
    $destintaionSelenium = $seleniumFolder +"\selenium-server-standalone-2.42.2.jar"
    
    New-Item -ItemType directory -Path $seleniumFolder

    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($urlChromeDriver, $destinationChromeDriver)
    $webClient.DownloadFile($urlSelenium, $destintaionSelenium)

	# unzip the chrome driver
	$shell_app = New-Object -com shell.application
	cd $seleniumFolder
	
	$zipFile = $shell_app.namespace((Get-Location).Path + "\chromedriver_2.10.zip")
	$destination = $shell_app.namespace((Get-Location).Path)
	$destination.Copyhere($zipFile.items())
}

$configFolder = split-path $protractorConfig
Invoke-Expression ("cd ""$configFolder""")
npm install protractor-trx-reporter --save-dev
