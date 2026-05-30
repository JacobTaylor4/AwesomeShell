<#
Using the ExampleUses.csv as your directory. Make a script that does the following:

1. Creates a report of all stale users. Stale users are defined as users that have not logged in for more than seven days.

2. Creates a report of all expired passwords. Passwords expire after 30 days.

3. Creates a report of all locked accounts.

4. Updates a user's password.

a. Prompt for username (if not found quit)

b.Prompt for password (if incorrect quit)

i. Prompt for new password

1. If password is sufficiently complex update it

2.If the password is not complex write an error and reprompt

Extra:
Create a main menu for the script that prompts the user for which of the above he or she wants to do
Have the three reports prompt the user if he or she would like to export the results to a CSV.
#>

Clear-Host
do{Clear-Host
#States what the function can be called
    $functionMap = @{
        "4" = { Test-User }
        }
    #Stores information from an excel data sheet into the directery for use
    $userData = Import-Csv -Path 'C:\Users\jacobtaylor\Desktop\New Project\ExampleUsers.csv'
    ""
    #Displays the avaiable funcions to the user
  
   Write-Host  "Select which option you want to preform:"
""
   Write-Host  "1.Create a report of all stale users (enter '1')"
""
   Write-Host  "2.Create a report of all expired passwords (enter '2')"
""
   Write-Host  "3.Create a report of all locked accounts (enter '3')"
""
   Write-Host  "4.Update a user's password (enter '4')"
""
   Write-Host  "5.Exit (enter 'e' or 'E')"
    ""
    # reads which function the user inputs
    $usercommand = Read-Host "Input option here"
    #This function allows the user access stale users
    if($usercommand -eq 1){
    Clear-Host
        $Array =  @()
        $checkdate = (Get-Date).AddDays(-7)
        foreach($user in $userData){
            $lastlogon = [DateTime]::Parse($user.LastLogon)   
            if($checkdate -ge $lastlogon){  
                $Array += $user.Username
       
            }
        
        }
        $itirator  = 1
        foreach($string in $Array){
            Write-Host $itirator".  $string"
       
            $itirator++ 
        
        }
        Read-Host -Prompt "Press Enter to continue"
        Clear-Host
    }
    # This function allows the user to see all expired passwords
    if($usercommand -eq 2){
    Clear-Host
    $Array =  @()
        $checkdate = (Get-Date).AddDays(-30)
        foreach($user in $userData){
            $PasswordLastSet = [DateTime]::Parse($user.PasswordLastSet)   
            if($checkdate -ge $PasswordLastSet){  
                $Array += $user.Username
        
            }
        
        }
        $itirator  = 1
        foreach($string in $Array){
            Write-Host $itirator".  $string"
       
            $itirator++ 
        
        }
        Read-Host -Prompt "Press Enter to continue"
        Clear-Host
    }
    # This function allows the uer to see all locked accounts
    if($usercommand -eq 3){
    Clear-Host
    $Array =  @()
        foreach($user in $userData){
            $Locked = $user.Locked  
            if( "TRUE" -eq $Locked){  
                $Array += $user.Username
        
            }
        
        }
        $itirator  = 1
        foreach($string in $Array){
            Write-Host $itirator".  $string"
       
            $itirator++ 
        
        }
        Read-Host -Prompt "Press Enter to continue"
        Clear-Host
    }
    #This function allows he user to change a paaword and quit during each step of the proccess
    function Test-User {
        if($usercommand -eq 4){
            Clear-Host
            Do{
                $exitcheck = $false
                 ""
                    $username = Read-Host "Please input your username or exit the function by using 'e' or 'E'"
                 ""
                foreach($user in $userData){
                            $NameTrue = $false
                            if($username -eq 'e'){
                                Clear-Host
                    return}
                if($userName -eq $user.userName){
                        Clear-Host
                        Write-Host "Username Found"
                        Read-Host -Prompt "Press Enter to continue"
                        clear-Host
                        $NameTrue = $true
                        $oldpasswordCheck = $user.Password
                        $oldPasswordTrue = $false
                            do{
                                ""
                                $oldPassword = Read-Host "Please input your current password or exit the function using 'e' or 'E'"
                                ""
                                if($oldPassword -eq 'e'){
                                Clear-Host
                                return}
                            if($oldPassword -eq $oldPasswordCheck){
                                    $oldPasswordTrue = $true
                                    Clear-Host
                                    Write-Host "Correct Password"
                                    Read-Host -Prompt "Press Enter to continue"
                                    clear-Host
                                    }
                            else{ Clear-Host
                                  Write-Host "Incorrect Password"
                                  for( $currentSeconds = 2; $currentSeconds -ge 0; $currentSeconds--){
                                  Write-Host "Wait $currentSeconds seconds"
                                  Start-Sleep 1
                                  } Clear-Host
                                }
                            }Until($oldPasswordTrue)
                             break ##Breaks out of Line 3 ForEach
                                                }
         
                                            } 
                                            if($NameTrue -eq $false){Clear-Host
                                            Write-Host "Didn't find username"
                                            Read-Host -Prompt "Press Enter to continue"
                                            Clear-Host}
                  }Until($NameTrue) 


    $capitalLetterArray = @('Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J','K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N','M') 
    $LetterArray =  @('q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f','g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v','b', 'n', 'm' )
    $SpecialCharacterArray =  @('!','@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '-', '+','=', '`', '~', '{', '[', ']','}', '\', '|', ';', ':', "'", '"', '<', ',', '>', '.', '/', '?')
    $numbersArray =  @('1', '2', '3', '4', '5', '6', '7', '8', '9', '0')

        do{
            $Capitals = 0
            $letter = 0
            $specialCharacter = 0
            $numberchar = 0
            " "
            Write-Host "Password must contain:" 
            Write-Host "8 characters up to 16 characters"
            Write-Host "2 capital letter characters"
            Write-Host "2 lowercase letter characters" 
            Write-Host "1 special character" 
            Write-Host "1 number character" 
            $newPassword = Read-Host -prompt "Please input your new password exit the function by using 'e' or 'E'"
            if($newPassword -eq 'e'){
                Clear-Host
                return
                }
            $newPasswordArray = [char[]]$newPassword
            foreach($newPasswordChar in $newPasswordArray){
                foreach($capitalLetter in $capitalLetterArray){
                    if($capitalLetterArray -ceq $newPasswordChar){
                        $Capitals++
                            break}
                                    }
                foreach($LetterinArray in $LetterArray){
                    if($LetterinArray -ceq $newPasswordChar){
                        $letter++
                        break
                        }
                            }
                foreach($specialCharacterinArray in $SpecialCharacterArray){
                    if($specialCharacterinArray -eq $newPasswordChar){
                        $specialCharacter++
                        break
                        }
                            }
                foreach($numbersinArray in $numbersArray){
                    if($numbersinArray -eq $newPasswordChar){
                        $numberchar++
                        break
                        }
                            }
                                }
            $characterAmount = $Capitals + $letter + $specialCharacter + $numberchar
            Clear-Host
	    Write-Host "Corrections needed to password:"
            if($characterAmount -lt 8){""
                Write-Host "Not enough characters"
                }
            if($characterAmount -gt 16){""
                Write-Host "Too many characters"
                }
            if($Capitals -lt 2){""
                Write-Host "Not enough Capital letters"
                }
            if($letter -lt 2){""
                Write-Host "Not enough lowercase letters"
                }
            if($specialCharacter -lt 1){""
                Write-Host "Not enough special characters"
                }
            if($numberchar -lt 1){""
                Write-Host "Not enough numbers"
                }
        }until($characterAmount -ge 8 -and $characterAmount -le 16 -and $Capitals -ge 2 -and $letter -ge 2 -and $specialCharacter -ge 1 -and $numberchar -ge 1)


    foreach($user in $userData){
        $namePassword = $user.Username
        if($namePassword -eq $username){
            Clear-Host
            $user.Password = $newPassword
            $user.PasswordLastSet = Get-date
            $userData | Export-Csv -Path 'C:\Users\jacobtaylor\Desktop\New Project\ExampleUsers.csv'
            $exitcheck = $True
            Write-Host "Password change Success"
            Read-Host -Prompt "Press Enter to continue"
            Clear-Host
        }
            }
    if($exitcheck){
    return
            }
        }
    }
if ($functionMap.ContainsKey($usercommand)) {
    & $functionMap[$usercommand]
    }

}until($usercommand -eq "e")
Clear-Host

<#
1. trying to recieve all stale users within a excell sheet by getting to a point where the dates can be compared 
(get-date) > rerieves current date
.AdDays(-7) > remves 7 days from todays date
for each($user in $userdata) > takes the array and ittrates through that array one item at a time
foreach($string in $Array) pulls all the strings out of the array variable that was created
This calls a string withint the document:
$userData[536].Username
$userData[0]
pram allows it to be reused later if needed

4.password from user will be from 12-64 characters, ask user for new password, edit excel sheet to new passowrd
#>

