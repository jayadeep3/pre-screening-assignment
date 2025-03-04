#!/bin/bash

# Function to install NVM and Node.js
install_node() {
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    read -p "Enter Node.js version to install: " node_version
    nvm install "$node_version"
    nvm use "$node_version"
    echo "Node.js $node_version installed successfully."
}

# Function to install PHP
install_php() {
    echo "Updating package lists..."
    sudo apt update

    read -p "Enter PHP version to install (e.g., 8.1 or 7.4): " php_version

    if [[ "$php_version" == "7.4" ]]; then
        echo "Adding Ondrej's PPA for PHP 7.4..."
        sudo apt install -y software-properties-common
        sudo add-apt-repository ppa:ondrej/php -y
        sudo apt update
    fi

    sudo apt install -y php$php_version

    if php -v | grep -q "$php_version"; then
        echo "PHP $php_version installed successfully."
    else
        echo "PHP installation failed. Please check manually."
    fi
}

# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins..."

    # Install dependencies
    sudo apt update && sudo apt install -y openjdk-17-jdk

    # Add the Jenkins repository
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update and install Jenkins
    sudo apt update
    sudo apt install -y jenkins

    # Start and enable Jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    echo "Jenkins installation completed successfully!"
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."

    # Update and install Docker
    sudo apt update
    sudo apt install -y docker.io
    sudo apt install -y docker-compose

    echo "Docker installation completed successfully!"
}

# Run installation functions
install_node
install_php
install_jenkins
install_docker
