[cmdletbinding()]
Param (
[string]$ps1
)
$details = @();
function Get-Banner{
    $ascii=@"
             .__              ________  ___ ___ ________         .__        __   
______  _____|  |            /  _____/ /   |   \\_____  \   _____|__| _____/  |_ 
\____ \/  ___/  |    ______ /   \  ___/    ~    \/   |   \ /  ___/  |/    \   __\
|  |_> >___ \|  |__ /_____/ \    \_\  \    Y    /    |    \\___ \|  |   |  \  |  
|   __/____  >____/          \______  /\___|_  /\_______  /____  >__|___|  /__|  
|__|       \/                       \/       \/         \/     \/        \/      
"@
Write-Color "{cyan}",$ascii;
Write-Color "{green}Made By: {white}FonderElite{green} | {white}Version: {white}1.0{green} | {white}Date: {white}$(date){green}`n";

}
function Write-Color() {
    Param (
        [string] $text = $(Write-Error "You must specify some text"),
        [switch] $NoNewLine = $false
    )

    $startColor = $host.UI.RawUI.ForegroundColor;

    $text.Split( [char]"{", [char]"}" ) | ForEach-Object { $i = 0; } {
        if ($i % 2 -eq 0) {
            Write-Host $_ -NoNewline;
        } else {
            if ($_ -in [enum]::GetNames("ConsoleColor")) {
                $host.UI.RawUI.ForegroundColor = ($_ -as [System.ConsoleColor]);
            }
        }
        $i++;
    }
    if (!$NoNewLine) {
        Write-Host;
    }
    $host.UI.RawUI.ForegroundColor = $startColor;
}
function Get-XorCipher{
        [cmdletbinding()]
Param (
    [Parameter(Mandatory=$true,ValueFromPipeline=$false)] 
    [string]$PlainText,
    [String[]]$Key
)
Process{
    $cyphertext = ""
    $keyposition = 0
    $KeyArray = $Key.ToCharArray()    
    $plaintext.ToCharArray() | foreach-object -process {
        $cyphertext += [char]([byte][char]$_ -bxor $KeyArray[$keyposition])
        $keyposition += 1
        if ($keyposition -eq $Key.Length) {$keyposition = 0}
        }
        return $cyphertext;
    }
   
}

function Get-Github(){
 Process{
    $url = "https://api.github.com/users/x/events/public";
    $repourl = "https://api.github.com/users/x"
    if($ps1 -ne ''){
    $encode =  Get-XorCipher -PlainText $ps1 -Key "!*#$%^&*()_+";
    $decode = Get-XorCipher -PlainText $encode -Key "!*#$%^&*()_+";
    $newurl = $url.Replace("x",$decode);
    $newrepourl = $repourl.Replace("x",$decode);
    $webJSONData = Invoke-WebRequest -Uri $newurl;
    $webJSONData2 = Invoke-WebRequest -Uri $newrepourl; 

    $temploc = "{0}\{1}" -f $env:TEMP,"data.json"

if(-not(Test-Path $temploc)){
Start-Sleep 1.5;
  $createFile = New-Item -Path $env:TEMP\data.json -Type File;
 if(Test-Path $temploc){
Write-Color "{white}[{green}+{white}]JSON Data Written...";
Start-Sleep 1.5;
$placeContentF = Set-Content $temploc $webJSONData.content;
$JsonDataF = Get-Content $temploc -Raw | ConvertFrom-Json;
$JsonDataF2 = $webJSONData2 | ConvertFrom-Json;

$authorEmail = $JsonDataF.payload.commits.author.email[0]; 
$authorId = $JsonDataF.actor.id[0]; 
$authorRepos = $JsonDataF2.public_repos;
$authorGist = $JsonDataF2.public_gists;
$authorUrl = $JsonDataF.actor.url[0]; 
$authorImg = $JsonDataF.actor.avatar_url[0];
$authorFollowers = $JsonDataF2.followers;
$authorFollowing = $JsonDataF2.following;
$authorCreated = $JsonDataF2.created_at;
$authorUpdated = $JsonDataF2.updated_at;
$authorLocation = $JsonDataF2.location;
$authorCompany = $JsonDataF2.company;
$authorTwitter = $JsonDataF2.twitter_username;
$authorBlog = $JsonDataF2.blog;
$userdetails = @($authorEmail,$authorId,$authorRepos,$authorUrl,$authorImg,$authorGist,$authorFollowers,$authorFollowing,$authorCreated,$authorUpdated,$authorLocation,$authorCompany,$authorTwitter, $authorBlog);
Clear-Host;
Get-Banner;
Start-Sleep 1.5;
Write-Color "{white}[{green}+{white}]User Details: ";
Write-Color "{green}User-Email:{white}",$userdetails[0];
Write-Color "{green}User-Id:{white} ",$userdetails[1];
Write-Color "{green}Location:{white} ",$userdetails[10];
Write-Color "{green}Company:{white} ",$userdetails[11];
Write-Color "{green}Twitter:{white} ",$userdetails[12];
Write-Color "{green}Website:{white} ",$userdetails[13];
Write-Color "{green}Total Public Repos:{white} ",$userdetails[2];
Write-Color "{green}Author-Gist:{white} ",$userdetails[5];
Write-Color "{green}Author-Url:{white} ",$userdetails[3];
Write-Color "{green}Followers:{white} ",$userdetails[6];
Write-Color "{green}Following:{white} ",$userdetails[7];
Write-Color "{green}Author-Created:{white} ",$userdetails[8];
Write-Color "{green}Author-Updated:{white} ",$userdetails[9];

 }
  }elseif(Test-Path $temploc){
    Write-Color "{white}[{green}+{white}]Json Data Location:",$temploc;
    Start-Sleep 1.5;
$placeContent = Set-Content $temploc $webJSONData.content;
$JsonData = Get-Content $temploc -Raw | ConvertFrom-Json;
$JsonData2 = $webJSONData2 | ConvertFrom-Json;
$email = $JsonData.payload.commits.author.email[0]; 
$id = $JsonData.actor.id[0]; 
$repos = $JsonData2.public_repos;
$gist = $JsonData2.public_gists;
$followers = $JsonData2.followers;
$following = $JsonData2.following;
$created = $JsonData2.created_at;
$updated = $JsonData2.updated_at;
$location = $JsonData2.location;
$company = $JsonData2.company;
$twitter = $JsonData2.twitter_username;
$blog = $JsonData2.blog;
$actorUrl = $JsonData.actor.url[0]; 


clear-Host;
Get-Banner;
Start-Sleep 1.5;
$userdetails2 = @($email,$id,$repos,$actorUrl,$avatar,$gist,$followers,$following,$created,$updated,$location,$company,$twitter,$blog);
Write-Color "{white}[{green}+{white}]User Details: ";
Write-Color "{green}User-Email:{white}",$userdetails2[0];
Write-Color "{green}User-Id:{white} ",$userdetails2[1];
Write-Color "{green}Website:{white}",$userdetails2[13];
Write-Color "{green}Location:{white} ",$userdetails2[10];
Write-Color "{green}Company:{white} ",$userdetails2[11];
Write-Color "{green}Twitter:{white} ",$userdetails2[12];
Write-Color "{green}Total Public Repos:{white} ",$userdetails2[2];
Write-Color "{green}Total Public Gists:{white} ",$userdetails2[4];
Write-Color "{green}Author-Url:{white} ",$userdetails2[3];
Write-Color "{green}Followers:{white} ",$userdetails2[6];
Write-Color "{green}Following:{white} ",$userdetails2[5];
Write-Color "{green}Created:{white} ",$userdetails2[8];
Write-Color "{green}Updated:{white} ",$userdetails2[9];
    }
elseif($ps1 -eq ''){
        Write-Color "{white}[{red}-{white}] You must specify a username{white}";
        Write-Color "{white}[{yellow}!{white}]How to Run: {cyan}&{white} {cyan}<{white}D:\Projects\Powershell\Practice\filename.ps{cyan}>{white} {cyan}<{white}Github Username{cyan}>{white}";
 }
} 
}
}

Get-Github;

