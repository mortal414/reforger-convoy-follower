param([switch]$LoadStart)
$ErrorActionPreference = 'Stop'
$filmWorkspace = Split-Path $PSScriptRoot -Parent
$filmGameDirectory = 'D:\SteamLibrary\steamapps\common\Arma Reforger'
$filmExecutable = Join-Path $filmGameDirectory 'ArmaReforgerSteamDiag.exe'
$filmRun = 'D:\ReforgerAgentRuns\everon-nato-film-recovered-v3-20261008'
$filmPackages = Join-Path $filmWorkspace '.cache\cinematic-player\everon-nato-20261008\packed-addons'
$filmRecoveredPackages = Join-Path $filmWorkspace '.cache\cinematic-player\everon-nato-20261008\recovered-addons-v3'
foreach ($filmRequired in @($filmExecutable,$filmPackages,$filmRecoveredPackages)) {
 if (-not (Test-Path -LiteralPath $filmRequired)) { throw "Required filming file or directory missing: $filmRequired" }
}
$filmExisting = Get-CimInstance Win32_Process -Filter "Name = 'ArmaReforgerSteamDiag.exe'" | Where-Object { $_.CommandLine -and $_.CommandLine.Contains($filmRun) }
if ($filmExisting) { throw 'The recovered filming client is already open. Keep the live scene or close that client normally before relaunching.' }
New-Item -ItemType Directory -Path (Join-Path $filmRun 'profile'),(Join-Path $filmRun 'logs') -Force | Out-Null
$filmArguments = @(
 '-profile',('"'+(Join-Path $filmRun 'profile')+'"'),
 '-logsDir',('"'+(Join-Path $filmRun 'logs')+'"'),
 '-window','-screenWidth','1280','-screenHeight','720','-maxFPS','30','-noSplash',
 '-addonsDir',('"'+$filmPackages+','+$filmRecoveredPackages+'"'),
 '-addons','5E389BB9F58B79A6,629B2BA37EFFD577,63120AE07E6C0966,5B02128D896F7DE8,5D1880C4AD410C14,BD74FC094F539BDC',
 '-world','Worlds/EveronFilmStart.ent',
 '-worldSystemsConfig','"{8DDC2A311929D52F}Configs/Systems/GameMasterSystems.conf"'
)
if ($LoadStart) {
 $filmMetadata = Get-ChildItem -LiteralPath (Join-Path $filmRun 'profile\profile\.save') -Recurse -Filter meta-info.json -File | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw | ConvertFrom-Json } | Where-Object { $_.m_sSavePointDisplayName -eq 'Everon NATO Film Start - Recovered 2026-10-08' } | Sort-Object m_iSavedAtUnix | Select-Object -First 1
 if (-not $filmMetadata) { throw 'The named starting checkpoint was not found. No game was launched.' }
 $filmArguments += @('-loadSessionSave',$filmMetadata.m_Id)
}
$filmProcess = Start-Process -FilePath $filmExecutable -ArgumentList $filmArguments -WorkingDirectory $filmGameDirectory -PassThru
Write-Output "Recovered Everon filming client PID $($filmProcess.Id); untimed. Original player client is not touched."
