--
-- PostgreSQL database dump
--


-- Dumped from database version 15.17 (Homebrew)
-- Dumped by pg_dump version 15.17 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.wishlists DROP CONSTRAINT IF EXISTS wishlists_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.wishlist_items DROP CONSTRAINT IF EXISTS wishlist_items_wishlist_id_fkey;
ALTER TABLE IF EXISTS ONLY public.wishlist_items DROP CONSTRAINT IF EXISTS wishlist_items_variant_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shipments DROP CONSTRAINT IF EXISTS shipments_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shipment_items DROP CONSTRAINT IF EXISTS shipment_items_shipment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shipment_items DROP CONSTRAINT IF EXISTS shipment_items_order_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_product_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_order_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_category_id_fkey;
ALTER TABLE IF EXISTS ONLY public.product_variants DROP CONSTRAINT IF EXISTS product_variants_product_id_fkey;
ALTER TABLE IF EXISTS ONLY public.product_tags DROP CONSTRAINT IF EXISTS product_tags_tag_id_fkey;
ALTER TABLE IF EXISTS ONLY public.product_tags DROP CONSTRAINT IF EXISTS product_tags_product_id_fkey;
ALTER TABLE IF EXISTS ONLY public.product_images DROP CONSTRAINT IF EXISTS product_images_product_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_shipping_address_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_coupon_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_billing_address_id_fkey;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_variant_id_fkey;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory DROP CONSTRAINT IF EXISTS inventory_variant_id_fkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_parent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.carts DROP CONSTRAINT IF EXISTS carts_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.carts DROP CONSTRAINT IF EXISTS carts_coupon_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_variant_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_cart_id_fkey;
ALTER TABLE IF EXISTS ONLY public.addresses DROP CONSTRAINT IF EXISTS addresses_user_id_fkey;
DROP INDEX IF EXISTS public.wishlists_user_id_idx;
DROP INDEX IF EXISTS public.wishlist_items_wishlist_id_variant_id_key;
DROP INDEX IF EXISTS public.users_email_key;
DROP INDEX IF EXISTS public.tags_name_key;
DROP INDEX IF EXISTS public.shipments_order_id_idx;
DROP INDEX IF EXISTS public.reviews_product_id_idx;
DROP INDEX IF EXISTS public.products_slug_key;
DROP INDEX IF EXISTS public.products_sku_key;
DROP INDEX IF EXISTS public.products_category_id_idx;
DROP INDEX IF EXISTS public.product_variants_sku_key;
DROP INDEX IF EXISTS public.product_variants_product_id_idx;
DROP INDEX IF EXISTS public.product_images_product_id_idx;
DROP INDEX IF EXISTS public.payments_order_id_idx;
DROP INDEX IF EXISTS public.orders_user_id_idx;
DROP INDEX IF EXISTS public.orders_order_number_key;
DROP INDEX IF EXISTS public.order_items_order_id_idx;
DROP INDEX IF EXISTS public.inventory_variant_id_key;
DROP INDEX IF EXISTS public.coupons_code_key;
DROP INDEX IF EXISTS public.categories_slug_key;
DROP INDEX IF EXISTS public.categories_parent_id_idx;
DROP INDEX IF EXISTS public.carts_user_id_key;
DROP INDEX IF EXISTS public.cart_items_cart_id_idx;
DROP INDEX IF EXISTS public.addresses_user_id_idx;
ALTER TABLE IF EXISTS ONLY public.wishlists DROP CONSTRAINT IF EXISTS wishlists_pkey;
ALTER TABLE IF EXISTS ONLY public.wishlist_items DROP CONSTRAINT IF EXISTS wishlist_items_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_pkey;
ALTER TABLE IF EXISTS ONLY public.shipments DROP CONSTRAINT IF EXISTS shipments_pkey;
ALTER TABLE IF EXISTS ONLY public.shipment_items DROP CONSTRAINT IF EXISTS shipment_items_pkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.product_variants DROP CONSTRAINT IF EXISTS product_variants_pkey;
ALTER TABLE IF EXISTS ONLY public.product_tags DROP CONSTRAINT IF EXISTS product_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.product_images DROP CONSTRAINT IF EXISTS product_images_pkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory DROP CONSTRAINT IF EXISTS inventory_pkey;
ALTER TABLE IF EXISTS ONLY public.coupons DROP CONSTRAINT IF EXISTS coupons_pkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY public.carts DROP CONSTRAINT IF EXISTS carts_pkey;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_pkey;
ALTER TABLE IF EXISTS ONLY public.addresses DROP CONSTRAINT IF EXISTS addresses_pkey;
ALTER TABLE IF EXISTS ONLY public._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
DROP TABLE IF EXISTS public.wishlists;
DROP TABLE IF EXISTS public.wishlist_items;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.tags;
DROP TABLE IF EXISTS public.shipments;
DROP TABLE IF EXISTS public.shipment_items;
DROP TABLE IF EXISTS public.reviews;
DROP TABLE IF EXISTS public.products;
DROP TABLE IF EXISTS public.product_variants;
DROP TABLE IF EXISTS public.product_tags;
DROP TABLE IF EXISTS public.product_images;
DROP TABLE IF EXISTS public.payments;
DROP TABLE IF EXISTS public.orders;
DROP TABLE IF EXISTS public.order_items;
DROP TABLE IF EXISTS public.inventory;
DROP TABLE IF EXISTS public.coupons;
DROP TABLE IF EXISTS public.categories;
DROP TABLE IF EXISTS public.carts;
DROP TABLE IF EXISTS public.cart_items;
DROP TABLE IF EXISTS public.addresses;
DROP TABLE IF EXISTS public._prisma_migrations;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id text NOT NULL,
    user_id text NOT NULL,
    label text,
    line1 text NOT NULL,
    line2 text,
    city text NOT NULL,
    state text,
    postal_code text NOT NULL,
    country text NOT NULL,
    is_default_shipping boolean DEFAULT false NOT NULL,
    is_default_billing boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id text NOT NULL,
    cart_id text NOT NULL,
    variant_id text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price_snapshot numeric(10,2) NOT NULL
);


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    id text NOT NULL,
    user_id text,
    session_id text,
    coupon_id text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id text NOT NULL,
    parent_id text,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    image_url text
);


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupons (
    id text NOT NULL,
    code text NOT NULL,
    discount_type text NOT NULL,
    discount_value numeric(10,2) NOT NULL,
    min_order_amount numeric(10,2),
    usage_limit integer,
    times_used integer DEFAULT 0 NOT NULL,
    valid_from timestamp(3) without time zone,
    valid_until timestamp(3) without time zone,
    active boolean DEFAULT true NOT NULL
);


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory (
    id text NOT NULL,
    variant_id text NOT NULL,
    quantity_on_hand integer DEFAULT 0 NOT NULL,
    quantity_reserved integer DEFAULT 0 NOT NULL,
    reorder_threshold integer DEFAULT 0 NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id text NOT NULL,
    order_id text NOT NULL,
    variant_id text NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    line_total numeric(10,2) NOT NULL,
    product_name_snapshot text NOT NULL,
    variant_sku_snapshot text NOT NULL
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id text NOT NULL,
    user_id text NOT NULL,
    order_number text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    tax_amount numeric(10,2) DEFAULT 0 NOT NULL,
    shipping_amount numeric(10,2) DEFAULT 0 NOT NULL,
    discount_amount numeric(10,2) DEFAULT 0 NOT NULL,
    grand_total numeric(10,2) NOT NULL,
    currency text DEFAULT 'BDT'::text NOT NULL,
    shipping_address_id text,
    billing_address_id text,
    coupon_id text,
    placed_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id text NOT NULL,
    order_id text NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency text DEFAULT 'BDT'::text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    method text DEFAULT 'cod'::text NOT NULL,
    collected_at timestamp(3) without time zone,
    notes text
);


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_images (
    id text NOT NULL,
    product_id text NOT NULL,
    url text NOT NULL,
    alt_text text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_primary boolean DEFAULT false NOT NULL
);


--
-- Name: product_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_tags (
    product_id text NOT NULL,
    tag_id text NOT NULL
);


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variants (
    id text NOT NULL,
    product_id text NOT NULL,
    sku text NOT NULL,
    size text,
    color text,
    price_override numeric(10,2),
    weight_grams integer,
    attributes jsonb,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id text NOT NULL,
    category_id text,
    sku text NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    base_price numeric(10,2) NOT NULL,
    currency text DEFAULT 'BDT'::text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    specifications text,
    care_instructions text,
    attributes jsonb
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id text NOT NULL,
    user_id text NOT NULL,
    product_id text NOT NULL,
    order_item_id text,
    rating integer NOT NULL,
    title text,
    body text,
    verified_purchase boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: shipment_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipment_items (
    id text NOT NULL,
    shipment_id text NOT NULL,
    order_item_id text NOT NULL,
    quantity integer NOT NULL
);


--
-- Name: shipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipments (
    id text NOT NULL,
    order_id text NOT NULL,
    carrier text,
    tracking_number text,
    status text DEFAULT 'pending'::text NOT NULL,
    shipped_at timestamp(3) without time zone,
    delivered_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id text NOT NULL,
    name text NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id text NOT NULL,
    email text NOT NULL,
    password_hash text,
    first_name text,
    last_name text,
    phone text,
    role text DEFAULT 'customer'::text NOT NULL,
    email_verified boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: wishlist_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlist_items (
    id text NOT NULL,
    wishlist_id text NOT NULL,
    variant_id text NOT NULL,
    added_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: wishlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlists (
    id text NOT NULL,
    user_id text NOT NULL,
    name text DEFAULT 'My Wishlist'::text NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('2ef5ecb0-5401-4eb1-9150-e66d2a45834c', 'd21766ce8b61698b4dbc37073cfe8e729994896a49bb1161703cf47738d42636', '2026-05-04 05:12:09.063759+06', '20260504050000_cod_only_payments', NULL, NULL, '2026-05-04 05:12:09.047628+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('5eb5cb84-59d0-4a34-8b1c-1adb0e4c2cd0', 'a14e0a8f3f8eb3bc363b6f9a36f4d8761653623bd7f0f74620a1d09bba0099c1', '2026-05-04 04:23:49.245527+06', '20260504040000_create_users', NULL, NULL, '2026-05-04 04:23:49.237315+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('d8ec7b37-2cf9-4f71-9162-8a6ce8bbf770', '3fd95e524f11cb29a1d453dbc8577bc17f2fb00fc20fa7926dffb0d609fd00bb', '2026-05-04 04:23:49.315912+06', '20260504041300_create_order_items', NULL, NULL, '2026-05-04 04:23:49.312831+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('40c71997-4419-4ac2-b971-3d2a6167e3d4', 'c139cea1407a2024a54d90c02ed615577be443cb7ebaa84cd840fbdbdf595f1f', '2026-05-04 04:23:49.256704+06', '20260504040100_create_addresses', NULL, NULL, '2026-05-04 04:23:49.246143+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('09fbc90d-346f-4198-a237-84edd1e2bad5', 'f0ce74168b64346fe48b135467bd8b56c77228fe5a3156c91573a197d169f958', '2026-05-04 04:23:49.264709+06', '20260504040200_create_categories', NULL, NULL, '2026-05-04 04:23:49.257107+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('5f727adf-d81c-43c5-9ef0-b0d4dd53cca6', '3fc7ce93b3d9bf889dd33e5a48a32050f3b8dcf531c329c65ae92386d505b5e5', '2026-05-04 04:23:49.270359+06', '20260504040300_create_tags', NULL, NULL, '2026-05-04 04:23:49.265158+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('9aa7a07c-310a-4f62-a096-e0587671f223', '51f3e7559f195ff6c025703e9d6b006f766b774fb6fd36fe53a3fdef6e7e90e8', '2026-05-04 04:23:49.319555+06', '20260504041400_create_payment_methods', NULL, NULL, '2026-05-04 04:23:49.316228+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('c0523ca6-24c2-4045-8a39-95f01a6a6027', '65e776f7bfaefbc986953c0b3d623fec9251ab70aa5e871b7e6366cc5172d802', '2026-05-04 04:23:49.279512+06', '20260504040400_create_products', NULL, NULL, '2026-05-04 04:23:49.270812+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('bc187e5f-c50f-4317-ab6a-84905eb89583', '81fb38ac0f28dcf8c4aa07107e6391278c0d8ebfef57bca830d8b71861ae308c', '2026-05-04 04:23:49.282603+06', '20260504040500_create_product_tags', NULL, NULL, '2026-05-04 04:23:49.279847+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('daf5a32c-9c48-43fc-91e7-85b047773d36', 'c3d1c28d5b2dd53c08cb611d45e3019504351f92eddef0d1a97598de6ce32cf0', '2026-05-04 04:23:49.287419+06', '20260504040600_create_product_variants', NULL, NULL, '2026-05-04 04:23:49.283011+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('f2297357-ab43-4116-8a8f-457d17523495', 'adb5d2632113ac3b643f981317a10605f8be7c696b0cebd382680d1a0ed05802', '2026-05-04 04:23:49.323144+06', '20260504041500_create_payments', NULL, NULL, '2026-05-04 04:23:49.320086+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('f104ced2-1db4-40e5-b1c3-a4a7c3fb7893', 'a4c44eb975fc3f25e708e95fb5d237c5bbdcf443327414f5dc1765c690ea3a53', '2026-05-04 04:23:49.291113+06', '20260504040700_create_product_images', NULL, NULL, '2026-05-04 04:23:49.287791+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('9d4d54fe-821b-4ebb-98fc-ab7fe8d1f5d8', '1652b303d504dfbc2873fd50b29c36c50ca089f7ebd0d3692d851b267a5e56d6', '2026-05-04 04:23:49.294526+06', '20260504040800_create_inventory', NULL, NULL, '2026-05-04 04:23:49.291408+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('d67beb00-8179-4918-8031-df06a5d92169', '3bd815ef50f28d6491533ff23093aec72ad54c0dda5310608217af0421343087', '2026-05-04 05:48:08.172821+06', '20260504060000_default_currency_bdt', NULL, NULL, '2026-05-04 05:48:08.161496+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('affcfbc8-7aeb-470e-bd63-267a9af5f3d8', '4434628d16c65ed6916eb1049b353f9ebe8d2793b27854211377a5ec1df6d424', '2026-05-04 04:23:49.297969+06', '20260504040900_create_coupons', NULL, NULL, '2026-05-04 04:23:49.294825+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('641f668b-2906-4ea1-a33b-07aea4e2266d', '8e2549fe136ffbac1799c6311bee94b5f8ab4c4ce80660dbd350130a90b2a116', '2026-05-04 04:23:49.326797+06', '20260504041600_create_shipments', NULL, NULL, '2026-05-04 04:23:49.323458+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('d60060fa-4ec7-4fb9-a6e5-80069055a41e', 'be924539ffc244b37ae496d135c655d43d001b82dfa59dd939f2c3241e3603cc', '2026-05-04 04:23:49.301609+06', '20260504041000_create_carts', NULL, NULL, '2026-05-04 04:23:49.298354+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('57cecf6b-74c1-4449-b95b-9d93a10a9ff2', '7482bd9f489d3ab959dd9ed2b4e16b8bc9d9d600480e268eb6ff9c1c69852c23', '2026-05-04 04:23:49.30513+06', '20260504041100_create_cart_items', NULL, NULL, '2026-05-04 04:23:49.301925+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('d9689be7-0088-4a9c-9bef-bf052d151f80', '3645fec837836af6b271920d5ca05b524cbefd612716dab8fa489d8bfff38c35', '2026-05-04 04:23:49.31192+06', '20260504041200_create_orders', NULL, NULL, '2026-05-04 04:23:49.305419+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('ae4d8510-227f-4117-88f6-e59b436c2f82', 'decfe9bec119fb12286a4fca48601f82324bfed0bb6d24c9346c171a58a32cae', '2026-05-04 04:23:49.330519+06', '20260504041700_create_shipment_items', NULL, NULL, '2026-05-04 04:23:49.327138+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('dc78588e-cabe-45af-a24c-5cfa22dbc8f8', '0676bd8e6bc3ae88c06c1ba67a186cce84b052f597e147b40d042c17f0a1edb8', '2026-05-04 04:23:49.334865+06', '20260504041800_create_reviews', NULL, NULL, '2026-05-04 04:23:49.330869+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('dfaef633-051c-406f-b504-0e6e80dd819f', '2187701c0a0000fc67664d827abb4a3aa3e452c65fd7da88b193e82c2e78e822', '2026-05-04 05:54:04.771741+06', '20260504070000_category_image_url', NULL, NULL, '2026-05-04 05:54:04.765943+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('da9aafff-d9d5-4738-bc7c-82830813766b', 'e6df4e8c2d2410205e1e83542b59f6ddf10b725bd2ef024b55131b2ec0452fcf', '2026-05-04 04:23:49.338531+06', '20260504041900_create_wishlists', NULL, NULL, '2026-05-04 04:23:49.335286+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('81fe7136-3350-410e-b608-7bcb482beed6', '23e88cb7b4fef57098973d15c52b3f473c8d634f7d847757c598189f60464ee5', '2026-05-04 04:23:49.342759+06', '20260504042000_create_wishlist_items', NULL, NULL, '2026-05-04 04:23:49.338871+06', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('c5ebdf0d-ebbb-4d61-b24a-fe1a64e6a706', '34c5d9318ef0c521d81b80f69e3c1871a731a04db4b8a4292e33f559eb1535c7', '2026-05-04 06:04:31.154017+06', '20260504080000_product_extra_fields', NULL, NULL, '2026-05-04 06:04:31.150299+06', 1);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.addresses (id, user_id, label, line1, line2, city, state, postal_code, country, is_default_shipping, is_default_billing, created_at) VALUES ('e09040a9-ce3d-4d3a-929f-467778cd946a', 'dba59a74-23f3-47c7-9e8f-86e1c3367534', 'Home', '123 Main St', NULL, 'New York', 'NY', '10001', 'US', true, true, '2026-05-04 02:07:34.583');
INSERT INTO public.addresses (id, user_id, label, line1, line2, city, state, postal_code, country, is_default_shipping, is_default_billing, created_at) VALUES ('eb3d07f1-7e10-4833-862b-777efc65b096', 'f150e58a-22e3-49f8-b20f-bea2eb3e46eb', 'Apt', '456 Oak Ave', 'Apt 7B', 'Brooklyn', 'NY', '11201', 'US', true, true, '2026-05-04 02:07:34.588');


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cart_items (id, cart_id, variant_id, quantity, unit_price_snapshot) VALUES ('0a238ef3-ee7f-445a-a640-c09ffd51c7ac', 'ccd8a937-139c-4ea0-b0ab-a67216af7c72', 'e1dc6171-0941-412f-8942-0ec56f4b66da', 1, 98900.00);
INSERT INTO public.cart_items (id, cart_id, variant_id, quantity, unit_price_snapshot) VALUES ('80ae288b-a111-45a0-8798-db6116bba145', 'ccd8a937-139c-4ea0-b0ab-a67216af7c72', '35544a78-e4b7-4f76-ac0f-086fdb9838f6', 1, 11900.00);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.carts (id, user_id, session_id, coupon_id, created_at, updated_at) VALUES ('ccd8a937-139c-4ea0-b0ab-a67216af7c72', 'dba59a74-23f3-47c7-9e8f-86e1c3367534', NULL, 'dea76234-7808-4907-871a-b13bc864e184', '2026-05-04 02:07:34.811', '2026-05-04 02:07:34.811');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('8521b632-49c5-45ff-a539-68ec78cd878b', NULL, 'Televisions', 'televisions', NULL, 1, '2026-05-04 02:07:34.589', '/storage/categories/8521b632-49c5-45ff-a539-68ec78cd878b/categories-01.png');
INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('6a9c8a82-4d33-4978-b29c-9805cc39107a', NULL, 'Laptop & PC', 'laptop-pc', NULL, 2, '2026-05-04 02:07:34.598', '/storage/categories/6a9c8a82-4d33-4978-b29c-9805cc39107a/categories-02.png');
INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('2b21f711-70fe-4073-9a0b-0ccdcabe5a03', NULL, 'Mobile & Tablets', 'mobile-tablets', NULL, 3, '2026-05-04 02:07:34.6', '/storage/categories/2b21f711-70fe-4073-9a0b-0ccdcabe5a03/categories-03.png');
INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('5041b743-1396-47af-8ee2-12c5ed70556b', NULL, 'Games & Videos', 'games-videos', NULL, 4, '2026-05-04 02:07:34.603', '/storage/categories/5041b743-1396-47af-8ee2-12c5ed70556b/categories-04.png');
INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('febade3f-1d9e-4a14-83b5-6939ccb6d3d1', NULL, 'Home Appliances', 'home-appliances', NULL, 5, '2026-05-04 02:07:34.605', '/storage/categories/febade3f-1d9e-4a14-83b5-6939ccb6d3d1/categories-05.png');
INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('04a914f3-47f1-4c0e-8425-a8c02a5667c2', NULL, 'Health & Sports', 'health-sports', NULL, 6, '2026-05-04 02:07:34.606', '/storage/categories/04a914f3-47f1-4c0e-8425-a8c02a5667c2/categories-06.png');
INSERT INTO public.categories (id, parent_id, name, slug, description, sort_order, created_at, image_url) VALUES ('392a958d-ca29-41f5-a782-f5b89c208d46', NULL, 'Watches', 'watches', NULL, 7, '2026-05-04 02:07:34.608', '/storage/categories/392a958d-ca29-41f5-a782-f5b89c208d46/categories-07.png');


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.coupons (id, code, discount_type, discount_value, min_order_amount, usage_limit, times_used, valid_from, valid_until, active) VALUES ('dea76234-7808-4907-871a-b13bc864e184', 'WELCOME10', 'percent', 10.00, 20.00, 1000, 0, '2026-05-04 02:07:34.807', '2026-06-03 02:07:34.807', true);
INSERT INTO public.coupons (id, code, discount_type, discount_value, min_order_amount, usage_limit, times_used, valid_from, valid_until, active) VALUES ('13f2e237-8e3e-4cea-a1d5-e174146b5217', 'FLAT500', 'fixed', 500.00, 2000.00, NULL, 0, NULL, NULL, true);


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('a4bce0cf-774e-4190-9125-03dd457879a8', 'e1dc6171-0941-412f-8942-0ec56f4b66da', 70, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('1eace89b-64d9-49a6-b7f4-ab482d7345b3', '4c323733-e2f0-44a7-afa0-55b0bc7a4348', 60, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('850eded8-7d1d-40d2-bcab-302696df092d', '7e83576f-02a7-4f14-a93c-b816c762abe3', 50, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('b9ef89fd-9e4b-42db-a407-47fe776a4c7a', '859c61cd-de93-4397-bdbf-1c9cbc2fa073', 150, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('960ef664-af25-4a00-bef4-29fc169f0dd9', '0346f41d-c91e-4b6e-879c-99806a65b536', 160, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('3638c729-fdda-428a-ae9a-d22611a0cbe5', '41843354-c4c7-4923-87e2-e680ceda5f10', 170, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('0ff5937d-2482-46db-977d-60ea6fbbd534', '6d927860-db3f-4031-8be0-a1d0bebcd290', 180, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('fbee03a5-0519-45be-90ad-dbb60e87182f', '228510db-d7e8-4861-becc-04aa2bdda296', 190, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('bd808b89-8912-41b4-8333-9152ebdd6ed7', '8255dda3-37ef-4010-bb87-ee27d7a452eb', 200, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('5020be4c-c4fe-4c46-8697-44a7871079ec', '143f3383-fa0e-4ead-aee2-2c9438422823', 210, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('f8c08156-57d0-48eb-8c91-f84cb5e4c1c6', '7ad9a6ba-dc12-4f15-8255-0386be4112b4', 230, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('9e30d61f-b319-4357-826a-74aeadb33e32', '43e95a49-963e-42a5-8b26-7c3b69a3f438', 220, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('d8a3926e-0b04-409c-b2f6-f6b0a48c294a', 'fc2e2b30-c263-4a31-8aa5-8bcbb4dbc507', 240, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('47b0327a-e479-45ec-bb52-d7a370e1411d', 'ce0a384a-3f8e-4dc1-a8d5-64b8c506bba9', 260, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('0833ffb2-247b-44c4-bbd0-b41de815159e', 'e7df5d08-0d79-41f2-8e63-bc1a9d59a774', 250, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('1d7d5930-d7a0-46d0-a69e-54dce19cccaf', '785101be-13b2-4fb5-969d-0656bd59ce19', 270, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('cca19426-8fbe-4c4d-a3c1-3aab04367d95', '2490f88d-2c5b-4699-b0c7-d7adc92c6a85', 280, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('cb95afcd-ee66-4ecb-9585-2a45b24bf506', '4040f849-74b0-48dd-8a66-5fce31714078', 290, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('f6ee0071-4d5d-42ea-8693-28ed8ec3af9b', '459e7679-fbe6-4d73-903a-78b2759a67d9', 90, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('d81178bb-ae3d-4595-96aa-38a16e83c131', '78f15967-08ee-44ed-a471-f6c5f026031e', 80, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('b72ac0a2-1858-4248-99ca-863f31413b96', '011f8e82-bd98-4576-ba51-4a06f051d4e6', 100, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('5778366a-5a59-4dc7-a410-647de05207d5', 'f7e69bec-c25a-46cd-8bbd-fe6eac5e9cfb', 110, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('40409835-2497-4db0-a115-5303b8ecacd8', '0d5e9a08-52fa-4c61-870f-3437d8d28bb9', 120, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('13903358-1c6c-4fbc-b1bf-6da9b6dc4b27', '75b185c6-77c9-49be-acca-b2c85ad054f6', 130, 0, 10, '2026-05-04 02:07:34.788');
INSERT INTO public.inventory (id, variant_id, quantity_on_hand, quantity_reserved, reorder_threshold, updated_at) VALUES ('55a44ee2-51fd-436b-9b98-edcc18257b69', '35544a78-e4b7-4f76-ac0f-086fdb9838f6', 140, 0, 10, '2026-05-04 02:07:34.788');


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.order_items (id, order_id, variant_id, quantity, unit_price, line_total, product_name_snapshot, variant_sku_snapshot) VALUES ('612f67af-b00d-4bfe-9e25-43a90ccc1fc0', '280609c3-eb91-4594-a190-df594a1a45d6', '4c323733-e2f0-44a7-afa0-55b0bc7a4348', 2, 98900.00, 197800.00, 'iPhone 14 Plus 6/128GB', 'IP-14P-128-MID');
INSERT INTO public.order_items (id, order_id, variant_id, quantity, unit_price, line_total, product_name_snapshot, variant_sku_snapshot) VALUES ('3cb986f2-3ba8-4a51-88a8-9757a48aecb5', '280609c3-eb91-4594-a190-df594a1a45d6', '859c61cd-de93-4397-bdbf-1c9cbc2fa073', 1, 11900.00, 11900.00, 'Logitech MX Master 3 Mouse', 'LG-MX3-PG');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.orders (id, user_id, order_number, status, subtotal, tax_amount, shipping_amount, discount_amount, grand_total, currency, shipping_address_id, billing_address_id, coupon_id, placed_at) VALUES ('280609c3-eb91-4594-a190-df594a1a45d6', 'f150e58a-22e3-49f8-b20f-bea2eb3e46eb', 'ORD-1001', 'delivered', 209700.00, 15728.00, 500.00, 0.00, 225928.00, 'BDT', 'eb3d07f1-7e10-4833-862b-777efc65b096', 'eb3d07f1-7e10-4833-862b-777efc65b096', NULL, '2026-05-04 02:07:34.817');


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments (id, order_id, amount, currency, status, created_at, method, collected_at, notes) VALUES ('af1545ec-f8ac-489f-a463-2254b2b190f1', '280609c3-eb91-4594-a190-df594a1a45d6', 225928.00, 'BDT', 'collected', '2026-05-04 02:07:34.821', 'cod', '2026-05-04 02:07:34.821', 'Collected on delivery');


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('8fc987f0-9c88-4d22-aecc-19915030669b', 'f42f2841-0fbf-4c00-9b3a-c79c5373aa49', '/storage/products/f42f2841-0fbf-4c00-9b3a-c79c5373aa49/product-14-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('45cb524a-27e3-4a83-ae35-41dca6a6ce5d', 'f42f2841-0fbf-4c00-9b3a-c79c5373aa49', '/storage/products/f42f2841-0fbf-4c00-9b3a-c79c5373aa49/product-14-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('3ca44426-7e5b-4ce5-bc49-ad9262de4188', 'f42f2841-0fbf-4c00-9b3a-c79c5373aa49', '/storage/products/f42f2841-0fbf-4c00-9b3a-c79c5373aa49/product-14-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('ba9f8f14-1b86-4e9f-9132-83d8ad243fb4', 'f42f2841-0fbf-4c00-9b3a-c79c5373aa49', '/storage/products/f42f2841-0fbf-4c00-9b3a-c79c5373aa49/product-14-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('6f623543-44c6-4324-b7f3-93a167e6866e', '727073fc-7eaa-4628-82f4-f3459956260c', '/storage/products/727073fc-7eaa-4628-82f4-f3459956260c/product-15-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('a4fb84f2-3b71-4db1-8175-64a9221701a3', '727073fc-7eaa-4628-82f4-f3459956260c', '/storage/products/727073fc-7eaa-4628-82f4-f3459956260c/product-15-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('f5ce759b-ed08-4f05-a5f1-390fd7ab987b', '727073fc-7eaa-4628-82f4-f3459956260c', '/storage/products/727073fc-7eaa-4628-82f4-f3459956260c/product-15-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('3e0edc8b-6d8a-4119-a6fc-e347793e0d20', '727073fc-7eaa-4628-82f4-f3459956260c', '/storage/products/727073fc-7eaa-4628-82f4-f3459956260c/product-15-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('e14c9f38-7b98-4013-b367-47030d2b5ff9', '90af310d-b7b6-48c2-8bdc-37158b0bb6d0', '/storage/products/90af310d-b7b6-48c2-8bdc-37158b0bb6d0/product-16-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('57528f1b-46bb-4af5-9cd6-5a32dbe99694', '90af310d-b7b6-48c2-8bdc-37158b0bb6d0', '/storage/products/90af310d-b7b6-48c2-8bdc-37158b0bb6d0/product-16-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('f9833d48-7256-4738-8073-bc43acb76c0b', 'f85f492b-0dc9-457a-9b0e-bd3f483cac07', '/storage/products/f85f492b-0dc9-457a-9b0e-bd3f483cac07/product-1-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('eb365efc-07c0-458f-89f1-c2cd5b2113f8', 'f85f492b-0dc9-457a-9b0e-bd3f483cac07', '/storage/products/f85f492b-0dc9-457a-9b0e-bd3f483cac07/product-1-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('2c64a0b7-3e5e-4176-92d1-044f56c43ffd', 'f85f492b-0dc9-457a-9b0e-bd3f483cac07', '/storage/products/f85f492b-0dc9-457a-9b0e-bd3f483cac07/product-1-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('a69d4fa9-c40f-455d-82dd-def4e8c7248e', 'f85f492b-0dc9-457a-9b0e-bd3f483cac07', '/storage/products/f85f492b-0dc9-457a-9b0e-bd3f483cac07/product-1-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('08a0049b-0d4a-48c2-9a62-fe973a368ec6', '4471e5da-7158-4233-b8c6-50cc0610ba70', '/storage/products/4471e5da-7158-4233-b8c6-50cc0610ba70/product-2-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('792f43dc-06f3-4bd2-9567-3c4ab92f6ad0', '4471e5da-7158-4233-b8c6-50cc0610ba70', '/storage/products/4471e5da-7158-4233-b8c6-50cc0610ba70/product-2-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('4d92b7c8-af59-4bbc-bcde-0d31cd7762df', '4471e5da-7158-4233-b8c6-50cc0610ba70', '/storage/products/4471e5da-7158-4233-b8c6-50cc0610ba70/product-2-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('2331ecf8-d9d9-47a9-b8a2-c07182fd38b3', '4471e5da-7158-4233-b8c6-50cc0610ba70', '/storage/products/4471e5da-7158-4233-b8c6-50cc0610ba70/product-2-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('8f52a382-c0ea-4868-b2c1-bb90a27e0071', '81d09f16-176d-4c98-ba9f-69ed3e8b3656', '/storage/products/81d09f16-176d-4c98-ba9f-69ed3e8b3656/product-3-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('82aad151-77f7-44ae-81df-8df2772a928e', '81d09f16-176d-4c98-ba9f-69ed3e8b3656', '/storage/products/81d09f16-176d-4c98-ba9f-69ed3e8b3656/product-3-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('183da015-f80f-44ce-be6d-080bf4f19965', '81d09f16-176d-4c98-ba9f-69ed3e8b3656', '/storage/products/81d09f16-176d-4c98-ba9f-69ed3e8b3656/product-3-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('c2d47892-17fe-4d71-964d-96b517e76b9d', '81d09f16-176d-4c98-ba9f-69ed3e8b3656', '/storage/products/81d09f16-176d-4c98-ba9f-69ed3e8b3656/product-3-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('f0f29bdb-0d44-4b05-9b28-2ae35178212f', 'fc98ff4b-a265-456c-a5ab-8bb13b954e4e', '/storage/products/fc98ff4b-a265-456c-a5ab-8bb13b954e4e/product-4-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('51323557-9aff-4025-90bf-57f6084b0135', 'fc98ff4b-a265-456c-a5ab-8bb13b954e4e', '/storage/products/fc98ff4b-a265-456c-a5ab-8bb13b954e4e/product-4-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('d5da5147-9eb9-4962-95e5-1f35cc65a654', 'fc98ff4b-a265-456c-a5ab-8bb13b954e4e', '/storage/products/fc98ff4b-a265-456c-a5ab-8bb13b954e4e/product-4-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('f1c8b0bc-5baf-472d-91e9-378d787d6360', 'fc98ff4b-a265-456c-a5ab-8bb13b954e4e', '/storage/products/fc98ff4b-a265-456c-a5ab-8bb13b954e4e/product-4-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('987f8b62-bdbd-453a-9457-1611d60037e9', 'bde2ca58-9db7-4ba6-a192-337a5973f732', '/storage/products/bde2ca58-9db7-4ba6-a192-337a5973f732/product-5-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('17e84f9d-1d41-4a0d-9230-308845316816', 'bde2ca58-9db7-4ba6-a192-337a5973f732', '/storage/products/bde2ca58-9db7-4ba6-a192-337a5973f732/product-5-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('eea3ac6c-e911-4254-8599-49b6bf76cf84', 'bde2ca58-9db7-4ba6-a192-337a5973f732', '/storage/products/bde2ca58-9db7-4ba6-a192-337a5973f732/product-5-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('ef80bbcc-f70a-4354-b82e-b3b47f1033ab', 'bde2ca58-9db7-4ba6-a192-337a5973f732', '/storage/products/bde2ca58-9db7-4ba6-a192-337a5973f732/product-5-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('a82dfc50-8773-410d-b003-89eace41f77c', '6859f1a2-8f00-4562-8273-bf4746f6baae', '/storage/products/6859f1a2-8f00-4562-8273-bf4746f6baae/product-6-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('2890db70-e0f7-48a1-9643-9882afe0b954', '6859f1a2-8f00-4562-8273-bf4746f6baae', '/storage/products/6859f1a2-8f00-4562-8273-bf4746f6baae/product-6-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('c9720761-44ce-4147-aa9b-247c083a3cfe', '6859f1a2-8f00-4562-8273-bf4746f6baae', '/storage/products/6859f1a2-8f00-4562-8273-bf4746f6baae/product-6-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('1ba22c0f-58b9-4227-aea1-f099e0021831', '6859f1a2-8f00-4562-8273-bf4746f6baae', '/storage/products/6859f1a2-8f00-4562-8273-bf4746f6baae/product-6-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('57bbc859-0add-4b14-b7bc-ebb47c022817', '0edb98fe-04b3-46b3-8805-db112188a8b7', '/storage/products/0edb98fe-04b3-46b3-8805-db112188a8b7/product-7-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('696b2d13-2a10-4063-93da-8c0105fdb911', '0edb98fe-04b3-46b3-8805-db112188a8b7', '/storage/products/0edb98fe-04b3-46b3-8805-db112188a8b7/product-7-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('d8963357-4d03-49e9-b886-6845d0ae74bc', '0edb98fe-04b3-46b3-8805-db112188a8b7', '/storage/products/0edb98fe-04b3-46b3-8805-db112188a8b7/product-7-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('44071e8d-44fa-40f1-a5bf-ed4179cbe3ab', '0edb98fe-04b3-46b3-8805-db112188a8b7', '/storage/products/0edb98fe-04b3-46b3-8805-db112188a8b7/product-7-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('2ec6a2ff-d892-4434-bd05-f7f1c67d83a1', 'd1f40074-3413-45e6-aca4-0bf0b02bc7ad', '/storage/products/d1f40074-3413-45e6-aca4-0bf0b02bc7ad/product-8-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('3df2da9d-7100-4007-8dc5-8b865e42c81e', 'd1f40074-3413-45e6-aca4-0bf0b02bc7ad', '/storage/products/d1f40074-3413-45e6-aca4-0bf0b02bc7ad/product-8-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('1ff8f230-e7fe-414f-acf7-af3c8a1a4e16', 'd1f40074-3413-45e6-aca4-0bf0b02bc7ad', '/storage/products/d1f40074-3413-45e6-aca4-0bf0b02bc7ad/product-8-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('688a05c3-10c9-4bd2-a806-0b11de9e5ad8', '2aec5f21-73e9-4a9f-a8c3-20d923a14580', '/storage/products/2aec5f21-73e9-4a9f-a8c3-20d923a14580/product-9-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('3081428c-9d16-4474-85da-e21cb2305d2d', '2aec5f21-73e9-4a9f-a8c3-20d923a14580', '/storage/products/2aec5f21-73e9-4a9f-a8c3-20d923a14580/product-9-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('171bb00d-076b-4d4c-968b-5e3637dd6163', '2aec5f21-73e9-4a9f-a8c3-20d923a14580', '/storage/products/2aec5f21-73e9-4a9f-a8c3-20d923a14580/product-9-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('f33cbb86-6fc9-4bf3-ba2a-ab5c18d78745', '2aec5f21-73e9-4a9f-a8c3-20d923a14580', '/storage/products/2aec5f21-73e9-4a9f-a8c3-20d923a14580/product-9-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('ee446608-67fc-4221-aff3-0e8118903fdd', 'd9d4060e-ea49-436d-aee3-bce102ec46dd', '/storage/products/d9d4060e-ea49-436d-aee3-bce102ec46dd/product-10-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('2c8f34b5-4227-467e-895e-48b1b5e73788', 'd9d4060e-ea49-436d-aee3-bce102ec46dd', '/storage/products/d9d4060e-ea49-436d-aee3-bce102ec46dd/product-10-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('d1aae058-c647-408f-9a89-21855c1d0743', 'd9d4060e-ea49-436d-aee3-bce102ec46dd', '/storage/products/d9d4060e-ea49-436d-aee3-bce102ec46dd/product-10-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('145f8ef4-4bb4-443a-b648-085efd57da10', 'd9d4060e-ea49-436d-aee3-bce102ec46dd', '/storage/products/d9d4060e-ea49-436d-aee3-bce102ec46dd/product-10-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('a8526f7d-de42-4cf0-89f4-cb84521b99fe', '3e988e38-6911-4717-a81d-52a32c2515e8', '/storage/products/3e988e38-6911-4717-a81d-52a32c2515e8/product-11-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('23c56110-44e0-443d-9189-722a74b2b021', '3e988e38-6911-4717-a81d-52a32c2515e8', '/storage/products/3e988e38-6911-4717-a81d-52a32c2515e8/product-11-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('41d0cb24-cb4c-4a53-a2d9-4fa3e37787fc', '3e988e38-6911-4717-a81d-52a32c2515e8', '/storage/products/3e988e38-6911-4717-a81d-52a32c2515e8/product-11-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('6f8f5b57-c287-4bd9-80cd-1e5ba67ac28e', '3e988e38-6911-4717-a81d-52a32c2515e8', '/storage/products/3e988e38-6911-4717-a81d-52a32c2515e8/product-11-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('29eccbd1-d41d-4dea-9cf6-feee49af706a', '535e519e-f1ea-4564-bce7-6163bd6be130', '/storage/products/535e519e-f1ea-4564-bce7-6163bd6be130/product-12-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('ea44bac3-4914-4bca-ad72-943cc969b9c5', '535e519e-f1ea-4564-bce7-6163bd6be130', '/storage/products/535e519e-f1ea-4564-bce7-6163bd6be130/product-12-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('ddbb7e95-0700-4f67-acc3-5b1bb52993f7', '535e519e-f1ea-4564-bce7-6163bd6be130', '/storage/products/535e519e-f1ea-4564-bce7-6163bd6be130/product-12-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('83fd5f53-b704-4e38-b89a-d1ff42475417', '535e519e-f1ea-4564-bce7-6163bd6be130', '/storage/products/535e519e-f1ea-4564-bce7-6163bd6be130/product-12-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('0f03392a-3f40-47a4-86aa-aa5c7a80c6a6', 'bddcddef-efe3-4730-97b0-a683dfc1cc23', '/storage/products/bddcddef-efe3-4730-97b0-a683dfc1cc23/product-13-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('c166f825-2d01-4076-b7fa-6e591b80665e', 'bddcddef-efe3-4730-97b0-a683dfc1cc23', '/storage/products/bddcddef-efe3-4730-97b0-a683dfc1cc23/product-13-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('2e237195-e6fc-46ca-9f67-4d710e77b28b', 'bddcddef-efe3-4730-97b0-a683dfc1cc23', '/storage/products/bddcddef-efe3-4730-97b0-a683dfc1cc23/product-13-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('9b466b3b-eabd-4af5-815f-35e24633d144', 'bddcddef-efe3-4730-97b0-a683dfc1cc23', '/storage/products/bddcddef-efe3-4730-97b0-a683dfc1cc23/product-13-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('9d6b9703-1d68-44e2-859f-dee9b7d21d5a', '90af310d-b7b6-48c2-8bdc-37158b0bb6d0', '/storage/products/90af310d-b7b6-48c2-8bdc-37158b0bb6d0/product-16-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('1fb7d6de-61c6-4d16-8d1d-703c7726427e', '90af310d-b7b6-48c2-8bdc-37158b0bb6d0', '/storage/products/90af310d-b7b6-48c2-8bdc-37158b0bb6d0/product-16-sm-2.png', 'Thumb 2', 3, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('6ccc9eb6-b62b-4055-98b8-892f6393e1dd', '8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', '/storage/products/8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76/product-17-bg-1.png', 'Front', 0, true);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('af6d20e0-b6b5-4bfa-bbd0-dec761daf931', '8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', '/storage/products/8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76/product-17-bg-2.png', 'Back', 1, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('83f1d97c-ecdd-43eb-a5fd-d8232bb38a48', '8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', '/storage/products/8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76/product-17-sm-1.png', 'Thumb 1', 2, false);
INSERT INTO public.product_images (id, product_id, url, alt_text, sort_order, is_primary) VALUES ('7252a06c-b699-4355-a996-9ab6a2cd7e01', '8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', '/storage/products/8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76/product-17-sm-2.png', 'Thumb 2', 3, false);


--
-- Data for Name: product_tags; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_tags (product_id, tag_id) VALUES ('f85f492b-0dc9-457a-9b0e-bd3f483cac07', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('4471e5da-7158-4233-b8c6-50cc0610ba70', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('4471e5da-7158-4233-b8c6-50cc0610ba70', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('81d09f16-176d-4c98-ba9f-69ed3e8b3656', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('fc98ff4b-a265-456c-a5ab-8bb13b954e4e', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('fc98ff4b-a265-456c-a5ab-8bb13b954e4e', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('bde2ca58-9db7-4ba6-a192-337a5973f732', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('bde2ca58-9db7-4ba6-a192-337a5973f732', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('6859f1a2-8f00-4562-8273-bf4746f6baae', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('6859f1a2-8f00-4562-8273-bf4746f6baae', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('0edb98fe-04b3-46b3-8805-db112188a8b7', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('0edb98fe-04b3-46b3-8805-db112188a8b7', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('d1f40074-3413-45e6-aca4-0bf0b02bc7ad', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('2aec5f21-73e9-4a9f-a8c3-20d923a14580', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('2aec5f21-73e9-4a9f-a8c3-20d923a14580', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('d9d4060e-ea49-436d-aee3-bce102ec46dd', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('3e988e38-6911-4717-a81d-52a32c2515e8', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('535e519e-f1ea-4564-bce7-6163bd6be130', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('535e519e-f1ea-4564-bce7-6163bd6be130', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('bddcddef-efe3-4730-97b0-a683dfc1cc23', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('f42f2841-0fbf-4c00-9b3a-c79c5373aa49', 'd183f25e-b49c-4a5d-8336-206734201a42');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('f42f2841-0fbf-4c00-9b3a-c79c5373aa49', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('727073fc-7eaa-4628-82f4-f3459956260c', '098fda37-c2f4-4605-8e0e-0c3ed1204b6d');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('727073fc-7eaa-4628-82f4-f3459956260c', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('90af310d-b7b6-48c2-8bdc-37158b0bb6d0', 'b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe');
INSERT INTO public.product_tags (product_id, tag_id) VALUES ('8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', 'd183f25e-b49c-4a5d-8336-206734201a42');


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('7e83576f-02a7-4f14-a93c-b816c762abe3', 'f85f492b-0dc9-457a-9b0e-bd3f483cac07', 'GP-HV-G69-BLK', NULL, 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.628');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('4c323733-e2f0-44a7-afa0-55b0bc7a4348', '4471e5da-7158-4233-b8c6-50cc0610ba70', 'IP-14P-128-MID', NULL, 'Midnight', NULL, NULL, NULL, '2026-05-04 02:07:34.645');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('e1dc6171-0941-412f-8942-0ec56f4b66da', '4471e5da-7158-4233-b8c6-50cc0610ba70', 'IP-14P-128-PUR', NULL, 'Purple', NULL, NULL, NULL, '2026-05-04 02:07:34.645');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('78f15967-08ee-44ed-a471-f6c5f026031e', '81d09f16-176d-4c98-ba9f-69ed3e8b3656', 'AP-IMAC-M1-24-SLV', NULL, 'Silver', NULL, NULL, NULL, '2026-05-04 02:07:34.658');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('459e7679-fbe6-4d73-903a-78b2759a67d9', 'fc98ff4b-a265-456c-a5ab-8bb13b954e4e', 'AP-MBA-M1-256-SG', NULL, 'Space Gray', NULL, NULL, NULL, '2026-05-04 02:07:34.669');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('011f8e82-bd98-4576-ba51-4a06f051d4e6', 'fc98ff4b-a265-456c-a5ab-8bb13b954e4e', 'AP-MBA-M1-256-SLV', NULL, 'Silver', NULL, NULL, NULL, '2026-05-04 02:07:34.669');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('f7e69bec-c25a-46cd-8bbd-fe6eac5e9cfb', 'bde2ca58-9db7-4ba6-a192-337a5973f732', 'AP-AW-ULTRA-41', '41mm', 'Titanium', NULL, NULL, NULL, '2026-05-04 02:07:34.68');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('0d5e9a08-52fa-4c61-870f-3437d8d28bb9', 'bde2ca58-9db7-4ba6-a192-337a5973f732', 'AP-AW-ULTRA-45', '45mm', 'Titanium', NULL, NULL, NULL, '2026-05-04 02:07:34.68');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('75b185c6-77c9-49be-acca-b2c85ad054f6', 'bde2ca58-9db7-4ba6-a192-337a5973f732', 'AP-AW-ULTRA-49', '49mm', 'Titanium', NULL, NULL, NULL, '2026-05-04 02:07:34.68');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('35544a78-e4b7-4f76-ac0f-086fdb9838f6', '6859f1a2-8f00-4562-8273-bf4746f6baae', 'LG-MX3-GRP', NULL, 'Graphite', NULL, NULL, NULL, '2026-05-04 02:07:34.692');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('859c61cd-de93-4397-bdbf-1c9cbc2fa073', '6859f1a2-8f00-4562-8273-bf4746f6baae', 'LG-MX3-PG', NULL, 'Pale Gray', NULL, NULL, NULL, '2026-05-04 02:07:34.692');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('0346f41d-c91e-4b6e-879c-99806a65b536', '0edb98fe-04b3-46b3-8805-db112188a8b7', 'AP-IPAD-AIR5-64-BLU', NULL, 'Blue', NULL, NULL, NULL, '2026-05-04 02:07:34.701');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('41843354-c4c7-4923-87e2-e680ceda5f10', '0edb98fe-04b3-46b3-8805-db112188a8b7', 'AP-IPAD-AIR5-64-SG', NULL, 'Space Gray', NULL, NULL, NULL, '2026-05-04 02:07:34.701');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('6d927860-db3f-4031-8be0-a1d0bebcd290', 'd1f40074-3413-45e6-aca4-0bf0b02bc7ad', 'AS-RT-DB-BLK', NULL, 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.713');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('228510db-d7e8-4861-becc-04aa2bdda296', '2aec5f21-73e9-4a9f-a8c3-20d923a14580', 'SM-QLED-55-BLK', '55"', 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.722');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('8255dda3-37ef-4010-bb87-ee27d7a452eb', 'd9d4060e-ea49-436d-aee3-bce102ec46dd', 'SN-BR-65-BLK', '65"', 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.729');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('143f3383-fa0e-4ead-aee2-2c9438422823', '3e988e38-6911-4717-a81d-52a32c2515e8', 'LG-OLED-50-BLK', '50"', 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.735');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('43e95a49-963e-42a5-8b26-7c3b69a3f438', '535e519e-f1ea-4564-bce7-6163bd6be130', 'XM-AP-4-WHT', NULL, 'White', NULL, NULL, NULL, '2026-05-04 02:07:34.742');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('7ad9a6ba-dc12-4f15-8255-0386be4112b4', 'bddcddef-efe3-4730-97b0-a683dfc1cc23', 'PH-AF-XXL-BLK', NULL, 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.749');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('fc2e2b30-c263-4a31-8aa5-8bcbb4dbc507', 'f42f2841-0fbf-4c00-9b3a-c79c5373aa49', 'DK-AC-15-INV-WHT', NULL, 'White', NULL, NULL, NULL, '2026-05-04 02:07:34.756');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('e7df5d08-0d79-41f2-8e63-bc1a9d59a774', '727073fc-7eaa-4628-82f4-f3459956260c', 'XM-MB-8-BLK', NULL, 'Graphite', NULL, NULL, NULL, '2026-05-04 02:07:34.763');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('ce0a384a-3f8e-4dc1-a8d5-64b8c506bba9', '727073fc-7eaa-4628-82f4-f3459956260c', 'XM-MB-8-GLD', NULL, 'Champagne Gold', NULL, NULL, NULL, '2026-05-04 02:07:34.763');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('785101be-13b2-4fb5-969d-0656bd59ce19', '90af310d-b7b6-48c2-8bdc-37158b0bb6d0', 'YM-PRO-6MM-BLU', NULL, 'Blue', NULL, NULL, NULL, '2026-05-04 02:07:34.772');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('2490f88d-2c5b-4699-b0c7-d7adc92c6a85', '90af310d-b7b6-48c2-8bdc-37158b0bb6d0', 'YM-PRO-6MM-PUR', NULL, 'Purple', NULL, NULL, NULL, '2026-05-04 02:07:34.772');
INSERT INTO public.product_variants (id, product_id, sku, size, color, price_override, weight_grams, attributes, created_at) VALUES ('4040f849-74b0-48dd-8a66-5fce31714078', '8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', 'ADJ-DB-24KG-BLK', NULL, 'Black', NULL, NULL, NULL, '2026-05-04 02:07:34.782');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('f85f492b-0dc9-457a-9b0e-bd3f483cac07', '5041b743-1396-47af-8ee2-12c5ed70556b', 'GP-HV-G69', 'Havit HV-G69 USB Gamepad', 'havit-hv-g69-usb-gamepad', 'Wired USB gamepad with vibration feedback.', 3290.00, 'BDT', true, '2026-05-04 02:07:34.628', '2026-05-04 02:07:34.628', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('4471e5da-7158-4233-b8c6-50cc0610ba70', '2b21f711-70fe-4073-9a0b-0ccdcabe5a03', 'IP-14P-128', 'iPhone 14 Plus 6/128GB', 'iphone-14-plus-6-128gb', 'Apple iPhone 14 Plus with 6GB RAM and 128GB storage.', 98900.00, 'BDT', true, '2026-05-04 02:07:34.645', '2026-05-04 02:07:34.645', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('81d09f16-176d-4c98-ba9f-69ed3e8b3656', '6a9c8a82-4d33-4978-b29c-9805cc39107a', 'AP-IMAC-M1-24', 'Apple iMac M1 24-inch 2021', 'apple-imac-m1-24-2021', 'All-in-one desktop with M1 chip and 24-inch Retina display.', 149900.00, 'BDT', true, '2026-05-04 02:07:34.658', '2026-05-04 02:07:34.658', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('fc98ff4b-a265-456c-a5ab-8bb13b954e4e', '6a9c8a82-4d33-4978-b29c-9805cc39107a', 'AP-MBA-M1-256', 'MacBook Air M1 8/256GB', 'macbook-air-m1-8-256gb', 'Apple MacBook Air with M1 chip, 8GB unified memory, 256GB SSD.', 109900.00, 'BDT', true, '2026-05-04 02:07:34.669', '2026-05-04 02:07:34.669', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('bde2ca58-9db7-4ba6-a192-337a5973f732', '392a958d-ca29-41f5-a782-f5b89c208d46', 'AP-AW-ULTRA', 'Apple Watch Ultra', 'apple-watch-ultra', 'Rugged titanium Apple Watch built for adventure.', 89900.00, 'BDT', true, '2026-05-04 02:07:34.68', '2026-05-04 02:07:34.68', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('6859f1a2-8f00-4562-8273-bf4746f6baae', '6a9c8a82-4d33-4978-b29c-9805cc39107a', 'LG-MX3', 'Logitech MX Master 3 Mouse', 'logitech-mx-master-3-mouse', 'Advanced wireless mouse with MagSpeed scrolling.', 11900.00, 'BDT', true, '2026-05-04 02:07:34.692', '2026-05-04 02:07:34.692', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('0edb98fe-04b3-46b3-8805-db112188a8b7', '2b21f711-70fe-4073-9a0b-0ccdcabe5a03', 'AP-IPAD-AIR5-64', 'Apple iPad Air 5th Gen 64GB', 'apple-ipad-air-5-64gb', 'Apple iPad Air with M1 chip, 10.9-inch Liquid Retina display.', 64900.00, 'BDT', true, '2026-05-04 02:07:34.701', '2026-05-04 02:07:34.701', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('d1f40074-3413-45e6-aca4-0bf0b02bc7ad', '6a9c8a82-4d33-4978-b29c-9805cc39107a', 'AS-RT-DB', 'Asus RT Dual Band Router', 'asus-rt-dual-band-router', 'Dual-band Wi-Fi 6 gigabit router with mesh support.', 14900.00, 'BDT', true, '2026-05-04 02:07:34.713', '2026-05-04 02:07:34.713', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('2aec5f21-73e9-4a9f-a8c3-20d923a14580', '8521b632-49c5-45ff-a539-68ec78cd878b', 'SM-QLED-55', 'Samsung 55" QLED 4K Smart TV', 'samsung-55-qled-4k-smart-tv', 'Quantum Dot 4K UHD smart TV with HDR10+ and Tizen OS.', 129900.00, 'BDT', true, '2026-05-04 02:07:34.722', '2026-05-04 02:07:34.722', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('d9d4060e-ea49-436d-aee3-bce102ec46dd', '8521b632-49c5-45ff-a539-68ec78cd878b', 'SN-BR-65', 'Sony Bravia 65" 4K Google TV', 'sony-bravia-65-4k-google-tv', 'X-Reality PRO 4K HDR LED panel with Google TV.', 174900.00, 'BDT', true, '2026-05-04 02:07:34.729', '2026-05-04 02:07:34.729', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('3e988e38-6911-4717-a81d-52a32c2515e8', '8521b632-49c5-45ff-a539-68ec78cd878b', 'LG-OLED-50', 'LG OLED 50" Evo C3', 'lg-oled-50-evo-c3', 'Self-lit OLED with α9 AI Processor Gen6 and Dolby Vision.', 189900.00, 'BDT', true, '2026-05-04 02:07:34.735', '2026-05-04 02:07:34.735', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('535e519e-f1ea-4564-bce7-6163bd6be130', 'febade3f-1d9e-4a14-83b5-6939ccb6d3d1', 'XM-AP-4', 'Xiaomi Smart Air Purifier 4', 'xiaomi-smart-air-purifier-4', 'HEPA H13 filter, OLED display, app-controlled.', 18900.00, 'BDT', true, '2026-05-04 02:07:34.742', '2026-05-04 02:07:34.742', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('bddcddef-efe3-4730-97b0-a683dfc1cc23', 'febade3f-1d9e-4a14-83b5-6939ccb6d3d1', 'PH-AF-XXL', 'Philips Airfryer XXL Premium', 'philips-airfryer-xxl-premium', 'Twin TurboStar 7.3L air fryer with Smart Sensing.', 28900.00, 'BDT', true, '2026-05-04 02:07:34.749', '2026-05-04 02:07:34.749', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('f42f2841-0fbf-4c00-9b3a-c79c5373aa49', 'febade3f-1d9e-4a14-83b5-6939ccb6d3d1', 'DK-AC-15-INV', 'Daikin 1.5 Ton Inverter AC', 'daikin-1-5-ton-inverter-ac', '5-star inverter split AC with Coanda airflow and PM2.5 filter.', 64900.00, 'BDT', true, '2026-05-04 02:07:34.756', '2026-05-04 02:07:34.756', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('727073fc-7eaa-4628-82f4-f3459956260c', '04a914f3-47f1-4c0e-8425-a8c02a5667c2', 'XM-MB-8', 'Xiaomi Mi Band 8', 'xiaomi-mi-band-8', '1.62" AMOLED fitness band with 150+ workout modes.', 4990.00, 'BDT', true, '2026-05-04 02:07:34.763', '2026-05-04 02:07:34.763', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('90af310d-b7b6-48c2-8bdc-37158b0bb6d0', '04a914f3-47f1-4c0e-8425-a8c02a5667c2', 'YM-PRO-6MM', 'Pro TPE Yoga Mat 6mm', 'pro-tpe-yoga-mat-6mm', 'Eco-friendly TPE yoga mat with non-slip texture, carry strap.', 2490.00, 'BDT', true, '2026-05-04 02:07:34.772', '2026-05-04 02:07:34.772', NULL, NULL, NULL);
INSERT INTO public.products (id, category_id, sku, name, slug, description, base_price, currency, active, created_at, updated_at, specifications, care_instructions, attributes) VALUES ('8fcd674a-1ce9-4a5e-b4c7-90e9bb09dc76', '04a914f3-47f1-4c0e-8425-a8c02a5667c2', 'ADJ-DB-24KG', 'Adjustable Dumbbell 24kg Pair', 'adjustable-dumbbell-24kg-pair', 'Quick-select adjustable dumbbell pair, 2.5–24kg per side.', 14900.00, 'BDT', true, '2026-05-04 02:07:34.782', '2026-05-04 02:07:34.782', NULL, NULL, NULL);


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.reviews (id, user_id, product_id, order_item_id, rating, title, body, verified_purchase, created_at) VALUES ('e87256fb-702e-46e0-a298-e242123999f7', 'f150e58a-22e3-49f8-b20f-bea2eb3e46eb', '4471e5da-7158-4233-b8c6-50cc0610ba70', '612f67af-b00d-4bfe-9e25-43a90ccc1fc0', 5, 'Worth every taka', 'Display is gorgeous, battery lasts a full day.', true, '2026-05-04 02:07:34.826');
INSERT INTO public.reviews (id, user_id, product_id, order_item_id, rating, title, body, verified_purchase, created_at) VALUES ('2b889e38-6dc3-4a48-8ed1-fd75450793b4', 'dba59a74-23f3-47c7-9e8f-86e1c3367534', '6859f1a2-8f00-4562-8273-bf4746f6baae', NULL, 4, 'Smooth scrolling', 'MagSpeed wheel is genuinely useful — minor learning curve.', false, '2026-05-04 02:07:34.828');


--
-- Data for Name: shipment_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.shipment_items (id, shipment_id, order_item_id, quantity) VALUES ('44d6ccbc-9fd6-453e-9be7-5f9556aec41f', 'b09df58d-7376-4a84-8066-e24720ec5b35', '612f67af-b00d-4bfe-9e25-43a90ccc1fc0', 2);
INSERT INTO public.shipment_items (id, shipment_id, order_item_id, quantity) VALUES ('c02788eb-8c96-4279-90fa-adc0ad9c9c06', 'b09df58d-7376-4a84-8066-e24720ec5b35', '3cb986f2-3ba8-4a51-88a8-9757a48aecb5', 1);


--
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.shipments (id, order_id, carrier, tracking_number, status, shipped_at, delivered_at, created_at) VALUES ('b09df58d-7376-4a84-8066-e24720ec5b35', '280609c3-eb91-4594-a190-df594a1a45d6', 'UPS', '1Z999AA10123456784', 'shipped', '2026-05-04 02:07:34.823', NULL, '2026-05-04 02:07:34.823');


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tags (id, name) VALUES ('d183f25e-b49c-4a5d-8336-206734201a42', 'featured');
INSERT INTO public.tags (id, name) VALUES ('b5b1e228-f6dd-4271-a7e1-1a0aca00ecbe', 'sale');
INSERT INTO public.tags (id, name) VALUES ('098fda37-c2f4-4605-8e0e-0c3ed1204b6d', 'new');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (id, email, password_hash, first_name, last_name, phone, role, email_verified, created_at, updated_at) VALUES ('8566421c-457b-497a-83f5-73652e35a7b2', 'admin@orbitalmind.xyz', '$2b$10$ChT0SfRUfNdN6IZD1XVRbOvxzTaJProPtjkNjQVSe15HcbLsxP1oG', 'Admin', 'User', NULL, 'admin', true, '2026-05-04 02:07:34.572', '2026-05-04 02:07:34.572');
INSERT INTO public.users (id, email, password_hash, first_name, last_name, phone, role, email_verified, created_at, updated_at) VALUES ('dba59a74-23f3-47c7-9e8f-86e1c3367534', 'jane@example.com', '$2b$10$ChT0SfRUfNdN6IZD1XVRbOvxzTaJProPtjkNjQVSe15HcbLsxP1oG', 'Jane', 'Doe', NULL, 'customer', true, '2026-05-04 02:07:34.573', '2026-05-04 02:07:34.573');
INSERT INTO public.users (id, email, password_hash, first_name, last_name, phone, role, email_verified, created_at, updated_at) VALUES ('f150e58a-22e3-49f8-b20f-bea2eb3e46eb', 'bob@example.com', '$2b$10$ChT0SfRUfNdN6IZD1XVRbOvxzTaJProPtjkNjQVSe15HcbLsxP1oG', 'Bob', 'Smith', NULL, 'customer', false, '2026-05-04 02:07:34.573', '2026-05-04 02:07:34.573');


--
-- Data for Name: wishlist_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.wishlist_items (id, wishlist_id, variant_id, added_at) VALUES ('1ff66851-4b9a-403a-8c74-3406134dc2bb', 'b2ca9b42-5853-43f4-b040-cc80b8e7f94e', '7e83576f-02a7-4f14-a93c-b816c762abe3', '2026-05-04 02:07:34.829');
INSERT INTO public.wishlist_items (id, wishlist_id, variant_id, added_at) VALUES ('ea4b8533-153a-49e7-ae72-e6c5a3f9e613', 'b2ca9b42-5853-43f4-b040-cc80b8e7f94e', 'f7e69bec-c25a-46cd-8bbd-fe6eac5e9cfb', '2026-05-04 02:07:34.829');
INSERT INTO public.wishlist_items (id, wishlist_id, variant_id, added_at) VALUES ('813c1822-7f27-47c4-916d-c817e5757b2a', 'b2ca9b42-5853-43f4-b040-cc80b8e7f94e', '35544a78-e4b7-4f76-ac0f-086fdb9838f6', '2026-05-04 02:07:34.829');


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.wishlists (id, user_id, name, is_public, created_at) VALUES ('b2ca9b42-5853-43f4-b040-cc80b8e7f94e', 'dba59a74-23f3-47c7-9e8f-86e1c3367534', 'Wishlist', false, '2026-05-04 02:07:34.829');


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: product_tags product_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_pkey PRIMARY KEY (product_id, tag_id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: shipment_items shipment_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_items
    ADD CONSTRAINT shipment_items_pkey PRIMARY KEY (id);


--
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wishlist_items wishlist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items
    ADD CONSTRAINT wishlist_items_pkey PRIMARY KEY (id);


--
-- Name: wishlists wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: addresses_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_user_id_idx ON public.addresses USING btree (user_id);


--
-- Name: cart_items_cart_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_cart_id_idx ON public.cart_items USING btree (cart_id);


--
-- Name: carts_user_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX carts_user_id_key ON public.carts USING btree (user_id);


--
-- Name: categories_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_parent_id_idx ON public.categories USING btree (parent_id);


--
-- Name: categories_slug_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX categories_slug_key ON public.categories USING btree (slug);


--
-- Name: coupons_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX coupons_code_key ON public.coupons USING btree (code);


--
-- Name: inventory_variant_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX inventory_variant_id_key ON public.inventory USING btree (variant_id);


--
-- Name: order_items_order_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_order_id_idx ON public.order_items USING btree (order_id);


--
-- Name: orders_order_number_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX orders_order_number_key ON public.orders USING btree (order_number);


--
-- Name: orders_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_user_id_idx ON public.orders USING btree (user_id);


--
-- Name: payments_order_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_order_id_idx ON public.payments USING btree (order_id);


--
-- Name: product_images_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_images_product_id_idx ON public.product_images USING btree (product_id);


--
-- Name: product_variants_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_product_id_idx ON public.product_variants USING btree (product_id);


--
-- Name: product_variants_sku_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_variants_sku_key ON public.product_variants USING btree (sku);


--
-- Name: products_category_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_category_id_idx ON public.products USING btree (category_id);


--
-- Name: products_sku_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_sku_key ON public.products USING btree (sku);


--
-- Name: products_slug_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_slug_key ON public.products USING btree (slug);


--
-- Name: reviews_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_product_id_idx ON public.reviews USING btree (product_id);


--
-- Name: shipments_order_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipments_order_id_idx ON public.shipments USING btree (order_id);


--
-- Name: tags_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tags_name_key ON public.tags USING btree (name);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: wishlist_items_wishlist_id_variant_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX wishlist_items_wishlist_id_variant_id_key ON public.wishlist_items USING btree (wishlist_id, variant_id);


--
-- Name: wishlists_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlists_user_id_idx ON public.wishlists USING btree (user_id);


--
-- Name: addresses addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_items cart_items_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: carts carts_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.coupons(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: categories categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inventory inventory_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_items order_items_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_billing_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_billing_address_id_fkey FOREIGN KEY (billing_address_id) REFERENCES public.addresses(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orders_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.coupons(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orders_shipping_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_shipping_address_id_fkey FOREIGN KEY (shipping_address_id) REFERENCES public.addresses(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_images product_images_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_tags product_tags_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_tags product_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variants product_variants_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reviews reviews_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipment_items shipment_items_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_items
    ADD CONSTRAINT shipment_items_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: shipment_items shipment_items_shipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_items
    ADD CONSTRAINT shipment_items_shipment_id_fkey FOREIGN KEY (shipment_id) REFERENCES public.shipments(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipments shipments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wishlist_items wishlist_items_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items
    ADD CONSTRAINT wishlist_items_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: wishlist_items wishlist_items_wishlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items
    ADD CONSTRAINT wishlist_items_wishlist_id_fkey FOREIGN KEY (wishlist_id) REFERENCES public.wishlists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wishlists wishlists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


