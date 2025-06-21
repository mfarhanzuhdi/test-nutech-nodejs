-- Table: public.banners

-- DROP TABLE IF EXISTS public.banners;

CREATE TABLE IF NOT EXISTS public.banners
(
    id integer NOT NULL DEFAULT nextval('banners_id_seq'::regclass),
    banner_name character varying(100) COLLATE pg_catalog."default",
    banner_image text COLLATE pg_catalog."default",
    CONSTRAINT banners_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.banners
    OWNER to postgres;