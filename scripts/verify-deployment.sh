#!/bin/bash

# Vercel Deployment Verification Script
# This script verifies that the project is ready for Vercel deployment

set -e

echo "🔍 Verifying InvoiceFlow deployment readiness..."

# Check if we're in the correct directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this script from the project root."
    exit 1
fi

# Check required files
echo "📋 Checking required files..."
required_files=("vercel.json" "astro.config.mjs" ".env.example" "src/layouts/Layout.astro")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file found"
    else
        echo "❌ $file missing"
        exit 1
    fi
done

# Check dependencies
echo "📦 Checking dependencies..."
if npm list @astrojs/vercel > /dev/null 2>&1; then
    echo "✅ @astrojs/vercel installed"
else
    echo "❌ @astrojs/vercel not installed"
    echo "   Run: npm install @astrojs/vercel"
    exit 1
fi

if npm list @vercel/analytics > /dev/null 2>&1; then
    echo "✅ @vercel/analytics installed"
else
    echo "❌ @vercel/analytics not installed"
    echo "   Run: npm install @vercel/analytics"
    exit 1
fi

# Test build
echo "🔨 Testing build process..."
if npm run build > /dev/null 2>&1; then
    echo "✅ Build successful"
else
    echo "❌ Build failed"
    echo "   Run: npm run build"
    exit 1
fi

# Check environment variables
echo "🔧 Checking environment configuration..."
if [ -f ".env" ]; then
    echo "✅ .env file found"
    if grep -q "PUBLIC_SUPABASE_URL" .env; then
        echo "✅ Supabase URL configured"
    else
        echo "⚠️  Supabase URL not configured (waitlist will be disabled)"
    fi
else
    echo "⚠️  .env file not found (using defaults)"
fi

# Check Vercel configuration
echo "⚙️  Checking Vercel configuration..."
if [ -f "vercel.json" ]; then
    echo "✅ vercel.json configured"
else
    echo "❌ vercel.json missing"
    exit 1
fi

echo ""
echo "🎉 Deployment verification complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Install Vercel CLI: npm i -g vercel"
echo "   2. Login to Vercel: vercel login"
echo "   3. Deploy preview: ./scripts/deploy.sh"
echo "   4. Deploy production: ./scripts/deploy.sh production"
echo ""
echo "🔗 Useful links:"
echo "   • Vercel Dashboard: https://vercel.com/dashboard"
echo "   • Deployment Guide: ./DEPLOYMENT.md"
echo "   • Supabase Setup: ./SUPABASE_ENV_SETUP.md"
echo ""