-- Table: public.transactions

-- DROP TABLE IF EXISTS public.transactions;

CREATE TABLE IF NOT EXISTS public.transactions
(
    transaction_id integer NOT NULL DEFAULT nextval('transactions_transaction_id_seq'::regclass),
    email character varying(100) COLLATE pg_catalog."default",
    transaction_type character varying(20) COLLATE pg_catalog."default",
    amount integer,
    created_at timestamp without time zone DEFAULT now(),
    invoice_number character varying(50) COLLATE pg_catalog."default",
    service_code character varying(50) COLLATE pg_catalog."default",
    total_amount integer,
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.transactions
    OWNER to postgres;