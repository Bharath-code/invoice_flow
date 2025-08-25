<script>
  let email = '';
  let isSubmitting = false;
  let isSubmitted = false;
  
  async function handleSubmit(event) {
    event.preventDefault();
    if (!email || isSubmitting) return;
    
    isSubmitting = true;
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    isSubmitted = true;
    isSubmitting = false;
    email = '';
    
    // Reset after 3 seconds
    setTimeout(() => {
      isSubmitted = false;
    }, 3000);
  }
</script>

<div class="bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl p-8 mt-8">
  <h3 class="text-xl font-semibold mb-6 text-center text-white">Join 2,847 freelancers who get paid faster</h3>
  
  {#if isSubmitted}
    <div class="flex items-center justify-center gap-3 p-6 bg-emerald-500/20 border border-emerald-500/30 rounded-xl font-medium text-white">
      <span class="text-xl">✅</span>
      <span>You're on the list! We'll notify you when we launch.</span>
    </div>
  {:else}
    <form on:submit={handleSubmit} class="flex flex-col gap-4">
      <div class="flex rounded-xl overflow-hidden shadow-lg md:flex-row flex-col">
        <input
          type="email"
          bind:value={email}
          placeholder="Enter your email address..."
          required
          class="flex-1 p-4 px-6 border-none text-base bg-white text-slate-800 placeholder-slate-400 focus:outline-none md:rounded-l-xl md:rounded-r-none rounded-t-xl md:rounded-t-xl"
          disabled={isSubmitting}
        />
        <button
          type="submit"
          class="px-8 py-4 bg-emerald-500 text-white border-none font-semibold cursor-pointer transition-all duration-200 whitespace-nowrap hover:bg-emerald-600 hover:scale-105 disabled:opacity-70 disabled:cursor-not-allowed md:rounded-r-xl md:rounded-l-none rounded-b-xl md:rounded-b-xl"
          disabled={isSubmitting || !email}
        >
          {isSubmitting ? 'Joining...' : 'Join Waitlist'}
        </button>
      </div>
      
      <div class="grid md:grid-cols-2 grid-cols-1 gap-2 text-sm opacity-90 text-white">
        <span class="flex items-center gap-2">✅ No spam, ever</span>
        <span class="flex items-center gap-2">✅ Early bird pricing</span>
        <span class="flex items-center gap-2">✅ Cancel anytime</span>
        <span class="flex items-center gap-2">✅ Launch updates</span>
      </div>
    </form>
  {/if}
  
  <p class="text-center text-sm opacity-80 mt-4 mb-0 text-white">Limited beta spots available</p>
</div>