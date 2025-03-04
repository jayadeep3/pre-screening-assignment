pipeline {
    agent any

    environment {
        PROJECT_DIR = "$WORKSPACE/assignment"
        NETWORK_NAME = "backend_assignment"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    sh '''
                    echo "Cleaning workspace..."
                    rm -rf assignment
                    echo "Cloning specific branch..."
                    git clone --branch assignment --single-branch https://github.com/jayadeep3/pre-screening-assignment.git assignment
                    echo "Verifying cloned repository structure..."
                    ls -lR assignment  # List all files for debugging
                    '''
                }
            }
        }

        stage('Create Network and Start Database') {
            steps {
                script {
                    sh '''

                    echo "Navigating to backend directory..."
                    cd ${PROJECT_DIR}/assignment/backend || { echo "Backend directory not found!"; exit 1; }

                    echo "Starting PostgreSQL using Docker Compose..."
                    docker-compose up -d
                    '''
                }
            }
        }

        stage('Build and Run Backend') {
            steps {
                script {
                    sh '''
                    echo "Navigating to backend directory..."
                    cd ${PROJECT_DIR}/assignment/backend

                    echo "Building backend Docker image..."
                    docker build -t backend-app .

                    echo "Running backend container..."
                    docker run -itd --name backend --network=${NETWORK_NAME} -p 8000:8080 backend-app:latest
                    '''
                }
            }
        }

        stage('Build and Run Frontend') {
            steps {
                script {
                    sh '''
                    echo "Navigating to frontend directory..."
                    cd ${PROJECT_DIR}/assignment/frontend

                    echo "Building frontend Docker image..."
                    docker build -t frontend-app .

                    echo "Running frontend container..."
                    docker run -itd --name frontend --network=${NETWORK_NAME} -p 3000:3000 frontend-app:latest
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh '''
                    echo "Checking running Docker containers..."
                    docker ps
                    '''
                }
            }
        }
    }

    post {
        always {
            echo "Deployment process completed."
        }
        failure {
            echo "Deployment failed!"
        }
    }
}

