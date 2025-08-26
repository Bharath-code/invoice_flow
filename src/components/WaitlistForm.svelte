<script>
  let email = '';
  let isSubmitting = false;
  let message = '';
  let messageType = '';
  let waitlistClosed = false;
  
  async function checkWaitlistStatus() {
    try {
      const response = await fetch('/api/waitlist-count');
      if (response.ok) {
        const data = await response.json();
        const currentCount = data.count || 0;
        
        if (currentCount >= 50) {
          waitlistClosed = true;
        }
      } else {
        // API not available (likely Supabase not configured)
        console.log('Waitlist status check unavailable - Supabase not configured');
      }
    } catch (error) {
      // Expected when Supabase is not configured
      console.log('Waitlist status check unavailable - Supabase not configured');
    }
  }

  async function handleSubmit() {
    if (waitlistClosed) {
      message = 'Waitlist is now closed. We\'re building the app!';
      messageType = 'info';
      return;
    }

    if (!email || !email.includes('@')) {
      message = 'Please enter a valid email address';
      messageType = 'error';
      return;
    }

    isSubmitting = true;
    message = '';

    try {
      const response = await fetch('/api/waitlist', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 
          email: email.trim()
        }),
      });

      const data = await response.json();

      if (response.ok) {
        if (data.isFounder) {
          message = 'Congratulations! You\'re one of our founding members. We\'ll be in touch soon!';
        } else {
          message = 'Thanks! You\'re on the waitlist. We\'ll be in touch soon!';
        }
        messageType = 'success';
        email = '';
        
        // Check if we've reached 50 entries
        if (data.totalCount >= 50) {
          waitlistClosed = true;
        }
      } else {
        message = data.error || 'Something went wrong. Please try again.';
        messageType = 'error';
      }
    } catch (error) {
      console.error('Error:', error);
      message = 'Network error. Please check your connection and try again.';
      messageType = 'error';
    } finally {
      isSubmitting = false;
    }
  }
  
  // Check waitlist status when component becomes interactive
  function handleFormFocus() {
    checkWaitlistStatus();
  }
</script>

<div class="bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl p-8 mt-8 waitlist-form">
  <h3 class="text-xl font-semibold mb-6 text-center text-white">
    👉 Join the Waitlist – Founding Members Get $9/mo Forever.
  </h3>
  
  {#if waitlistClosed}
    <div class="text-center p-8 bg-gradient-to-r from-emerald-50/10 to-blue-50/10 rounded-xl border border-emerald-200/20">
      <div class="text-4xl mb-4">🚀</div>
      <h3 class="text-2xl font-bold text-white mb-2">Waitlist Closed!</h3>
      <p class="text-white/80 leading-relaxed">
        We've reached our initial 50 founding members and are now building the app. 
        Follow us for updates on the launch!
      </p>
    </div>
  {:else}
    <form on:submit|preventDefault={handleSubmit} class="flex flex-col gap-4">
      {#if message}
        {#if messageType === 'error'}
          <div class="flex items-center gap-3 p-4 rounded-xl text-white border bg-red-500/20 border-red-500/30">
            <span class="text-lg">⚠️</span>
            <span>{message}</span>
          </div>
        {:else if messageType === 'success'}
          <div class="flex items-center gap-3 p-4 rounded-xl text-white border bg-green-500/20 border-green-500/30">
            <span class="text-lg">✅</span>
            <span>{message}</span>
          </div>
        {:else}
          <div class="flex items-center gap-3 p-4 rounded-xl text-white border bg-blue-500/20 border-blue-500/30">
            <span class="text-lg">ℹ️</span>
            <span>{message}</span>
          </div>
        {/if}
      {/if}
      
      <div class="flex shadow-lg md:flex-row flex-col md:rounded-xl overflow-hidden">
        <input
          type="email"
          bind:value={email}
          placeholder="Enter your email address..."
          required
          disabled={isSubmitting}
          on:focus={handleFormFocus}
          class="flex-1 p-4 px-6 border-none text-base bg-white text-slate-800 placeholder-slate-400 focus:outline-none md:rounded-l-xl md:rounded-r-none rounded-t-xl md:rounded-t-none disabled:opacity-50"
        />
        <button
          type="submit"
          class="px-8 py-4 bg-emerald-500 text-white border-none font-semibold cursor-pointer transition-all duration-200 whitespace-nowrap hover:bg-emerald-600 hover:scale-105 disabled:opacity-70 disabled:cursor-not-allowed md:rounded-r-xl md:rounded-l-none rounded-b-xl md:rounded-b-none"
          disabled={isSubmitting}
        >
          {isSubmitting ? 'Joining...' : 'Join Waitlist'}
        </button>
      </div>
      
      <div class="grid md:grid-cols-2 grid-cols-1 gap-2 text-sm opacity-90 text-white">
        <span class="flex items-center gap-2">✅ $9/mo founding price</span>
        <span class="flex items-center gap-2">✅ Concierge support</span>
        <span class="flex items-center gap-2">✅ First 50 members only</span>
        <span class="flex items-center gap-2">✅ No spam, ever</span>
      </div>
    </form>
  {/if}
  
  <p class="text-center text-sm opacity-80 mt-4 mb-0 text-white">Limited to first 50 founding members</p>
</div>