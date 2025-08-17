# Modern DevOps Pipeline with Laravel 11

A comprehensive DevOps pipeline for deploying Laravel applications using modern tools and best practices.

## 🚀 Technology Stack

### Backend
- **Laravel 11.x** - Latest PHP framework
- **PHP 8.2** - Latest stable PHP version
- **MySQL 8.0** - Latest stable database
- **Apache 2.4** - Web server

### Frontend
- **Vite 5.0** - Modern build tool (replaces Laravel Mix)
- **Tailwind CSS 3.4** - Utility-first CSS framework (replaces Bootstrap)
- **Alpine.js 3.13** - Lightweight JavaScript framework (replaces Vue.js)
- **Node.js 20.x** - Latest LTS version

### DevOps Tools
- **Docker & Docker Compose** - Containerization
- **Ansible** - Configuration management
- **Terraform** - Infrastructure as Code
- **Jenkins** - CI/CD pipeline
- **AWS** - Cloud infrastructure

## 📋 Prerequisites

- Docker and Docker Compose
- Node.js 20.x and npm
- PHP 8.2+
- Composer
- Git

## 🛠️ Local Development Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd DevOps-Pipeline-PHP/laravel-app
```

### 2. Install Dependencies
```bash
# Install PHP dependencies
composer install

# Install Node.js dependencies
npm install
```

### 3. Environment Configuration
```bash
# Copy environment file
cp env.example .env

# Generate application key
php artisan key:generate
```

### 4. Build Assets
```bash
# Development
npm run dev

# Production
npm run build
```

### 5. Run Database Migrations
```bash
php artisan migrate
```

### 6. Start Development Server
```bash
php artisan serve
```

## 🐳 Docker Deployment

### Using Docker Compose
```bash
# Build and start all services
docker-compose up -d --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Services Available
- **Laravel App**: http://localhost:5000
- **phpMyAdmin**: http://localhost:4000
- **MySQL Database**: localhost:3306

## ☁️ AWS Deployment

### 1. Infrastructure Setup with Terraform

```bash
cd terraform

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply infrastructure
terraform apply -auto-approve
```

### 2. Connect to EC2 Instance
```bash
# Use the generated key file
ssh -i mykey.pem ubuntu@<EC2_PUBLIC_IP>
```

### 3. Install DevOps Tools
```bash
# Make script executable
chmod +x install.sh

# Run installation
./install.sh
```

### 4. Jenkins Setup
1. Access Jenkins: http://<EC2_PUBLIC_IP>:8080
2. Get initial password: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
3. Install suggested plugins
4. Create admin user
5. Configure Jenkins URL

### 5. Create Jenkins Pipeline
1. Create new Pipeline job
2. Configure Git repository
3. Use the provided Jenkinsfile
4. Add Docker Hub credentials

## 🔧 Configuration Files

### Environment Variables
Key environment variables for production:

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.com

DB_HOST=db
DB_DATABASE=laravel-db
DB_USERNAME=laravel
DB_PASSWORD=secure_password

CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

### Docker Configuration
- **Dockerfile**: Multi-stage build with PHP 8.2 and Apache
- **docker-compose.yml**: Services for app, database, and phpMyAdmin
- **vhost.conf**: Apache virtual host configuration

### Terraform Configuration
- **main.tf**: EC2 instance, VPC, and networking
- **security.tf**: Security groups and key pairs
- **variables.tf**: Configurable parameters
- **outputs.tf**: Useful output values

## 🔒 Security Best Practices

### Implemented Security Measures
- ✅ Latest PHP 8.2 with security patches
- ✅ MySQL 8.0 with improved security
- ✅ Encrypted EBS volumes
- ✅ Security groups with minimal required ports
- ✅ Environment variable management
- ✅ HTTPS support in security groups
- ✅ Latest Docker images with security updates

### Additional Recommendations
- Use AWS Secrets Manager for sensitive data
- Implement WAF for web application protection
- Set up CloudTrail for audit logging
- Use AWS Certificate Manager for SSL/TLS
- Implement proper IAM roles and policies

## 📊 Performance Optimizations

### Laravel Optimizations
- OPcache enabled in PHP
- Composer autoloader optimization
- Laravel route caching
- Configuration caching
- View caching

### Docker Optimizations
- Multi-stage builds
- Layer caching
- Health checks
- Resource limits
- Volume persistence

### AWS Optimizations
- GP3 EBS volumes for better performance
- T3 instances with burst capability
- VPC with optimized routing
- Security groups with minimal rules

## 🚨 Troubleshooting

### Common Issues

1. **Composer Memory Limit**
   ```bash
   COMPOSER_MEMORY_LIMIT=-1 composer install
   ```

2. **Docker Permission Issues**
   ```bash
   sudo chmod 666 /var/run/docker.sock
   ```

3. **Database Connection Issues**
   - Check environment variables
   - Verify MySQL service is running
   - Check security group rules

4. **Asset Build Issues**
   ```bash
   npm cache clean --force
   rm -rf node_modules package-lock.json
   npm install
   ```

### Logs and Debugging
```bash
# Laravel logs
tail -f storage/logs/laravel.log

# Docker logs
docker-compose logs -f

# Jenkins logs
sudo tail -f /var/log/jenkins/jenkins.log
```

## 📈 Monitoring and Maintenance

### Health Checks
- Docker health checks for all services
- Laravel application health endpoints
- Database connectivity monitoring
- Jenkins pipeline monitoring

### Backup Strategy
- Database backups with mysqldump
- Application code version control
- Docker image versioning
- Terraform state management

### Updates and Maintenance
- Regular security updates
- Dependency updates via Dependabot
- Infrastructure updates via Terraform
- Application updates via CI/CD pipeline

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review Laravel and Docker documentation

---

**Note**: This is a production-ready DevOps pipeline with modern best practices. Always test in a staging environment before deploying to production.
