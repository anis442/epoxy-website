// Paste your Supabase Project URL and publishable (anon) key below.
// Never put a service_role/secret key in this file.
window.EPOXY_SUPABASE_URL = "https://suosjlppyjtdvcztpgfm.supabase.co/rest/v1/";
window.EPOXY_SUPABASE_ANON_KEY = "sb_publishable_hI3pYQ1AzVWFSKZeK79USQ_XGnKsX8m";
if (window.supabase && window.EPOXY_SUPABASE_URL.startsWith("https://") && !window.EPOXY_SUPABASE_ANON_KEY.includes("PASTE_")) {
  window.epoxySupabase = window.supabase.createClient(window.EPOXY_SUPABASE_URL, window.EPOXY_SUPABASE_ANON_KEY);
}

