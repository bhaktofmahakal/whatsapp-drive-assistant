#!/bin/bash

# Setup script for WhatsApp-Drive Assistant n8n workflow

echo "🚀 Setting up WhatsApp-Drive Assistant..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p workflows
mkdir -p credentials
mkdir -p logs

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Copying from .env.sample..."
    cp .env.sample .env
    echo "🔧 Please edit .env file with your actual credentials"
fi

# Start n8n with Docker Compose
echo "🐳 Starting n8n with Docker Compose..."
docker-compose up -d

# Wait for n8n to be ready
echo "⏳ Waiting for n8n to be ready..."
sleep 30

# Check if n8n is running
if curl -s http://localhost:5678/healthz > /dev/null; then
    echo "✅ n8n is running successfully!"
    echo "🌐 Access n8n at: http://localhost:5678"
    echo "👤 Username: admin"
    echo "🔑 Password: admin123"
    echo ""
    echo "📋 Next steps:"
    echo "1. Open http://localhost:5678 in your browser"
    echo "2. Login with admin/admin123"
    echo "3. Import the workflow.json file"
    echo "4. Configure your credentials (Twilio, Google Drive, Gemini)"
else
    echo "❌ n8n failed to start. Check the logs:"
    docker-compose logs n8n
fi