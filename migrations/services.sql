-- Table: public.services

-- DROP TABLE IF EXISTS public.services;

CREATE TABLE IF NOT EXISTS public.services
(
    service_code character varying(50) COLLATE pg_catalog."default" NOT NULL,
    service_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    service_icon character varying(255) COLLATE pg_catalog."default" NOT NULL,
    service_tariff integer NOT NULL,
    CONSTRAINT services_pkey PRIMARY KEY (service_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.services
    OWNER to postgres;