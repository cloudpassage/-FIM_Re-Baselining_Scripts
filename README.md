# FIM_Re-Baselining_Scripts
Bash and PowerShell scripts for FIM Re-Baselining


## Table of contents
* FIM Re-Baseline Script Goal
* FIM Re-Baseline Pre-Requisites
    * Bash Script (Linux Environment)
        * JQ Tool
        * Script Mode
    * PowerShell Script (Windows Environment)
        * Enable execution of PowerShell scripts
* FIM Re-Baseline Script Parameters
* Passing parameters to the FIM Re-Baseline script
    * Bash Script (Linux Environment)
    * PowerShell Script (Windows Environment)
* FIM Re-Baseline Script Outputs
* FIM Re-Baseline Script Process
<!--* [FIM Re-Baseline Script Goal](#FIM Re-Baseline Script Goal)
* [FIM Re-Baseline Pre-Requisites](#FIM Re-Baseline Pre-Requisites)
    * [Bash Script (Linux Environment)](#Bash Script (Linux Environment))
        * [JQ Tool:](#JQ Tool:)
        * [Script Mode:](#Script Mode:)
    * [PowerShell Script (Windows Environment)](#PowerShell Script (Windows Environment))
        * [Enable execution of PowerShell scripts:](#Enable execution of PowerShell scripts:)
* [FIM Re-Baseline Script Parameters](#FIM Re-Baseline Script Parameters)
* [Passing parameters to the FIM Re-Baseline script](#Passing parameters to the FIM Re-Baseline script)
    * [Bash Script (Linux Environment)](#Bash Script (Linux Environment))
    * [PowerShell Script (Windows Environment)](#PowerShell Script (Windows Environment))
* [FIM Re-Baseline Script Outputs](#FIM Re-Baseline Script Outputs)
* [FIM Re-Baseline Script Process](#FIM Re-Baseline Script Process)-->

## FIM Re-Baseline Script Goal
Updates the baseline (re-runs the baseline scan) specified by baseline ID and policy ID in the call URL, on the server specified in the request body.

## FIM Re-Baseline Pre-Requisites
### Bash Script (Linux Environment)
#### JQ Tool:
The script requires third tool library called **“jq”** to be installed in the underlying operating system. **jq** is a powerful tool that lets you read, filter, and write JSON in bash. To install **jq** run the below command:
```
    sudo yum install jq
```
        
#### Script Mode:
Created bash script needs to be marked as executable bash file in order to be able to call it from the console. To change the mode of the bash script file run the command below:
```
sudo chmod 775 FIM Re-Baselining bash.sh
```
### PowerShell Script (Windows Environment)
#### Enable execution of PowerShell scripts:
In order to be able to call the PowerShell script, you should enable execution of PowerShell scripts on the underlying operating system. Two steps to enable execution of PowerShell scripts:
* Start Windows PowerShell with the "Run as Administrator" option. Only members of the Administrators group on the computer can change the execution policy.
* Enable running unsigned scripts by entering:
```
set-executionpolicy remotesigned
```
        
This will allow running unsigned scripts that you write on your local computer and signed scripts from Internet.

## FIM Re-Baseline Script Parameters
To be able to run the bash / powershell script, you should provide the following input parameters:

- api_key_id
- api_key_secret
- fim_policy_id
- fim_baseline_id
- expires_at
- comment
- server_id
- agent_id

## Passing parameters to the FIM Re-Baseline script
### Bash Script (Linux Environment)
There are two versions of the bash script.
- The first version of the bash script named “FIM_Re-
Baselining_Bash_Command-Params.sh” takes the input parameters from
the terminal as illustrated in Figure 1.

    ```
    $ bash FIM_Re-Baselining_Bash_Command-Params.sh 
    -a "a7ab96e8"
    -b "2ab3cc676c5fa33e43aaf64c84660b11"
    -c "c77c809ab26b11eaafc959098258d76d"
    -d "3d969ba8b27111ea9a4515c8227f0790"
    -e ""
    -f "FIM_Rebaselining_Script"
    -g "b7303e86b26911ea8c421382890b5bc7"
    -h ""
  ```
        Figure 1. Passing input parameters to the bash script from the terminal.
        
- The second version of the bash script named “FIM_Re-
Baselining_Bash_Static-Params.sh” takes the input parameters in a static
manner where input parameters are set in the script source as illustrated in
Figure 2.

```
    #!/bin/bash
    # Input Variables
    api_key_id="a7ab96e8"
    api_key_secret="2ab3cc676c5fa33e43aaf64c84660b11"
    fim_policy_id="c77c809ab26b11eaafc959098258d76d"
    fim_baseline_id="3d969ba8b27111ea9a4515c8227f0790"
    expires_at=""
    comment="FIM_Rebaselining_Script"
    agent_id=""
    server_id="b7303e86b26911ea8c421382890b5bc7"
```
    Figure 2. passing input parameters to the bash script in a static manner through the script source.
   
### PowerShell Script (Windows Environment) 
There are two versions of the powershell script.
- The first version of the powershell script named “FIM_Re-
Baselining_Powershell_Command-Params.ps1” takes the input
parameters from the command prompt as illustrated in Figure 3.

```
    PS C:\Users\Tom\Projects\CloudPassage\FIM_Baseline_Script\Scripts> .\FIM_Re-Baselining_Powershell_Command-Params.ps1 
    -api_key_id "a7ab96e8" 
    -api_key_secret "2ab3cc676c5fa33e43aaf64c84660b11" 
    -fim_policy_id "c77c809ab26b11eaafc959098258d76d" 
    -fim_baseline_id "3d969ba8b27111ea9a4515c8227f0790" 
    -expires_at "" 
    -comment "FIM_Rebaselining_Script" 
    -server_id "b7303e86b26911ea8c421382890b5bc7" 
    -agent_id ""
```
    Figure 3. passing input parameters to the powershell script through the command prompt.

- The second version of the powershell script named “FIM_Re-
Baselining_Powershell_File-Params.ps1” takes the input parameters from
a configuration file called “inputparams.txt” located in the same directory
of the script as illustrated in Figure 4.

```
    api_key_id=a7ab96e8
    api_key_secret=2ab3cc676c5fa33e43aaf64c84660b11
    fim_policy_id=c77c809ab26b11eaafc959098258d76d
    fim_baseline_id=3d969ba8b27111ea9a4515c8227f0790
    expires_at=
    comment=FIM_Rebaselining_Script_Powershell_New
    server_id=b7303e86b26911ea8c421382890b5bc7
    agent_id=
```
    Figure 4. Passing input parameters to the powershell script through a configuration file located in the same directory of the script.

## FIM Re-Baseline Script Outputs
The script exports all generated results into log file created in the same directory
of the script. If the script updated the baseline successfully without any errors,
you should receive response as illustrated in Figure 5.

```
{"baseline":{"id":"3d969ba8b27111ea9a4515c8227f0790",
"url":"https://api.cloudpassage.com/v1/fim_policies/c77c809ab26b
11eaafc959098258d76d/baselines/3d969ba8b27111ea9a4515c8227f0790"
,"server_id":"b7303e86b26911ea8c421382890b5bc7","comment":"FIM_R
ebaselining_Script","status":"Pending",
"effective_at":null,"expires_at":null,"policy_name":"FIM_Baselin
e_Linux_Policy",
"server_name":"ip-172-31-36-201.us-east-
2.compute.internal","platform":"linux"}}
```
    Figure 5. Sample of the script returned results.
    
## FIM Re-Baseline Script Process
FIM Re-Baseline script executes specific interal tasks to update the baseline. These steps are illustrated in Figure 6.
![FIM_Script_Process](/images/FIM_Script_Process.png)

Figure 6. FIM Re-Baseline Script Process