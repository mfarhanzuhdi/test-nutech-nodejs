--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-21 16:10:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
-- SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16566)
-- Name: banners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banners (
    id integer NOT NULL,
    banner_name character varying(100),
    banner_image text
);


ALTER TABLE public.banners OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16565)
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banners_id_seq OWNER TO postgres;

--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 219
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- TOC entry 221 (class 1259 OID 16574)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    service_code character varying(50) NOT NULL,
    service_name character varying(100) NOT NULL,
    service_icon character varying(255) NOT NULL,
    service_tariff integer NOT NULL
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16581)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    email character varying(100),
    transaction_type character varying(20),
    amount integer,
    created_at timestamp without time zone DEFAULT now(),
    invoice_number character varying(50),
    service_code character varying(50),
    total_amount integer,
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16580)
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_transaction_id_seq OWNER TO postgres;

--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 222
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- TOC entry 218 (class 1259 OID 16554)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    password character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    profile_image text,
    balance integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16553)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4712 (class 2604 OID 16569)
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- TOC entry 4713 (class 2604 OID 16584)
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- TOC entry 4709 (class 2604 OID 16557)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4874 (class 0 OID 16566)
-- Dependencies: 220
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.banners VALUES (1, 'Promo 1', 'https://yourdomain.com/images/banner1.jpeg');
INSERT INTO public.banners VALUES (2, 'Promo 2', 'https://yourdomain.com/images/banner2.jpeg');
INSERT INTO public.banners VALUES (3, 'Promo 3', 'https://yourdomain.com/images/banner3.jpeg');


--
-- TOC entry 4875 (class 0 OID 16574)
-- Dependencies: 221
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.services VALUES ('PAJAK', 'Pajak PBB', 'https://nutech-integrasi.app/dummy.jpg', 40000);
INSERT INTO public.services VALUES ('PLN', 'Listrik', 'https://nutech-integrasi.app/dummy.jpg', 10000);
INSERT INTO public.services VALUES ('PDAM', 'PDAM Berlangganan', 'https://nutech-integrasi.app/dummy.jpg', 40000);
INSERT INTO public.services VALUES ('PULSA', 'Pulsa', 'https://nutech-integrasi.app/dummy.jpg', 40000);
INSERT INTO public.services VALUES ('PGN', 'PGN Berlangganan', 'https://nutech-integrasi.app/dummy.jpg', 50000);
INSERT INTO public.services VALUES ('MUSIK', 'Musik Berlangganan', 'https://nutech-integrasi.app/dummy.jpg', 50000);
INSERT INTO public.services VALUES ('TV', 'TV Berlangganan', 'https://nutech-integrasi.app/dummy.jpg', 50000);
INSERT INTO public.services VALUES ('PAKET_DATA', 'Paket data', 'https://nutech-integrasi.app/dummy.jpg', 50000);
INSERT INTO public.services VALUES ('VOUCHER_GAME', 'Voucher Game', 'https://nutech-integrasi.app/dummy.jpg', 100000);


--
-- TOC entry 4877 (class 0 OID 16581)
-- Dependencies: 223
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.transactions VALUES (1, 'user@nutech-integrasi.com', 'TOPUP', 1000000, '2025-06-21 14:08:40.736347', NULL, NULL, NULL, '2025-06-21 14:28:11.539168');
INSERT INTO public.transactions VALUES (2, 'user@nutech-integrasi.com', 'PAYMENT', NULL, '2025-06-21 14:28:13.939527', 'INV1750490893931', 'PULSA', 40000, '2025-06-21 14:28:13.931');


--
-- TOC entry 4872 (class 0 OID 16554)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'user@nutech-integrasi.com', 'User Edited', 'Nutech Edited', '$2b$10$CuWhAqSDA8hklX96Z8lNTuqax7x2ZkNS64qKGEL0NwLh6ELxflBou', '2025-06-21 11:43:54.531668', 'https://yoururlapi.com/1750485740679-City-Night.png', 800000);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 219
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banners_id_seq', 3, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 222
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 2, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 4721 (class 2606 OID 16573)
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 16578)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_code);


--
-- TOC entry 4725 (class 2606 OID 16587)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 4717 (class 2606 OID 16564)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4719 (class 2606 OID 16562)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2025-06-21 16:10:15

--
-- PostgreSQL database dump complete
--

