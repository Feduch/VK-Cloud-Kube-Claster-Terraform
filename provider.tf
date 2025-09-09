terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "< 1.0.0"
        }
    }
}

provider "vkcs" {
    # Your user account.
    username = var.OS_USERNAME

    # The password of the account
    password = var.OS_PASSWORD

    # The tenant token can be taken from the project Settings tab - > API keys.
    # Project ID will be our token.
    project_id = "fd3fa9b1dc8042c8bc19f483b88c6328"

    # Region name
    region = "RegionOne"

    auth_url = "https://infra.mail.ru:35357/v3/"
}
