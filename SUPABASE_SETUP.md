# Supabase Setup for InvoiceFlow Waitlist

This guide will help you set up Supabase database integration for the InvoiceFlow waitlist feature.

## 1. Create a Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in to your account
3. Click "New Project"
4. Choose your organization
5. Enter project details:
   - Name: `invoiceflow-waitlist`
   - Database Password: (choose a strong password)
   - Region: (choose closest to your users)
6. Click "Create new project"

## 2. Get Your Project Credentials

1. Go to your project dashboard
2. Navigate to **Settings** > **API**
3. Copy the following values:
   - **Project URL** (starts with `https://`)
   - **anon/public key** (starts with `eyJ`)

## 3. Configure Environment Variables

1. Open the `.env` file in your project root
2. Replace the placeholder values:
   ```env
   PUBLIC_SUPABASE_URL=https://your-actual-project-id.supabase.co
   PUBLIC_SUPABASE_ANON_KEY=your-actual-anon-key-here
   ```

## 4. Create the Waitlist Table

1. In your Supabase dashboard, go to **SQL Editor**
2. Click "New Query"
3. Copy and paste the following SQL:

```sql
-- Create waitlist table
CREATE TABLE waitlist (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  founder_member BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX idx_waitlist_email ON waitlist(email);
CREATE INDEX idx_waitlist_founder_member ON waitlist(founder_member);
CREATE INDEX idx_waitlist_created_at ON waitlist(created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Create policy to allow public inserts (for waitlist signup)
CREATE POLICY "Allow public inserts" ON waitlist
  FOR INSERT
  WITH CHECK (true);

-- Create policy to allow public reads (for counter)
CREATE POLICY "Allow public reads" ON waitlist
  FOR SELECT
  USING (true);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_waitlist_updated_at
  BEFORE UPDATE ON waitlist
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
```

**Note**: The `founder_member` field is now automatically set to `true` for the first 50 entries and `false` for subsequent entries. The waitlist will close after 50 entries.

4. Click "Run" to execute the SQL

## 5. Verify Setup

1. Start your development server:
   ```bash
   npm run dev
   ```

2. Open your browser and go to `http://localhost:4321`

3. Try submitting the waitlist form with a test email

4. Check your Supabase dashboard:
   - Go to **Table Editor**
   - Select the `waitlist` table
   - You should see your test entry

## 6. Monitor Your Waitlist

You can monitor your waitlist directly in Supabase:

1. Go to **Table Editor** > `waitlist`
2. View all signups, filter by founder members, etc.
3. Export data as CSV if needed

### Useful Queries

```sql
-- Get total waitlist count
SELECT COUNT(*) FROM waitlist;

-- Get founder member count
SELECT COUNT(*) FROM waitlist WHERE founder_member = true;

-- Get recent signups
SELECT * FROM waitlist ORDER BY created_at DESC LIMIT 10;

-- Get daily signup stats
SELECT 
  DATE(created_at) as signup_date,
  COUNT(*) as total_signups,
  COUNT(*) FILTER (WHERE founder_member = true) as founder_signups
FROM waitlist 
GROUP BY DATE(created_at) 
ORDER BY signup_date DESC;
```

## Security Notes

- The anon key is safe to use in client-side code
- Row Level Security (RLS) is enabled to protect your data
- Only INSERT and SELECT operations are allowed from the client
- Never expose your service role key in client-side code

## Troubleshooting

### "Missing Supabase environment variables" Error
- Make sure your `.env` file has the correct variable names
- Restart your development server after updating `.env`
- Check that there are no extra spaces in your environment variables

### "Failed to add to waitlist" Error
- Check your Supabase project is active
- Verify your credentials are correct
- Check the browser console for detailed error messages
- Ensure the waitlist table exists and has the correct schema

### Live Counter Not Updating
- Check that the `/api/waitlist-count` endpoint is working
- Verify your Supabase credentials
- Check browser network tab for API errors

For more help, check the [Supabase Documentation](https://supabase.com/docs) or create an issue in this repository.