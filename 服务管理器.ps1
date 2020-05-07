$cssd_3rdParty = "CSSD.Packpress.Service.3rdParty"
$cssd_API = "CSSD.Packpress.Service.API"
$cssd_Cache = "CSSD.Packpress.Service.Cache"
$cssd_Logging = "CSSD.Packpress.Service.Logging"
$cssd_Messaging = "CSSD.Packpress.Service.Messaging"
$cssd_Support = "CSSD.Packpress.Service.Support"
$cssd_Workflow = "CSSD.Packpress.Service.Workflow"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form -Property @{
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    Size          = New-Object Drawing.Size 800, 600
    Text          = 'CSSD'    
    Topmost       = $true    
}

$txtLabel = New-Object Windows.Forms.Label -Property @{
    Location     = New-Object Drawing.Point 10, 10
    Size     = New-Object Drawing.Size 130,20
    Text         = 'Service地址：'
}
$form.Controls.Add($txtLabel)

$tbxPath = New-Object System.Windows.Forms.TextBox -Property @{
 Location = New-Object Drawing.Point 10,30
 Size = New-Object Drawing.Size 400,20
 Text = '..\Output\Debug\Service\'
}
$tbxPath.TabIndex=100
$form.Controls.Add($tbxPath)

$txtArea = New-Object System.Windows.Forms.RichTextBox
$txtArea.Location = New-Object System.Drawing.Point 10,60
$txtArea.Size = New-Object System.Drawing.Size 400,400
$txtArea.TabIndex = 1

$form.Controls.Add($txtArea)

$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Location = New-Object System.Drawing.Point 10,480
$btnRun.Size = New-Object System.Drawing.Size 100,40
$btnRun.Text = "启动服务"
$btnRun.Focus()

$form.Controls.Add($btnRun)

$btnInstall = New-Object System.Windows.Forms.Button
$btnInstall.Location = New-Object System.Drawing.Point 130,480
$btnInstall.Size = New-Object System.Drawing.Size 100,40
$btnInstall.Text = "安装服务"

$form.Controls.Add($btnInstall)

$btnUninstall = New-Object System.Windows.Forms.Button
$btnUninstall.Location = New-Object System.Drawing.Point 260,480
$btnUninstall.Size = New-Object System.Drawing.Size 100,40
$btnUninstall.Text = "卸载服务"

$form.Controls.Add($btnUninstall)



$cbx3rdParty = New-Object System.Windows.Forms.CheckBox
$cbx3rdParty.Location = New-Object System.Drawing.Point 450,60
$cbx3rdParty.Text="3rdParty"
$cbx3rdParty.Checked = "True"

$form.Controls.Add($cbx3rdParty)

$cbxAPI = New-Object System.Windows.Forms.CheckBox
$cbxAPI.Location = New-Object System.Drawing.Point 450,100
$cbxAPI.Text = "API"
$cbxAPI.Checked = "True"

$form.Controls.Add($cbxAPI)

$cbxCache = New-Object System.Windows.Forms.CheckBox
$cbxCache.Location = New-Object System.Drawing.Point 450,140
$cbxCache.Text = "Cache"
$cbxCache.Checked = "True"

$form.Controls.Add($cbxCache)

$cbxLogging = New-Object System.Windows.Forms.CheckBox
$cbxLogging.Location = New-Object System.Drawing.Point 450,180
$cbxLogging.Text = "Logging"
$cbxLogging.Checked = "True"

$form.Controls.Add($cbxLogging)


$cbxMessaging = New-Object System.Windows.Forms.CheckBox
$cbxMessaging.Location = New-Object System.Drawing.Point 580,60
$cbxMessaging.Text = "Messaging"
$cbxMessaging.Checked = "True"

$form.Controls.Add($cbxMessaging)

$cbxSupport = New-Object System.Windows.Forms.CheckBox
$cbxSupport.Location = New-Object System.Drawing.Point 580,100
$cbxSupport.Text = "Support"
$cbxSupport.Checked = "True"

$form.Controls.Add($cbxSupport)

$cbxWorkflow = New-Object System.Windows.Forms.CheckBox
$cbxWorkflow.Location = New-Object System.Drawing.Point 580,140
$cbxWorkflow.Text = "Workflow"
$cbxWorkflow.Checked = "True"

$form.Controls.Add($cbxWorkflow)

$btnCheckAll = New-Object System.Windows.Forms.Button
$btnCheckAll.Location = New-Object System.Drawing.Point 450,220
$btnCheckAll.Size = New-Object System.Drawing.Size 100,40
$btnCheckAll.Text = "CheckAll"
$btnCheckAll.Add_Click({$cbxWorkflow.Checked = !$cbxWorkflow.Checked;$cbx3rdParty.Checked=$cbxWorkflow.Checked;$cbxAPI.Checked=$cbxWorkflow.Checked;$cbxCache.Checked=$cbxWorkflow.Checked;$cbxLogging.Checked=$cbxWorkflow.Checked;$cbxMessaging.Checked=$cbxWorkflow.Checked;$cbxSupport.Checked=$cbxWorkflow.Checked;})

$form.Controls.Add($btnCheckAll)


$btnRefresh = New-Object System.Windows.Forms.Button
$btnRefresh.Location = New-Object System.Drawing.Point 560,220
$btnRefresh.Size = New-Object System.Drawing.Size 130,40
$btnRefresh.Text = "Refresh"
$form.Controls.Add($btnRefresh)

$runButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 113, 165
    Size         = New-Object Drawing.Size 75, 23
    Text         = 'Run'
}
$form.Controls.Add($runButton)

refresh_cssd


function cssd_remove{
    Remove-Service -Name $cssd_3rdParty
    Remove-Service -Name $cssd_API
    Remove-Service -Name $cssd_Cache
    Remove-Service -Name $cssd_Logging
    Remove-Service -Name $cssd_Messaging
    Remove-Service -Name $cssd_Support
    Remove-Service -Name $cssd_Workflow
}

function cssd_add{
    $params_3rdParty = @{
      Name = $cssd_3rdParty
      BinaryPathName = $tbxPath.Text + "\3rdParty\CSSD.Packpress.Service.3rdParty.exe"
      DependsOn = "NetLogon"
      DisplayName = $cssd_3rdParty
      StartupType = "Manual"
      Description = $cssd_3rdParty
    }
    New-Service @params_3rdParty
}

function refresh_cssd{
    $aa_3rdParty = Get-Service "CSSD.Packpress.Service.3rdParty" 
    $txtArea.AppendText(($aa_3rdParty.Name + " - " + $aa_3rdParty.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")
    
    $aa_API = Get-Service "CSSD.Packpress.Service.API"
    $txtArea.AppendText(($aa_API.Name + " - " + $aa_API.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")

    $aa_Cache = Get-Service "CSSD.Packpress.Service.Cache"
    $txtArea.AppendText(($aa_Cache.Name + " - " + $aa_Cache.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")

    $aa_Logging = Get-Service "CSSD.Packpress.Service.Logging"
    $txtArea.AppendText(($aa_Logging.Name + " - " + $aa_Logging.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")

    $aa_Messaging = Get-Service "CSSD.Packpress.Service.Messaging"
    $txtArea.AppendText(($aa_Messaging.Name + " - " + $aa_Messaging.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")

    $aa_Support = Get-Service "CSSD.Packpress.Service.Support"
    $txtArea.AppendText(($aa_Support.Name + " - " + $aa_Support.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")

    $aa_Workflow = Get-Service "CSSD.Packpress.Service.Workflow"
    $txtArea.AppendText(($aa_Workflow.Name + " - " + $aa_Workflow.CanShutdown).Replace("True","Running").Replace("False","Stop    "))
    $txtArea.AppendText("\n")
}



$form.ShowDialog()


#if ($result -eq [Windows.Forms.DialogResult]::OK) {
#    $date = $calendar.SelectionStart
#    Write-Host "Date selected: $($date.ToShortDateString())"
#}
