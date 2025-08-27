# Supabase Environment Variables Setup Guide

This guide will help you properly configure Supabase environment variables for the InvoiceFlow waitlist functionality.

## Current Status

If you're seeing console warnings like:
- `Supabase not configured. Waitlist functionality will be disabled.`
- `Supabase not configured - returning default count`

This means your Supabase environment variables are not properly configured.

## Quick Fix

### Step 1: Check Your `.env` File

Open your `.env` file in the project root and verify it contains:

```bash
# Supabase Configuration
PUBLIC_SUPABASE_URL=your_supabase_url_here
PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here
```

### Step 2: Get Your Supabase Credentials

1. **Create a Supabase Project** (if you haven't already):
   - Go to [https://supabase.com](https://supabase.com)
   - Sign up/login and create a new project
   - Wait for the project to be ready (2-3 minutes)

2. **Get Your Credentials**:
   - In your Supabase dashboard, go to **Settings** → **API**
   - Copy the **Project URL** (starts with `https://`)
   - Copy the **anon/public key** (starts with `eyJ`)

### Step 3: Update Your `.env` File

Replace the placeholder values in your `.env` file:

```bash
# Replace these with your actual values
PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Step 4: Create the Database Table

1. In your Supabase dashboard, go to **SQL Editor**
2. Run this SQL to create the waitlist table:

```sql
-- Create waitlist table
CREATE TABLE waitlist (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  founder_member BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_waitlist_email ON waitlist(email);
CREATE INDEX idx_waitlist_founder_member ON waitlist(founder_member);
CREATE INDEX idx_waitlist_created_at ON waitlist(created_at);

-- Enable Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Allow public inserts (for waitlist signup)
CREATE POLICY "Allow public inserts" ON waitlist
  FOR INSERT
  WITH CHECK (true);

-- Allow public reads (for counter)
CREATE POLICY "Allow public reads" ON waitlist
  FOR SELECT
  USING (true);
```

### Step 5: Restart Your Development Server

```bash
# Stop the current server (Ctrl+C)
# Then restart
npm run dev
```

## Verification

After completing the setup:

1. **No More Warnings**: You shouldn't see Supabase configuration warnings in the console
2. **Waitlist Works**: The waitlist form should accept email submissions
3. **Counter Updates**: The live counter should show actual signup numbers

## Troubleshooting

### Still Seeing Warnings?

1. **Check Environment Variable Names**: Must be exactly `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY`
2. **No Extra Spaces**: Make sure there are no spaces around the `=` sign
3. **Restart Required**: Always restart the dev server after changing `.env`
4. **Valid URL**: Supabase URL must start with `https://`

### Example of Correct `.env` Format:

```bash
PUBLIC_SUPABASE_URL=https://abcdefghijklmnop.supabase.co
PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG1ub3AiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNjU0ODAwMCwiZXhwIjoxOTUyMTI0MDAwfQ.example-signature
```

### Common Mistakes:

❌ **Wrong**: `PUBLIC_SUPABASE_URL = https://...` (extra spaces)
❌ **Wrong**: `SUPABASE_URL=https://...` (missing PUBLIC_ prefix)
❌ **Wrong**: `PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here` (placeholder not replaced)

✅ **Correct**: `PUBLIC_SUPABASE_URL=https://your-project.supabase.co`
✅ **Correct**: `PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIs...`

## Need Help?

If you're still having issues:

1. Check the [Supabase Documentation](https://supabase.com/docs)
2. Verify your project is active in the Supabase dashboard
3. Make sure you've created the waitlist table using the SQL above
4. Check the browser console for any additional error messages

## Development vs Production

- **Development**: Use your development Supabase project credentials
- **Production**: Use separate production Supabase project credentials
- **Never**: Commit real credentials to version control

The application is designed to work gracefully without Supabase (showing warnings but not crashing), so you can develop other features while setting up the database.