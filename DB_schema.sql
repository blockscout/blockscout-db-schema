--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8
-- Dumped by pg_dump version 12.8

-- Started on 2022-06-23 11:32:57 +03

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

--
-- TOC entry 4 (class 3079 OID 709217)
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- TOC entry 3 (class 3079 OID 709998)
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- TOC entry 2 (class 3079 OID 710242)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 709898)
-- Name: address_coin_balances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_coin_balances (
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    value numeric(100,0) DEFAULT NULL::numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.address_coin_balances OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 710471)
-- Name: address_coin_balances_daily; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_coin_balances_daily (
    address_hash bytea NOT NULL,
    day date NOT NULL,
    value numeric(100,0) DEFAULT NULL::numeric,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.address_coin_balances_daily OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 710118)
-- Name: address_current_token_balances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_current_token_balances (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    value numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_value numeric,
    token_id numeric(78,0),
    token_type character varying(255)
);


ALTER TABLE public.address_current_token_balances OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 710116)
-- Name: address_current_token_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_current_token_balances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_current_token_balances_id_seq OWNER TO postgres;

--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 230
-- Name: address_current_token_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.address_current_token_balances_id_seq OWNED BY public.address_current_token_balances.id;


--
-- TOC entry 225 (class 1259 OID 709935)
-- Name: address_names; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_names (
    address_hash bytea NOT NULL,
    name character varying(255) NOT NULL,
    "primary" boolean DEFAULT false NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    metadata jsonb
);


ALTER TABLE public.address_names OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 709914)
-- Name: address_token_balances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_token_balances (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    value numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    token_id numeric(78,0),
    token_type character varying(255)
);


ALTER TABLE public.address_token_balances OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 709912)
-- Name: address_token_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_token_balances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_token_balances_id_seq OWNER TO postgres;

--
-- TOC entry 4006 (class 0 OID 0)
-- Dependencies: 223
-- Name: address_token_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.address_token_balances_id_seq OWNED BY public.address_token_balances.id;


--
-- TOC entry 206 (class 1259 OID 709018)
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    fetched_coin_balance numeric(100,0),
    fetched_coin_balance_block_number bigint,
    hash bytea NOT NULL,
    contract_code bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    nonce integer,
    decompiled boolean,
    verified boolean,
    gas_used bigint,
    transactions_count integer,
    token_transfers_count integer
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 709985)
-- Name: administrators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrators (
    id bigint NOT NULL,
    role character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.administrators OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 709983)
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.administrators_id_seq OWNER TO postgres;

--
-- TOC entry 4007 (class 0 OID 0)
-- Dependencies: 228
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrators_id_seq OWNED BY public.administrators.id;


--
-- TOC entry 232 (class 1259 OID 710151)
-- Name: block_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.block_rewards (
    address_hash bytea NOT NULL,
    address_type character varying(255) NOT NULL,
    block_hash bytea NOT NULL,
    reward numeric(100,0),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.block_rewards OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 709944)
-- Name: block_second_degree_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.block_second_degree_relations (
    nephew_hash bytea NOT NULL,
    uncle_hash bytea NOT NULL,
    uncle_fetched_at timestamp without time zone,
    index integer
);


ALTER TABLE public.block_second_degree_relations OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 709026)
-- Name: blocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocks (
    consensus boolean NOT NULL,
    difficulty numeric(50,0),
    gas_limit numeric(100,0) NOT NULL,
    gas_used numeric(100,0) NOT NULL,
    hash bytea NOT NULL,
    miner_hash bytea NOT NULL,
    nonce bytea NOT NULL,
    number bigint NOT NULL,
    parent_hash bytea NOT NULL,
    size integer,
    "timestamp" timestamp without time zone NOT NULL,
    total_difficulty numeric(50,0),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    refetch_needed boolean DEFAULT false,
    base_fee_per_gas numeric(100,0),
    is_empty boolean
);


ALTER TABLE public.blocks OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 710173)
-- Name: contract_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_methods (
    id bigint NOT NULL,
    identifier integer NOT NULL,
    abi jsonb NOT NULL,
    type character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contract_methods OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 710171)
-- Name: contract_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contract_methods_id_seq OWNER TO postgres;

--
-- TOC entry 4008 (class 0 OID 0)
-- Dependencies: 233
-- Name: contract_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_methods_id_seq OWNED BY public.contract_methods.id;


--
-- TOC entry 245 (class 1259 OID 710542)
-- Name: contract_verification_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_verification_status (
    uid character varying(64) NOT NULL,
    status smallint NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contract_verification_status OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 710226)
-- Name: decompiled_smart_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.decompiled_smart_contracts (
    id bigint NOT NULL,
    decompiler_version character varying(255) NOT NULL,
    decompiled_source_code text NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.decompiled_smart_contracts OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 710224)
-- Name: decompiled_smart_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.decompiled_smart_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.decompiled_smart_contracts_id_seq OWNER TO postgres;

--
-- TOC entry 4009 (class 0 OID 0)
-- Dependencies: 235
-- Name: decompiled_smart_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.decompiled_smart_contracts_id_seq OWNED BY public.decompiled_smart_contracts.id;


--
-- TOC entry 219 (class 1259 OID 709840)
-- Name: emission_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emission_rewards (
    block_range int8range,
    reward numeric
);


ALTER TABLE public.emission_rewards OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 709121)
-- Name: internal_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_transactions (
    call_type character varying(255),
    created_contract_code bytea,
    error character varying(255),
    gas numeric(100,0),
    gas_used numeric(100,0),
    index integer NOT NULL,
    init bytea,
    input bytea,
    output bytea,
    trace_address integer[] NOT NULL,
    type character varying(255) NOT NULL,
    value numeric(100,0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_contract_address_hash bytea,
    from_address_hash bytea,
    to_address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_number integer,
    transaction_index integer,
    block_hash bytea NOT NULL,
    block_index integer NOT NULL,
    CONSTRAINT call_has_error_or_result CHECK ((((type)::text <> 'call'::text) OR ((gas IS NOT NULL) AND (((error IS NULL) AND (gas_used IS NOT NULL) AND (output IS NOT NULL)) OR ((error IS NOT NULL) AND (gas_used IS NULL) AND (output IS NULL)))))),
    CONSTRAINT create_has_error_or_result CHECK ((((type)::text <> 'create'::text) OR ((gas IS NOT NULL) AND (((error IS NULL) AND (created_contract_address_hash IS NOT NULL) AND (created_contract_code IS NOT NULL) AND (gas_used IS NOT NULL)) OR ((error IS NOT NULL) AND (created_contract_address_hash IS NULL) AND (created_contract_code IS NULL) AND (gas_used IS NULL))))))
);


ALTER TABLE public.internal_transactions OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 710484)
-- Name: last_fetched_counters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.last_fetched_counters (
    counter_type character varying(255) NOT NULL,
    value numeric(100,0),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.last_fetched_counters OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 709091)
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    data bytea NOT NULL,
    index integer NOT NULL,
    type character varying(255),
    first_topic character varying(255),
    second_topic character varying(255),
    third_topic character varying(255),
    fourth_topic character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_hash bytea NOT NULL,
    block_number integer
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 709160)
-- Name: market_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.market_history (
    id bigint NOT NULL,
    date date,
    closing_price numeric,
    opening_price numeric
);


ALTER TABLE public.market_history OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 709158)
-- Name: market_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.market_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.market_history_id_seq OWNER TO postgres;

--
-- TOC entry 4010 (class 0 OID 0)
-- Dependencies: 211
-- Name: market_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.market_history_id_seq OWNED BY public.market_history.id;


--
-- TOC entry 240 (class 1259 OID 710386)
-- Name: pending_block_operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pending_block_operations (
    block_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetch_internal_transactions boolean NOT NULL
);


ALTER TABLE public.pending_block_operations OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 709013)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 709202)
-- Name: smart_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.smart_contracts (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    compiler_version character varying(255) NOT NULL,
    optimization boolean NOT NULL,
    contract_source_code text NOT NULL,
    abi jsonb NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    constructor_arguments text,
    optimization_runs bigint,
    evm_version character varying(255),
    external_libraries jsonb[] DEFAULT ARRAY[]::jsonb[],
    verified_via_sourcify boolean,
    is_vyper_contract boolean,
    partially_verified boolean,
    file_path text,
    is_changed_bytecode boolean DEFAULT false,
    bytecode_checked_at timestamp without time zone DEFAULT (timezone('utc'::text, now()) - '1 day'::interval),
    contract_code_md5 character varying(255) NOT NULL,
    implementation_name character varying(255)
);


ALTER TABLE public.smart_contracts OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 710504)
-- Name: smart_contracts_additional_sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.smart_contracts_additional_sources (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    contract_source_code text NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.smart_contracts_additional_sources OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 710502)
-- Name: smart_contracts_additional_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.smart_contracts_additional_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.smart_contracts_additional_sources_id_seq OWNER TO postgres;

--
-- TOC entry 4011 (class 0 OID 0)
-- Dependencies: 243
-- Name: smart_contracts_additional_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.smart_contracts_additional_sources_id_seq OWNED BY public.smart_contracts_additional_sources.id;


--
-- TOC entry 217 (class 1259 OID 709200)
-- Name: smart_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.smart_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.smart_contracts_id_seq OWNER TO postgres;

--
-- TOC entry 4012 (class 0 OID 0)
-- Dependencies: 217
-- Name: smart_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.smart_contracts_id_seq OWNED BY public.smart_contracts.id;


--
-- TOC entry 239 (class 1259 OID 710368)
-- Name: token_instances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_instances (
    token_id numeric(78,0) NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    metadata jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    error character varying(255)
);


ALTER TABLE public.token_instances OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 709863)
-- Name: token_transfers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_transfers (
    transaction_hash bytea NOT NULL,
    log_index integer NOT NULL,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea NOT NULL,
    amount numeric,
    token_id numeric(78,0),
    token_contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_number integer,
    block_hash bytea NOT NULL,
    amounts numeric[],
    token_ids numeric(78,0)[]
);


ALTER TABLE public.token_transfers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 709848)
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokens (
    name character varying(255),
    symbol character varying(255),
    total_supply numeric,
    decimals numeric,
    type character varying(255) NOT NULL,
    cataloged boolean DEFAULT false,
    contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    holder_count integer,
    skip_metadata boolean
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 709958)
-- Name: transaction_forks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_forks (
    hash bytea NOT NULL,
    index integer NOT NULL,
    uncle_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.transaction_forks OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 710357)
-- Name: transaction_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_stats (
    id bigint NOT NULL,
    date date,
    number_of_transactions integer,
    gas_used numeric(100,0),
    total_fee numeric(100,0)
);


ALTER TABLE public.transaction_stats OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 710355)
-- Name: transaction_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_stats_id_seq OWNER TO postgres;

--
-- TOC entry 4013 (class 0 OID 0)
-- Dependencies: 237
-- Name: transaction_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_stats_id_seq OWNED BY public.transaction_stats.id;


--
-- TOC entry 208 (class 1259 OID 709042)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    cumulative_gas_used numeric(100,0),
    error character varying(255),
    gas numeric(100,0) NOT NULL,
    gas_price numeric(100,0) NOT NULL,
    gas_used numeric(100,0),
    hash bytea NOT NULL,
    index integer,
    input bytea NOT NULL,
    nonce integer NOT NULL,
    r numeric(100,0) NOT NULL,
    s numeric(100,0) NOT NULL,
    status integer,
    v numeric(100,0) NOT NULL,
    value numeric(100,0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_hash bytea,
    block_number integer,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea,
    created_contract_address_hash bytea,
    created_contract_code_indexed_at timestamp without time zone,
    earliest_processing_start timestamp without time zone,
    old_block_hash bytea,
    revert_reason text,
    max_priority_fee_per_gas numeric(100,0),
    max_fee_per_gas numeric(100,0),
    type integer,
    has_error_in_internal_txs boolean,
    CONSTRAINT collated_block_number CHECK (((block_hash IS NULL) OR (block_number IS NOT NULL))),
    CONSTRAINT collated_cumalative_gas_used CHECK (((block_hash IS NULL) OR (cumulative_gas_used IS NOT NULL))),
    CONSTRAINT collated_gas_used CHECK (((block_hash IS NULL) OR (gas_used IS NOT NULL))),
    CONSTRAINT collated_index CHECK (((block_hash IS NULL) OR (index IS NOT NULL))),
    CONSTRAINT error CHECK (((status = 0) OR ((status <> 0) AND (error IS NULL)))),
    CONSTRAINT pending_block_number CHECK (((block_hash IS NOT NULL) OR (block_number IS NULL))),
    CONSTRAINT pending_cumalative_gas_used CHECK (((block_hash IS NOT NULL) OR (cumulative_gas_used IS NULL))),
    CONSTRAINT pending_gas_used CHECK (((block_hash IS NOT NULL) OR (gas_used IS NULL))),
    CONSTRAINT pending_index CHECK (((block_hash IS NOT NULL) OR (index IS NULL))),
    CONSTRAINT status CHECK ((((block_hash IS NULL) AND (status IS NULL)) OR (block_hash IS NOT NULL) OR ((status = 0) AND ((error)::text = 'dropped/replaced'::text))))
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 709184)
-- Name: user_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_contacts (
    id bigint NOT NULL,
    email public.citext NOT NULL,
    user_id bigint NOT NULL,
    "primary" boolean DEFAULT false,
    verified boolean DEFAULT false,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_contacts OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 709182)
-- Name: user_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_contacts_id_seq OWNER TO postgres;

--
-- TOC entry 4014 (class 0 OID 0)
-- Dependencies: 215
-- Name: user_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_contacts_id_seq OWNED BY public.user_contacts.id;


--
-- TOC entry 214 (class 1259 OID 709172)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username public.citext NOT NULL,
    password_hash character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 709170)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4015 (class 0 OID 0)
-- Dependencies: 213
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3679 (class 2604 OID 710121)
-- Name: address_current_token_balances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_current_token_balances ALTER COLUMN id SET DEFAULT nextval('public.address_current_token_balances_id_seq'::regclass);


--
-- TOC entry 3676 (class 2604 OID 709917)
-- Name: address_token_balances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_token_balances ALTER COLUMN id SET DEFAULT nextval('public.address_token_balances_id_seq'::regclass);


--
-- TOC entry 3678 (class 2604 OID 709988)
-- Name: administrators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrators ALTER COLUMN id SET DEFAULT nextval('public.administrators_id_seq'::regclass);


--
-- TOC entry 3680 (class 2604 OID 710176)
-- Name: contract_methods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_methods ALTER COLUMN id SET DEFAULT nextval('public.contract_methods_id_seq'::regclass);


--
-- TOC entry 3681 (class 2604 OID 710229)
-- Name: decompiled_smart_contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decompiled_smart_contracts ALTER COLUMN id SET DEFAULT nextval('public.decompiled_smart_contracts_id_seq'::regclass);


--
-- TOC entry 3665 (class 2604 OID 709163)
-- Name: market_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_history ALTER COLUMN id SET DEFAULT nextval('public.market_history_id_seq'::regclass);


--
-- TOC entry 3670 (class 2604 OID 709205)
-- Name: smart_contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_contracts ALTER COLUMN id SET DEFAULT nextval('public.smart_contracts_id_seq'::regclass);


--
-- TOC entry 3684 (class 2604 OID 710507)
-- Name: smart_contracts_additional_sources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_contracts_additional_sources ALTER COLUMN id SET DEFAULT nextval('public.smart_contracts_additional_sources_id_seq'::regclass);


--
-- TOC entry 3682 (class 2604 OID 710360)
-- Name: transaction_stats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_stats ALTER COLUMN id SET DEFAULT nextval('public.transaction_stats_id_seq'::regclass);


--
-- TOC entry 3667 (class 2604 OID 709187)
-- Name: user_contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_contacts ALTER COLUMN id SET DEFAULT nextval('public.user_contacts_id_seq'::regclass);


--
-- TOC entry 3666 (class 2604 OID 709175)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3802 (class 2606 OID 710126)
-- Name: address_current_token_balances address_current_token_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_current_token_balances
    ADD CONSTRAINT address_current_token_balances_pkey PRIMARY KEY (id);


--
-- TOC entry 3780 (class 2606 OID 709922)
-- Name: address_token_balances address_token_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_token_balances
    ADD CONSTRAINT address_token_balances_pkey PRIMARY KEY (id);


--
-- TOC entry 3691 (class 2606 OID 709025)
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (hash);


--
-- TOC entry 3796 (class 2606 OID 709990)
-- Name: administrators administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- TOC entry 3790 (class 2606 OID 710188)
-- Name: block_second_degree_relations block_second_degree_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.block_second_degree_relations
    ADD CONSTRAINT block_second_degree_relations_pkey PRIMARY KEY (nephew_hash, uncle_hash);


--
-- TOC entry 3699 (class 2606 OID 709033)
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (hash);


--
-- TOC entry 3659 (class 2606 OID 710147)
-- Name: internal_transactions call_has_call_type; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT call_has_call_type CHECK ((((type)::text <> 'call'::text) OR (call_type IS NOT NULL))) NOT VALID;


--
-- TOC entry 3661 (class 2606 OID 710148)
-- Name: internal_transactions call_has_input; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT call_has_input CHECK ((((type)::text <> 'call'::text) OR (input IS NOT NULL))) NOT VALID;


--
-- TOC entry 3813 (class 2606 OID 710181)
-- Name: contract_methods contract_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_methods
    ADD CONSTRAINT contract_methods_pkey PRIMARY KEY (id);


--
-- TOC entry 3833 (class 2606 OID 710549)
-- Name: contract_verification_status contract_verification_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_verification_status
    ADD CONSTRAINT contract_verification_status_pkey PRIMARY KEY (uid);


--
-- TOC entry 3663 (class 2606 OID 710149)
-- Name: internal_transactions create_has_init; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT create_has_init CHECK ((((type)::text <> 'create'::text) OR (init IS NOT NULL))) NOT VALID;


--
-- TOC entry 3816 (class 2606 OID 710234)
-- Name: decompiled_smart_contracts decompiled_smart_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decompiled_smart_contracts
    ADD CONSTRAINT decompiled_smart_contracts_pkey PRIMARY KEY (id);


--
-- TOC entry 3737 (class 2606 OID 710402)
-- Name: internal_transactions internal_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_pkey PRIMARY KEY (block_hash, block_index);


--
-- TOC entry 3828 (class 2606 OID 710488)
-- Name: last_fetched_counters last_fetched_counters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.last_fetched_counters
    ADD CONSTRAINT last_fetched_counters_pkey PRIMARY KEY (counter_type);


--
-- TOC entry 3726 (class 2606 OID 710415)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (transaction_hash, block_hash, index);


--
-- TOC entry 3742 (class 2606 OID 709168)
-- Name: market_history market_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_history
    ADD CONSTRAINT market_history_pkey PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 709847)
-- Name: emission_rewards no_overlapping_ranges; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emission_rewards
    ADD CONSTRAINT no_overlapping_ranges EXCLUDE USING gist (block_range WITH &&);


--
-- TOC entry 3825 (class 2606 OID 710393)
-- Name: pending_block_operations pending_block_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_block_operations
    ADD CONSTRAINT pending_block_operations_pkey PRIMARY KEY (block_hash);


--
-- TOC entry 3686 (class 2606 OID 709017)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3664 (class 2606 OID 710146)
-- Name: internal_transactions selfdestruct_has_from_and_to_address; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.internal_transactions
    ADD CONSTRAINT selfdestruct_has_from_and_to_address CHECK ((((type)::text <> 'selfdestruct'::text) OR ((from_address_hash IS NOT NULL) AND (gas IS NULL) AND (to_address_hash IS NOT NULL)))) NOT VALID;


--
-- TOC entry 3831 (class 2606 OID 710512)
-- Name: smart_contracts_additional_sources smart_contracts_additional_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_contracts_additional_sources
    ADD CONSTRAINT smart_contracts_additional_sources_pkey PRIMARY KEY (id);


--
-- TOC entry 3753 (class 2606 OID 709210)
-- Name: smart_contracts smart_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_contracts
    ADD CONSTRAINT smart_contracts_pkey PRIMARY KEY (id);


--
-- TOC entry 3822 (class 2606 OID 710375)
-- Name: token_instances token_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_instances
    ADD CONSTRAINT token_instances_pkey PRIMARY KEY (token_id, token_contract_address_hash);


--
-- TOC entry 3767 (class 2606 OID 710423)
-- Name: token_transfers token_transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_pkey PRIMARY KEY (transaction_hash, block_hash, log_index);


--
-- TOC entry 3759 (class 2606 OID 710186)
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (contract_address_hash);


--
-- TOC entry 3819 (class 2606 OID 710362)
-- Name: transaction_stats transaction_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_stats
    ADD CONSTRAINT transaction_stats_pkey PRIMARY KEY (id);


--
-- TOC entry 3714 (class 2606 OID 709049)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (hash);


--
-- TOC entry 3749 (class 2606 OID 709191)
-- Name: user_contacts user_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_contacts
    ADD CONSTRAINT user_contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 709180)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3774 (class 1259 OID 709910)
-- Name: address_coin_balances_address_hash_block_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_coin_balances_address_hash_block_number_index ON public.address_coin_balances USING btree (address_hash, block_number);


--
-- TOC entry 3826 (class 1259 OID 710483)
-- Name: address_coin_balances_daily_address_hash_day_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_coin_balances_daily_address_hash_day_index ON public.address_coin_balances_daily USING btree (address_hash, day);


--
-- TOC entry 3775 (class 1259 OID 710202)
-- Name: address_coin_balances_value_fetched_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_coin_balances_value_fetched_at_index ON public.address_coin_balances USING btree (value_fetched_at);


--
-- TOC entry 3799 (class 1259 OID 710197)
-- Name: address_cur_token_balances_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_cur_token_balances_index ON public.address_current_token_balances USING btree (block_number);


--
-- TOC entry 3800 (class 1259 OID 710194)
-- Name: address_current_token_balances_address_hash_block_number_token_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_current_token_balances_address_hash_block_number_token_ ON public.address_current_token_balances USING btree (address_hash, block_number, token_contract_address_hash);


--
-- TOC entry 3803 (class 1259 OID 710183)
-- Name: address_current_token_balances_token_contract_address_hash_inde; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_current_token_balances_token_contract_address_hash_inde ON public.address_current_token_balances USING btree (token_contract_address_hash) WHERE ((address_hash <> '\x0000000000000000000000000000000000000000'::bytea) AND (value > (0)::numeric));


--
-- TOC entry 3804 (class 1259 OID 710432)
-- Name: address_current_token_balances_token_contract_address_hash_valu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_current_token_balances_token_contract_address_hash_valu ON public.address_current_token_balances USING btree (token_contract_address_hash, value);


--
-- TOC entry 3805 (class 1259 OID 710519)
-- Name: address_current_token_balances_token_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_current_token_balances_token_id_index ON public.address_current_token_balances USING btree (token_id);


--
-- TOC entry 3806 (class 1259 OID 710138)
-- Name: address_current_token_balances_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_current_token_balances_value ON public.address_current_token_balances USING btree (value) WHERE (value IS NOT NULL);


--
-- TOC entry 3814 (class 1259 OID 710241)
-- Name: address_decompiler_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_decompiler_version ON public.decompiled_smart_contracts USING btree (address_hash, decompiler_version);


--
-- TOC entry 3787 (class 1259 OID 709942)
-- Name: address_names_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_names_address_hash_index ON public.address_names USING btree (address_hash) WHERE ("primary" = true);


--
-- TOC entry 3777 (class 1259 OID 710538)
-- Name: address_token_balances_address_hash_token_contract_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_token_balances_address_hash_token_contract_address_hash ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, block_number);


--
-- TOC entry 3778 (class 1259 OID 710365)
-- Name: address_token_balances_block_number_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_token_balances_block_number_address_hash_index ON public.address_token_balances USING btree (block_number, address_hash);


--
-- TOC entry 3781 (class 1259 OID 710536)
-- Name: address_token_balances_token_contract_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_token_balances_token_contract_address_hash_index ON public.address_token_balances USING btree (token_contract_address_hash);


--
-- TOC entry 3782 (class 1259 OID 710431)
-- Name: address_token_balances_token_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_token_balances_token_id_index ON public.address_token_balances USING btree (token_id);


--
-- TOC entry 3687 (class 1259 OID 710150)
-- Name: addresses_fetched_coin_balance_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX addresses_fetched_coin_balance_hash_index ON public.addresses USING btree (fetched_coin_balance DESC, hash) WHERE (fetched_coin_balance > (0)::numeric);


--
-- TOC entry 3688 (class 1259 OID 710196)
-- Name: addresses_fetched_coin_balance_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX addresses_fetched_coin_balance_index ON public.addresses USING btree (fetched_coin_balance);


--
-- TOC entry 3689 (class 1259 OID 710223)
-- Name: addresses_inserted_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX addresses_inserted_at_index ON public.addresses USING btree (inserted_at);


--
-- TOC entry 3797 (class 1259 OID 709997)
-- Name: administrators_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX administrators_user_id_index ON public.administrators USING btree (user_id);


--
-- TOC entry 3809 (class 1259 OID 710193)
-- Name: block_rewards_address_hash_block_hash_address_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX block_rewards_address_hash_block_hash_address_type_index ON public.block_rewards USING btree (address_hash, block_hash, address_type);


--
-- TOC entry 3810 (class 1259 OID 710366)
-- Name: block_rewards_block_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX block_rewards_block_hash_index ON public.block_rewards USING btree (block_hash);


--
-- TOC entry 3692 (class 1259 OID 710201)
-- Name: blocks_consensus_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_consensus_index ON public.blocks USING btree (consensus);


--
-- TOC entry 3693 (class 1259 OID 709897)
-- Name: blocks_inserted_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_inserted_at_index ON public.blocks USING btree (inserted_at);


--
-- TOC entry 3694 (class 1259 OID 710526)
-- Name: blocks_is_empty_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_is_empty_index ON public.blocks USING btree (is_empty);


--
-- TOC entry 3695 (class 1259 OID 710170)
-- Name: blocks_miner_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_miner_hash_index ON public.blocks USING btree (miner_hash);


--
-- TOC entry 3696 (class 1259 OID 710435)
-- Name: blocks_miner_hash_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_miner_hash_number_index ON public.blocks USING btree (miner_hash, number);


--
-- TOC entry 3697 (class 1259 OID 710198)
-- Name: blocks_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_number_index ON public.blocks USING btree (number);


--
-- TOC entry 3700 (class 1259 OID 709039)
-- Name: blocks_timestamp_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blocks_timestamp_index ON public.blocks USING btree ("timestamp");


--
-- TOC entry 3811 (class 1259 OID 710182)
-- Name: contract_methods_identifier_abi_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX contract_methods_identifier_abi_index ON public.contract_methods USING btree (identifier, abi);


--
-- TOC entry 3746 (class 1259 OID 710107)
-- Name: email_unique_for_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX email_unique_for_user ON public.user_contacts USING btree (user_id, email);


--
-- TOC entry 3754 (class 1259 OID 710199)
-- Name: emission_rewards_block_range_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX emission_rewards_block_range_index ON public.emission_rewards USING btree (block_range);


--
-- TOC entry 3701 (class 1259 OID 710535)
-- Name: empty_consensus_blocks; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX empty_consensus_blocks ON public.blocks USING btree (consensus) WHERE (is_empty IS NULL);


--
-- TOC entry 3807 (class 1259 OID 710521)
-- Name: fetched_current_token_balances; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fetched_current_token_balances ON public.address_current_token_balances USING btree (address_hash, token_contract_address_hash) WHERE (token_id IS NULL);


--
-- TOC entry 3808 (class 1259 OID 710520)
-- Name: fetched_current_token_balances_with_token_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fetched_current_token_balances_with_token_id ON public.address_current_token_balances USING btree (address_hash, token_contract_address_hash, token_id) WHERE (token_id IS NOT NULL);


--
-- TOC entry 3783 (class 1259 OID 710523)
-- Name: fetched_token_balances; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fetched_token_balances ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, block_number) WHERE (token_id IS NULL);


--
-- TOC entry 3784 (class 1259 OID 710522)
-- Name: fetched_token_balances_with_token_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fetched_token_balances_with_token_id ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, token_id, block_number) WHERE (token_id IS NOT NULL);


--
-- TOC entry 3731 (class 1259 OID 710109)
-- Name: internal_transactions_block_number_DESC__transaction_index_DESC; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "internal_transactions_block_number_DESC__transaction_index_DESC" ON public.internal_transactions USING btree (block_number DESC, transaction_index DESC, index DESC);


--
-- TOC entry 3732 (class 1259 OID 709153)
-- Name: internal_transactions_created_contract_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_transactions_created_contract_address_hash_index ON public.internal_transactions USING btree (created_contract_address_hash);


--
-- TOC entry 3733 (class 1259 OID 710427)
-- Name: internal_transactions_created_contract_address_hash_partial_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_transactions_created_contract_address_hash_partial_ind ON public.internal_transactions USING btree (created_contract_address_hash, block_number DESC, transaction_index DESC, index DESC) WHERE ((((type)::text = 'call'::text) AND (index > 0)) OR ((type)::text <> 'call'::text));


--
-- TOC entry 3734 (class 1259 OID 709154)
-- Name: internal_transactions_from_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_transactions_from_address_hash_index ON public.internal_transactions USING btree (from_address_hash);


--
-- TOC entry 3735 (class 1259 OID 710425)
-- Name: internal_transactions_from_address_hash_partial_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_transactions_from_address_hash_partial_index ON public.internal_transactions USING btree (from_address_hash, block_number DESC, transaction_index DESC, index DESC) WHERE ((((type)::text = 'call'::text) AND (index > 0)) OR ((type)::text <> 'call'::text));


--
-- TOC entry 3738 (class 1259 OID 710426)
-- Name: internal_transactions_to_address_hash_partial_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_transactions_to_address_hash_partial_index ON public.internal_transactions USING btree (to_address_hash, block_number DESC, transaction_index DESC, index DESC) WHERE ((((type)::text = 'call'::text) AND (index > 0)) OR ((type)::text <> 'call'::text));


--
-- TOC entry 3739 (class 1259 OID 710408)
-- Name: internal_transactions_transaction_hash_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX internal_transactions_transaction_hash_index_index ON public.internal_transactions USING btree (transaction_hash, index);


--
-- TOC entry 3719 (class 1259 OID 709110)
-- Name: logs_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_address_hash_index ON public.logs USING btree (address_hash);


--
-- TOC entry 3720 (class 1259 OID 710539)
-- Name: logs_address_hash_transaction_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_address_hash_transaction_hash_index ON public.logs USING btree (address_hash, transaction_hash);


--
-- TOC entry 3721 (class 1259 OID 710429)
-- Name: logs_block_number_DESC__index_DESC_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "logs_block_number_DESC__index_DESC_index" ON public.logs USING btree (block_number DESC, index DESC);


--
-- TOC entry 3722 (class 1259 OID 709114)
-- Name: logs_first_topic_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_first_topic_index ON public.logs USING btree (first_topic);


--
-- TOC entry 3723 (class 1259 OID 709117)
-- Name: logs_fourth_topic_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_fourth_topic_index ON public.logs USING btree (fourth_topic);


--
-- TOC entry 3724 (class 1259 OID 709112)
-- Name: logs_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_index_index ON public.logs USING btree (index);


--
-- TOC entry 3727 (class 1259 OID 709115)
-- Name: logs_second_topic_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_second_topic_index ON public.logs USING btree (second_topic);


--
-- TOC entry 3728 (class 1259 OID 709116)
-- Name: logs_third_topic_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_third_topic_index ON public.logs USING btree (third_topic);


--
-- TOC entry 3729 (class 1259 OID 710416)
-- Name: logs_transaction_hash_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_transaction_hash_index_index ON public.logs USING btree (transaction_hash, index);


--
-- TOC entry 3730 (class 1259 OID 709113)
-- Name: logs_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logs_type_index ON public.logs USING btree (type);


--
-- TOC entry 3740 (class 1259 OID 709169)
-- Name: market_history_date_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX market_history_date_index ON public.market_history USING btree (date);


--
-- TOC entry 3791 (class 1259 OID 709955)
-- Name: nephew_hash_to_uncle_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nephew_hash_to_uncle_hash ON public.block_second_degree_relations USING btree (nephew_hash, uncle_hash);


--
-- TOC entry 3702 (class 1259 OID 709041)
-- Name: one_consensus_block_at_height; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_consensus_block_at_height ON public.blocks USING btree (number) WHERE consensus;


--
-- TOC entry 3703 (class 1259 OID 709040)
-- Name: one_consensus_child_per_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_consensus_child_per_parent ON public.blocks USING btree (parent_hash) WHERE consensus;


--
-- TOC entry 3747 (class 1259 OID 709199)
-- Name: one_primary_per_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_primary_per_user ON public.user_contacts USING btree (user_id) WHERE "primary";


--
-- TOC entry 3798 (class 1259 OID 709996)
-- Name: owner_role_limit; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX owner_role_limit ON public.administrators USING btree (role) WHERE ((role)::text = 'owner'::text);


--
-- TOC entry 3823 (class 1259 OID 710430)
-- Name: pending_block_operations_block_hash_index_partial; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pending_block_operations_block_hash_index_partial ON public.pending_block_operations USING btree (block_hash) WHERE (fetch_internal_transactions = true);


--
-- TOC entry 3704 (class 1259 OID 710434)
-- Name: pending_txs_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pending_txs_index ON public.transactions USING btree (inserted_at, hash) WHERE ((block_hash IS NULL) AND ((error IS NULL) OR ((error)::text <> 'dropped/replaced'::text)));


--
-- TOC entry 3829 (class 1259 OID 710518)
-- Name: smart_contracts_additional_sources_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX smart_contracts_additional_sources_address_hash_index ON public.smart_contracts_additional_sources USING btree (address_hash);


--
-- TOC entry 3750 (class 1259 OID 709216)
-- Name: smart_contracts_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX smart_contracts_address_hash_index ON public.smart_contracts USING btree (address_hash);


--
-- TOC entry 3751 (class 1259 OID 712768)
-- Name: smart_contracts_contract_code_md5_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX smart_contracts_contract_code_md5_index ON public.smart_contracts USING btree (contract_code_md5);


--
-- TOC entry 3820 (class 1259 OID 710385)
-- Name: token_instances_error_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_instances_error_index ON public.token_instances USING btree (error);


--
-- TOC entry 3763 (class 1259 OID 710384)
-- Name: token_transfers_block_number_DESC_log_index_DESC_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "token_transfers_block_number_DESC_log_index_DESC_index" ON public.token_transfers USING btree (block_number DESC, log_index DESC);


--
-- TOC entry 3764 (class 1259 OID 710382)
-- Name: token_transfers_block_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_block_number_index ON public.token_transfers USING btree (block_number);


--
-- TOC entry 3765 (class 1259 OID 709894)
-- Name: token_transfers_from_address_hash_transaction_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_from_address_hash_transaction_hash_index ON public.token_transfers USING btree (from_address_hash, transaction_hash);


--
-- TOC entry 3768 (class 1259 OID 709893)
-- Name: token_transfers_to_address_hash_transaction_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_to_address_hash_transaction_hash_index ON public.token_transfers USING btree (to_address_hash, transaction_hash);


--
-- TOC entry 3769 (class 1259 OID 710433)
-- Name: token_transfers_token_contract_address_hash_block_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_token_contract_address_hash_block_number_index ON public.token_transfers USING btree (token_contract_address_hash, block_number);


--
-- TOC entry 3770 (class 1259 OID 710470)
-- Name: token_transfers_token_contract_address_hash_token_id_DESC_block; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "token_transfers_token_contract_address_hash_token_id_DESC_block" ON public.token_transfers USING btree (token_contract_address_hash, token_id DESC, block_number DESC);


--
-- TOC entry 3771 (class 1259 OID 709895)
-- Name: token_transfers_token_contract_address_hash_transaction_hash_in; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_token_contract_address_hash_transaction_hash_in ON public.token_transfers USING btree (token_contract_address_hash, transaction_hash);


--
-- TOC entry 3772 (class 1259 OID 710367)
-- Name: token_transfers_token_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_token_id_index ON public.token_transfers USING btree (token_id);


--
-- TOC entry 3773 (class 1259 OID 710424)
-- Name: token_transfers_transaction_hash_log_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_transfers_transaction_hash_log_index_index ON public.token_transfers USING btree (transaction_hash, log_index);


--
-- TOC entry 3757 (class 1259 OID 709860)
-- Name: tokens_contract_address_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tokens_contract_address_hash_index ON public.tokens USING btree (contract_address_hash);


--
-- TOC entry 3760 (class 1259 OID 710203)
-- Name: tokens_symbol_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tokens_symbol_index ON public.tokens USING btree (symbol);


--
-- TOC entry 3761 (class 1259 OID 710319)
-- Name: tokens_trgm_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tokens_trgm_idx ON public.tokens USING gin (to_tsvector('english'::regconfig, (((symbol)::text || ' '::text) || (name)::text)));


--
-- TOC entry 3762 (class 1259 OID 710383)
-- Name: tokens_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tokens_type_index ON public.tokens USING btree (type);


--
-- TOC entry 3794 (class 1259 OID 709975)
-- Name: transaction_forks_uncle_hash_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX transaction_forks_uncle_hash_index_index ON public.transaction_forks USING btree (uncle_hash, index);


--
-- TOC entry 3817 (class 1259 OID 710363)
-- Name: transaction_stats_date_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX transaction_stats_date_index ON public.transaction_stats USING btree (date);


--
-- TOC entry 3705 (class 1259 OID 710192)
-- Name: transactions_block_hash_error_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_block_hash_error_index ON public.transactions USING btree (block_hash, error);


--
-- TOC entry 3706 (class 1259 OID 709088)
-- Name: transactions_block_hash_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX transactions_block_hash_index_index ON public.transactions USING btree (block_hash, index);


--
-- TOC entry 3707 (class 1259 OID 710537)
-- Name: transactions_block_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_block_number_index ON public.transactions USING btree (block_number);


--
-- TOC entry 3708 (class 1259 OID 709087)
-- Name: transactions_created_contract_address_hash_recent_collated_inde; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_created_contract_address_hash_recent_collated_inde ON public.transactions USING btree (created_contract_address_hash, block_number DESC, index DESC, hash);


--
-- TOC entry 3709 (class 1259 OID 710184)
-- Name: transactions_created_contract_code_indexed_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_created_contract_code_indexed_at_index ON public.transactions USING btree (created_contract_code_indexed_at);


--
-- TOC entry 3710 (class 1259 OID 709085)
-- Name: transactions_from_address_hash_recent_collated_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_from_address_hash_recent_collated_index ON public.transactions USING btree (from_address_hash, block_number DESC, index DESC, hash);


--
-- TOC entry 3711 (class 1259 OID 709081)
-- Name: transactions_inserted_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_inserted_at_index ON public.transactions USING btree (inserted_at);


--
-- TOC entry 3712 (class 1259 OID 710191)
-- Name: transactions_nonce_from_address_hash_block_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_nonce_from_address_hash_block_hash_index ON public.transactions USING btree (nonce, from_address_hash, block_hash);


--
-- TOC entry 3715 (class 1259 OID 709084)
-- Name: transactions_recent_collated_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_recent_collated_index ON public.transactions USING btree (block_number DESC, index DESC);


--
-- TOC entry 3716 (class 1259 OID 709083)
-- Name: transactions_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_status_index ON public.transactions USING btree (status);


--
-- TOC entry 3717 (class 1259 OID 709086)
-- Name: transactions_to_address_hash_recent_collated_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_to_address_hash_recent_collated_index ON public.transactions USING btree (to_address_hash, block_number DESC, index DESC, hash);


--
-- TOC entry 3718 (class 1259 OID 709082)
-- Name: transactions_updated_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_updated_at_index ON public.transactions USING btree (updated_at);


--
-- TOC entry 3792 (class 1259 OID 709957)
-- Name: uncle_hash_to_nephew_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uncle_hash_to_nephew_hash ON public.block_second_degree_relations USING btree (uncle_hash, nephew_hash);


--
-- TOC entry 3776 (class 1259 OID 709911)
-- Name: unfetched_balances; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unfetched_balances ON public.address_coin_balances USING btree (address_hash, block_number) WHERE (value_fetched_at IS NULL);


--
-- TOC entry 3785 (class 1259 OID 710524)
-- Name: unfetched_token_balances; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unfetched_token_balances ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, block_number) WHERE ((value_fetched_at IS NULL) AND (token_id IS NULL));


--
-- TOC entry 3786 (class 1259 OID 710525)
-- Name: unfetched_token_balances_with_token_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unfetched_token_balances_with_token_id ON public.address_token_balances USING btree (address_hash, token_contract_address_hash, token_id, block_number) WHERE ((value_fetched_at IS NULL) AND (token_id IS NOT NULL));


--
-- TOC entry 3793 (class 1259 OID 709956)
-- Name: unfetched_uncles; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unfetched_uncles ON public.block_second_degree_relations USING btree (nephew_hash, uncle_hash) WHERE (uncle_fetched_at IS NULL);


--
-- TOC entry 3788 (class 1259 OID 709943)
-- Name: unique_address_names; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_address_names ON public.address_names USING btree (address_hash, name);


--
-- TOC entry 3743 (class 1259 OID 710103)
-- Name: unique_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_username ON public.users USING btree (username);


--
-- TOC entry 3855 (class 2606 OID 709905)
-- Name: address_coin_balances address_coin_balances_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_coin_balances
    ADD CONSTRAINT address_coin_balances_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3869 (class 2606 OID 710478)
-- Name: address_coin_balances_daily address_coin_balances_daily_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_coin_balances_daily
    ADD CONSTRAINT address_coin_balances_daily_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3862 (class 2606 OID 710127)
-- Name: address_current_token_balances address_current_token_balances_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_current_token_balances
    ADD CONSTRAINT address_current_token_balances_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3863 (class 2606 OID 710132)
-- Name: address_current_token_balances address_current_token_balances_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_current_token_balances
    ADD CONSTRAINT address_current_token_balances_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.tokens(contract_address_hash);


--
-- TOC entry 3856 (class 2606 OID 709923)
-- Name: address_token_balances address_token_balances_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_token_balances
    ADD CONSTRAINT address_token_balances_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3857 (class 2606 OID 709928)
-- Name: address_token_balances address_token_balances_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_token_balances
    ADD CONSTRAINT address_token_balances_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.tokens(contract_address_hash);


--
-- TOC entry 3861 (class 2606 OID 709991)
-- Name: administrators administrators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3864 (class 2606 OID 710157)
-- Name: block_rewards block_rewards_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.block_rewards
    ADD CONSTRAINT block_rewards_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3865 (class 2606 OID 710162)
-- Name: block_rewards block_rewards_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.block_rewards
    ADD CONSTRAINT block_rewards_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- TOC entry 3858 (class 2606 OID 709950)
-- Name: block_second_degree_relations block_second_degree_relations_nephew_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.block_second_degree_relations
    ADD CONSTRAINT block_second_degree_relations_nephew_hash_fkey FOREIGN KEY (nephew_hash) REFERENCES public.blocks(hash);


--
-- TOC entry 3834 (class 2606 OID 709034)
-- Name: blocks blocks_miner_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_miner_hash_fkey FOREIGN KEY (miner_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3866 (class 2606 OID 710235)
-- Name: decompiled_smart_contracts decompiled_smart_contracts_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decompiled_smart_contracts
    ADD CONSTRAINT decompiled_smart_contracts_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3846 (class 2606 OID 710403)
-- Name: internal_transactions internal_transactions_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash);


--
-- TOC entry 3842 (class 2606 OID 709130)
-- Name: internal_transactions internal_transactions_created_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_created_contract_address_hash_fkey FOREIGN KEY (created_contract_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3843 (class 2606 OID 709135)
-- Name: internal_transactions internal_transactions_from_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_from_address_hash_fkey FOREIGN KEY (from_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3844 (class 2606 OID 709140)
-- Name: internal_transactions internal_transactions_to_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_to_address_hash_fkey FOREIGN KEY (to_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3845 (class 2606 OID 709145)
-- Name: internal_transactions internal_transactions_transaction_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_transactions
    ADD CONSTRAINT internal_transactions_transaction_hash_fkey FOREIGN KEY (transaction_hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- TOC entry 3839 (class 2606 OID 709100)
-- Name: logs logs_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3841 (class 2606 OID 710409)
-- Name: logs logs_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash);


--
-- TOC entry 3840 (class 2606 OID 709105)
-- Name: logs logs_transaction_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_transaction_hash_fkey FOREIGN KEY (transaction_hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- TOC entry 3868 (class 2606 OID 710394)
-- Name: pending_block_operations pending_block_operations_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_block_operations
    ADD CONSTRAINT pending_block_operations_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- TOC entry 3870 (class 2606 OID 710513)
-- Name: smart_contracts_additional_sources smart_contracts_additional_sources_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_contracts_additional_sources
    ADD CONSTRAINT smart_contracts_additional_sources_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.smart_contracts(address_hash) ON DELETE CASCADE;


--
-- TOC entry 3848 (class 2606 OID 709211)
-- Name: smart_contracts smart_contracts_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_contracts
    ADD CONSTRAINT smart_contracts_address_hash_fkey FOREIGN KEY (address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3867 (class 2606 OID 710376)
-- Name: token_instances token_instances_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_instances
    ADD CONSTRAINT token_instances_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.tokens(contract_address_hash);


--
-- TOC entry 3854 (class 2606 OID 710417)
-- Name: token_transfers token_transfers_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash);


--
-- TOC entry 3851 (class 2606 OID 709877)
-- Name: token_transfers token_transfers_from_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_from_address_hash_fkey FOREIGN KEY (from_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3852 (class 2606 OID 709882)
-- Name: token_transfers token_transfers_to_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_to_address_hash_fkey FOREIGN KEY (to_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3853 (class 2606 OID 709887)
-- Name: token_transfers token_transfers_token_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_token_contract_address_hash_fkey FOREIGN KEY (token_contract_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3850 (class 2606 OID 709872)
-- Name: token_transfers token_transfers_transaction_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_transfers
    ADD CONSTRAINT token_transfers_transaction_hash_fkey FOREIGN KEY (transaction_hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- TOC entry 3849 (class 2606 OID 709855)
-- Name: tokens tokens_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_contract_address_hash_fkey FOREIGN KEY (contract_address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3859 (class 2606 OID 709964)
-- Name: transaction_forks transaction_forks_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_forks
    ADD CONSTRAINT transaction_forks_hash_fkey FOREIGN KEY (hash) REFERENCES public.transactions(hash) ON DELETE CASCADE;


--
-- TOC entry 3860 (class 2606 OID 709969)
-- Name: transaction_forks transaction_forks_uncle_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_forks
    ADD CONSTRAINT transaction_forks_uncle_hash_fkey FOREIGN KEY (uncle_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- TOC entry 3835 (class 2606 OID 709050)
-- Name: transactions transactions_block_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_block_hash_fkey FOREIGN KEY (block_hash) REFERENCES public.blocks(hash) ON DELETE CASCADE;


--
-- TOC entry 3838 (class 2606 OID 709065)
-- Name: transactions transactions_created_contract_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_created_contract_address_hash_fkey FOREIGN KEY (created_contract_address_hash) REFERENCES public.addresses(hash);


--
-- TOC entry 3836 (class 2606 OID 709055)
-- Name: transactions transactions_from_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_from_address_hash_fkey FOREIGN KEY (from_address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3837 (class 2606 OID 709060)
-- Name: transactions transactions_to_address_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_to_address_hash_fkey FOREIGN KEY (to_address_hash) REFERENCES public.addresses(hash) ON DELETE CASCADE;


--
-- TOC entry 3847 (class 2606 OID 709192)
-- Name: user_contacts user_contacts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_contacts
    ADD CONSTRAINT user_contacts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2022-06-23 11:32:58 +03

--
-- PostgreSQL database dump complete
--

