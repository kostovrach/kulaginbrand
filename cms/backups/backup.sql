--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg110+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg110+1)

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
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO directus;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO directus;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO directus;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contact; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.contact (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    phone character varying(255),
    mail character varying(255),
    address character varying(255),
    vk character varying(255),
    tg character varying(255) DEFAULT NULL::character varying,
    whatsapp character varying(255) DEFAULT NULL::character varying,
    ok character varying(255) DEFAULT NULL::character varying,
    tiktok character varying(255) DEFAULT NULL::character varying,
    studio_link character varying(255)
);


ALTER TABLE public.contact OWNER TO directus;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    accepted_terms boolean DEFAULT false,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: home_agency_slide; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_agency_slide (
    id uuid NOT NULL,
    title character varying(255),
    image uuid
);


ALTER TABLE public.home_agency_slide OWNER TO directus;

--
-- Name: home_page; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_page (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    agency_title character varying(255),
    agency_description text,
    personal_title character varying(255),
    personal_subtitle text,
    agency_subtitle text,
    personal_image uuid
);


ALTER TABLE public.home_page OWNER TO directus;

--
-- Name: home_page_home_agency_slide; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_page_home_agency_slide (
    id integer NOT NULL,
    home_page_id uuid,
    home_agency_slide_id uuid
);


ALTER TABLE public.home_page_home_agency_slide OWNER TO directus;

--
-- Name: home_page_home_agency_slide_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.home_page_home_agency_slide_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.home_page_home_agency_slide_id_seq OWNER TO directus;

--
-- Name: home_page_home_agency_slide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.home_page_home_agency_slide_id_seq OWNED BY public.home_page_home_agency_slide.id;


--
-- Name: seo; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.seo (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    meta_title character varying(255),
    meta_description text,
    og_image uuid
);


ALTER TABLE public.seo OWNER TO directus;

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: home_page_home_agency_slide id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_agency_slide ALTER COLUMN id SET DEFAULT nextval('public.home_page_home_agency_slide_id_seq'::regclass);


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.contact (id, date_updated, phone, mail, address, vk, tg, whatsapp, ok, tiktok, studio_link) FROM stdin;
9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	2025-11-20 13:54:34.824+00	+7 (927) 714-33-39	example@gmail.com	г. Самара, ул. Конноармейская 17  (офис Kulaginbrand)	https://example.com	https://example.com	https://example.com	https://example.com	https://example.com	https://kulaginstudio.ru
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
56aa4a6c-74e9-407d-b9fd-af145bc7676a	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
11efa500-51b0-40fd-9b08-0c658332de19	5a09e807-f654-4501-ab1b-e2bb5f612679	\N	4eaf42be-0cd7-4958-b7f7-ddd00d5767ec	\N
d2ef36e9-2f73-4931-8a95-336df595a121	\N	2545f07d-7228-4759-a84b-607cc64e44c1	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:29:28.434+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	http://localhost:8055
2	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:29:31.028+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
3	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:30:33.506+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
4	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:31:25.585+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	227d60c0-b241-4c94-9f8d-16e8d8eca0d9	http://localhost:8055
5	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:31:34.659+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	http://localhost:8055
6	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:32:36.103+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	1	http://localhost:8055
7	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:32:36.11+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	http://localhost:8055
8	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:32:36.117+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	http://localhost:8055
9	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:32:36.125+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
10	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:33:07.434+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
11	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:33:25.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
12	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:33:46.424+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
13	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:33:46.429+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
14	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:33:46.436+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
15	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:33:53.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
16	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:34:58.792+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
17	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:37:06.496+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
18	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:38:13.579+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
19	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:38:16.182+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
20	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:38:16.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
21	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:38:16.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
22	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:38:16.24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
23	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:38:18.921+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
24	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:10.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
25	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:13.766+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
26	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:15.564+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
27	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:15.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
28	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:15.585+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
29	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:15.587+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
30	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:39:15.599+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
31	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:07.666+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	6	http://localhost:8055
32	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:10.832+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
33	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:10.847+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
34	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:10.884+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
35	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:10.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
36	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:10.916+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
37	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:10.948+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	6	http://localhost:8055
38	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:42:35.484+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
39	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:25.897+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
40	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:28.693+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
41	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:30.583+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
42	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:30.584+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
43	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:30.604+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
44	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:30.619+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
45	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:30.635+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
46	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:44:59.43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
47	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:10.263+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
48	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:13.38+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
49	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:13.39+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
50	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:13.402+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
51	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:13.418+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
52	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:13.421+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
53	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:13.439+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
54	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:23.891+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
55	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:34.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
56	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.178+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
57	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
58	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.201+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
59	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.216+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
60	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.219+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
61	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
62	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:37.247+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
63	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:44.817+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	11	http://localhost:8055
64	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:45:59.605+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	11	http://localhost:8055
65	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
66	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.274+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
67	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.292+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
68	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.307+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
69	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.319+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
70	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.339+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
71	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.353+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
72	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:02.369+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	11	http://localhost:8055
73	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:09.913+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
74	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:20.192+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
75	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
76	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
77	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.305+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
78	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.306+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
79	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.318+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
80	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.324+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
81	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
82	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.351+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	11	http://localhost:8055
83	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:46:22.372+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
84	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:49:23.632+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	contact	9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	http://localhost:8055
85	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:50:28.8+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	2	http://localhost:8055
86	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:50:28.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	http://localhost:8055
87	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:50:28.811+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	http://localhost:8055
88	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:50:28.82+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
89	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:07.237+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
90	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:07.243+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
91	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:07.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_page	http://localhost:8055
92	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:10.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
93	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:44.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_page	http://localhost:8055
94	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:46.717+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_page	http://localhost:8055
95	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:46.777+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
96	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:51:46.786+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
97	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:53:27.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
98	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:00.716+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
99	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:48.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
100	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:50.19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
101	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:50.203+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
102	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:50.222+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
103	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:50.227+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
104	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:54:50.239+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
105	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:17.06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
106	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:20.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
107	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:20.181+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
108	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:20.189+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
109	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:20.204+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
110	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:20.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
111	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:56:20.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
112	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:09.499+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
113	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.203+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
114	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.216+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
115	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.228+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
116	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.239+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
117	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
118	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.254+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
119	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:57:12.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
120	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:58:09.488+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	20	http://localhost:8055
121	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:59:16.108+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	20	http://localhost:8055
122	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:59:46.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	21	http://localhost:8055
123	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:59:46.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_agency_slide	http://localhost:8055
124	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:00:25.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	22	http://localhost:8055
125	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:00:32.304+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_agency_slide	http://localhost:8055
129	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:01:31.271+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	23	http://localhost:8055
139	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.447+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
140	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.465+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
141	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
142	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.511+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	24	http://localhost:8055
126	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:00:35.275+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_agency_slide	http://localhost:8055
127	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:00:35.333+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
128	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:00:35.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
130	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:43.884+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	24	http://localhost:8055
131	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:43.987+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	25	http://localhost:8055
132	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:43.993+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_page_home_agency_slide	http://localhost:8055
133	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:44.046+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	26	http://localhost:8055
134	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:44.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	27	http://localhost:8055
135	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.407+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
136	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
137	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.428+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
138	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:02:46.445+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
143	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:03:49.421+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_page_home_agency_slide	http://localhost:8055
144	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:03:49.479+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
145	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:03:49.487+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
146	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:54.069+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
147	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:55.941+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
148	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:55.972+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
149	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:55.991+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
150	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:56.008+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
151	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:56.046+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
152	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:04:58.525+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
153	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:33.455+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
154	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:36.689+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
155	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:36.704+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
156	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:36.723+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
157	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:36.729+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
158	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:36.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
159	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:05:36.754+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
160	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:02.731+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
161	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:15.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
162	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
165	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.271+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
167	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.295+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
169	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	24	http://localhost:8055
163	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
164	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.269+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
166	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.291+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
168	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:18.321+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
170	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:31.322+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
171	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:53.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
172	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.721+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
173	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.732+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
174	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
175	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.761+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
176	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.766+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
177	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.781+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
178	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:56.799+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
179	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:06:59.831+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
180	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:08:11.146+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	e248aec4-8c7e-4240-9e4c-1fdd2c802240	http://localhost:8055
181	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:29.074+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	ebce4a72-76fb-48f2-9527-26413b4eb33c	http://localhost:8055
182	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_agency_slide	5a1630cd-3d0f-4ff3-bc4a-6674db83f3b3	http://localhost:8055
183	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.929+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_page_home_agency_slide	1	http://localhost:8055
184	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.935+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_agency_slide	284be087-4f4f-4cff-b50c-85cba79b08d0	http://localhost:8055
185	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.938+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_page_home_agency_slide	2	http://localhost:8055
186	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.943+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_agency_slide	2058b18a-da8c-4ab7-9a5f-cafaf2f9a0b4	http://localhost:8055
187	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.946+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_page_home_agency_slide	3	http://localhost:8055
188	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:31.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_page	13885d59-6839-4a89-a926-aa33747d1400	http://localhost:8055
189	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:54.025+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	24	http://localhost:8055
190	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:06.91+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_agency_slide	http://localhost:8055
191	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:22.934+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
192	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:30.2+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	23	http://localhost:8055
193	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:54.533+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	3	http://localhost:8055
194	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:54.539+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	4	http://localhost:8055
195	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:54.545+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	5	http://localhost:8055
196	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:54.55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	http://localhost:8055
197	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:54.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	http://localhost:8055
198	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:10:54.569+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
199	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:16:47.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	6	http://localhost:8055
200	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:16:47.269+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
201	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:26.739+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
202	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.102+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
203	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.115+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
204	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.134+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
205	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.135+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
206	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.151+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
207	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.154+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
208	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.168+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
209	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:53:30.191+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	6	http://localhost:8055
210	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:54:34.825+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	contact	9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	http://localhost:8055
211	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:16.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	33	http://localhost:8055
212	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:16.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
213	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:16.689+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
214	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:19.645+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
215	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:45.132+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
216	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:54.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
217	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:54.25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
218	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:08:54.256+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
219	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:09:30.607+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	35	http://localhost:8055
220	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:09:38.464+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	35	http://localhost:8055
221	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:09:55.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	36	http://localhost:8055
222	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:10:06.983+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	37	http://localhost:8055
223	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:10:23.939+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	7	http://localhost:8055
224	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:10:23.954+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	http://localhost:8055
225	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:10:23.964+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	http://localhost:8055
226	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:10:23.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
227	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 14:11:21.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	seo	923c17ae-3476-465e-a214-6b9412f93c65	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
home_page	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Разводная страница","singular":"Разводная страница","plural":"Разводные страницы"}]	\N	t	\N	\N	\N	all	\N	\N	1	pages	open	\N	f
home_page_home_agency_slide	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	home_agency_slide	open	\N	f
home_agency_slide	\N	\N	{{image}}{{title}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	home_page	open	\N	f
contact	globe_location_pin	\N	\N	f	t	[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}]	\N	t	\N	\N	\N	all	\N	\N	1	\N	open	\N	f
seo	settings_suggest	\N	\N	f	t	[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}]	\N	t	\N	\N	\N	all	\N	\N	2	\N	open	\N	f
pages	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	3	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
26	home_page_home_agency_slide	home_page_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
27	home_page_home_agency_slide	home_agency_slide_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
33	seo	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
30	home_page	agency_subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Подзаголовок блока студии"}]	\N	\N	t	agency	\N	\N
31	home_page	personal_image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение личного блока"}]	\N	\N	t	personal	\N	\N
13	home_page	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
23	home_agency_slide	image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение слайда"}]	\N	\N	t	\N	\N	\N
17	home_page	agency_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок блока студии"}]	\N	\N	t	agency	\N	\N
34	seo	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
35	seo	meta_title	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	t	\N	\N	\N
36	seo	meta_description	\N	input-multiline	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
8	contact	vk	\N	input	{"iconLeft":"vk"}	formatted-value	\N	f	f	1	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
37	seo	og_image	file	file-image	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
9	contact	tg	\N	input	{"iconLeft":"telegram"}	formatted-value	\N	f	f	2	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
10	contact	whatsapp	\N	input	{"iconLeft":"square_whatsapp"}	formatted-value	\N	f	f	3	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
11	contact	ok	\N	input	{"iconLeft":"odnoklassniki_square"}	formatted-value	\N	f	f	4	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
12	contact	tiktok	\N	input	{"iconLeft":"tiktok"}	formatted-value	\N	f	f	5	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
1	contact	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
2	contact	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
3	contact	main	alias,no-data,group	group-detail	{"headerIcon":"link"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Основная информация"}]	\N	\N	f	\N	\N	\N
21	home_agency_slide	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
22	home_agency_slide	title	\N	input	{"iconLeft":"title"}	\N	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок слайда"}]	Короткий заголовок 1-2 слова	\N	t	\N	\N	\N
25	home_page_home_agency_slide	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
14	home_page	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
15	home_page	agency	alias,no-data,group	group-detail	{"headerIcon":"work"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Блок студии"}]	\N	\N	f	\N	\N	\N
4	contact	phone	\N	input	{"iconLeft":"phone_enabled"}	formatted-value	\N	f	f	1	half	[{"language":"ru-RU","translation":"Номер телефона"}]	\N	\N	t	main	\N	\N
28	home_page	personal_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок личного блока"}]	\N	\N	t	personal	\N	\N
16	home_page	personal	alias,no-data,group	group-detail	{"headerIcon":"person"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Личный блок"}]	\N	\N	f	\N	\N	\N
5	contact	mail	\N	input	{"iconLeft":"mail"}	formatted-value	\N	f	f	2	half	[{"language":"ru-RU","translation":"Электронная почта"}]	\N	\N	t	main	\N	\N
29	home_page	personal_subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Подзаголовок личного блока"}]	\N	\N	t	personal	\N	\N
7	contact	socials	alias,no-data,group	group-detail	{"headerIcon":"alternate_email"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Социальные сети"}]	\N	\N	f	\N	\N	\N
19	home_page	agency_description	\N	input-multiline	\N	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Описание блока студии"}]	Например, контактная информация	\N	f	agency	\N	\N
32	contact	studio_link	\N	input	{"iconLeft":"add_link"}	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Ссылка на сайт студии"}]	\N	\N	t	main	\N	\N
24	home_page	agency_slides	m2m	list-m2m	{"enableSelect":false,"limit":100}	related-values	{"template":"{{home_agency_slide_id.image}}{{home_agency_slide_id.title}}"}	f	f	4	full	[{"language":"ru-RU","translation":"Слайды блока студии"}]	\N	\N	t	agency	\N	\N
6	contact	address	\N	input	{"iconLeft":"home_work"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Адрес"}]	Адрес студии или любой другой	\N	f	main	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
227d60c0-b241-4c94-9f8d-16e8d8eca0d9	local	227d60c0-b241-4c94-9f8d-16e8d8eca0d9.png	theplace.png	Theplace	image/png	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:31:25.578+00	\N	2025-11-20 12:31:25.625+00	\N	1343	180	180	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-20 12:31:25.624+00
e248aec4-8c7e-4240-9e4c-1fdd2c802240	local	e248aec4-8c7e-4240-9e4c-1fdd2c802240.gif	snapshot.gif	Snapshot	image/gif	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:08:11.142+00	\N	2025-11-20 13:08:11.922+00	\N	15620316	640	360	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-20 13:08:11.911+00
ebce4a72-76fb-48f2-9527-26413b4eb33c	local	ebce4a72-76fb-48f2-9527-26413b4eb33c.png	igor2.png	Igor2	image/png	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:29.071+00	\N	2025-11-20 13:09:29.113+00	\N	339033	619	679	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-20 13:09:29.112+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-11-20 12:28:38.201913+00
20201029A	Remove System Relations	2025-11-20 12:28:38.214763+00
20201029B	Remove System Collections	2025-11-20 12:28:38.229361+00
20201029C	Remove System Fields	2025-11-20 12:28:38.243834+00
20201105A	Add Cascade System Relations	2025-11-20 12:28:38.309549+00
20201105B	Change Webhook URL Type	2025-11-20 12:28:38.321699+00
20210225A	Add Relations Sort Field	2025-11-20 12:28:38.331019+00
20210304A	Remove Locked Fields	2025-11-20 12:28:38.336653+00
20210312A	Webhooks Collections Text	2025-11-20 12:28:38.347412+00
20210331A	Add Refresh Interval	2025-11-20 12:28:38.352398+00
20210415A	Make Filesize Nullable	2025-11-20 12:28:38.365475+00
20210416A	Add Collections Accountability	2025-11-20 12:28:38.374621+00
20210422A	Remove Files Interface	2025-11-20 12:28:38.379112+00
20210506A	Rename Interfaces	2025-11-20 12:28:38.408849+00
20210510A	Restructure Relations	2025-11-20 12:28:38.431531+00
20210518A	Add Foreign Key Constraints	2025-11-20 12:28:38.442115+00
20210519A	Add System Fk Triggers	2025-11-20 12:28:38.483599+00
20210521A	Add Collections Icon Color	2025-11-20 12:28:38.488388+00
20210525A	Add Insights	2025-11-20 12:28:38.520314+00
20210608A	Add Deep Clone Config	2025-11-20 12:28:38.526177+00
20210626A	Change Filesize Bigint	2025-11-20 12:28:38.546536+00
20210716A	Add Conditions to Fields	2025-11-20 12:28:38.551713+00
20210721A	Add Default Folder	2025-11-20 12:28:38.561295+00
20210802A	Replace Groups	2025-11-20 12:28:38.568303+00
20210803A	Add Required to Fields	2025-11-20 12:28:38.574394+00
20210805A	Update Groups	2025-11-20 12:28:38.580531+00
20210805B	Change Image Metadata Structure	2025-11-20 12:28:38.586919+00
20210811A	Add Geometry Config	2025-11-20 12:28:38.592696+00
20210831A	Remove Limit Column	2025-11-20 12:28:38.597629+00
20210903A	Add Auth Provider	2025-11-20 12:28:38.624637+00
20210907A	Webhooks Collections Not Null	2025-11-20 12:28:38.635631+00
20210910A	Move Module Setup	2025-11-20 12:28:38.642548+00
20210920A	Webhooks URL Not Null	2025-11-20 12:28:38.653208+00
20210924A	Add Collection Organization	2025-11-20 12:28:38.66294+00
20210927A	Replace Fields Group	2025-11-20 12:28:38.675271+00
20210927B	Replace M2M Interface	2025-11-20 12:28:38.679665+00
20210929A	Rename Login Action	2025-11-20 12:28:38.683651+00
20211007A	Update Presets	2025-11-20 12:28:38.695183+00
20211009A	Add Auth Data	2025-11-20 12:28:38.700356+00
20211016A	Add Webhook Headers	2025-11-20 12:28:38.705287+00
20211103A	Set Unique to User Token	2025-11-20 12:28:38.71433+00
20211103B	Update Special Geometry	2025-11-20 12:28:38.718883+00
20211104A	Remove Collections Listing	2025-11-20 12:28:38.724582+00
20211118A	Add Notifications	2025-11-20 12:28:38.746959+00
20211211A	Add Shares	2025-11-20 12:28:38.779312+00
20211230A	Add Project Descriptor	2025-11-20 12:28:38.785752+00
20220303A	Remove Default Project Color	2025-11-20 12:28:38.800578+00
20220308A	Add Bookmark Icon and Color	2025-11-20 12:28:38.807806+00
20220314A	Add Translation Strings	2025-11-20 12:28:38.81478+00
20220322A	Rename Field Typecast Flags	2025-11-20 12:28:38.822614+00
20220323A	Add Field Validation	2025-11-20 12:28:38.831372+00
20220325A	Fix Typecast Flags	2025-11-20 12:28:38.838765+00
20220325B	Add Default Language	2025-11-20 12:28:38.854783+00
20220402A	Remove Default Value Panel Icon	2025-11-20 12:28:38.865628+00
20220429A	Add Flows	2025-11-20 12:28:38.927184+00
20220429B	Add Color to Insights Icon	2025-11-20 12:28:38.935683+00
20220429C	Drop Non Null From IP of Activity	2025-11-20 12:28:38.944122+00
20220429D	Drop Non Null From Sender of Notifications	2025-11-20 12:28:38.951695+00
20220614A	Rename Hook Trigger to Event	2025-11-20 12:28:38.958163+00
20220801A	Update Notifications Timestamp Column	2025-11-20 12:28:38.970879+00
20220802A	Add Custom Aspect Ratios	2025-11-20 12:28:38.977125+00
20220826A	Add Origin to Accountability	2025-11-20 12:28:38.987756+00
20230401A	Update Material Icons	2025-11-20 12:28:39.001585+00
20230525A	Add Preview Settings	2025-11-20 12:28:39.006745+00
20230526A	Migrate Translation Strings	2025-11-20 12:28:39.02836+00
20230721A	Require Shares Fields	2025-11-20 12:28:39.037747+00
20230823A	Add Content Versioning	2025-11-20 12:28:39.06808+00
20230927A	Themes	2025-11-20 12:28:39.094011+00
20231009A	Update CSV Fields to Text	2025-11-20 12:28:39.101556+00
20231009B	Update Panel Options	2025-11-20 12:28:39.105856+00
20231010A	Add Extensions	2025-11-20 12:28:39.116045+00
20231215A	Add Focalpoints	2025-11-20 12:28:39.121736+00
20240122A	Add Report URL Fields	2025-11-20 12:28:39.128159+00
20240204A	Marketplace	2025-11-20 12:28:39.17162+00
20240305A	Change Useragent Type	2025-11-20 12:28:39.186357+00
20240311A	Deprecate Webhooks	2025-11-20 12:28:39.198863+00
20240422A	Public Registration	2025-11-20 12:28:39.207196+00
20240515A	Add Session Window	2025-11-20 12:28:39.212477+00
20240701A	Add Tus Data	2025-11-20 12:28:39.217706+00
20240716A	Update Files Date Fields	2025-11-20 12:28:39.228871+00
20240806A	Permissions Policies	2025-11-20 12:28:39.292554+00
20240817A	Update Icon Fields Length	2025-11-20 12:28:39.333468+00
20240909A	Separate Comments	2025-11-20 12:28:39.354138+00
20240909B	Consolidate Content Versioning	2025-11-20 12:28:39.360529+00
20240924A	Migrate Legacy Comments	2025-11-20 12:28:39.370735+00
20240924B	Populate Versioning Deltas	2025-11-20 12:28:39.377582+00
20250224A	Visual Editor	2025-11-20 12:28:39.383677+00
20250609A	License Banner	2025-11-20 12:28:39.391673+00
20250613A	Add Project ID	2025-11-20 12:28:39.421738+00
20250718A	Add Direction	2025-11-20 12:28:39.427474+00
20250813A	Add MCP	2025-11-20 12:28:39.434109+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	directus_files	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
2	contact	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
3	home_agency_slide	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
4	home_page	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
5	home_page_home_agency_slide	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
6	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
7	seo	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
4eaf42be-0cd7-4958-b7f7-ddd00d5767ec	Administrator	verified	$t:admin_description	\N	f	t	t
60ca5918-2a7d-4808-9a8e-cdfd721a22dd	read_only	badge	\N	\N	f	f	f
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	\N	directus_users	\N	cards	{"cards":{"sort":["email"]}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":3}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	home_agency_slide	image	directus_files	\N	\N	\N	\N	\N	nullify
2	home_page_home_agency_slide	home_agency_slide_id	home_agency_slide	\N	\N	\N	home_page_id	\N	nullify
3	home_page_home_agency_slide	home_page_id	home_page	agency_slides	\N	\N	home_agency_slide_id	\N	nullify
4	home_page	personal_image	directus_files	\N	\N	\N	\N	\N	nullify
5	seo	og_image	directus_files	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"accepted_terms":true}	\N	\N
2	3	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_name":"Kulaginbrand","module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"default_language":"ru-RU"}	\N	\N
3	4	directus_files	227d60c0-b241-4c94-9f8d-16e8d8eca0d9	{"title":"Theplace","filename_download":"theplace.png","type":"image/png","storage":"local"}	{"title":"Theplace","filename_download":"theplace.png","type":"image/png","storage":"local"}	\N	\N
4	5	directus_users	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	{"id":"d05b00f5-2aeb-4f89-ad64-e41ca3b0327a","first_name":"Kulagin-studio","last_name":null,"email":"theplace2024@yandex.ru","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":"227d60c0-b241-4c94-9f8d-16e8d8eca0d9","language":null,"tfa_secret":null,"status":"active","role":"5a09e807-f654-4501-ab1b-e2bb5f612679","token":null,"last_access":"2025-11-20T12:29:28.440Z","last_page":"/users/d05b00f5-2aeb-4f89-ad64-e41ca3b0327a","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"first_name":"Kulagin-studio","last_name":null,"avatar":"227d60c0-b241-4c94-9f8d-16e8d8eca0d9"}	\N	\N
5	6	directus_permissions	1	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	6	\N
6	7	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}	7	\N
8	9	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	{"first_name":"frontend","email_notifications":false,"policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]}}	{"first_name":"frontend","email_notifications":false,"policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]}}	\N	\N
10	11	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	\N	\N
11	12	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"contact"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"contact"}	\N	\N
12	13	directus_fields	2	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"contact"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"contact"}	\N	\N
13	14	directus_collections	contact	{"singleton":true,"collection":"contact"}	{"singleton":true,"collection":"contact"}	\N	\N
26	26	directus_fields	4	{"id":4,"collection":"contact","field":"phone","special":null,"interface":"input","options":{"iconLeft":"phone_enabled"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Номер телефона"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"phone","sort":1,"group":"main"}	\N	\N
191	197	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	{"id":"d2ef36e9-2f73-4931-8a95-336df595a121","role":null,"user":"2545f07d-7228-4759-a84b-607cc64e44c1","policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","sort":1}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd"}	\N	\N
7	8	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"2545f07d-7228-4759-a84b-607cc64e44c1"}	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"2545f07d-7228-4759-a84b-607cc64e44c1"}	8	\N
9	10	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	{"id":"2545f07d-7228-4759-a84b-607cc64e44c1","first_name":"frontend","last_name":null,"email":null,"password":null,"location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":null,"token":"**********","last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":false,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":["d2ef36e9-2f73-4931-8a95-336df595a121"]}	{"token":"**********"}	\N	\N
14	15	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","width":"full"}	\N	\N
15	16	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"globe_location_pin","translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}]}	\N	\N
16	17	directus_fields	3	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Основная информация"}],"interface":"group-detail","options":{"headerIcon":"link"},"collection":"contact","field":"main"}	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Основная информация"}],"interface":"group-detail","options":{"headerIcon":"link"},"collection":"contact","field":"main"}	\N	\N
17	18	directus_fields	4	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"phone_enabled"},"translations":[{"language":"ru-RU","translation":"Номер телефона"}],"display":"formatted-value","collection":"contact","field":"phone"}	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"phone_enabled"},"translations":[{"language":"ru-RU","translation":"Номер телефона"}],"display":"formatted-value","collection":"contact","field":"phone"}	\N	\N
18	19	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
19	20	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
20	21	directus_fields	4	{"id":4,"collection":"contact","field":"phone","special":null,"interface":"input","options":{"iconLeft":"phone_enabled"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Номер телефона"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"phone","sort":1,"group":"main"}	\N	\N
21	22	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
22	23	directus_fields	4	{"id":4,"collection":"contact","field":"phone","special":null,"interface":"input","options":{"iconLeft":"phone_enabled"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Номер телефона"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"phone","width":"half"}	\N	\N
23	24	directus_fields	5	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Электронная почта"}],"options":{"iconLeft":"mail"},"display":"formatted-value","collection":"contact","field":"mail"}	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Электронная почта"}],"options":{"iconLeft":"mail"},"display":"formatted-value","collection":"contact","field":"mail"}	\N	\N
24	25	directus_fields	5	{"id":5,"collection":"contact","field":"mail","special":null,"interface":"input","options":{"iconLeft":"mail"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Электронная почта"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"mail","width":"half"}	\N	\N
25	27	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
88	91	directus_collections	home_page	{"singleton":true,"collection":"home_page"}	{"singleton":true,"collection":"home_page"}	\N	\N
27	28	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
29	30	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
28	29	directus_fields	5	{"id":5,"collection":"contact","field":"mail","special":null,"interface":"input","options":{"iconLeft":"mail"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Электронная почта"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"mail","sort":2,"group":"main"}	\N	\N
30	31	directus_fields	6	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"home_work"},"translations":[{"language":"ru-RU","translation":"Адрес"}],"note":"Адрес студии или любой другой","display":"formatted-value","collection":"contact","field":"address"}	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"home_work"},"translations":[{"language":"ru-RU","translation":"Адрес"}],"note":"Адрес студии или любой другой","display":"formatted-value","collection":"contact","field":"address"}	\N	\N
31	32	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
32	33	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
33	34	directus_fields	4	{"id":4,"collection":"contact","field":"phone","special":null,"interface":"input","options":{"iconLeft":"phone_enabled"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Номер телефона"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"phone","sort":1,"group":"main"}	\N	\N
34	35	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
35	36	directus_fields	5	{"id":5,"collection":"contact","field":"mail","special":null,"interface":"input","options":{"iconLeft":"mail"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Электронная почта"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"mail","sort":2,"group":"main"}	\N	\N
36	37	directus_fields	6	{"id":6,"collection":"contact","field":"address","special":null,"interface":"input","options":{"iconLeft":"home_work"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Адрес"}],"note":"Адрес студии или любой другой","conditions":null,"required":false,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"address","sort":3,"group":"main"}	\N	\N
37	38	directus_fields	7	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Социальные сети"}],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"collection":"contact","field":"socials"}	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Социальные сети"}],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"collection":"contact","field":"socials"}	\N	\N
38	39	directus_fields	8	{"sort":5,"translations":null,"special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","note":"Ссылка в формате https://","collection":"contact","field":"vk"}	{"sort":5,"translations":null,"special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","note":"Ссылка в формате https://","collection":"contact","field":"vk"}	\N	\N
39	40	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"vk","width":"half"}	\N	\N
40	41	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"vk","sort":1,"group":"socials"}	\N	\N
41	42	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
42	43	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
43	44	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
44	45	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
45	46	directus_fields	9	{"sort":5,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":5,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
46	47	directus_fields	9	{"id":9,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"tg","options":{"iconLeft":"telegram"}}	\N	\N
47	48	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
48	49	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
49	50	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
50	51	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"vk","sort":1,"group":"socials"}	\N	\N
51	52	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
52	53	directus_fields	9	{"id":9,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tg","sort":2,"group":"socials"}	\N	\N
53	54	directus_fields	10	{"sort":5,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":5,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
54	55	directus_fields	10	{"id":10,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"whatsapp","options":{"iconLeft":"square_whatsapp"}}	\N	\N
55	56	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
56	57	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
57	58	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
192	199	directus_permissions	6	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
58	59	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
59	60	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"vk","sort":1,"group":"socials"}	\N	\N
60	61	directus_fields	9	{"id":9,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tg","sort":2,"group":"socials"}	\N	\N
61	62	directus_fields	10	{"id":10,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"whatsapp","sort":3,"group":"socials"}	\N	\N
62	63	directus_fields	11	{"sort":5,"collection":"contact","field":"ok","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":5,"collection":"contact","field":"ok","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
63	64	directus_fields	11	{"id":11,"collection":"contact","field":"ok","special":null,"interface":"input","options":{"iconLeft":"odnoklassniki_square"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"ok","options":{"iconLeft":"odnoklassniki_square"}}	\N	\N
64	65	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
65	66	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
66	67	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
67	68	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"vk","sort":1,"group":"socials"}	\N	\N
68	69	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
69	70	directus_fields	9	{"id":9,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tg","sort":2,"group":"socials"}	\N	\N
70	71	directus_fields	10	{"id":10,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"whatsapp","sort":3,"group":"socials"}	\N	\N
71	72	directus_fields	11	{"id":11,"collection":"contact","field":"ok","special":null,"interface":"input","options":{"iconLeft":"odnoklassniki_square"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"ok","sort":4,"group":"socials"}	\N	\N
89	92	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","width":"full"}	\N	\N
72	73	directus_fields	12	{"sort":5,"collection":"contact","field":"tiktok","special":null,"interface":"input","options":{"iconLeft":"odnoklassniki_square"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":5,"collection":"contact","field":"tiktok","special":null,"interface":"input","options":{"iconLeft":"odnoklassniki_square"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
73	74	directus_fields	12	{"id":12,"collection":"contact","field":"tiktok","special":null,"interface":"input","options":{"iconLeft":"tiktok"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"tiktok","options":{"iconLeft":"tiktok"}}	\N	\N
74	75	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
75	76	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
76	77	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
77	78	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"vk","sort":1,"group":"socials"}	\N	\N
78	79	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
79	80	directus_fields	9	{"id":9,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tg","sort":2,"group":"socials"}	\N	\N
80	81	directus_fields	10	{"id":10,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"whatsapp","sort":3,"group":"socials"}	\N	\N
81	82	directus_fields	11	{"id":11,"collection":"contact","field":"ok","special":null,"interface":"input","options":{"iconLeft":"odnoklassniki_square"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"ok","sort":4,"group":"socials"}	\N	\N
82	83	directus_fields	12	{"id":12,"collection":"contact","field":"tiktok","special":null,"interface":"input","options":{"iconLeft":"tiktok"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tiktok","sort":5,"group":"socials"}	\N	\N
83	84	contact	9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	{"phone":"+7 (927) 714-33-39","mail":"example@gmail.com","address":"г. Самара, ул. Конноармейская 17  (офис Kulaginbrand)","vk":"https://example.com","tg":"https://example.com","whatsapp":"https://example.com","ok":"https://example.com","tiktok":"https://example.com"}	{"phone":"+7 (927) 714-33-39","mail":"example@gmail.com","address":"г. Самара, ул. Конноармейская 17  (офис Kulaginbrand)","vk":"https://example.com","tg":"https://example.com","whatsapp":"https://example.com","ok":"https://example.com","tiktok":"https://example.com"}	\N	\N
84	85	directus_permissions	2	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact","action":"read"}	\N	\N
85	87	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	{"id":"d2ef36e9-2f73-4931-8a95-336df595a121","role":null,"user":"2545f07d-7228-4759-a84b-607cc64e44c1","policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","sort":1}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd"}	\N	\N
86	89	directus_fields	13	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_page"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_page"}	\N	\N
87	90	directus_fields	14	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"home_page"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"home_page"}	\N	\N
90	93	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Разводная страница","singular":"Разводная страница","plural":"Разводные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Разводная страница","singular":"Разводная страница","plural":"Разводные страницы"}]}	\N	\N
91	94	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Разводная страница","singular":"Разводная страница","plural":"Разводные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
92	95	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
93	96	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
94	97	directus_fields	15	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок студии"}],"interface":"group-detail","options":{"headerIcon":"work"},"collection":"home_page","field":"agency"}	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок студии"}],"interface":"group-detail","options":{"headerIcon":"work"},"collection":"home_page","field":"agency"}	\N	\N
95	98	directus_fields	16	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Личный блок"}],"interface":"group-detail","options":{"headerIcon":"person"},"collection":"home_page","field":"personal"}	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Личный блок"}],"interface":"group-detail","options":{"headerIcon":"person"},"collection":"home_page","field":"personal"}	\N	\N
96	99	directus_fields	17	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"title"},"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"display":"formatted-value","collection":"home_page","field":"agency_title"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"title"},"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"display":"formatted-value","collection":"home_page","field":"agency_title"}	\N	\N
97	100	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
98	101	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
99	102	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
100	103	directus_fields	17	{"id":17,"collection":"home_page","field":"agency_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_title","sort":1,"group":"agency"}	\N	\N
101	104	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
102	105	directus_fields	18	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"text_fields"},"required":true,"translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}],"display":"formatted-value","collection":"home_page","field":"agency_subtitle"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"text_fields"},"required":true,"translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}],"display":"formatted-value","collection":"home_page","field":"agency_subtitle"}	\N	\N
103	106	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
104	107	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
189	194	directus_permissions	4	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page","action":"read"}	\N	\N
105	108	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
106	109	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
107	110	directus_fields	17	{"id":17,"collection":"home_page","field":"agency_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_title","sort":1,"group":"agency"}	\N	\N
108	111	directus_fields	18	{"id":18,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_subtitle","sort":2,"group":"agency"}	\N	\N
109	112	directus_fields	19	{"sort":5,"interface":"input-multiline","special":null,"translations":[{"language":"ru-RU","translation":"Описание блока студии"}],"note":"Например, контактная информация","display":"formatted-value","collection":"home_page","field":"agency_description"}	{"sort":5,"interface":"input-multiline","special":null,"translations":[{"language":"ru-RU","translation":"Описание блока студии"}],"note":"Например, контактная информация","display":"formatted-value","collection":"home_page","field":"agency_description"}	\N	\N
110	113	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
111	114	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
112	115	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
113	116	directus_fields	17	{"id":17,"collection":"home_page","field":"agency_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_title","sort":1,"group":"agency"}	\N	\N
114	117	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
115	118	directus_fields	18	{"id":18,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_subtitle","sort":2,"group":"agency"}	\N	\N
116	119	directus_fields	19	{"id":19,"collection":"home_page","field":"agency_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание блока студии"}],"note":"Например, контактная информация","conditions":null,"required":false,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_description","sort":3,"group":"agency"}	\N	\N
117	120	directus_fields	20	{"sort":5,"interface":"list","special":["cast-json"],"options":{"fields":[{"field":"test","name":"test","type":"json","meta":{"field":"test","type":"json","interface":"collection-item-dropdown","options":{"selectedCollection":"directus_files"}}}]},"collection":"home_page","field":"test"}	{"sort":5,"interface":"list","special":["cast-json"],"options":{"fields":[{"field":"test","name":"test","type":"json","meta":{"field":"test","type":"json","interface":"collection-item-dropdown","options":{"selectedCollection":"directus_files"}}}]},"collection":"home_page","field":"test"}	\N	\N
118	122	directus_fields	21	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_agency_slide"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_agency_slide"}	\N	\N
119	123	directus_collections	home_agency_slide	{"singleton":false,"collection":"home_agency_slide"}	{"singleton":false,"collection":"home_agency_slide"}	\N	\N
120	124	directus_fields	22	{"sort":2,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"required":true,"note":"Короткий заголовок 1-2 слова","collection":"home_agency_slide","field":"title"}	{"sort":2,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"required":true,"note":"Короткий заголовок 1-2 слова","collection":"home_agency_slide","field":"title"}	\N	\N
121	125	directus_collections	home_agency_slide	{"collection":"home_agency_slide","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
122	126	directus_collections	home_agency_slide	{"collection":"home_agency_slide","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_page","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"home_page"}	\N	\N
123	127	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
124	128	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
126	130	directus_fields	24	{"sort":5,"interface":"list-m2m","special":["m2m"],"required":true,"options":{"enableSelect":false,"limit":100},"translations":[{"language":"ru-RU","translation":"Слайды блока студии"}],"display":"related-values","collection":"home_page","field":"agency_slides"}	{"sort":5,"interface":"list-m2m","special":["m2m"],"required":true,"options":{"enableSelect":false,"limit":100},"translations":[{"language":"ru-RU","translation":"Слайды блока студии"}],"display":"related-values","collection":"home_page","field":"agency_slides"}	\N	\N
127	131	directus_fields	25	{"sort":1,"hidden":true,"field":"id","collection":"home_page_home_agency_slide"}	{"sort":1,"hidden":true,"field":"id","collection":"home_page_home_agency_slide"}	\N	\N
128	132	directus_collections	home_page_home_agency_slide	{"hidden":true,"icon":"import_export","collection":"home_page_home_agency_slide"}	{"hidden":true,"icon":"import_export","collection":"home_page_home_agency_slide"}	\N	\N
129	133	directus_fields	26	{"sort":2,"hidden":true,"collection":"home_page_home_agency_slide","field":"home_page_id"}	{"sort":2,"hidden":true,"collection":"home_page_home_agency_slide","field":"home_page_id"}	\N	\N
130	134	directus_fields	27	{"sort":3,"hidden":true,"collection":"home_page_home_agency_slide","field":"home_agency_slide_id"}	{"sort":3,"hidden":true,"collection":"home_page_home_agency_slide","field":"home_agency_slide_id"}	\N	\N
131	135	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
132	136	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
133	137	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
134	138	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
125	129	directus_fields	23	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение слайда"}],"required":true,"collection":"home_agency_slide","field":"image"}	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение слайда"}],"required":true,"collection":"home_agency_slide","field":"image"}	\N	\N
135	139	directus_fields	17	{"id":17,"collection":"home_page","field":"agency_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_title","sort":1,"group":"agency"}	\N	\N
136	140	directus_fields	18	{"id":18,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_subtitle","sort":2,"group":"agency"}	\N	\N
137	141	directus_fields	19	{"id":19,"collection":"home_page","field":"agency_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание блока студии"}],"note":"Например, контактная информация","conditions":null,"required":false,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_description","sort":3,"group":"agency"}	\N	\N
138	142	directus_fields	24	{"id":24,"collection":"home_page","field":"agency_slides","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false,"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Слайды блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_slides","sort":4,"group":"agency"}	\N	\N
139	143	directus_collections	home_page_home_agency_slide	{"collection":"home_page_home_agency_slide","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_agency_slide","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"home_agency_slide"}	\N	\N
140	144	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
141	145	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
142	146	directus_fields	28	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок личного блока"}],"display":"formatted-value","collection":"home_page","field":"personal_title"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок личного блока"}],"display":"formatted-value","collection":"home_page","field":"personal_title"}	\N	\N
143	147	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
144	148	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
145	149	directus_fields	28	{"id":28,"collection":"home_page","field":"personal_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок личного блока"}],"note":null,"conditions":null,"required":false,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_title","sort":1,"group":"personal"}	\N	\N
146	150	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
147	151	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
148	152	directus_fields	28	{"id":28,"collection":"home_page","field":"personal_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_title","required":true}	\N	\N
149	153	directus_fields	29	{"sort":5,"required":true,"translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"special":null,"interface":"input-multiline","display":"formatted-value","collection":"home_page","field":"personal_subtitle"}	{"sort":5,"required":true,"translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"special":null,"interface":"input-multiline","display":"formatted-value","collection":"home_page","field":"personal_subtitle"}	\N	\N
150	154	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
151	155	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
152	156	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
154	158	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
157	163	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
159	164	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
161	166	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
163	168	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
170	175	directus_fields	28	{"id":28,"collection":"home_page","field":"personal_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_title","sort":1,"group":"personal"}	\N	\N
172	177	directus_fields	29	{"id":29,"collection":"home_page","field":"personal_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_subtitle","sort":2,"group":"personal"}	\N	\N
173	178	directus_fields	31	{"id":31,"collection":"home_page","field":"personal_image","special":["file"],"interface":"file-image","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение личного блока"}],"note":null,"conditions":null,"required":false,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_image","sort":3,"group":"personal"}	\N	\N
153	157	directus_fields	28	{"id":28,"collection":"home_page","field":"personal_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_title","sort":1,"group":"personal"}	\N	\N
155	159	directus_fields	29	{"id":29,"collection":"home_page","field":"personal_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_subtitle","sort":2,"group":"personal"}	\N	\N
156	161	directus_fields	30	{"sort":5,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"note":null,"conditions":null,"required":true,"validation":null,"validation_message":null}	{"sort":5,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"note":null,"conditions":null,"required":true,"validation":null,"validation_message":null}	\N	\N
158	162	directus_fields	17	{"id":17,"collection":"home_page","field":"agency_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_title","sort":1,"group":"agency"}	\N	\N
160	165	directus_fields	30	{"id":30,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок личного блока"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_subtitle","sort":2,"group":"agency"}	\N	\N
162	167	directus_fields	19	{"id":19,"collection":"home_page","field":"agency_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание блока студии"}],"note":"Например, контактная информация","conditions":null,"required":false,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_description","sort":3,"group":"agency"}	\N	\N
164	169	directus_fields	24	{"id":24,"collection":"home_page","field":"agency_slides","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false,"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Слайды блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_slides","sort":4,"group":"agency"}	\N	\N
165	170	directus_fields	30	{"id":30,"collection":"home_page","field":"agency_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_subtitle","translations":[{"language":"ru-RU","translation":"Подзаголовок блока студии"}]}	\N	\N
166	171	directus_fields	31	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение личного блока"}],"collection":"home_page","field":"personal_image"}	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение личного блока"}],"collection":"home_page","field":"personal_image"}	\N	\N
167	172	directus_fields	13	{"id":13,"collection":"home_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"id","sort":1,"group":null}	\N	\N
168	173	directus_fields	14	{"id":14,"collection":"home_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"date_updated","sort":2,"group":null}	\N	\N
169	174	directus_fields	15	{"id":15,"collection":"home_page","field":"agency","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блок студии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"agency","sort":3,"group":null}	\N	\N
171	176	directus_fields	16	{"id":16,"collection":"home_page","field":"personal","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"person"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Личный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home_page","field":"personal","sort":4,"group":null}	\N	\N
190	195	directus_permissions	5	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page_home_agency_slide","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page_home_agency_slide","action":"read"}	\N	\N
174	179	directus_fields	31	{"id":31,"collection":"home_page","field":"personal_image","special":["file"],"interface":"file-image","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_image","required":true}	\N	\N
175	180	directus_files	e248aec4-8c7e-4240-9e4c-1fdd2c802240	{"title":"Snapshot","filename_download":"snapshot.gif","type":"image/gif","storage":"local"}	{"title":"Snapshot","filename_download":"snapshot.gif","type":"image/gif","storage":"local"}	\N	\N
176	181	directus_files	ebce4a72-76fb-48f2-9527-26413b4eb33c	{"title":"Igor2","filename_download":"igor2.png","type":"image/png","storage":"local"}	{"title":"Igor2","filename_download":"igor2.png","type":"image/png","storage":"local"}	\N	\N
177	182	home_agency_slide	5a1630cd-3d0f-4ff3-bc4a-6674db83f3b3	{"title":"Брендинг","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	{"title":"Брендинг","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	178	\N
179	184	home_agency_slide	284be087-4f4f-4cff-b50c-85cba79b08d0	{"title":"Создание сайтов","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	{"title":"Создание сайтов","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	180	\N
181	186	home_agency_slide	2058b18a-da8c-4ab7-9a5f-cafaf2f9a0b4	{"title":"Продвижение","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	{"title":"Продвижение","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	182	\N
183	188	home_page	13885d59-6839-4a89-a926-aa33747d1400	{"agency_title":"Дизайн студия","agency_subtitle":"Симбиоз талантливых и неординарных личностей, создающих нечто более, чем просто продукт","agency_description":"+7 (927) 714-33-39","agency_slides":{"create":[{"home_agency_slide_id":{"title":"Брендинг","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}},{"home_agency_slide_id":{"title":"Создание сайтов","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}},{"home_agency_slide_id":{"title":"Продвижение","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}}],"update":[],"delete":[]},"personal_title":"Развиваю личные бренды","personal_subtitle":"Мой опыт и знания смогут сократить путь к результатам, экономя несколько лет усилий","personal_image":"ebce4a72-76fb-48f2-9527-26413b4eb33c"}	{"agency_title":"Дизайн студия","agency_subtitle":"Симбиоз талантливых и неординарных личностей, создающих нечто более, чем просто продукт","agency_description":"+7 (927) 714-33-39","agency_slides":{"create":[{"home_agency_slide_id":{"title":"Брендинг","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}},{"home_agency_slide_id":{"title":"Создание сайтов","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}},{"home_agency_slide_id":{"title":"Продвижение","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}}],"update":[],"delete":[]},"personal_title":"Развиваю личные бренды","personal_subtitle":"Мой опыт и знания смогут сократить путь к результатам, экономя несколько лет усилий","personal_image":"ebce4a72-76fb-48f2-9527-26413b4eb33c"}	\N	\N
178	183	home_page_home_agency_slide	1	{"home_agency_slide_id":{"title":"Брендинг","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"},"home_page_id":"13885d59-6839-4a89-a926-aa33747d1400"}	{"home_agency_slide_id":{"title":"Брендинг","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"},"home_page_id":"13885d59-6839-4a89-a926-aa33747d1400"}	183	\N
180	185	home_page_home_agency_slide	2	{"home_agency_slide_id":{"title":"Создание сайтов","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"},"home_page_id":"13885d59-6839-4a89-a926-aa33747d1400"}	{"home_agency_slide_id":{"title":"Создание сайтов","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"},"home_page_id":"13885d59-6839-4a89-a926-aa33747d1400"}	183	\N
182	187	home_page_home_agency_slide	3	{"home_agency_slide_id":{"title":"Продвижение","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"},"home_page_id":"13885d59-6839-4a89-a926-aa33747d1400"}	{"home_agency_slide_id":{"title":"Продвижение","image":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"},"home_page_id":"13885d59-6839-4a89-a926-aa33747d1400"}	183	\N
184	189	directus_fields	24	{"id":24,"collection":"home_page","field":"agency_slides","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false,"limit":100},"display":"related-values","display_options":{"template":"{{home_agency_slide_id.image}}{{home_agency_slide_id.title}}"},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Слайды блока студии"}],"note":null,"conditions":null,"required":true,"group":"agency","validation":null,"validation_message":null}	{"collection":"home_page","field":"agency_slides","display_options":{"template":"{{home_agency_slide_id.image}}{{home_agency_slide_id.title}}"}}	\N	\N
185	190	directus_collections	home_agency_slide	{"collection":"home_agency_slide","icon":null,"note":null,"display_template":"{{image}}{{title}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_page","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image}}{{title}}"}	\N	\N
186	191	directus_fields	31	{"id":31,"collection":"home_page","field":"personal_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение личного блока"}],"note":null,"conditions":null,"required":true,"group":"personal","validation":null,"validation_message":null}	{"collection":"home_page","field":"personal_image","display":"image"}	\N	\N
187	192	directus_fields	23	{"id":23,"collection":"home_agency_slide","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение слайда"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"home_agency_slide","field":"image","display":"image"}	\N	\N
188	193	directus_permissions	3	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_agency_slide","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_agency_slide","action":"read"}	\N	\N
193	201	directus_fields	32	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"add_link"},"required":true,"translations":[{"language":"ru-RU","translation":"Ссылка на сайт студии"}],"display":"formatted-value","collection":"contact","field":"studio_link"}	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"add_link"},"required":true,"translations":[{"language":"ru-RU","translation":"Ссылка на сайт студии"}],"display":"formatted-value","collection":"contact","field":"studio_link"}	\N	\N
194	202	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
195	203	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
196	205	directus_fields	4	{"id":4,"collection":"contact","field":"phone","special":null,"interface":"input","options":{"iconLeft":"phone_enabled"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Номер телефона"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"phone","sort":1,"group":"main"}	\N	\N
197	204	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
198	206	directus_fields	5	{"id":5,"collection":"contact","field":"mail","special":null,"interface":"input","options":{"iconLeft":"mail"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Электронная почта"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"mail","sort":2,"group":"main"}	\N	\N
199	207	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
200	208	directus_fields	32	{"id":32,"collection":"contact","field":"studio_link","special":null,"interface":"input","options":{"iconLeft":"add_link"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Ссылка на сайт студии"}],"note":null,"conditions":null,"required":true,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"studio_link","sort":3,"group":"main"}	\N	\N
201	209	directus_fields	6	{"id":6,"collection":"contact","field":"address","special":null,"interface":"input","options":{"iconLeft":"home_work"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Адрес"}],"note":"Адрес студии или любой другой","conditions":null,"required":false,"group":"main","validation":null,"validation_message":null}	{"collection":"contact","field":"address","sort":4,"group":"main"}	\N	\N
202	210	contact	9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	{"id":"9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe","date_updated":"2025-11-20T13:54:34.824Z","phone":"+7 (927) 714-33-39","mail":"example@gmail.com","address":"г. Самара, ул. Конноармейская 17  (офис Kulaginbrand)","vk":"https://example.com","tg":"https://example.com","whatsapp":"https://example.com","ok":"https://example.com","tiktok":"https://example.com","studio_link":"https://kulaginstudio.ru"}	{"studio_link":"https://kulaginstudio.ru","date_updated":"2025-11-20T13:54:34.824Z"}	\N	\N
203	211	directus_fields	33	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"seo"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"seo"}	\N	\N
204	212	directus_fields	34	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"seo"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"seo"}	\N	\N
205	213	directus_collections	seo	{"singleton":true,"collection":"seo"}	{"singleton":true,"collection":"seo"}	\N	\N
206	214	directus_fields	34	{"id":34,"collection":"seo","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"seo","field":"date_updated","width":"full"}	\N	\N
207	215	directus_collections	seo	{"collection":"seo","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"settings_suggest","translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}]}	\N	\N
208	216	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
209	217	directus_collections	seo	{"collection":"seo","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
210	218	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
211	219	directus_fields	35	{"sort":3,"interface":"input","special":null,"collection":"seo","field":"meta_title"}	{"sort":3,"interface":"input","special":null,"collection":"seo","field":"meta_title"}	\N	\N
212	220	directus_fields	35	{"id":35,"collection":"seo","field":"meta_title","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"seo","field":"meta_title","required":true}	\N	\N
213	221	directus_fields	36	{"sort":4,"interface":"input-multiline","special":null,"collection":"seo","field":"meta_description"}	{"sort":4,"interface":"input-multiline","special":null,"collection":"seo","field":"meta_description"}	\N	\N
214	222	directus_fields	37	{"sort":5,"interface":"file-image","special":["file"],"collection":"seo","field":"og_image"}	{"sort":5,"interface":"file-image","special":["file"],"collection":"seo","field":"og_image"}	\N	\N
215	223	directus_permissions	7	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"seo","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"seo","action":"read"}	\N	\N
216	225	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	{"id":"d2ef36e9-2f73-4931-8a95-336df595a121","role":null,"user":"2545f07d-7228-4759-a84b-607cc64e44c1","policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","sort":1}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd"}	\N	\N
217	227	seo	923c17ae-3476-465e-a214-6b9412f93c65	{"meta_title":"Развитие личных брендов | Игорь Кулагин","meta_description":"Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса. Помогаю бизнесу зарабатывать!"}	{"meta_title":"Развитие личных брендов | Игорь Кулагин","meta_description":"Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса. Помогаю бизнесу зарабатывать!"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
5a09e807-f654-4501-ab1b-e2bb5f612679	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
YvbQT_WmgxTvVBoMozCpcfAXZldeBRuuON1LUI1RHAEfAfSxkvqIqBCZg2XNHeMz	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 15:26:17.777+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	sJpc2D_BOfxNSeDoOONFQi50DCytk-Dbg9XX5U20FMuYjp1JBYcQI6sdb_GWRFPR
sJpc2D_BOfxNSeDoOONFQi50DCytk-Dbg9XX5U20FMuYjp1JBYcQI6sdb_GWRFPR	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-21 15:26:07.776+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Kulaginbrand	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}]	\N	ru-RU	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	019aa13c-fa7b-75bb-8488-756ddfa7fac4	f	f	\N	t	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	Kulagin-studio	\N	theplace2024@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$xwBvwoDzOWVZ3nSXT5rt4A$zaYmuZ5rLQb3NR/jKA+YFdDfKbe3u+Vua091riv5vc8	\N	\N	\N	\N	227d60c0-b241-4c94-9f8d-16e8d8eca0d9	\N	\N	active	5a09e807-f654-4501-ab1b-e2bb5f612679	\N	2025-11-20 15:26:07.803+00	/content/seo	default	\N	\N	t	\N	\N	\N	\N	\N	auto
2545f07d-7228-4759-a84b-607cc64e44c1	frontend	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	active	\N	UyMhffIWvbYNvX02b3nTuRfWqftpTAm9	\N	\N	default	\N	\N	f	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: home_agency_slide; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_agency_slide (id, title, image) FROM stdin;
5a1630cd-3d0f-4ff3-bc4a-6674db83f3b3	Брендинг	e248aec4-8c7e-4240-9e4c-1fdd2c802240
284be087-4f4f-4cff-b50c-85cba79b08d0	Создание сайтов	e248aec4-8c7e-4240-9e4c-1fdd2c802240
2058b18a-da8c-4ab7-9a5f-cafaf2f9a0b4	Продвижение	e248aec4-8c7e-4240-9e4c-1fdd2c802240
\.


--
-- Data for Name: home_page; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_page (id, date_updated, agency_title, agency_description, personal_title, personal_subtitle, agency_subtitle, personal_image) FROM stdin;
13885d59-6839-4a89-a926-aa33747d1400	\N	Дизайн студия	+7 (927) 714-33-39	Развиваю личные бренды	Мой опыт и знания смогут сократить путь к результатам, экономя несколько лет усилий	Симбиоз талантливых и неординарных личностей, создающих нечто более, чем просто продукт	ebce4a72-76fb-48f2-9527-26413b4eb33c
\.


--
-- Data for Name: home_page_home_agency_slide; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_page_home_agency_slide (id, home_page_id, home_agency_slide_id) FROM stdin;
1	13885d59-6839-4a89-a926-aa33747d1400	5a1630cd-3d0f-4ff3-bc4a-6674db83f3b3
2	13885d59-6839-4a89-a926-aa33747d1400	284be087-4f4f-4cff-b50c-85cba79b08d0
3	13885d59-6839-4a89-a926-aa33747d1400	2058b18a-da8c-4ab7-9a5f-cafaf2f9a0b4
\.


--
-- Data for Name: seo; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.seo (id, date_updated, meta_title, meta_description, og_image) FROM stdin;
923c17ae-3476-465e-a214-6b9412f93c65	\N	Развитие личных брендов | Игорь Кулагин	Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса. Помогаю бизнесу зарабатывать!	\N
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 227, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 37, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 7, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 5, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 217, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: home_page_home_agency_slide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.home_page_home_agency_slide_id_seq', 3, true);


--
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: directus
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: home_agency_slide home_agency_slide_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_agency_slide
    ADD CONSTRAINT home_agency_slide_pkey PRIMARY KEY (id);


--
-- Name: home_page_home_agency_slide home_page_home_agency_slide_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_agency_slide
    ADD CONSTRAINT home_page_home_agency_slide_pkey PRIMARY KEY (id);


--
-- Name: home_page home_page_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page
    ADD CONSTRAINT home_page_pkey PRIMARY KEY (id);


--
-- Name: seo seo_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.seo
    ADD CONSTRAINT seo_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: home_agency_slide home_agency_slide_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_agency_slide
    ADD CONSTRAINT home_agency_slide_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: home_page_home_agency_slide home_page_home_agency_slide_home_agency_slide_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_agency_slide
    ADD CONSTRAINT home_page_home_agency_slide_home_agency_slide_id_foreign FOREIGN KEY (home_agency_slide_id) REFERENCES public.home_agency_slide(id) ON DELETE SET NULL;


--
-- Name: home_page_home_agency_slide home_page_home_agency_slide_home_page_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_agency_slide
    ADD CONSTRAINT home_page_home_agency_slide_home_page_id_foreign FOREIGN KEY (home_page_id) REFERENCES public.home_page(id) ON DELETE SET NULL;


--
-- Name: home_page home_page_personal_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page
    ADD CONSTRAINT home_page_personal_image_foreign FOREIGN KEY (personal_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: seo seo_og_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.seo
    ADD CONSTRAINT seo_og_image_foreign FOREIGN KEY (og_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

