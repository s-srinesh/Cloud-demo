pipeline {
    agent any

    environment {
        APP_NAME = 'student-management-system'
    }

    stages {
        // Stage 1: Pull the latest code from GitHub repository
        stage('1. Code Checkout') {
            steps {
                echo 'Pulling latest code from GitHub...'
                checkout scm
            }
        }

        // Stage 2: Validate JavaScript syntax before building
        stage('2. Syntax Validation') {
            steps {
                echo 'Validating backend JavaScript syntax...'
                sh '''
                    if command -v node > /dev/null 2>&1; then
                        node -c index.js
                        node -c database/studentDB.js
                        node -c routes/studentRoutes.js
                        node -c controllers/studentController.js
                        echo "Backend JavaScript syntax verified successfully."
                    else
                        echo "Node.js not installed on host, skipping local check and proceeding to Docker build."
                    fi
                '''
            }
        }

        // Stage 3: Build Docker images and run containers with Docker Compose
        stage('3. Build & Deploy Containers') {
            steps {
                echo 'Building and deploying MongoDB, Backend, and Frontend containers...'
                sh '''
                    echo "Stopping old containers if any..."
                    docker compose down --remove-orphans || docker-compose down --remove-orphans || true

                    echo "Building images and launching services in the background..."
                    docker compose up -d --build || docker-compose up -d --build
                '''
            }
        }

        // Stage 4: Check if containers are up and running
        stage('4. Verify Running Containers') {
            steps {
                echo 'Verifying running containers status...'
                sh 'docker compose ps || docker-compose ps'
            }
        }
    }

    // Post-execution notifications and cleanup
    post {
        always {
            echo "Pipeline run completed. Cleaning up dangling Docker images..."
            sh 'docker image prune -f || true'
        }
        success {
            script {
                def publicIp = sh(script: "curl -s http://checkip.amazonaws.com || curl -s ifconfig.me || echo 'localhost'", returnStdout: true).trim()
                echo "============================================================"
                echo " DEPLOYMENT SUCCESSFUL!"
                echo " Access your live application at:"
                echo " Frontend UI: http://${publicIp}:3000"
                echo " Backend API: http://${publicIp}:80/students"
                echo "============================================================"
            }
        }
        failure {
            echo "Deployment failed! Check the console output or run 'docker compose logs' on EC2."
        }
    }
}
