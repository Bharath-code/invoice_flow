#!/bin/bash

# Vercel Deployment Script
# This script handles the deployment process for the InvoiceFlow landing page

set -e  # Exit on any error

echo "🚀 Starting InvoiceFlow deployment process..."

# Check if we're in the correct directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this script from the project root."
    exit 1
fi

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Vercel CLI not found. Installing..."
    npm install -g vercel
fi

# Environment setup
echo "🔧 Setting up environment..."

# Check for required environment variables
if [ -z "$VERCEL_TOKEN" ] && [ ! -f ".vercel/project.json" ]; then
    echo "⚠️  Warning: VERCEL_TOKEN not set and no existing Vercel project found."
    echo "   You may need to run 'vercel login' first."
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm ci

# Run build to check for errors
echo "🔨 Building project..."
npm run build

# Deploy based on argument
if [ "$1" = "production" ] || [ "$1" = "prod" ]; then
    echo "🌟 Deploying to production..."
    vercel --prod
else
    echo "🔍 Deploying preview..."
    vercel
fi

echo "✅ Deployment complete!"
echo "📊 Check your deployment at: https://vercel.com/dashboard"