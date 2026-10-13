EPOXY LUXE ADMIN PANEL — setup notes

FILES
- index.html: public website, reads designs from Supabase when configured; keeps the built-in sample designs as fallback until database has rows.
- admin.html: owner login + add/edit/delete designs, upload image, change price.
- supabase-config.js: add Supabase Project URL and publishable key here.
- supabase_setup.sql: run in Supabase SQL Editor.

SETUP
1. In Supabase, open Project Settings > API (or Connect). Copy Project URL and the publishable key (older projects may label it anon/public key). Never use service_role or secret key in browser files.
2. Open supabase-config.js and replace both PASTE_... values.
3. In Supabase > SQL Editor > New query, paste all of supabase_setup.sql and click Run.
4. In Supabase > Authentication > Users, create the owner user with email/password (or use the sign-up option if enabled). Verify email if required.
5. In Authentication > Users, open that user and copy the user UUID. In SQL Editor run this, replacing the example UUID:
   insert into public.admin_users(user_id) values ('PASTE_OWNER_USER_UUID_HERE');
   Do not add other users to admin_users.
6. Upload index.html, admin.html, supabase-config.js to the same GitHub Pages repository root. Keep the existing repo's other needed files. Do not upload supabase_setup.sql as a public web page (it is a setup script, not a secret, but it is not needed on the site).
7. Open https://YOUR-GITHUB-USERNAME.github.io/YOUR-REPO/admin.html and sign in. Add a design with name, category, price, and photo. It will show on index.html after refresh.

IMPORTANT
- This is a catalog/admin panel only, not checkout, payment processing, or an enquiry backend.
- Existing 100 generated sample designs remain visible until at least one row is added to the Supabase designs table; after the first row exists, the public page shows the database catalog only. Add your real designs from Admin.
- GitHub Pages is static hosting. Supabase provides database, authentication, and image storage.
- The publishable/anon key is intended for frontend use; access is restricted by SQL Row Level Security policies. Never expose a service_role/secret key.
- Test using the public live URL, not by opening the HTML as file://. Supabase config must be filled in for cloud editing to work.
