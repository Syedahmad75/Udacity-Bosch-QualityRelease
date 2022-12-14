# Azure Pipelines: Ensure Quality Release Using Postman, Selenium, jmeter and Azure Monitor

### Introduction
For this project, In this project, we develop and demonstrate our skills in using a variety of industry leading tools, especially Microsoft Azure, to create disposable test environments and run a variety of automated tests with the click of a button. Additionally, we will monitor and provide insight of our application's behavior, and determine root causes by querying the application’s custom log files.

### Getting Started
1. [Create a disposable Outlook Account](https://outlook.com/) 

2. [Create a free Azure Account](https://azure.microsoft.com/en-us/free/) .Use the Outlook email address. Please note you will need to provide a credit card to receive $200.00 in free credits. Your credit card will not be charged unless you exceed this amount. This should be plenty of credits for you to complete your project.

3. [Create an Azure DevOps account. Use the Outlook email address. ](https://azure.microsoft.com/en-us/pricing/details/devops/azure-devops-services/) (If needed, click "start" free under user licenses.)

4. [Use cloud shell or Install Azure CLI.](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) 

5. Use your favorite text editor or IDE - for this I used [VS Code.](https://code.visualstudio.com/Download) . Install the VS Code extensions for (optional):\
-Python\
-Terraform

### Configurations
1. Download the [latest Chrome driver.](https://sites.google.com/a/chromium.org/chromedriver/) 
   ``` pip install -U selenium
       sudo apt-get install -y chromium-browser
    ``` 
    -IMPORTANT You will need to [add the chromedriver to PATH.](https://sites.google.com/a/chromium.org/chromedriver/getting-started)\
    -Execute the /automatedtesting/selenium/login.py file to run the testcases manually.

2. [Install JMeter](https://jmeter.apache.org/download_jmeter.cgi) 
    -Use JMeter to open the automatedtesting/jmeter/stress.jmx or endurance test file to run tests locally.\
    -Replace the APPSERVICEURL with the URL of your AppService once it's deployed.\
    -When you Want to check this in your local, Also change the CSV Files path and change it according to your agent root folder to run it on Pipeline. 

3. 2. [Install Postman.](https://www.postman.com/downloads/) 
    -Use JMeter to open the automatedtesting/jmeter/Starter.jmx file.\
    -Replace the APPSERVICEURL with the URL of your AppService once it's deployed.\
    -When you Want to check this in your local, Also change the CSV Files path and change it according to your agent root folder to run it on Pipeline. 
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Prerequisites
We assume that, the code is cloned in local disk name as Udacity-Bosch-QualityRelease named folder
1. The full path is - E:\Udacity-Bosch-QualityRelease
2. Exection starts from E:\Udacity-Bosch-QualityRelease\Scripts
3. `cd E:\Udacity-Bosch-QualityRelease\Scripts` 
4. In terminal, use the Azure CLI tool to setup your account permissions locally. Make sure that your login is already done, if not please use the `az login`
5. you can also set the subscription name using the following command (recommended)\
   `az account set --name <subscriptionName>`

### Customization
Make sure to copy Managedimageid and change it in modules/vars.tf file\
When the image is created, copy the ManagedimageId and change it in Configuaration\vars.tf file for the variable\
Details are in Instructions step 6. 

### Note: The execution is done in our own private subscription.

### Steps to Deploy the Infrastructure
1. Follow the prerequsite steps 
2. Create Resource Group for PackerImage\
Apply Policy -createPolicy.ps1\
Execute it using powershell ISE - `./createPolicy`\
![tagging-policy](https://i.imgur.com/LhjRxVk.png)\
The script also lists the policies existing in the subscription. Screeshot below-\
![az-list-policies](https://i.imgur.com/jldBaDw.png)

3. Create ResourceGroup\
Execute it using powershell ISE - `./createResourceGroup.ps1`\
This script checks if the ResourceGroup is already created,it does not create a new one, otherwise it creates a new\
ResourceGroup and validate it. Screeshot below-\
![resourcegroup](https://i.imgur.com/0MtalYz.png)

4. Create ServicePrinciple\
Execute it using powershell ISE - `./createServicePrinciple.ps1`\
This script Create Service Principle and parse into Json values and then store the secrets in the environment.You also need to replace the values in terraform/environments/test/terraform.tfvars with the output from the Screeshot below-\
![service-principle](https://i.imgur.com/b4zo7cl.png)

5. Get ServicePrinciple Details\
Execute it using powershell ISE - `.\getServicePrincipleDetails.ps1`\
This will return all the service principle details copy it and store it in .tfvars file.

5.  Create PackerImage\
Execute it using powershell ISE - `./createImage.ps1`\
This script Creates a VM image, which we have created using Packer. Screeshot below-\
![packer-image](https://i.imgur.com/Mz1vbIt.png)
you can Optionally delete these images. you have to change the resource name and image name in the deletePackerImage.ps1 file.\
Execute it using powershell ISE - `./deletePackerImage.ps1`
6. Copy the ManagedImageid and change it in terraform\modules\vm\input.tf file\
When the image is created, copy the ManagedimageId and change it in terraform\modules\vm\input.tf file for the variable\
packerImage. Screenshot below-\
![packer-image](https://i.imgur.com/jZF6dou.png)
7. Now you have to create a storageAccount and store the access key in the environment variable. 
Execute it using powershell ISE - `.\stroageAccount.ps1`\
Show the values and save it to Terraform Main.tf file under the backend module Screeshot below-\
![Storage Account](https://i.imgur.com/DtuC9PT.png)
![Storage Account](https://i.imgur.com/Mo5YUSG.png)
8. Create a SSH Key using your local environment that the VM will be used to login and set the path of the SSH key in the terraform\modules\vm\input.tf
 



### Setting up Azure Pipeline
### Prerequisites
1. Install [Terraform Extention by Microsoft DevLabs](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks) 
2. Install [Jmeter Extention](https://marketplace.visualstudio.com/items?itemName=AlexandreGattiker.jmeter-tasks)
3. Install [NewMan] (https://marketplace.visualstudio.com/items?itemName=carlowahlstedt.NewmanPostman)
### Steps
1. Create a New Service Connection 
    1. Sign in to your organization (https://dev.azure.com/{yourorganization}) and select your project.
    2. Select Project settings > Service connections.
    3. Select + New service connection, select the type of service connection that you need, and then select Next.
    4. Choose an authentication method, and then select Next.
    5. Choose an authentication method, and then select Next.
    6. Enter the parameters for the service connection.
    7. Select Save to create the connection.
2. Upload the Secure File in the Library.
    1. Open your terminal to create a SSH Key and also perform a keyscan of your github to get the known hosts. 
    ```
    ssh-keygen -t rsa
    cat ~/.ssh/id_rsa.pub
    ```
    ```
    ssh-keyscan github.com
    ```
    2. In order for accessing the VM we have to upload it in the Secure Files Section. \
    ![SSH Key](https://i.imgur.com/GPmmP3W.png)

3. Update the Paths in the Jmeter files for the CSV File and Also Update the WEB APP Name.
    1. Change your webapp name. 
    ![Jmeter Paths](https://i.imgur.com/a3ZEjDa.png)
    2. Change path for CSV Files. 
    ![Jmeter CSV File](https://i.imgur.com/PRacH5K.png)

4. DeleteResource.ps1 Output
    ![Terraform-Resources](https://i.imgur.com/NDtEtvh.png)

5. Configuring Pipeline Environment and Self Hosted Agent
    1. Create a new agent pool in DevOps account, and a new Linux VM using the following values in the Azure portal:\
    ![VM Agent](https://i.imgur.com/GPmmP3W.png)
    2. Configure the newly created Linux VM as a [self-hosted agent](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops). The agent VM will perform the pipeline jobs, such as building your code residing in Github and deploying it to the Azure services. This step will let you authenticate the agent via a Personal Access Token (PAT) generated from your DevOps account. If everything goes well, you will see the agent "online" in your DevOps account, as shown in the snapshot below.\
    ![VM Agent](https://i.imgur.com/ZKa0fYc.png)
    3. you also need to create an Test Environment and add above VM in the Test Environment.For this Pipelines -> Environments -> TEST -> Add resource -> Virtual Machines -> Linux. Then copy the registration script and manually ssh into the virtual machine, paste it on the terminal and run it.
    ![VM Agent](https://i.imgur.com/Iux3cAY.png)
    
    ```
    mkdir azagent;cd azagent;curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/2.210.1/vsts-agent-linux-x64-2.210.1.tar.gz;tar -zxvf vstsagent.tar.gz; if [ -x "$(command -v systemctl)" ]; then ./config.sh --environment --environmentname "TEST" --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/ahmadjee75/ --work _work --projectname 'Quality Release Project Pipelines' --auth PAT --token wupqimhlfpokmniz3ja63sxku7xj5fpg777rlpig3svzpkkz6kvq --runasservice; sudo ./svc.sh install; sudo ./svc.sh start; else ./config.sh --environment --environmentname "TEST" --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/ahmadjee75/ --work _work --projectname 'Quality Release Project Pipelines' --auth PAT --token wupqimhlfpokmniz3ja63sxku7xj5fpg777rlpig3svzpkkz6kvq; ./run.sh; fi
    ```
6. Set up a DevOps Pipeline
    1. Create an Azure Devops pipeline using the YAML file, azure-pipelines.yaml, present in your GitHub repository.
    2. If you are using your own Azure account, [follow the instructions](https://learn.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline?view=azure-devops&tabs=java%2Ctfs-2018-2%2Cbrowser) to create a new Azure Pipeline using the azure-pipelines.yaml file.
    3. Navigate to the DevOps project, and select Pipeline and create a new one. You will use the following steps:
    4. Connect - Choose the Github repository as the source code location.
    5. Select - Select the Github repository containing your code.
    6. Configure - Choose the Existing Azure Pipelines YAML file option. When you do not have any starter YAML file already, you can choose Starter pipeline option, as shown in the snapshot below.
    7. Known issue: Choosing other options may result in error due to restricted permission on your Azure account.
    ![Pipeline](https://i.imgur.com/syeQwYf.jpeg)
    8. Choose the Existing Azure Pipelines YAML file option. The project name may vary.
7. Pipelines Expected Outputs
    1. Terraform Apply 
    ![VM Agent](https://i.imgur.com/RKGuyg4.png)
    2. Deployed Web App
    ![Web App](https://i.imgur.com/brWKfdh.png)
    ![Web App](https://i.imgur.com/CJaPWpp.png)
    3. Regression Test Results
    ![Regression Test](https://i.imgur.com/KQZXgB4.png)
    ![Regression Test](https://i.imgur.com/gg7KQKM.png)
    4. Validation Test Results
    ![Validation Test](https://i.imgur.com/v9bWRxo.png)
    ![Validation Test](https://i.imgur.com/AYmGPlc.png)
    5. UI Test Results
    ![UI](https://i.imgur.com/ZYMJhYW.png)
    6. Jmeter Logs
    ![Jmeter](https://i.imgur.com/8O2XnqQ.png)
    5. Stages and in Azure Pipeline with 100 percent test passed. 
    ![Stages](https://i.imgur.com/Xm0hpgo.png)
    ![Tests](https://i.imgur.com/wCg0Mvd.png)
    ![Tests](https://i.imgur.com/XJmMmdw.png)
8. Creating Log Analytics Workspace
    1. in the Modules, we have already added Log Analytics workspace, so it should be created along with the Infrastructure. 
    2. Go to Agents management > Linux server > Log Analytics agent instructions > Download and onboard agent for Linux
    ![Agent](https://i.imgur.com/iHnRoX7.png)
    3. SSH into the VM created above (Under test) and install the OSMAgent.
    ```
    wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w dcf2a88d-b910-4faf-964b-14afb6decc20 -s Zb+kEzKbq7AQSLUOfXzJAJt+NA26bmfpR614rMwXf1UDi/YSTpZPSvYFHoF8CxSRPLsGJECRh+FAkzMHf97iqw== -d opinsights.azure.com
    ```
9. Create an Alert fot the App Service. 
    1. From the Azure Portal go to:
    Home > Resource groups > "RESOURCE_GROUP_NAME" > "App Service Name" > Monitoring > Alerts
    2. Click on New alert rule
    3. Double-check that you have the correct resource to make the alert for.
    4. Under Condition click Add condition
    5. Choose a condition e.g. Http 404
    6. Set the Threshold value to e.g. 1. (You will get altered after two consecutive HTTP 404 errors)
    7. Click Done
10. Create a new action group for the App Service
    1. In the same page, go to the Actions section, click Add action groups and then Create action group
    2. Give the action group a name e.g. http404
    3. Add an **Action name** e.g. `HTTP 404` and choose `Email/SMS message/Push/Voice` in Action Type.
    4. Provide your email and then click OK
     ![Action Group](https://i.imgur.com/sIjZ0Mg.png)
11. Create AppServiceHTTPLogs
    1. Go to the App service > Diagnostic Settings > + Add Diagnostic Setting. Tick AppServiceHTTPLogs and Send to Log Analytics Workspace created on step above and Save.
    ![Log Diagnostic](https://i.imgur.com/iQg403l.png)
    2. Go back to the App service > App Service Logs . Turn on Detailed Error Messages and Failed Request Tracing > Save. Restart the app service.
12. Setting up Log Analytics
    1. Set up custom logging, in the log analytics workspace go to Settings > Custom Logs > Add + > Choose File. Select the file selenium.log > Next > Next. Put in the following paths as type Linux:
    ```
    /var/log/selenium/selenium.log
    ```
    2. I called it selenium_CL, Tick the box Apply below configuration to my Linux machines.\
    ![Log Diagnostic](https://i.imgur.com/EjpL9xO.png)
    ![Log Diagnostic](https://i.imgur.com/4Zq6mgW.png)
    ![Log Diagnostic](https://i.imgur.com/rxYtjCY.png)
    ![Log Diagnostic](https://i.imgur.com/dg46hdt.png)
13. Hit Wrong URLS to generate 404 not found. 
    ![Log Diagnostic](https://i.imgur.com/I5eWeB6.png)
    ![Log Diagnostic](https://i.imgur.com/Xnjfpg9.png)
    ![Log Diagnostic](https://i.imgur.com/UV17tEa.png)




### References
1. https://docs.microsoft.com/en-us/azure/governance/policy/how-to/programmatically-create
2. [Example setup using GitHub](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/install-ssh-key?view=azure-devops#example-setup-using-github)
3. https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?tabs=yaml%2Cbatch&view=azure-devops&preserve-view=true#secret-variables
4. https://docs.microsoft.com/en-us/azure/architecture/example-scenario/apps/devops-dotnet-webapp
5. https://docs.microsoft.com/en-us/azure/devops-project/azure-devops-project-github
6. https://docs.microsoft.com/en-us/azure/devops-project/azure-devops-project-python?WT.mc_id=udacity_learn-wwl
7. [Collect custom logs with Log Analytics agent in Azure Monitor]( https://docs.microsoft.com/en-us/azure/azure-monitor/agents/data-sources-custom-logs)
8. [Collect data from an Azure virtual machine with Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/vm/quick-collect-azurevm)
9. [Environment - virtual machine resource](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/environments-virtual-machines?view=azure-devops)
10. [Build GitHub repositories](https://docs.microsoft.com/en-us/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml)
11. [Tutorial: Store Terraform state in Azure Storage](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage)
12. [Create your first pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline?view=azure-devops&tabs=azure-cli%2Ctfs-2018-2%2Cbrowser)
13. [Create a project in Azure DevOps](https://docs.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=preview-page)
14. [Create a Linux VM with infrastructure in Azure using Terraform](https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure)