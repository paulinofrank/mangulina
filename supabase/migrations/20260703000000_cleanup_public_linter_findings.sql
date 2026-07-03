BEGIN;

ALTER VIEW IF EXISTS public.recordings_with_release_info
SET (security_invoker = true);

DROP TABLE IF EXISTS
    public.genres_backup_before_single_table_taxonomy,
    public.subgenres_backup_before_single_table_taxonomy,
    public.genre_import_mapping_backup_before_single_table_taxonomy,
    public.recordings_genres_backup_before_single_table_taxonomy,
    public.genres_backup_before_christian_cleanup,
    public.recordings_genres_backup_before_christian_cleanup,
    public.genre_import_mapping_backup_before_christian_cleanup,
    public.genres_backup_before_top_level_promotions,
    public.recordings_genres_backup_before_top_level_promotions,
    public.genre_import_mapping_backup_before_top_level_promotions,
    public.genre_taxonomy_migration_validation_20260612,
    public.recordings_genres_backup_before_taxonomy_migration,
    public.genres_backup_before_taxonomy_migration,
    public.genre_import_mapping_backup_before_taxonomy_migration,
    public.genre_taxonomy_final_validation_20260612,
    public.genres_backup_before_final_taxonomy,
    public.genre_import_mapping_backup_before_final_taxonomy,
    public.recordings_genres_backup_before_final_taxonomy,
    public.genre_taxonomy_final_approved_validation_20260612,
    public.genres_backup_before_urban_fusion_removal,
    public.genre_import_mapping_backup_before_urban_fusion_removal,
    public.recordings_genres_backup_before_urban_fusion_removal,
    public.subgenres_backup_before_drop,
    public.releases_cover_image_url_backup_before_drop;

NOTIFY pgrst, 'reload schema';

COMMIT;
