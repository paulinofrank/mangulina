-- Cleanup: Drop everything if it exists (in correct order)

-- Drop triggers first
DROP TRIGGER IF EXISTS credited_work_credits_update_timestamp ON credited_work_credits;
DROP TRIGGER IF EXISTS credited_works_update_timestamp ON credited_works;

-- Drop functions
DROP FUNCTION IF EXISTS update_credited_works_timestamp();
DROP FUNCTION IF EXISTS get_artist_credited_works_with_roles(UUID);
DROP FUNCTION IF EXISTS get_artist_role_summary(UUID);

-- Drop policies
DROP POLICY IF EXISTS credited_works_select_public ON credited_works;
DROP POLICY IF EXISTS credited_works_insert_admin ON credited_works;
DROP POLICY IF EXISTS credited_works_update_admin ON credited_works;
DROP POLICY IF EXISTS credited_work_credits_select_public ON credited_work_credits;
DROP POLICY IF EXISTS credited_work_credits_insert_admin ON credited_work_credits;
DROP POLICY IF EXISTS credited_work_credits_update_admin ON credited_work_credits;

-- Drop tables (foreign key order matters)
DROP TABLE IF EXISTS credited_work_credits CASCADE;
DROP TABLE IF EXISTS credited_works CASCADE;
