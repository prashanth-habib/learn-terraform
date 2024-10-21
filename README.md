## Installing Terraform
Run the below commands to install Terraform on Ubuntu:</br>
* `wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform` </br>
source: https://developer.hashicorp.com/terraform/install
</br>

## Initialize Terraform
Run the below commands to initialize:
* `terraform init`

To create a plan and create an output file of the plan:
* `terraform plan -out <your_plan_name>`

To apply the plan to your target platform:
* `terraform apply "<plan_name>"`
