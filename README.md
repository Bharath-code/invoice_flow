# InvoiceFlow Landing Page 🚀

A high-performance, SEO-optimized landing page for InvoiceFlow - the AI-powered invoice automation platform that transforms manual invoice processing into streamlined workflows.

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/your-username/invoice-flow)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Astro](https://img.shields.io/badge/Built%20with-Astro-ff5d01)](https://astro.build)

> 🚀 **Ready to Deploy?** Check out our [Vercel Deployment Summary](./VERCEL_DEPLOYMENT_SUMMARY.md) for a complete deployment guide!

## ✨ Features

- **🎯 High-Converting Design**: Modern, professional landing page optimized for conversions
- **⚡ Lightning Fast**: Built with Astro for optimal performance (90+ Lighthouse scores)
- **📱 Fully Responsive**: Mobile-first design that works on all devices
- **🔍 SEO Optimized**: Comprehensive meta tags, structured data, and sitemap
- **📊 Analytics Ready**: Vercel Analytics and Speed Insights integration
- **🎨 Interactive Components**: Smooth animations and micro-interactions
- **📧 Waitlist Integration**: Supabase-powered email collection system
- **🚀 Production Ready**: Optimized for Vercel deployment

## 🛠️ Tech Stack

- **Framework**: [Astro](https://astro.build) - Static site generator with islands architecture
- **Styling**: [TailwindCSS](https://tailwindcss.com) - Utility-first CSS framework
- **Components**: [Svelte](https://svelte.dev) - Reactive UI components
- **Database**: [Supabase](https://supabase.com) - Backend-as-a-Service for waitlist
- **Deployment**: [Vercel](https://vercel.com) - Edge-optimized hosting
- **Analytics**: Vercel Analytics & Speed Insights
- **Language**: TypeScript for type safety

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ installed
- npm or yarn package manager
- Supabase account (for waitlist functionality)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/invoice-flow.git
   cd invoice-flow
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Configure your `.env` file with your Supabase credentials:
   ```bash
   # Supabase Configuration (Required for waitlist functionality)
   PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
   PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here
   ```
   
   📋 **Need help with Supabase setup?** See our detailed guide: [SUPABASE_ENV_SETUP.md](./SUPABASE_ENV_SETUP.md)
   
   ⚠️ **Note**: The app will run without Supabase configured, but waitlist functionality will be disabled.

4. **Start development server**
   ```bash
   npm run dev
   ```
   
   Open [http://localhost:4321](http://localhost:4321) in your browser.

## 📁 Project Structure

```text
/
├── public/                 # Static assets
│   ├── favicon.ico
│   ├── robots.txt
│   └── sitemap.xml
├── src/
│   ├── components/         # Reusable UI components
│   │   ├── HeroSection.astro
│   │   ├── WaitlistForm.svelte
│   │   ├── FeatureCard.astro
│   │   └── ...
│   ├── layouts/           # Page layouts
│   │   └── Layout.astro
│   ├── lib/              # Utility functions
│   │   └── supabase.ts
│   ├── pages/            # Route pages
│   │   ├── index.astro
│   │   └── api/
│   └── styles/           # Global styles
│       └── global.css
├── scripts/              # Deployment scripts
│   └── deploy.sh
├── .env.example          # Environment variables template
├── astro.config.mjs      # Astro configuration
├── tailwind.config.js    # TailwindCSS configuration
├── vercel.json          # Vercel deployment config
└── package.json
```

## 🧞 Available Commands

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Install dependencies                             |
| `npm run dev`             | Start local dev server at `localhost:4321`      |
| `npm run build`           | Build production site to `./dist/`              |
| `npm run preview`         | Preview build locally before deploying          |
| `npm run deploy`          | Deploy to production (Vercel)                   |
| `npm run deploy:preview`  | Deploy to preview environment                   |
| `npm run astro ...`       | Run Astro CLI commands                          |
| `npm run astro check`     | Check for TypeScript and accessibility issues   |

## 🚀 Deployment

### Deploy to Vercel (Recommended)

1. **Using Vercel CLI**
   ```bash
   # Install Vercel CLI
   npm i -g vercel
   
   # Login and deploy
   vercel login
   ./scripts/deploy.sh production
   ```

2. **Using Git Integration**
   - Push your code to GitHub
   - Connect repository to Vercel
   - Configure environment variables
   - Deploy automatically on push

### Environment Variables for Production

Configure these in your Vercel dashboard:

```bash
# Required
PUBLIC_SUPABASE_URL=your_production_supabase_url
PUBLIC_SUPABASE_ANON_KEY=your_production_supabase_anon_key

# Optional
SITE_URL=https://yourdomain.com
CONTACT_EMAIL=hello@yourdomain.com
ENABLE_ANALYTICS=true
```

For detailed deployment instructions, see [DEPLOYMENT.md](./DEPLOYMENT.md).

## 🎨 Customization

### Brand Colors
Update brand colors in `tailwind.config.js`:

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          500: '#3b82f6',
          900: '#1e3a8a',
        }
      }
    }
  }
}
```

### Content
Update content in the respective component files:
- Hero section: `src/components/HeroSection.astro`
- Features: `src/components/FeatureCard.astro`
- Pricing: `src/components/PricingSection.astro`

### SEO
Update SEO settings in `src/layouts/Layout.astro`:

```astro
---
const seo = {
  title: "Your App Name",
  description: "Your app description",
  keywords: "your, keywords, here"
};
---
```

## 📊 Performance

This landing page is optimized for performance:

- **Lighthouse Score**: 95+ across all metrics
- **Core Web Vitals**: Optimized LCP, CLS, and INP
- **Bundle Size**: < 50KB JavaScript
- **Image Optimization**: WebP/AVIF with lazy loading
- **Caching**: Optimal cache headers for static assets

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow TypeScript best practices
- Use TailwindCSS for styling
- Ensure components are accessible (WCAG 2.1)
- Test on multiple devices and browsers
- Maintain 90+ Lighthouse scores

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: [Astro Docs](https://docs.astro.build)
- **Deployment**: [Vercel Docs](https://vercel.com/docs)
- **Database**: [Supabase Docs](https://supabase.com/docs)
- **Issues**: [GitHub Issues](https://github.com/your-username/invoice-flow/issues)

## 🙏 Acknowledgments

- Built with [Astro](https://astro.build)
- Styled with [TailwindCSS](https://tailwindcss.com)
- Deployed on [Vercel](https://vercel.com)
- Database by [Supabase](https://supabase.com)

---

**Made with ❤️ for the InvoiceFlow community**
