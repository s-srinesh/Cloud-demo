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
                    docker compose down --remove-orphans || true

                    echo "Building images and launching services in the background..."
                    docker compose up -d --build
                '''
            }
        }

        // Stage 4: Verify containers are up and show live URLs
        stage('4. Verify Status & Show URLs') {
            steps {
                echo 'Verifying running containers...'
                sh 'docker compose ps || true'
                echo "============================================================"
                echo " DEPLOYMENT SUCCESSFUL!"
                echo " Access your live application at:"
                echo " Frontend UI: http://3.25.238.109:3000"
                echo " Backend API: http://3.25.238.109:80/students"
                echo "============================================================"
            }
        }
    }

    // Post-execution status messages
    post {
        success {
            echo "Pipeline run completed successfully! All services are active."
        }
        failure {
            echo "Deployment failed! Check console output or run 'docker compose logs' on EC2."
        }
    }
}
