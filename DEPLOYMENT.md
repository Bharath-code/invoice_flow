# InvoiceFlow Deployment Guide

## Vercel Deployment

This guide covers deploying InvoiceFlow to Vercel with optimal performance and security configurations.

### Prerequisites

1. **Vercel Account**: Sign up at [vercel.com](https://vercel.com)
2. **Vercel CLI**: Install globally with `npm i -g vercel`
3. **Environment Variables**: Prepare your production environment variables

### Quick Deployment

#### Option 1: Deploy with Vercel CLI

```bash
# Install dependencies
npm install

# Login to Vercel
vercel login

# Deploy to preview
npm run deploy:preview

# Deploy to production
npm run deploy
```

#### Option 2: Deploy via Git Integration

1. Push your code to GitHub/GitLab/Bitbucket
2. Connect your repository to Vercel
3. Vercel will automatically deploy on every push

### Environment Variables Setup

Configure these environment variables in your Vercel dashboard:

#### Required Variables
```bash
# Supabase Configuration
PUBLIC_SUPABASE_URL=your_production_supabase_url
PUBLIC_SUPABASE_ANON_KEY=your_production_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_production_service_role_key

# Application
NODE_ENV=production
PUBLIC_SITE_URL=https://your-domain.vercel.app
```

#### Optional Variables
```bash
# Analytics & Monitoring
VERCEL_ANALYTICS_ID=your_vercel_analytics_id
PUBLIC_ENABLE_ANALYTICS=true
PUBLIC_ENABLE_PERFORMANCE_MONITORING=true

# Security
PUBLIC_ENABLE_CSP=true
PUBLIC_ENABLE_SECURITY_HEADERS=true

# Features
PUBLIC_ENABLE_SERVICE_WORKER=true
PUBLIC_ENABLE_PWA=true
```

### Domain Configuration

1. **Custom Domain**: Add your custom domain in Vercel dashboard
2. **SSL**: Automatic SSL certificates via Let's Encrypt
3. **DNS**: Configure your DNS to point to Vercel

### Performance Optimizations

The deployment includes several performance optimizations:

#### Caching Strategy
- **Static Assets**: 1 year cache with immutable headers
- **Service Worker**: No cache to ensure updates
- **API Routes**: CORS headers for cross-origin requests

#### Security Headers
- Content Security Policy (CSP)
- X-Frame-Options: DENY
- X-Content-Type-Options: nosniff
- Referrer Policy: strict-origin-when-cross-origin

#### Build Optimizations
- CSS and JavaScript compression
- Image optimization with WebP/AVIF support
- Code splitting and tree shaking
- Service Worker for offline functionality

### Monitoring & Analytics

#### Vercel Analytics
- **Web Vitals**: Core Web Vitals monitoring
- **Real User Metrics**: Performance data from actual users
- **Speed Insights**: Detailed performance analysis

#### Custom Analytics
- Performance monitoring via Web Vitals API
- Error tracking and reporting
- User interaction analytics

### Troubleshooting

#### Common Issues

1. **Build Failures**
   ```bash
   # Check build logs
   vercel logs your-deployment-url
   
   # Test build locally
   npm run build
   ```

2. **Environment Variables**
   ```bash
   # Verify environment variables
   vercel env ls
   
   # Add missing variables
   vercel env add VARIABLE_NAME
   ```

3. **Function Timeouts**
   - Serverless functions have a 10s timeout on Hobby plan
   - Optimize API routes for faster response times
   - Consider upgrading to Pro plan for 60s timeout

#### Performance Issues

1. **Slow Loading**
   - Check Vercel Speed Insights
   - Optimize images and assets
   - Review Core Web Vitals metrics

2. **High Bundle Size**
   ```bash
   # Analyze bundle
   npm run build
   npx astro build --analyze
   ```

### Deployment Checklist

- [ ] Environment variables configured
- [ ] Custom domain added (if applicable)
- [ ] SSL certificate active
- [ ] Analytics enabled
- [ ] Performance monitoring active
- [ ] Error tracking configured
- [ ] Service worker functioning
- [ ] PWA features working
- [ ] Core Web Vitals optimized
- [ ] Security headers active

### Advanced Configuration

#### Custom Build Command
```json
{
  "buildCommand": "npm run build && npm run optimize"
}
```

#### Function Configuration
```json
{
  "functions": {
    "src/pages/api/**/*.ts": {
      "runtime": "nodejs18.x",
      "maxDuration": 10
    }
  }
}
```

#### Edge Functions
For ultra-fast response times, consider migrating API routes to Edge Functions:

```typescript
// src/pages/api/edge-example.ts
export const config = {
  runtime: 'edge'
};
```

### Support

For deployment issues:
1. Check [Vercel Documentation](https://vercel.com/docs)
2. Review [Astro Vercel Guide](https://docs.astro.build/en/guides/deploy/vercel/)
3. Contact support via Vercel dashboard

### Production Checklist

Before going live:
- [ ] Test all functionality in preview deployment
- [ ] Verify environment variables
- [ ] Check performance metrics
- [ ] Test mobile responsiveness
- [ ] Validate SEO meta tags
- [ ] Confirm analytics tracking
- [ ] Test form submissions
- [ ] Verify API endpoints
- [ ] Check error handling
- [ ] Test offline functionality