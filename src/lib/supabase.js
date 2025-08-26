import { createClient } from '@supabase/supabase-js'

// Supabase configuration
const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Waitlist functions
export async function addToWaitlist(email, isFounderMember = false) {
  try {
    const { data, error } = await supabase
      .from('waitlist')
      .insert([
        {
          email: email,
          founder_member: isFounderMember,
          created_at: new Date().toISOString()
        }
      ])
      .select()

    if (error) {
      console.error('Error adding to waitlist:', error)
      return { success: false, error: error.message }
    }

    return { success: true, data }
  } catch (err) {
    console.error('Unexpected error:', err)
    return { success: false, error: 'An unexpected error occurred' }
  }
}

export async function getWaitlistCount() {
  try {
    const { count, error } = await supabase
      .from('waitlist')
      .select('*', { count: 'exact', head: true })

    if (error) {
      console.error('Error getting waitlist count:', error)
      return { success: false, error: error.message, count: 0 }
    }

    return { success: true, count: count || 0 }
  } catch (err) {
    console.error('Unexpected error:', err)
    return { success: false, error: 'An unexpected error occurred', count: 0 }
  }
}

export async function getFounderMemberCount() {
  try {
    const { count, error } = await supabase
      .from('waitlist')
      .select('*', { count: 'exact', head: true })
      .eq('founder_member', true)

    if (error) {
      console.error('Error getting founder member count:', error)
      return { success: false, error: error.message, count: 0 }
    }

    return { success: true, count: count || 0 }
  } catch (err) {
    console.error('Unexpected error:', err)
    return { success: false, error: 'An unexpected error occurred', count: 0 }
  }
}