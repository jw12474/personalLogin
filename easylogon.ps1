#need to figure out how to exicute a java file
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.Application]::EnableVisualStyles()
#Form Creation

######form
$form = New-Object System.Windows.Forms.Form
$form.StartPosition = 'CenterScreen'
$form.MinimizeBox = $true
$form.MaximizeBox = $false
$form.Text = 'Easy Login'
$form.BackColor = 'lightgray'
$form.Size = '650,630'
$form.MaximumSize = '650,630'
$form.MinimumSize = '650,630'
$form.Activate()
###### I don't know what Im doing Copying from software installer and software checker


####Username radio button
$groupBoxUSRName = New-Object System.Windows.Forms.GroupBox
$groupBoxUSRName.Location = '18,50'
$groupBoxUSRName.Size = '200,80'
$groupBoxUSRName.Font = 'Segoe UI, 12'
$form.Controls.Add($groupBoxUSRName)

        #####radiobuttonUSR1
        $RadioButtonUSR1 = New-Object System.Windows.Forms.RadioButton
        $RadioButtonUSR1.Location = '0,0'
        $RadioButtonUSR1.size = '200,20'
        $RadioButtonUSR1.Font = 'Segoe UI, 8'
        $RadioButtonUSR1.Text = "User: name1"
        $RadioButtonUSR1.Checked = $true
        $groupBoxUSRName.Controls.Add($RadioButtonUSR1)

        #####radiobuttonUSR2
        $RadioButtonUSR2 = New-Object System.Windows.Forms.RadioButton
        $RadioButtonUSR2.Location = '0,20'
        $RadioButtonUSR2.size = '200,20'
        $RadioButtonUSR2.Font = 'Segoe UI, 8'
        $RadioButtonUSR2.Text = "User: name2"
        $groupBoxUSRName.Controls.Add($RadioButtonUSR2)




####Browser radio button
$groupBoxBrowser = New-Object System.Windows.Forms.GroupBox
$groupBoxBrowser.Location = '450,50'
$groupBoxBrowser.Size = '200,80'
$groupBoxBrowser.Font = 'Segoe UI, 12'
$form.Controls.Add($groupBoxBrowser)
          #####radiobuttonBWS1
        $RadioButtonBRS1 = New-Object System.Windows.Forms.RadioButton
        $RadioButtonBRS1.Location = '0,0'
        $RadioButtonBRS1.size = '200,20'
        $RadioButtonBRS1.Font = 'Segoe UI, 8'
        $RadioButtonBRS1.Text = "Yes"
      
        $groupBoxBrowser.Controls.Add($RadioButtonBRS1)

        #####radiobuttonBRS2
        $RadioButtonBRS2 = New-Object System.Windows.Forms.RadioButton
        $RadioButtonBRS2.Location = '0,20'
        $RadioButtonBRS2.size = '200,20'
        $RadioButtonBRS2.Font = 'Segoe UI, 8'
        $RadioButtonBRS2.Text = "No"
        $RadioButtonBRS2.Checked = $true
        $groupBoxBrowser.Controls.Add($RadioButtonBRS2)



#####panelOutput
$panelOutput = New-Object System.Windows.Forms.Panel
$panelOutput.Location = '19,360'
$panelOutput.Size = '596,170'
$panelOutput.BorderStyle = 'FixedSingle'
$form.Controls.Add($panelOutput)

#####richtextboxOutput
$richtextboxOutput = New-Object System.Windows.Forms.RichTextBox
$richtextboxOutput.Font = 'Segoe UI,9'
$richtextboxOutput.Dock = 'Fill'
$richtextboxOutput.ReadOnly = $true
$richtextboxOutput.BorderStyle = 'none'
$panelOutput.Controls.Add($richtextboxOutput)



#####buttonRun
$buttonRun = New-Object System.Windows.Forms.Button
$buttonRun.Location = '245,546'
$buttonRun.Size = '80,32'
$buttonRun.Text = 'Run'
$buttonRun.BackColor = 'white'
$form.Controls.Add($buttonRun)

#####buttonClose
$buttonClose = New-Object System.Windows.Forms.Button
$buttonClose.Location = '325,546'
$buttonClose.Size = '80,32'
$buttonClose.Text = 'Close'
$buttonClose.BackColor = 'white'
$form.Controls.Add($buttonClose)




#####label1
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = '30,300'
$label1.Text = 'Code written by Jeffery Walls'
$label1.AutoSize = $True
$form.Controls.Add($label1)

#####linklabel1
$linklabel1 = New-Object System.Windows.Forms.LinkLabel
$linklabel1.Location = '18,320'
$linklabel1.Text = 'Form based on PS scripts Written by Cody Horton'
$linklabel1.AutoSize = $True
$linklabel1.Add_Click({[System.Diagnostics.Process]::Start("www.linkedin.com/in/codymhorton")})
$form.Controls.Add($linklabel1)



####This funciton writes to the big box to display the messages
Function Write-OutputBox {
	param(
		[parameter(Mandatory=$true)]
		[string]$Message,
		[ValidateSet('WARNING:','ERROR:')]
		[string]$Type,
	    [switch]$NoNewLine
	)
	
    if($NoNewLine){
        $richtextboxOutput.AppendText($Message)
    }else{
        $richtextboxOutput.SelectionColor = [Drawing.Color]::Black
        $date = Get-Date -format hh:mm:ss
        if($Type -eq ""){
            $msg = "[$($date)] $($Message)"
        }else{
            $msg = "[$($date)] $($Type) $($Message)"
        }
        
		$richtextboxOutput.SelectionStart = $richtextboxOutput.Text.Length
        if($richtextboxOutput.Text.Length -eq 0){
            switch ($Type){
			    'ERROR:'{
                    $richtextboxOutput.SelectionColor = [Drawing.Color]::Red
                    $richtextboxOutput.AppendText("$msg")
                }
        	    'WARNING:'{
                    $richtextboxOutput.SelectionColor = [Drawing.Color]::Orange
                    $richtextboxOutput.AppendText("$msg")
                }
			    default{
                    $richtextboxOutput.AppendText("$msg")
                }
            }
        }else{
            switch ($Type){
			    'ERROR:'{
                    $richtextboxOutput.SelectionColor = [Drawing.Color]::Red
                    $richtextboxOutput.AppendText("`n$msg")
                }
        	    'WARNING:'{
                    $richtextboxOutput.SelectionColor = [Drawing.Color]::Orange
                    $richtextboxOutput.AppendText("`n$msg")
                }
			    default{
                    $richtextboxOutput.AppendText("`n$msg")
                }
            }
        }
        $richtextboxOutput.ScrollToCaret()
	}
    #$richtextboxOutput.SelectionStart = $richtextboxOutput.Text.Length
    
    [System.Windows.Forms.Application]::DoEvents()
}

$global:Password = $null

Function GetPass {

    param(
        [string]$UsrNm
    )
    #### make a form that pops up that has a text box 
    $form2 = New-Object System.Windows.Forms.Form
    $form2.StartPosition = 'CenterScreen'
    $form2.MinimizeBox = $true
    $form2.MaximizeBox = $false
    $form2.Text = 'Authenticate'
    $form2.BackColor = 'lightgray'
    $form2.Size = '325,315'
    $form2.MaximumSize = '325,315'
    $form2.MinimumSize = '325,315'
    $form2.Activate()

        #### lable for username
        $labelUsr = New-Object System.windows.Forms.Label
        $labelUsr.Text = "UserName:"
        $labelUsr.Autosize = $true
        $labelUsr.Location = '17,15'
        $labelUsr.Font = 'Segoe UI, 12'
        $form2.Controls.Add($labelUsr)


        #####panelfor usernam
        $panelPrefixUsr = New-Object System.Windows.Forms.Panel
        $panelPrefixUsr.BorderStyle = 'FixedSingle'
        $panelPrefixUsr.Size = '250,25'
        $panelPrefixUsr.BackColor = 'white'
        $panelPrefixUsr.Location = '17,55'
        $form2.Controls.Add($panelPrefixUsr)

        #####textboxtextbox that has username in it
        $richtextboxPrefix1 = New-Object System.Windows.Forms.RichTextBox
        $richtextboxPrefix1.Font = 'Segoe UI, 10'
        $richtextboxPrefix1.Size = '250,17'
        $richtextboxPrefix1.Location = '0,2'
        $richtextboxPrefix1.BorderStyle = 'none'
        $richtextboxPrefix1.Multiline = $false
        $richtextboxPrefix1.Text = $UsrNm
        $panelPrefixUsr.Controls.Add($richtextboxPrefix1)
        ####
        #### lable for password
        $labelUsr = New-Object System.windows.Forms.Label
        $labelUsr.Text = "Password:"
        $labelUsr.Autosize = $true
        $labelUsr.Location = '17,80'
        $labelUsr.Font = 'Segoe UI, 12'
        $form2.Controls.Add($labelUsr)
        #####panelfor password
        $panelPrefixPass = New-Object System.Windows.Forms.Panel
        $panelPrefixPass.BorderStyle = 'FixedSingle'
        $panelPrefixPass.Size = '250,25'
        $panelPrefixPass.BackColor = 'white'
        $panelPrefixPass.Location = '17,110'
        $form2.Controls.Add($panelPrefixPass)

        #####textboxtextbox that stores password
        $richtextboxPass = New-Object System.Windows.Forms.RichTextBox
        $richtextboxPass.Font = 'Segoe UI, 10'
        $richtextboxPass.Size = '250,17'
        $richtextboxPass.Location = '0,2'
        $richtextboxPass.BorderStyle = 'none'
        $richtextboxPass.ForeColor = 'white'
        $richtextboxPass.Multiline = $false
        $panelPrefixPass.Controls.Add($richtextboxPass)

        #####buttonRun
        $buttonRun2 = New-Object System.Windows.Forms.Button
        $buttonRun2.Location = '40,140'
        $buttonRun2.Size = '80,32'
        $buttonRun2.Text = 'Run'
        $buttonRun2.BackColor = 'white'
        $form2.Controls.Add($buttonRun2)

        $richtextboxPass.Focus()

        #####buttonClose
        $buttonClose2 = New-Object System.Windows.Forms.Button
        $buttonClose2.Location = '130,140'
        $buttonClose2.Size = '80,32'
        $buttonClose2.Text = 'Close'
        $buttonClose2.BackColor = 'white'
        $form2.Controls.Add($buttonClose2)

        

        $buttonRun2.Add_Click({
            $buttonRun2.Enabled = $false
            $richtextboxPass.Focus()

            $Password = $richtextboxPass.Text

            if($Password -eq "" ){
                Write-OutputBox -Message "There was nothing put in the password textbox... `n closing program"
                $ButtonRun.Enabled = $true
                $form2.Close()
            } Else{
                $global:Password = $Password
                $form2.Close()
                
              
	    
    
            
            }






            
        })
           


        ##button close event calls form close event
        $buttonClose2.Add_Click({
        $Form2.Close()
       }) 



    $form2.ShowDialog() | Out-Null
}


$buttonRun.Add_Click({

    #turns off run button
    $ButtonRun.Enabled = $false
    $filepath = "C:\Users\jeffery-walls\Documents\easylogon\easylogincompletescript"


    $Username = $null
    $Browser = $null
    $Chrome = $null
    $Firefox = $null
    $Password = $null
    ####this is to make the username come from the radio button
    if($RadioButtonUSR1.Checked -eq $true){
        $Username = 'jeffery-walls'
    }elseif($RadioButtonUSR2.Checked -eq $true){
        $Username = 'jw12474'
    }
    ####
    ####this is to choose which browser to use
    if($RadioButtonBRS1.Checked -eq $true){
        Write-OutputBox "You already clocked in"
        exit

    }elseif($RadioButtonBRS2.Checked -eq $true){
        Write-OutputBox "Need to clock in now"
    }

    Write-OutputBox -Message " The username is $Username and the browser is $Browser"

    Write-OutputBox -Message "Your password needs to be entered"
    $Password = GetPass -UsrNm "$Username" 
    $passlength = $global:Password | Measure-Object -Character
    $count = $passlength.Characters
    Write-OutputBox -Message "The length of your password is $count"
    Start-Sleep -s 2
    
    
    if($global:Password -eq ""){
        $buttonRun.Enabled = $true
    }else{
        $Password = $global:Password
    }
    Clear-Content "$filepath\usernameAndPassword.txt"
    Write-Output "$Username,$Password" | add-content "$filepath\usernameAndPassword.txt"
    Write-OutputBox "saved to file"
    
            Write-OutputBox "Opening Browser"
            Start-Process -FilePath "$filepath\loginjava.jar"
            
            
     
     #Clear-Content "$filepath\usernameAndPassword.txt"
    # Write-OutputBox "Deleted from file"
    
      

    
    
    



     $ButtonRun.Enabled = $true
    })

##button close event calls form close event
$buttonClose.Add_Click({
    $Form.Close()
})        

$form.ShowDialog() | Out-Null





