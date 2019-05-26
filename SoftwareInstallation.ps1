#############################################################
## Download software from urls, use regex to specify name, ##
## install software                                        ##
#############################################################

# Downloas urls
$urls =
# Dell Command Update
"https://downloads.dell.com/FOLDER05312739M/1/Dell-Command-Update_Y2KWD_WIN_3.0.1_A00.EXE",
# Dell Power Manager
"https://downloads.dell.com/FOLDER05545680M/5/Dell-Power-Manager-Service_HDMK1_WIN64_3.3.0_A00_03.EXE"

# Method for downloading
function Get-FromUrl ([String]$url) {
    # regex marks everything to the last /
    [String]$file_name = $url -replace "^(.*[\\\/])", ""

    # Make sure that every filename has a .exe ending
    if (!$file_name.Contains("exe") -and !$file_name.Contains(".EXE")) {
        $file_name = "$file_name.exe"
    }

    $Title = "Run the nstaller for:"
    $Info = "$file_name"

    $options = [System.Management.Automation.Host.ChoiceDescription[]] @("&Install", "&Download", "&Skip", "&Quit")
    [int]$defaultchoice = 0
    $opt = $host.UI.PromptForChoice($Title, $Info , $Options, $defaultchoice)

    switch ($opt) {
        0 {
            Write-Host "Download And Install" -ForegroundColor Green;
            $is_installation = $true; $is_download = $true
        }
        1 {
            Write-Host "Download" -ForegroundColor Green;
            $is_installation = $false; $is_download = $true
        }
        2 {
            Write-Host "Skip" -ForegroundColor Green;
            $is_installation = $false; $is_download = $false
        }
        3 {
            Write-Host "Quit" -ForegroundColor Green;
            break
        }
    }

    if ($is_download) {
        Write-Host "Downloading $($file_name)"
        $output = "$HOME\Downloads\$file_name"
        $start_time = Get-Date
        $web_client = New-Object System.Net.WebClient
        $web_client.DownloadFile($url, $output)
        Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    }
    if ($is_installation ) {
        Write-Host "Installing $($file_name)"
        Start-Process -Wait -FilePath $output
    }
}


for ($i = 0; $i -lt $urls.Count; $i++) {
    Get-FromUrl($urls[$i], $url_regex)
}









