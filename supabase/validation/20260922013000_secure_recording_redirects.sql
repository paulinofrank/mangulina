SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name = 'recording_redirects'
  AND grantee IN ('anon', 'authenticated')
ORDER BY grantee, privilege_type;

SELECT policyname, roles, cmd
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename = 'recording_redirects';
