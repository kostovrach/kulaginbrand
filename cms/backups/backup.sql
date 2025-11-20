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
-- Name: about_page; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.about_page (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    hero_title character varying(255),
    hero_subtitle text,
    hero_image uuid,
    hero_hint uuid,
    brand_letter_b uuid,
    brand_letter_r uuid,
    brand_letter_a uuid,
    brand_letter_n uuid,
    brand_letter_d uuid,
    brand_hint uuid,
    brand_title character varying(255),
    brand_description text,
    brand_gallery_1 uuid,
    brand_gallery_2 uuid,
    brand_gallery_3 uuid,
    brand_gallery_4 uuid,
    brand_gallery_5 uuid,
    brand_gallery_6 uuid,
    brand_gallery_7 uuid,
    brand_gallery_8 uuid,
    brand_gallery_9 uuid
);


ALTER TABLE public.about_page OWNER TO directus;

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
    studio_link character varying(255),
    instagram character varying(255) DEFAULT NULL::character varying
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
-- Name: hint; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.hint (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    description text,
    video uuid,
    button_text character varying(255) DEFAULT 'Про уникальный опыт'::character varying NOT NULL
);


ALTER TABLE public.hint OWNER TO directus;

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
-- Name: policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.policies (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    content text,
    sort integer
);


ALTER TABLE public.policies OWNER TO directus;

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
-- Data for Name: about_page; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.about_page (id, date_updated, hero_title, hero_subtitle, hero_image, hero_hint, brand_letter_b, brand_letter_r, brand_letter_a, brand_letter_n, brand_letter_d, brand_hint, brand_title, brand_description, brand_gallery_1, brand_gallery_2, brand_gallery_3, brand_gallery_4, brand_gallery_5, brand_gallery_6, brand_gallery_7, brand_gallery_8, brand_gallery_9) FROM stdin;
f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	2025-11-20 21:13:39.437+00	Помогаю бизнесу зарабатывать.	Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса.	ebce4a72-76fb-48f2-9527-26413b4eb33c	4809efdd-56dc-4117-80e3-a24ce4c4320a	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	4809efdd-56dc-4117-80e3-a24ce4c4320a	Развиваю личные бренды	На личность —идет наличность	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240	e248aec4-8c7e-4240-9e4c-1fdd2c802240
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.contact (id, date_updated, phone, mail, address, vk, tg, whatsapp, ok, tiktok, studio_link, instagram) FROM stdin;
9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	2025-11-20 18:31:52.682+00	+7 (927) 714-33-39	example@gmail.com	г. Самара, ул. Конноармейская 17  (офис Kulaginbrand)	https://example.com	https://example.com	https://example.com	https://example.com	https://example.com	https://kulaginstudio.ru	https://example.com
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
228	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:20.393+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
229	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:22.969+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
230	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:22.977+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
231	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:22.994+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
232	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.001+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
233	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
234	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.031+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
235	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.051+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	11	http://localhost:8055
236	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
237	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.091+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
238	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:23.12+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
239	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:39.32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
240	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:31:52.683+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	contact	9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	http://localhost:8055
241	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:33:10.321+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	39	http://localhost:8055
242	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:33:10.326+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	40	http://localhost:8055
243	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:33:10.333+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	41	http://localhost:8055
244	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:33:10.339+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
245	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:33:33.59+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	42	http://localhost:8055
246	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:34:18.535+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	43	http://localhost:8055
247	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:35:34.914+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
248	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:35:39.186+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
249	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:35:39.195+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
250	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:35:39.207+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
251	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:35:39.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
252	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:37:08.138+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
253	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:37:33.503+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	policies	52d487f4-0da3-4004-ae51-1861b9f035b3	http://localhost:8055
254	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:37:53.234+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	policies	a37f84bf-f78b-466c-aeb5-97985d4bc059	http://localhost:8055
255	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:03.071+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	policies	fd3a7ade-7d55-4a2c-93d5-9f539c692a1b	http://localhost:8055
256	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:28.259+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	44	http://localhost:8055
257	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:30.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	39	http://localhost:8055
258	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:30.495+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	40	http://localhost:8055
259	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:30.506+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	41	http://localhost:8055
260	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:30.519+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	44	http://localhost:8055
261	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:30.537+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	42	http://localhost:8055
262	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:30.548+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	43	http://localhost:8055
263	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:38:35.594+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
264	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:39:04.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	8	http://localhost:8055
265	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:39:04.066+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	http://localhost:8055
266	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:39:04.074+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	http://localhost:8055
267	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 18:39:04.082+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
268	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:53:59.844+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	components	http://localhost:8055
269	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:54:36.452+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	45	http://localhost:8055
270	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:54:36.459+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	46	http://localhost:8055
271	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:54:36.465+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	47	http://localhost:8055
272	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:54:36.471+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	hint	http://localhost:8055
273	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:07.144+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	hint	http://localhost:8055
274	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:09.674+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	hint	http://localhost:8055
275	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:09.763+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
280	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:59:25.563+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	48	http://localhost:8055
276	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:09.772+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
277	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:09.779+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
278	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:09.79+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
279	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:56:09.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	components	http://localhost:8055
281	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 19:59:27.878+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	hint	http://localhost:8055
282	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:00:07.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	49	http://localhost:8055
283	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:01:18.967+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	50	http://localhost:8055
284	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:01:59.313+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	51	http://localhost:8055
285	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:02:26.779+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	50	http://localhost:8055
286	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:03:35.839+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	b2138b89-054f-4d84-a389-df871654b76d	http://localhost:8055
287	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:03:47.672+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	hint	4809efdd-56dc-4117-80e3-a24ce4c4320a	http://localhost:8055
288	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:09:48.163+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	9	http://localhost:8055
289	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:09:48.171+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	60ca5918-2a7d-4808-9a8e-cdfd721a22dd	http://localhost:8055
290	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:09:48.179+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	http://localhost:8055
291	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:09:48.188+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	2545f07d-7228-4759-a84b-607cc64e44c1	http://localhost:8055
292	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:12:40.687+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
293	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:12:40.693+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
294	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:12:40.698+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page	http://localhost:8055
295	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:12:44.125+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
296	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:12.289+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page	http://localhost:8055
297	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.253+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_page	http://localhost:8055
298	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page	http://localhost:8055
299	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.312+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
300	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.321+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
301	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
302	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
303	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:13:25.342+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	components	http://localhost:8055
304	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:16:19.148+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	54	http://localhost:8055
305	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:16:19.154+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	55	http://localhost:8055
306	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:16:19.162+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_hero	http://localhost:8055
307	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:16:23.151+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	55	http://localhost:8055
308	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:36.837+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_hero	http://localhost:8055
309	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:42.417+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_hero	http://localhost:8055
310	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:42.523+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	contact	http://localhost:8055
311	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:42.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	policies	http://localhost:8055
312	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:42.54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	seo	http://localhost:8055
313	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:42.549+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
314	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:19:42.563+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	components	http://localhost:8055
315	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:20:29.671+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	56	http://localhost:8055
316	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:20:49.43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	56	http://localhost:8055
317	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:27:23.42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
318	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:28:05.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
319	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:28:53.503+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
320	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:11.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
321	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:17.185+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
322	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:17.198+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
323	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:17.209+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
324	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:17.219+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
325	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:17.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
326	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:17.263+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
327	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:21.721+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
328	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.705+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
329	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.716+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
330	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
331	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.733+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
332	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
333	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.754+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
334	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:25.765+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
335	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:31.072+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_hero	http://localhost:8055
336	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:31.075+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	54	http://localhost:8055
337	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:29:31.077+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	55	http://localhost:8055
338	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:30:14.381+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
339	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:30:21.368+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
340	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:30:35.029+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
341	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:31:09.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
342	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:31:34.261+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
343	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:31:43.735+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
344	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:31:50.622+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
345	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:32:08.4+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
346	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:32:20.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
347	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:32:29.189+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
348	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:32:37.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
349	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:00.165+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
350	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:05.665+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
351	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:11.644+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
352	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:19.544+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
353	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:37.818+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
354	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:46.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
355	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:33:51.705+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
356	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:34:02.89+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
357	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:34:10.011+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
358	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:34:20.496+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
359	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:34:27.201+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
360	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:34:44.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
361	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:34:52.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
362	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:35:11.334+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
363	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:35:22.382+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
364	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:35:27.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
365	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:35:49.188+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
366	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:35:56.599+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
367	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:37:04.714+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
368	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:37:08.108+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
369	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:37:18.431+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
370	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:37:24.64+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
371	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:37:30.631+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
372	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:37:34.468+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
373	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:38:20.904+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
374	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:38:34.029+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
375	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:42.247+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
376	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.392+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
377	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.406+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
378	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.418+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
379	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
380	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.436+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
381	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.449+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
382	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.465+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
383	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:39:44.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
384	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:17.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
385	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.244+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
386	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.257+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
387	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
388	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.281+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
389	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.296+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
390	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.307+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
391	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.313+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
392	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.33+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
393	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:19.351+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
394	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:53.273+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
395	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.022+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
396	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.033+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
397	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.051+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
398	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.062+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
399	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.073+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
400	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.079+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
401	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.089+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
402	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.097+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
403	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.112+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
404	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:40:56.129+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
405	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:41:08.089+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
406	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:41:20.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
407	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:41:28.653+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
408	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:28.408+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	65	http://localhost:8055
409	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
410	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.93+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
411	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.941+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
412	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.963+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
413	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.969+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
414	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
415	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.986+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
416	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:34.994+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
417	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:35.011+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
418	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:35.02+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	65	http://localhost:8055
419	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:42:35.029+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
420	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:07.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	9c58cff1-46f1-4446-845e-b3a0bb9cc908	http://localhost:8055
421	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:10.381+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
424	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:41.509+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
426	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:44:00.666+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
422	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:16.53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
423	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:39.709+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	1a2dea75-6b07-4e18-8f78-bab537ed7f48	http://localhost:8055
425	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:59.261+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	43c73c70-147e-4820-811c-0810f29c5f57	http://localhost:8055
427	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:44:13.395+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
428	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:14.584+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	66	http://localhost:8055
429	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:14.766+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	67	http://localhost:8055
430	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:14.772+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page_files	http://localhost:8055
431	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:14.837+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
432	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:14.932+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
433	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.259+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
434	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.272+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
435	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.284+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
436	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.299+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	66	http://localhost:8055
437	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.3+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
438	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
439	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.328+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
440	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:46:18.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
441	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:47:23.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	66	http://localhost:8055
442	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:47:27.557+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page_files	http://localhost:8055
443	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:47:27.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	67	http://localhost:8055
444	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:47:27.561+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
445	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:47:27.562+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
446	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:47:40.323+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	about_page	f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	http://localhost:8055
447	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:48:04.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	43c73c70-147e-4820-811c-0810f29c5f57	http://localhost:8055
448	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:48:08.64+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	9c58cff1-46f1-4446-845e-b3a0bb9cc908	http://localhost:8055
449	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:12.326+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
450	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.567+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
451	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.577+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
452	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.588+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
453	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.597+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
454	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.61+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
455	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.616+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
456	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
457	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:18.647+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
458	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:27.603+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
459	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:50:56.685+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
460	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:00.428+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
461	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:03.437+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
462	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.102+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
463	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.102+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
464	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.12+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
465	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.125+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
466	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.145+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
467	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.157+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
468	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
469	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.188+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
470	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:05.2+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
471	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:27.634+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
472	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:29.951+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
473	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:50.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
474	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:51:53.525+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
475	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:21.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
476	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:24.621+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
477	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
478	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
479	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
480	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.268+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
481	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.284+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
482	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.287+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
483	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.307+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
484	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.321+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
485	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
486	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:27.356+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
487	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:52:57.704+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
488	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:00.476+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
489	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
490	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
491	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
492	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.223+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
493	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.236+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
494	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.239+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
495	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
496	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
497	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.274+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
498	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.286+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
499	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:02.305+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
500	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:32.736+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
501	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:35.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
502	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.124+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
503	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.125+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
504	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.141+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
505	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.143+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
506	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.155+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
507	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.16+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
508	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.171+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
509	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
510	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.182+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
512	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.216+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
513	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
511	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:53:38.186+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
514	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:57.053+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
515	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.496+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
516	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.508+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
517	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.52+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
518	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.539+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
519	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.541+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
520	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.552+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
521	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
522	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
523	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.566+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
524	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.577+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
525	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.578+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
526	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.593+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
527	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:54:59.611+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
528	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:56:07.973+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	about_page	f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	http://localhost:8055
529	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:00:38.215+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	76	http://localhost:8055
530	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:00:38.221+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_brand_image	http://localhost:8055
531	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:00:48.084+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	77	http://localhost:8055
532	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:46.02+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
533	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:46.141+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	79	http://localhost:8055
534	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:46.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page_about_brand_image	http://localhost:8055
535	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:46.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	80	http://localhost:8055
536	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:46.308+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	81	http://localhost:8055
537	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.785+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
538	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.809+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
539	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.829+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
540	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.839+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
541	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.86+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
543	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.878+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
545	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.897+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
547	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
549	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.94+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
550	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.956+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
542	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.87+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
544	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.885+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
546	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
548	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:01:49.933+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
551	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:04:55.867+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
552	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:05:22.166+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
553	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:05:58.323+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
554	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:00.943+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
555	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:00.956+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
556	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:00.967+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
557	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:00.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
558	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:00.981+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
559	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:00.995+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
560	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.002+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
561	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.008+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
562	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
563	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.021+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
564	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.026+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
565	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.033+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
566	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.062+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
567	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:01.078+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
568	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:03.771+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
569	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:35.505+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
570	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:37.988+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
571	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.001+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
572	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
573	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.031+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
574	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.031+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
575	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.047+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
577	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
579	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.077+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
585	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:49.259+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	81	http://localhost:8055
586	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:49.33+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_brand_image	http://localhost:8055
587	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:49.332+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	76	http://localhost:8055
588	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:49.334+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	77	http://localhost:8055
576	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.047+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
578	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.066+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
580	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.086+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
581	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.115+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
582	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.129+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
583	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.149+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
584	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:38.163+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
589	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:55.337+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	about_page_about_brand_image	http://localhost:8055
590	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:55.341+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	79	http://localhost:8055
591	delete	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:06:55.342+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	80	http://localhost:8055
592	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:08:59.379+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
593	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:01.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
594	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
595	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
596	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.263+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
597	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
598	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.292+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
599	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.293+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
600	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.315+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
601	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
602	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.35+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
603	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.352+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
604	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.404+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
605	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.409+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
606	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.419+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
607	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.422+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
608	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
609	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:04.448+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
610	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:39.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
611	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:42.549+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
612	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.232+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
614	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
616	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.262+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
618	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
620	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.295+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
622	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.314+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
624	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.351+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
626	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.378+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
627	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.395+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
628	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.407+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
632	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
634	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.46+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
636	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.478+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
638	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
640	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.502+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
642	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.514+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
645	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
652	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.491+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
654	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.502+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
656	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.531+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
658	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.553+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
660	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.597+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
662	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.623+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
664	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.639+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
613	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
615	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
617	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
619	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.278+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
621	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.3+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
623	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
625	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:09:44.37+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
629	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:05.232+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
630	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:07.576+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
631	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.431+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
633	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.442+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
635	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.463+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
637	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.479+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
639	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.491+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
641	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.504+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
643	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.516+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
644	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.554+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
646	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
647	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.596+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
648	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:10.618+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
649	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:38.494+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
650	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:40.745+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
651	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
653	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.502+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
655	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.522+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
657	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.544+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
659	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.569+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
661	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.613+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
663	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.631+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
665	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.647+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
666	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.661+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
667	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.67+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
668	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.687+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
669	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:10:42.697+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
670	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:00.932+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
671	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:03.624+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
672	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.908+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
673	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.909+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
674	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
675	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.928+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
676	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.937+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
677	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.944+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
678	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.951+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
679	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
680	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.966+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
681	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.978+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
682	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:05.988+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
683	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.006+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
684	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
685	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
686	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.067+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
687	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.08+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
688	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
689	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.104+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
690	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.117+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
691	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:06.148+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
692	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:22.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
693	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:24.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
694	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.439+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
696	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.45+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
698	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.463+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
700	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.476+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
702	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.488+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
704	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.501+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
706	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.528+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
708	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.557+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
709	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.57+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
710	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.594+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
711	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.608+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
712	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.616+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
713	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.649+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
714	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
695	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.443+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
697	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.453+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
699	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.466+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
701	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.479+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
703	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.492+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
705	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.504+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
707	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:26.53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
715	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:43.282+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	90	http://localhost:8055
716	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:45.842+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	90	http://localhost:8055
717	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.813+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
718	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.815+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
719	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.825+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
720	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
721	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
722	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.837+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
723	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.849+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
724	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.852+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
725	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
726	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.865+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
727	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.881+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
728	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
729	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
730	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.92+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
731	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.945+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
732	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.962+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
733	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:47.997+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
734	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:48.014+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
735	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:48.028+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
736	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:48.075+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
737	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:48.109+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
738	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:11:48.117+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	90	http://localhost:8055
739	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:03.419+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	91	http://localhost:8055
740	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:05.951+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	91	http://localhost:8055
741	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.371+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
743	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.385+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
745	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
747	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.411+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
749	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.421+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
751	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.447+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
753	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.476+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
755	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.498+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
756	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.512+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
757	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.538+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
758	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.552+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
759	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.564+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
760	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.599+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
761	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.628+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
762	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.636+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	90	http://localhost:8055
763	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.645+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	91	http://localhost:8055
764	create	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:21.627+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	92	http://localhost:8055
765	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:24.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	92	http://localhost:8055
766	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.853+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
768	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.87+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
770	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
772	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.898+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
774	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.914+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
742	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.372+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
744	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.386+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
746	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.401+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
748	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.414+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
750	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.424+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
752	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.449+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
754	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:07.478+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
767	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.857+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
769	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.871+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
771	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.885+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
773	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.901+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
775	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
777	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.933+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
779	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.972+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
776	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.928+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
778	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.955+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
780	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
781	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:26.995+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
782	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
783	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.041+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
784	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.056+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
785	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.099+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
786	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.128+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
787	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.137+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	90	http://localhost:8055
788	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	91	http://localhost:8055
789	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:12:27.155+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	92	http://localhost:8055
790	update	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 21:13:39.439+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	about_page	f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
home_page	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Разводная страница","singular":"Разводная страница","plural":"Разводные страницы"}]	\N	t	\N	\N	\N	all	\N	\N	1	pages	open	\N	f
about_page	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Обо мне\\"","singular":"Страница \\"Обо мне\\"","plural":"Страницы \\"Обо мне\\""}]	\N	t	\N	\N	\N	all	\N	\N	2	pages	open	\N	f
home_page_home_agency_slide	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	home_agency_slide	open	\N	f
home_agency_slide	\N	\N	{{image}}{{title}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	home_page	open	\N	f
contact	globe_location_pin	\N	\N	f	t	[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}]	\N	t	\N	\N	\N	all	\N	\N	1	\N	open	\N	f
policies	shield_lock	\N	\N	f	f	[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}]	\N	t	\N	\N	sort	all	\N	\N	2	\N	open	\N	f
seo	settings_suggest	\N	\N	f	t	[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}]	\N	t	\N	\N	\N	all	\N	\N	3	\N	open	\N	f
pages	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	4	\N	open	\N	f
components	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Блоки"}]	\N	t	\N	\N	\N	all	\N	\N	5	\N	open	\N	f
hint	extension	\N	\N	f	f	[{"language":"ru-RU","translation":"Блоки с видео","singular":"Блок с видео","plural":"Блоки с видео"}]	\N	t	\N	\N	\N	all	\N	\N	1	components	open	\N	f
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
7	contact	socials	alias,no-data,group	group-detail	{"headerIcon":"alternate_email"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Социальные сети"}]	\N	\N	f	\N	\N	\N
35	seo	meta_title	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	t	\N	\N	\N
36	seo	meta_description	\N	input-multiline	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
12	contact	tiktok	\N	input	{"iconLeft":"tiktok"}	formatted-value	\N	f	f	5	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
37	seo	og_image	file	file-image	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
38	contact	instagram	\N	input	{"iconLeft":"instagram"}	formatted-value	\N	f	f	6	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
39	policies	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
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
40	policies	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
19	home_page	agency_description	\N	input-multiline	\N	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Описание блока студии"}]	Например, контактная информация	\N	f	agency	\N	\N
32	contact	studio_link	\N	input	{"iconLeft":"add_link"}	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Ссылка на сайт студии"}]	\N	\N	t	main	\N	\N
24	home_page	agency_slides	m2m	list-m2m	{"enableSelect":false,"limit":100}	related-values	{"template":"{{home_agency_slide_id.image}}{{home_agency_slide_id.title}}"}	f	f	4	full	[{"language":"ru-RU","translation":"Слайды блока студии"}]	\N	\N	t	agency	\N	\N
6	contact	address	\N	input	{"iconLeft":"home_work"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Адрес"}]	Адрес студии или любой другой	\N	f	main	\N	\N
8	contact	vk	\N	input	{"iconLeft":"vk"}	formatted-value	\N	f	f	1	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
1	contact	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
9	contact	tg	\N	input	{"iconLeft":"telegram"}	formatted-value	\N	f	f	2	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
2	contact	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
10	contact	whatsapp	\N	input	{"iconLeft":"square_whatsapp"}	formatted-value	\N	f	f	3	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
3	contact	main	alias,no-data,group	group-detail	{"headerIcon":"link"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Основная информация"}]	\N	\N	f	\N	\N	\N
11	contact	ok	\N	input	{"iconLeft":"odnoklassniki_square"}	formatted-value	\N	f	f	4	half	\N	Ссылка в формате https://	\N	f	socials	\N	\N
41	policies	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
44	policies	sort	\N	input	{"min":1}	\N	\N	t	t	4	full	\N	\N	\N	f	\N	\N	\N
42	policies	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Заголовок"}]	\N	\N	t	\N	\N	\N
43	policies	content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","indent","outdent","numlist","bullist","customLink","hr","fullscreen"]}	\N	\N	f	f	6	full	[{"language":"ru-RU","translation":"Содержание"}]	\N	\N	t	\N	\N	\N
45	hint	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
46	hint	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
47	hint	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
48	hint	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок"}]	\N	\N	t	\N	\N	\N
49	hint	description	\N	input-multiline	\N	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Описание"}]	\N	\N	f	\N	\N	\N
51	hint	button_text	\N	input	{"iconLeft":"text_format"}	formatted-value	\N	f	f	7	full	[{"language":"ru-RU","translation":"Текст рядом с кнопкой"}]	\N	\N	t	\N	\N	\N
50	hint	video	file	file	\N	related-values	\N	f	f	6	full	[{"language":"ru-RU","translation":"Видео"}]	Рекомендуется добавлять только видео. Статичные изображения не будут отображены на сайте	\N	t	\N	\N	\N
62	about_page	hero_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок первого экрана"}]	\N	\N	t	hero	\N	\N
63	about_page	hero_subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}]	\N	\N	t	hero	\N	\N
59	about_page	projects	alias,no-data,group	group-detail	{"headerIcon":"work"}	\N	\N	f	f	7	full	[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}]	\N	\N	f	\N	\N	\N
72	about_page	brand_letter_a	file	file-image	\N	image	\N	f	f	3	half	[{"language":"ru-RU","translation":"Буква \\"A\\""}]	\N	\N	t	brand	\N	\N
90	about_page	brand_gallery_7	file	file-image	\N	image	\N	f	f	15	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
91	about_page	brand_gallery_8	file	file-image	\N	image	\N	f	f	16	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
64	about_page	hero_image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение первого экрана"}]	\N	\N	t	hero	\N	\N
57	about_page	hero	alias,no-data,group	group-detail	{"headerIcon":"magnify_fullscreen"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Хироскрин"}]	\N	\N	f	\N	\N	\N
83	about_page	brand_description	\N	input-multiline	\N	formatted-value	\N	f	f	8	full	[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}]	\N	\N	f	brand	\N	\N
84	about_page	brand_gallery_1	file	file-image	\N	image	\N	f	f	9	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
92	about_page	brand_gallery_9	file	file-image	\N	image	\N	f	f	17	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
73	about_page	brand_letter_n	file	file-image	\N	image	\N	f	f	4	half	[{"language":"ru-RU","translation":"Буква \\"N\\""}]	\N	\N	t	brand	\N	\N
65	about_page	hero_hint	m2o	select-dropdown-m2o	{"template":"{{title}}"}	related-values	\N	f	f	4	full	[{"language":"ru-RU","translation":"Видео-подсказки на первом экране"}]	\N	\N	f	hero	\N	\N
61	about_page	divider-z5vybz	alias,no-data	presentation-divider	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
85	about_page	brand_gallery_2	file	file-image	\N	image	\N	f	f	10	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
86	about_page	brand_gallery_3	file	file-image	\N	image	\N	f	f	11	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
87	about_page	brand_gallery_4	file	file-image	\N	image	\N	f	f	12	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
74	about_page	brand_letter_d	file	file-image	\N	image	\N	f	f	5	half	[{"language":"ru-RU","translation":"Буква \\"D\\""}]	\N	\N	t	brand	\N	\N
58	about_page	brand	alias,no-data,group	group-detail	{"headerIcon":"brand_family"}	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Блок \\"Brand\\""}]	\N	\N	f	\N	\N	\N
75	about_page	brand_hint	m2o	select-dropdown-m2o	{"template":"{{title}}"}	related-values	\N	f	f	6	full	[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}]	\N	\N	f	brand	\N	\N
70	about_page	brand_letter_b	file	file-image	\N	image	\N	f	f	1	half	[{"language":"ru-RU","translation":"Буква \\"B\\""}]	\N	\N	t	brand	\N	\N
52	about_page	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
60	about_page	divider-z-ijz0	alias,no-data	presentation-divider	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
88	about_page	brand_gallery_5	file	file-image	\N	image	\N	f	f	13	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
89	about_page	brand_gallery_6	file	file-image	\N	image	\N	f	f	14	half	[{"language":"ru-RU","translation":"Фото галереи BRAND"}]	\N	\N	t	brand	\N	\N
71	about_page	brand_letter_r	file	file-image	\N	image	\N	f	f	2	half	[{"language":"ru-RU","translation":"Буква \\"R\\""}]	\N	\N	t	brand	\N	\N
53	about_page	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
82	about_page	brand_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	7	full	[{"language":"ru-RU","translation":"Заголовок блока BRAND"}]	\N	\N	t	brand	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
227d60c0-b241-4c94-9f8d-16e8d8eca0d9	local	227d60c0-b241-4c94-9f8d-16e8d8eca0d9.png	theplace.png	Theplace	image/png	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 12:31:25.578+00	\N	2025-11-20 12:31:25.625+00	\N	1343	180	180	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-20 12:31:25.624+00
e248aec4-8c7e-4240-9e4c-1fdd2c802240	local	e248aec4-8c7e-4240-9e4c-1fdd2c802240.gif	snapshot.gif	Snapshot	image/gif	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:08:11.142+00	\N	2025-11-20 13:08:11.922+00	\N	15620316	640	360	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-20 13:08:11.911+00
ebce4a72-76fb-48f2-9527-26413b4eb33c	local	ebce4a72-76fb-48f2-9527-26413b4eb33c.png	igor2.png	Igor2	image/png	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 13:09:29.071+00	\N	2025-11-20 13:09:29.113+00	\N	339033	619	679	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-20 13:09:29.112+00
b2138b89-054f-4d84-a389-df871654b76d	local	b2138b89-054f-4d84-a389-df871654b76d.mp4	404.mp4	404	video/mp4	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:03:35.834+00	\N	2025-11-20 20:03:36.104+00	\N	6066154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 20:03:36.102+00
1a2dea75-6b07-4e18-8f78-bab537ed7f48	local	1a2dea75-6b07-4e18-8f78-bab537ed7f48.ico	favicon.ico	Favicon	image/x-icon	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:39.705+00	\N	2025-11-20 20:43:39.751+00	\N	29742	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 20:43:39.75+00
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
8	policies	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
9	hint	read	\N	\N	\N	*	60ca5918-2a7d-4808-9a8e-cdfd721a22dd
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
2	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	\N	policies	\N	\N	{"tabular":{"fields":["sort","title","content"],"sort":["sort"],"page":1}}	{"tabular":{"widths":{"sort":32,"title":276,"content":231}}}	\N	\N	bookmark	\N
3	\N	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	\N	hint	\N	\N	{"tabular":{"page":1,"fields":["title","description"]}}	{"tabular":{"widths":{"title":344,"description":373}}}	\N	\N	bookmark	\N
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
6	hint	video	directus_files	\N	\N	\N	\N	\N	nullify
7	about_page	hero_image	directus_files	\N	\N	\N	\N	\N	nullify
8	about_page	hero_hint	hint	\N	\N	\N	\N	\N	nullify
11	about_page	brand_letter_b	directus_files	\N	\N	\N	\N	\N	nullify
12	about_page	brand_letter_r	directus_files	\N	\N	\N	\N	\N	nullify
13	about_page	brand_letter_a	directus_files	\N	\N	\N	\N	\N	nullify
14	about_page	brand_letter_n	directus_files	\N	\N	\N	\N	\N	nullify
15	about_page	brand_letter_d	directus_files	\N	\N	\N	\N	\N	nullify
16	about_page	brand_hint	hint	\N	\N	\N	\N	\N	nullify
20	about_page	brand_gallery_1	directus_files	\N	\N	\N	\N	\N	nullify
21	about_page	brand_gallery_2	directus_files	\N	\N	\N	\N	\N	nullify
22	about_page	brand_gallery_3	directus_files	\N	\N	\N	\N	\N	nullify
23	about_page	brand_gallery_4	directus_files	\N	\N	\N	\N	\N	nullify
24	about_page	brand_gallery_5	directus_files	\N	\N	\N	\N	\N	nullify
25	about_page	brand_gallery_6	directus_files	\N	\N	\N	\N	\N	nullify
26	about_page	brand_gallery_7	directus_files	\N	\N	\N	\N	\N	nullify
27	about_page	brand_gallery_8	directus_files	\N	\N	\N	\N	\N	nullify
28	about_page	brand_gallery_9	directus_files	\N	\N	\N	\N	\N	nullify
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
225	235	directus_fields	11	{"id":11,"collection":"contact","field":"ok","special":null,"interface":"input","options":{"iconLeft":"odnoklassniki_square"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"ok","sort":4,"group":"socials"}	\N	\N
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
218	228	directus_fields	38	{"sort":6,"collection":"contact","field":"instagram","special":null,"interface":"input","options":{"iconLeft":"tiktok"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":6,"collection":"contact","field":"instagram","special":null,"interface":"input","options":{"iconLeft":"tiktok"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
219	229	directus_fields	8	{"id":8,"collection":"contact","field":"vk","special":null,"interface":"input","options":{"iconLeft":"vk"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"vk","sort":1,"group":"socials"}	\N	\N
220	230	directus_fields	1	{"id":1,"collection":"contact","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"id","sort":1,"group":null}	\N	\N
221	231	directus_fields	9	{"id":9,"collection":"contact","field":"tg","special":null,"interface":"input","options":{"iconLeft":"telegram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tg","sort":2,"group":"socials"}	\N	\N
222	232	directus_fields	2	{"id":2,"collection":"contact","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"date_updated","sort":2,"group":null}	\N	\N
223	233	directus_fields	10	{"id":10,"collection":"contact","field":"whatsapp","special":null,"interface":"input","options":{"iconLeft":"square_whatsapp"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"whatsapp","sort":3,"group":"socials"}	\N	\N
367	385	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
224	234	directus_fields	3	{"id":3,"collection":"contact","field":"main","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"link"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Основная информация"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"main","sort":3,"group":null}	\N	\N
226	236	directus_fields	7	{"id":7,"collection":"contact","field":"socials","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"alternate_email"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Социальные сети"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"contact","field":"socials","sort":4,"group":null}	\N	\N
229	239	directus_fields	38	{"id":38,"collection":"contact","field":"instagram","special":null,"interface":"input","options":{"iconLeft":"instagram"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"instagram","options":{"iconLeft":"instagram"},"translations":null}	\N	\N
227	237	directus_fields	12	{"id":12,"collection":"contact","field":"tiktok","special":null,"interface":"input","options":{"iconLeft":"tiktok"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"tiktok","sort":5,"group":"socials"}	\N	\N
228	238	directus_fields	38	{"id":38,"collection":"contact","field":"instagram","special":null,"interface":"input","options":{"iconLeft":"tiktok"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":null,"note":"Ссылка в формате https://","conditions":null,"required":false,"group":"socials","validation":null,"validation_message":null}	{"collection":"contact","field":"instagram","sort":6,"group":"socials"}	\N	\N
230	240	contact	9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe	{"id":"9b0e9fc2-5bef-4e5e-ba12-a4ca557019fe","date_updated":"2025-11-20T18:31:52.682Z","phone":"+7 (927) 714-33-39","mail":"example@gmail.com","address":"г. Самара, ул. Конноармейская 17  (офис Kulaginbrand)","vk":"https://example.com","tg":"https://example.com","whatsapp":"https://example.com","ok":"https://example.com","tiktok":"https://example.com","studio_link":"https://kulaginstudio.ru","instagram":"https://example.com"}	{"instagram":"https://example.com","date_updated":"2025-11-20T18:31:52.682Z"}	\N	\N
231	241	directus_fields	39	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"policies"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"policies"}	\N	\N
232	242	directus_fields	40	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"policies"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"policies"}	\N	\N
233	243	directus_fields	41	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"policies"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"policies"}	\N	\N
234	244	directus_collections	policies	{"singleton":false,"collection":"policies"}	{"singleton":false,"collection":"policies"}	\N	\N
235	245	directus_fields	42	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок"}],"display":"formatted-value","collection":"policies","field":"title"}	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок"}],"display":"formatted-value","collection":"policies","field":"title"}	\N	\N
236	246	directus_fields	43	{"sort":5,"interface":"input-rich-text-html","special":null,"required":true,"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","indent","outdent","numlist","bullist","customLink","hr","fullscreen"]},"translations":[{"language":"ru-RU","translation":"Содержание"}],"collection":"policies","field":"content"}	{"sort":5,"interface":"input-rich-text-html","special":null,"required":true,"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","indent","outdent","numlist","bullist","customLink","hr","fullscreen"]},"translations":[{"language":"ru-RU","translation":"Содержание"}],"collection":"policies","field":"content"}	\N	\N
237	247	directus_collections	policies	{"collection":"policies","icon":"edit_document","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"edit_document","translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}]}	\N	\N
238	248	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
239	249	directus_collections	policies	{"collection":"policies","icon":"edit_document","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
240	250	directus_collections	seo	{"collection":"seo","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
241	251	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
242	252	directus_collections	policies	{"collection":"policies","icon":"shield_lock","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"shield_lock"}	\N	\N
243	253	policies	52d487f4-0da3-4004-ae51-1861b9f035b3	{"title":"Политика конфиденциальности","content":"<h2>1. Обзор</h2>\\n<h3>1.1 Наши Ценности</h3>\\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\\n<h3>2.2 Правила Участия</h3>\\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\\n<h2>2. Проведение Боя</h2>\\n<h3>2.1 Уважайте Соперника</h3>\\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\\n<h2>3. Поведение После Боя</h2>\\n<h3>3.1 Поддерживайте Соперников</h3>\\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\\n<h2>4. Протоколы Безопасности</h2>\\n<h3>4.1 Экстренные Процедуры</h3>\\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\\n<h2>5. Возрастные Требования</h2>\\n<h3>5.1 Требования к Участникам</h3>\\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\\n<h2>6. Свяжитесь с Нами</h2>\\n<h3>6.1 Обратная Связь</h3>\\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href=\\"https://example.com/\\" target=\\"_blank\\" rel=\\"noopener\\">info@fightclub.com</a>.</p>"}	{"title":"Политика конфиденциальности","content":"<h2>1. Обзор</h2>\\n<h3>1.1 Наши Ценности</h3>\\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\\n<h3>2.2 Правила Участия</h3>\\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\\n<h2>2. Проведение Боя</h2>\\n<h3>2.1 Уважайте Соперника</h3>\\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\\n<h2>3. Поведение После Боя</h2>\\n<h3>3.1 Поддерживайте Соперников</h3>\\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\\n<h2>4. Протоколы Безопасности</h2>\\n<h3>4.1 Экстренные Процедуры</h3>\\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\\n<h2>5. Возрастные Требования</h2>\\n<h3>5.1 Требования к Участникам</h3>\\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\\n<h2>6. Свяжитесь с Нами</h2>\\n<h3>6.1 Обратная Связь</h3>\\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href=\\"https://example.com/\\" target=\\"_blank\\" rel=\\"noopener\\">info@fightclub.com</a>.</p>"}	\N	\N
244	254	policies	a37f84bf-f78b-466c-aeb5-97985d4bc059	{"title":"Оферта","content":"<h2>1. Обзор</h2>\\n<h3>1.1 Наши Ценности</h3>\\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\\n<h3>2.2 Правила Участия</h3>\\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\\n<h2>2. Проведение Боя</h2>\\n<h3>2.1 Уважайте Соперника</h3>\\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\\n<h2>3. Поведение После Боя</h2>\\n<h3>3.1 Поддерживайте Соперников</h3>\\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\\n<h2>4. Протоколы Безопасности</h2>\\n<h3>4.1 Экстренные Процедуры</h3>\\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\\n<h2>5. Возрастные Требования</h2>\\n<h3>5.1 Требования к Участникам</h3>\\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\\n<h2>6. Свяжитесь с Нами</h2>\\n<h3>6.1 Обратная Связь</h3>\\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href=\\"https://example.com/\\" target=\\"_blank\\" rel=\\"noopener\\">info@fightclub.com</a>.</p>"}	{"title":"Оферта","content":"<h2>1. Обзор</h2>\\n<h3>1.1 Наши Ценности</h3>\\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\\n<h3>2.2 Правила Участия</h3>\\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\\n<h2>2. Проведение Боя</h2>\\n<h3>2.1 Уважайте Соперника</h3>\\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\\n<h2>3. Поведение После Боя</h2>\\n<h3>3.1 Поддерживайте Соперников</h3>\\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\\n<h2>4. Протоколы Безопасности</h2>\\n<h3>4.1 Экстренные Процедуры</h3>\\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\\n<h2>5. Возрастные Требования</h2>\\n<h3>5.1 Требования к Участникам</h3>\\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\\n<h2>6. Свяжитесь с Нами</h2>\\n<h3>6.1 Обратная Связь</h3>\\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href=\\"https://example.com/\\" target=\\"_blank\\" rel=\\"noopener\\">info@fightclub.com</a>.</p>"}	\N	\N
245	255	policies	fd3a7ade-7d55-4a2c-93d5-9f539c692a1b	{"title":"Пользовательское соглашение","content":"<h2>1. Обзор</h2>\\n<h3>1.1 Наши Ценности</h3>\\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\\n<h3>2.2 Правила Участия</h3>\\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\\n<h2>2. Проведение Боя</h2>\\n<h3>2.1 Уважайте Соперника</h3>\\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\\n<h2>3. Поведение После Боя</h2>\\n<h3>3.1 Поддерживайте Соперников</h3>\\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\\n<h2>4. Протоколы Безопасности</h2>\\n<h3>4.1 Экстренные Процедуры</h3>\\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\\n<h2>5. Возрастные Требования</h2>\\n<h3>5.1 Требования к Участникам</h3>\\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\\n<h2>6. Свяжитесь с Нами</h2>\\n<h3>6.1 Обратная Связь</h3>\\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href=\\"https://example.com/\\" target=\\"_blank\\" rel=\\"noopener\\">info@fightclub.com</a>.</p>"}	{"title":"Пользовательское соглашение","content":"<h2>1. Обзор</h2>\\n<h3>1.1 Наши Ценности</h3>\\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\\n<h3>2.2 Правила Участия</h3>\\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\\n<h2>2. Проведение Боя</h2>\\n<h3>2.1 Уважайте Соперника</h3>\\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\\n<h2>3. Поведение После Боя</h2>\\n<h3>3.1 Поддерживайте Соперников</h3>\\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\\n<h2>4. Протоколы Безопасности</h2>\\n<h3>4.1 Экстренные Процедуры</h3>\\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\\n<h2>5. Возрастные Требования</h2>\\n<h3>5.1 Требования к Участникам</h3>\\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\\n<h2>6. Свяжитесь с Нами</h2>\\n<h3>6.1 Обратная Связь</h3>\\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href=\\"https://example.com/\\" target=\\"_blank\\" rel=\\"noopener\\">info@fightclub.com</a>.</p>"}	\N	\N
246	256	directus_fields	44	{"sort":6,"interface":"input","special":null,"options":{"min":1},"readonly":true,"hidden":true,"collection":"policies","field":"sort"}	{"sort":6,"interface":"input","special":null,"options":{"min":1},"readonly":true,"hidden":true,"collection":"policies","field":"sort"}	\N	\N
247	257	directus_fields	39	{"id":39,"collection":"policies","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"policies","field":"id","sort":1,"group":null}	\N	\N
248	258	directus_fields	40	{"id":40,"collection":"policies","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"policies","field":"date_created","sort":2,"group":null}	\N	\N
249	259	directus_fields	41	{"id":41,"collection":"policies","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"policies","field":"date_updated","sort":3,"group":null}	\N	\N
250	260	directus_fields	44	{"id":44,"collection":"policies","field":"sort","special":null,"interface":"input","options":{"min":1},"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"policies","field":"sort","sort":4,"group":null}	\N	\N
251	261	directus_fields	42	{"id":42,"collection":"policies","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"policies","field":"title","sort":5,"group":null}	\N	\N
252	262	directus_fields	43	{"id":43,"collection":"policies","field":"content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","indent","outdent","numlist","bullist","customLink","hr","fullscreen"]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Содержание"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"policies","field":"content","sort":6,"group":null}	\N	\N
253	263	directus_collections	policies	{"collection":"policies","icon":"shield_lock","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort_field":"sort"}	\N	\N
254	264	directus_permissions	8	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"policies","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"policies","action":"read"}	\N	\N
255	266	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	{"id":"d2ef36e9-2f73-4931-8a95-336df595a121","role":null,"user":"2545f07d-7228-4759-a84b-607cc64e44c1","policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","sort":1}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd"}	\N	\N
256	268	directus_collections	components	{"collection":"components","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Блоки"}]}	{"collection":"components","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Блоки"}]}	\N	\N
257	269	directus_fields	45	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"hint"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"hint"}	\N	\N
258	270	directus_fields	46	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"hint"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"hint"}	\N	\N
259	271	directus_fields	47	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"hint"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"hint"}	\N	\N
260	272	directus_collections	hint	{"singleton":false,"collection":"hint"}	{"singleton":false,"collection":"hint"}	\N	\N
261	273	directus_collections	hint	{"collection":"hint","icon":"extension","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Блоки с видео-подсказками","singular":"Блок с видео-подсказкой","plural":"Блоки с видео-подсказками"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"extension","translations":[{"language":"ru-RU","translation":"Блоки с видео-подсказками","singular":"Блок с видео-подсказкой","plural":"Блоки с видео-подсказками"}]}	\N	\N
262	274	directus_collections	hint	{"collection":"hint","icon":"extension","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Блоки с видео-подсказками","singular":"Блок с видео-подсказкой","plural":"Блоки с видео-подсказками"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"components","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"components"}	\N	\N
263	275	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
264	276	directus_collections	policies	{"collection":"policies","icon":"shield_lock","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
265	277	directus_collections	seo	{"collection":"seo","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
266	278	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
267	279	directus_collections	components	{"collection":"components","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Блоки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
268	280	directus_fields	48	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок"}],"display":"formatted-value","collection":"hint","field":"title"}	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок"}],"display":"formatted-value","collection":"hint","field":"title"}	\N	\N
269	281	directus_collections	hint	{"collection":"hint","icon":"extension","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Блоки с видео","singular":"Блок с видео","plural":"Блоки с видео"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"components","collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Блоки с видео","singular":"Блок с видео","plural":"Блоки с видео"}]}	\N	\N
270	282	directus_fields	49	{"sort":5,"interface":"input-multiline","special":null,"required":false,"translations":[{"language":"ru-RU","translation":"Описание"}],"display":"formatted-value","collection":"hint","field":"description"}	{"sort":5,"interface":"input-multiline","special":null,"required":false,"translations":[{"language":"ru-RU","translation":"Описание"}],"display":"formatted-value","collection":"hint","field":"description"}	\N	\N
271	283	directus_fields	50	{"sort":6,"interface":"file","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Видео"}],"note":"Рекомендуется добавлять только видео, статичные изображения не будут отображены на сайте","display":"related-values","collection":"hint","field":"video"}	{"sort":6,"interface":"file","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Видео"}],"note":"Рекомендуется добавлять только видео, статичные изображения не будут отображены на сайте","display":"related-values","collection":"hint","field":"video"}	\N	\N
272	284	directus_fields	51	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"text_format"},"translations":[{"language":"ru-RU","translation":"Текст рядом с кнопкой"}],"required":true,"display":"formatted-value","collection":"hint","field":"button_text"}	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"text_format"},"translations":[{"language":"ru-RU","translation":"Текст рядом с кнопкой"}],"required":true,"display":"formatted-value","collection":"hint","field":"button_text"}	\N	\N
273	285	directus_fields	50	{"id":50,"collection":"hint","field":"video","special":["file"],"interface":"file","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Видео"}],"note":"Рекомендуется добавлять только видео. Статичные изображения не будут отображены на сайте","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"hint","field":"video","note":"Рекомендуется добавлять только видео. Статичные изображения не будут отображены на сайте"}	\N	\N
274	286	directus_files	b2138b89-054f-4d84-a389-df871654b76d	{"title":"404","filename_download":"404.mp4","type":"video/mp4","storage":"local"}	{"title":"404","filename_download":"404.mp4","type":"video/mp4","storage":"local"}	\N	\N
275	287	hint	4809efdd-56dc-4117-80e3-a24ce4c4320a	{"title":"Хотите развить свой бренд, но не знаете с чего начать?","description":"Мой опыт и знания смогут сократить путь к результатам, экономя несколько лет усилий.","video":"b2138b89-054f-4d84-a389-df871654b76d","button_text":"Про уникальный опыт"}	{"title":"Хотите развить свой бренд, но не знаете с чего начать?","description":"Мой опыт и знания смогут сократить путь к результатам, экономя несколько лет усилий.","video":"b2138b89-054f-4d84-a389-df871654b76d","button_text":"Про уникальный опыт"}	\N	\N
276	288	directus_permissions	9	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"hint","action":"read"}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"hint","action":"read"}	\N	\N
277	290	directus_access	d2ef36e9-2f73-4931-8a95-336df595a121	{"id":"d2ef36e9-2f73-4931-8a95-336df595a121","role":null,"user":"2545f07d-7228-4759-a84b-607cc64e44c1","policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd","sort":1}	{"policy":"60ca5918-2a7d-4808-9a8e-cdfd721a22dd"}	\N	\N
278	292	directus_fields	52	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"about_page"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"about_page"}	\N	\N
279	293	directus_fields	53	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"about_page"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"about_page"}	\N	\N
280	294	directus_collections	about_page	{"singleton":true,"collection":"about_page"}	{"singleton":true,"collection":"about_page"}	\N	\N
281	295	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","width":"full"}	\N	\N
282	296	directus_collections	about_page	{"collection":"about_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Обо мне\\"","singular":"Страница \\"Обо мне\\"","plural":"Страницы \\"Обо мне\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Обо мне\\"","singular":"Страница \\"Обо мне\\"","plural":"Страницы \\"Обо мне\\""}]}	\N	\N
283	297	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Разводная страница","singular":"Разводная страница","plural":"Разводные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
284	298	directus_collections	about_page	{"collection":"about_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Обо мне\\"","singular":"Страница \\"Обо мне\\"","plural":"Страницы \\"Обо мне\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
285	299	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
286	300	directus_collections	policies	{"collection":"policies","icon":"shield_lock","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
287	301	directus_collections	seo	{"collection":"seo","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
288	302	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
289	303	directus_collections	components	{"collection":"components","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Блоки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
290	304	directus_fields	54	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"about_hero"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"about_hero"}	\N	\N
291	305	directus_fields	55	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"about_hero"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"about_hero"}	\N	\N
292	306	directus_collections	about_hero	{"singleton":true,"collection":"about_hero"}	{"singleton":true,"collection":"about_hero"}	\N	\N
293	307	directus_fields	55	{"id":55,"collection":"about_hero","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_hero","field":"date_updated","width":"full"}	\N	\N
294	308	directus_collections	about_hero	{"collection":"about_hero","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"singleton":false}	\N	\N
295	309	directus_collections	about_hero	{"collection":"about_hero","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"about_page","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"about_page"}	\N	\N
296	310	directus_collections	contact	{"collection":"contact","icon":"globe_location_pin","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Контактная информация","singular":"Контактная информация","plural":"Контактная информация"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
297	311	directus_collections	policies	{"collection":"policies","icon":"shield_lock","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Политики и соглашения","singular":"Политика и соглашение","plural":"Политики и соглашения"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
298	312	directus_collections	seo	{"collection":"seo","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Настройки SEO","singular":"Настройка SEO","plural":"Настройки SEO"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
299	313	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
300	314	directus_collections	components	{"collection":"components","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Блоки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
301	315	directus_fields	56	{"sort":3,"interface":"list-o2m","special":["o2m"],"required":true,"collection":"about_page","field":"hero"}	{"sort":3,"interface":"list-o2m","special":["o2m"],"required":true,"collection":"about_page","field":"hero"}	\N	\N
302	317	directus_fields	57	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Хироскрин"}],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"collection":"about_page","field":"hero"}	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Хироскрин"}],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"collection":"about_page","field":"hero"}	\N	\N
303	318	directus_fields	58	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"interface":"group-detail","options":{"headerIcon":"brand_family"},"collection":"about_page","field":"brand"}	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"interface":"group-detail","options":{"headerIcon":"brand_family"},"collection":"about_page","field":"brand"}	\N	\N
304	319	directus_fields	59	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"interface":"group-detail","options":{"headerIcon":"work"},"collection":"about_page","field":"projects"}	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"interface":"group-detail","options":{"headerIcon":"work"},"collection":"about_page","field":"projects"}	\N	\N
305	320	directus_fields	60	{"sort":6,"interface":"presentation-divider","special":["alias","no-data"],"collection":"about_page","field":"divider-z-ijz0"}	{"sort":6,"interface":"presentation-divider","special":["alias","no-data"],"collection":"about_page","field":"divider-z-ijz0"}	\N	\N
306	321	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
307	322	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
308	323	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
309	324	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":4,"group":null}	\N	\N
310	325	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":5,"group":null}	\N	\N
311	326	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":6,"group":null}	\N	\N
312	327	directus_fields	61	{"sort":7,"interface":"presentation-divider","special":["alias","no-data"],"collection":"about_page","field":"divider-z5vybz"}	{"sort":7,"interface":"presentation-divider","special":["alias","no-data"],"collection":"about_page","field":"divider-z5vybz"}	\N	\N
313	328	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
314	329	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
315	330	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
316	331	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
317	332	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
318	333	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
319	334	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
320	338	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#111111","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#111111"}	\N	\N
321	339	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#6644FF"}	\N	\N
322	340	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_appearance":"light"}	\N	\N
323	341	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"foreground":"#111111"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"foreground":"#111111"}}	\N	\N
324	342	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{}}	\N	\N
325	343	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"foregroundAccent":"#111111"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"foregroundAccent":"#111111"}}	\N	\N
328	346	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{}}	\N	\N
329	347	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"backgroundAccent":"red"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"backgroundAccent":"red"}}	\N	\N
326	344	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"foregroundAccent":"#111111","foregroundSubdued":"#111111"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"foregroundAccent":"#111111","foregroundSubdued":"#111111"}}	\N	\N
327	345	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"backgroundNormal":"#111111"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"backgroundNormal":"#111111"}}	\N	\N
330	348	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"backgroundSubdued":"red"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"backgroundSubdued":"red"}}	\N	\N
331	349	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"primaryBackground":"red"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"primaryBackground":"red"}}	\N	\N
363	381	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
364	382	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
368	386	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
332	350	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"primarySubdued":"red"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"primarySubdued":"red"}}	\N	\N
333	351	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"primaryAccent":"red"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"primaryAccent":"red"}}	\N	\N
334	352	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"secondaryBackground":"red"},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"secondaryBackground":"red"}}	\N	\N
335	353	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{}}	\N	\N
336	354	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"navigation":{"background":"red"}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"navigation":{"background":"red"}}}	\N	\N
337	355	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"navigation":{"backgroundAccent":"red"}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"navigation":{"backgroundAccent":"red"}}}	\N	\N
347	365	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"red"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_dark_overrides":{"background":"red"}}	\N	\N
348	366	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_dark_overrides":{"background":"#111111"}}	\N	\N
338	356	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"navigation":{"project":{"background":"red"}}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"navigation":{"project":{"background":"red"}}}}	\N	\N
339	357	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"navigation":{"project":{"foreground":"red"}}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"navigation":{"project":{"foreground":"red"}}}}	\N	\N
340	358	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"sidebar":{"background":"red"}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"sidebar":{"background":"red"}}}	\N	\N
341	359	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"sidebar":{"foreground":"red"}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"sidebar":{"foreground":"red"}}}	\N	\N
365	383	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
366	384	directus_fields	63	{"sort":8,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок хироскрина"}],"required":true,"display":"formatted-value","collection":"about_page","field":"hero_subtitle"}	{"sort":8,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок хироскрина"}],"required":true,"display":"formatted-value","collection":"about_page","field":"hero_subtitle"}	\N	\N
342	360	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{"popover":{"menu":{"background":"red"}}},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{"popover":{"menu":{"background":"red"}}}}	\N	\N
343	361	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_light_overrides":{}}	\N	\N
344	362	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#E41F1A"}	\N	\N
345	363	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_dark":"Directus Default"}	\N	\N
346	364	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":null,"theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_appearance":"dark"}	\N	\N
349	367	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":"Directus Color Match","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Color Match"}	\N	\N
350	368	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Color Match","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_appearance":"light"}	\N	\N
351	369	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#E41F1A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Default"}	\N	\N
352	370	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#A2B5CD","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#A2B5CD"}	\N	\N
353	371	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#3399FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#3399FF"}	\N	\N
354	372	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#6644FF"}	\N	\N
355	373	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{"background":"#111111"},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_appearance":"dark"}	\N	\N
356	374	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"theme_dark_overrides":{}}	\N	\N
357	375	directus_fields	62	{"sort":8,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок хироскрина"}],"display":"formatted-value","collection":"about_page","field":"hero_title"}	{"sort":8,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок хироскрина"}],"display":"formatted-value","collection":"about_page","field":"hero_title"}	\N	\N
358	376	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
359	377	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
360	378	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
361	379	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок хироскрина"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","sort":1,"group":"hero"}	\N	\N
362	380	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
369	387	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
370	388	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок хироскрина"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","sort":1,"group":"hero"}	\N	\N
371	389	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
372	390	directus_fields	63	{"id":63,"collection":"about_page","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок хироскрина"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
373	391	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
374	392	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
375	393	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
376	394	directus_fields	64	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображение хироскрина"}],"display":"image","collection":"about_page","field":"hero_image"}	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображение хироскрина"}],"display":"image","collection":"about_page","field":"hero_image"}	\N	\N
377	395	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
378	396	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
379	397	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
380	398	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок хироскрина"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","sort":1,"group":"hero"}	\N	\N
381	399	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
382	400	directus_fields	63	{"id":63,"collection":"about_page","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок хироскрина"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
383	401	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
384	402	directus_fields	64	{"id":64,"collection":"about_page","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение хироскрина"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_image","sort":3,"group":"hero"}	\N	\N
387	405	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}]}	\N	\N
388	406	directus_fields	63	{"id":63,"collection":"about_page","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_subtitle","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}]}	\N	\N
389	407	directus_fields	64	{"id":64,"collection":"about_page","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_image","translations":[{"language":"ru-RU","translation":"Изображение первого экрана"}]}	\N	\N
390	408	directus_fields	65	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"required":false,"options":{"template":"{{title}}"},"translations":[{"language":"ru-RU","translation":"Видео-подсказки на первом экране"}],"display":"related-values","collection":"about_page","field":"hero_hint"}	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"required":false,"options":{"template":"{{title}}"},"translations":[{"language":"ru-RU","translation":"Видео-подсказки на первом экране"}],"display":"related-values","collection":"about_page","field":"hero_hint"}	\N	\N
391	409	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
392	410	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
393	411	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
395	413	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
397	415	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
399	417	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
401	419	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
422	440	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
423	446	about_page	f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	{"hero_title":"Помогаю бизнесу зарабатывать.","hero_subtitle":"Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса.","hero_image":"ebce4a72-76fb-48f2-9527-26413b4eb33c","hero_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a"}	{"hero_title":"Помогаю бизнесу зарабатывать.","hero_subtitle":"Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса.","hero_image":"ebce4a72-76fb-48f2-9527-26413b4eb33c","hero_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a"}	\N	\N
385	403	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
386	404	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
394	412	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","sort":1,"group":"hero"}	\N	\N
396	414	directus_fields	63	{"id":63,"collection":"about_page","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
398	416	directus_fields	64	{"id":64,"collection":"about_page","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_image","sort":3,"group":"hero"}	\N	\N
400	418	directus_fields	65	{"id":65,"collection":"about_page","field":"hero_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Видео-подсказки на первом экране"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_hint","sort":4,"group":"hero"}	\N	\N
402	420	directus_files	9c58cff1-46f1-4446-845e-b3a0bb9cc908	{"title":"Аккредитация Аккредитации   Лебедев И Партнеры","filename_download":"Аккредитация аккредитации _ Лебедев и партнеры.jpg","type":"image/jpeg","storage":"local"}	{"title":"Аккредитация Аккредитации   Лебедев И Партнеры","filename_download":"Аккредитация аккредитации _ Лебедев и партнеры.jpg","type":"image/jpeg","storage":"local"}	\N	\N
403	421	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":"9c58cff1-46f1-4446-845e-b3a0bb9cc908","default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"public_favicon":"9c58cff1-46f1-4446-845e-b3a0bb9cc908"}	\N	\N
405	423	directus_files	1a2dea75-6b07-4e18-8f78-bab537ed7f48	{"title":"Favicon","filename_download":"favicon.ico","type":"image/x-icon","storage":"local"}	{"title":"Favicon","filename_download":"favicon.ico","type":"image/x-icon","storage":"local"}	\N	\N
406	424	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":"1a2dea75-6b07-4e18-8f78-bab537ed7f48","default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"public_favicon":"1a2dea75-6b07-4e18-8f78-bab537ed7f48"}	\N	\N
418	436	directus_fields	66	{"id":66,"collection":"about_page","field":"brand_gallery","special":["files"],"interface":"files","options":{"filter":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"brand","validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"validation_message":null}	{"collection":"about_page","field":"brand_gallery","sort":1,"group":"brand"}	\N	\N
404	422	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"public_favicon":null}	\N	\N
407	425	directus_files	43c73c70-147e-4820-811c-0810f29c5f57	{"title":"Favicon","filename_download":"favicon.ico","type":"image/x-icon","storage":"local"}	{"title":"Favicon","filename_download":"favicon.ico","type":"image/x-icon","storage":"local"}	\N	\N
408	426	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":"43c73c70-147e-4820-811c-0810f29c5f57","public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":"1a2dea75-6b07-4e18-8f78-bab537ed7f48","default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_logo":"43c73c70-147e-4820-811c-0810f29c5f57"}	\N	\N
409	427	directus_settings	1	{"id":1,"project_name":"Kulaginbrand","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":"1a2dea75-6b07-4e18-8f78-bab537ed7f48","default_appearance":"dark","default_theme_light":"Directus Default","theme_light_overrides":{},"default_theme_dark":"Directus Default","theme_dark_overrides":{},"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019aa13c-fa7b-75bb-8488-756ddfa7fac4","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_logo":null}	\N	\N
410	428	directus_fields	66	{"sort":8,"interface":"files","special":["files"],"required":true,"options":{"filter":null},"validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"collection":"about_page","field":"brand_gallery"}	{"sort":8,"interface":"files","special":["files"],"required":true,"options":{"filter":null},"validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"collection":"about_page","field":"brand_gallery"}	\N	\N
411	429	directus_fields	67	{"sort":1,"hidden":true,"field":"id","collection":"about_page_files"}	{"sort":1,"hidden":true,"field":"id","collection":"about_page_files"}	\N	\N
412	430	directus_collections	about_page_files	{"hidden":true,"icon":"import_export","collection":"about_page_files"}	{"hidden":true,"icon":"import_export","collection":"about_page_files"}	\N	\N
413	431	directus_fields	68	{"sort":2,"hidden":true,"collection":"about_page_files","field":"about_page_id"}	{"sort":2,"hidden":true,"collection":"about_page_files","field":"about_page_id"}	\N	\N
414	432	directus_fields	69	{"sort":3,"hidden":true,"collection":"about_page_files","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"about_page_files","field":"directus_files_id"}	\N	\N
415	433	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
416	434	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
417	435	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
419	437	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
420	438	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
421	439	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
477	503	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
424	449	directus_fields	70	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"display":"image","collection":"about_page","field":"brand_letter_b"}	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"display":"image","collection":"about_page","field":"brand_letter_b"}	\N	\N
425	450	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
426	451	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
427	452	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
428	453	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
429	454	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
430	455	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
431	456	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
432	457	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
433	458	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","width":"half"}	\N	\N
434	459	directus_fields	71	{"sort":8,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"display":"image","collection":"about_page","field":"brand_letter_r"}	{"sort":8,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"display":"image","collection":"about_page","field":"brand_letter_r"}	\N	\N
435	460	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","required":true}	\N	\N
436	461	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","width":"half"}	\N	\N
437	462	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
438	463	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
440	465	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
439	464	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
446	471	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","width":"half"}	\N	\N
447	472	directus_fields	63	{"id":63,"collection":"about_page","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_subtitle","width":"half"}	\N	\N
441	466	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
442	467	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
443	468	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
444	469	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
445	470	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
448	473	directus_fields	62	{"id":62,"collection":"about_page","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_title","width":"full"}	\N	\N
449	474	directus_fields	63	{"id":63,"collection":"about_page","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"about_page","field":"hero_subtitle","width":"full"}	\N	\N
450	475	directus_fields	72	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"display":"image","collection":"about_page","field":"brand_letter_a"}	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"display":"image","collection":"about_page","field":"brand_letter_a"}	\N	\N
451	476	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","width":"half"}	\N	\N
452	477	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
453	478	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
454	479	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
455	480	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
456	481	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
457	482	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
458	483	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
459	484	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
460	485	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
461	486	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
462	487	directus_fields	73	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"display":"image","collection":"about_page","field":"brand_letter_n"}	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"display":"image","collection":"about_page","field":"brand_letter_n"}	\N	\N
463	488	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","width":"half"}	\N	\N
464	489	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
465	490	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
466	491	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
467	492	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
468	493	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
469	494	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
470	495	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
471	496	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
472	497	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
473	498	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
474	499	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
475	500	directus_fields	74	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"display":"image","collection":"about_page","field":"brand_letter_d"}	{"sort":8,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"display":"image","collection":"about_page","field":"brand_letter_d"}	\N	\N
476	501	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","width":"half"}	\N	\N
478	502	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
480	505	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
482	507	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
484	509	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
486	511	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
489	514	directus_fields	75	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}"},"translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"display":"related-values","collection":"about_page","field":"brand_hint"}	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}"},"translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"display":"related-values","collection":"about_page","field":"brand_hint"}	\N	\N
490	515	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
491	516	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
492	517	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
494	519	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
495	520	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
479	504	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
481	506	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
483	508	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
485	510	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
487	512	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
488	513	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
493	518	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
496	521	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
498	523	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
500	525	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
501	526	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
502	527	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
497	522	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
499	524	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
503	528	about_page	f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	{"id":"f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21","date_updated":"2025-11-20T20:56:07.969Z","hero_title":"Помогаю бизнесу зарабатывать.","hero_subtitle":"Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса.","hero_image":"ebce4a72-76fb-48f2-9527-26413b4eb33c","hero_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a","brand_letter_b":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_r":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_a":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_n":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_d":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a"}	{"brand_letter_b":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_r":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_a":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_n":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_d":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a","date_updated":"2025-11-20T20:56:07.969Z"}	\N	\N
504	529	directus_fields	76	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"about_brand_image"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"about_brand_image"}	\N	\N
505	530	directus_collections	about_brand_image	{"singleton":false,"collection":"about_brand_image"}	{"singleton":false,"collection":"about_brand_image"}	\N	\N
506	531	directus_fields	77	{"sort":2,"interface":"file-image","special":["file"],"required":true,"collection":"about_brand_image","field":"image"}	{"sort":2,"interface":"file-image","special":["file"],"required":true,"collection":"about_brand_image","field":"image"}	\N	\N
507	532	directus_fields	78	{"sort":8,"interface":"list-m2m","special":["m2m"],"required":true,"options":{"enableSelect":false,"limit":100},"display":"related-values","validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"collection":"about_page","field":"brand_gallery"}	{"sort":8,"interface":"list-m2m","special":["m2m"],"required":true,"options":{"enableSelect":false,"limit":100},"display":"related-values","validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"collection":"about_page","field":"brand_gallery"}	\N	\N
508	533	directus_fields	79	{"sort":1,"hidden":true,"field":"id","collection":"about_page_about_brand_image"}	{"sort":1,"hidden":true,"field":"id","collection":"about_page_about_brand_image"}	\N	\N
509	534	directus_collections	about_page_about_brand_image	{"hidden":true,"icon":"import_export","collection":"about_page_about_brand_image"}	{"hidden":true,"icon":"import_export","collection":"about_page_about_brand_image"}	\N	\N
510	535	directus_fields	80	{"sort":2,"hidden":true,"collection":"about_page_about_brand_image","field":"about_page_id"}	{"sort":2,"hidden":true,"collection":"about_page_about_brand_image","field":"about_page_id"}	\N	\N
511	536	directus_fields	81	{"sort":3,"hidden":true,"collection":"about_page_about_brand_image","field":"about_brand_image_id"}	{"sort":3,"hidden":true,"collection":"about_page_about_brand_image","field":"about_brand_image_id"}	\N	\N
512	537	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
513	538	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
514	539	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
515	540	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
516	541	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
517	542	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
518	543	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
520	545	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
522	547	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
524	549	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
525	550	directus_fields	78	{"id":78,"collection":"about_page","field":"brand_gallery","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false,"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"brand","validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"validation_message":null}	{"collection":"about_page","field":"brand_gallery","sort":7,"group":"brand"}	\N	\N
519	544	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
521	546	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
523	548	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
526	551	directus_fields	78	{"id":78,"collection":"about_page","field":"brand_gallery","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false,"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"brand","validation":{"_and":[{"brand_gallery":{"_eq":"9"}}]},"validation_message":null}	{"collection":"about_page","field":"brand_gallery"}	\N	\N
527	553	directus_fields	82	{"sort":8,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"display":"formatted-value","collection":"about_page","field":"brand_title"}	{"sort":8,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"display":"formatted-value","collection":"about_page","field":"brand_title"}	\N	\N
528	554	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
529	555	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
530	556	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
531	557	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
532	558	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
533	559	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
534	560	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
535	561	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
536	562	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
537	563	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
538	564	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
539	565	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
540	566	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
541	567	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
542	568	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","required":true}	\N	\N
543	569	directus_fields	83	{"sort":8,"interface":"input-multiline","special":null,"translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"display":"formatted-value","collection":"about_page","field":"brand_description"}	{"sort":8,"interface":"input-multiline","special":null,"translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"display":"formatted-value","collection":"about_page","field":"brand_description"}	\N	\N
544	570	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
545	571	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
546	572	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
547	573	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
548	574	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
549	575	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
550	576	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
551	577	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
552	578	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
553	579	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
554	580	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
555	581	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
556	582	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
557	583	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
558	584	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
559	592	directus_fields	84	{"sort":9,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_1"}	{"sort":9,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_1"}	\N	\N
560	593	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","width":"half"}	\N	\N
561	594	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
562	595	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
563	597	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
564	596	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
565	598	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
566	599	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
567	600	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
568	601	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
569	602	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
571	604	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
573	606	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
575	608	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
576	609	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
570	603	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
572	605	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
574	607	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
577	610	directus_fields	85	{"sort":10,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_2"}	{"sort":10,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_2"}	\N	\N
578	611	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","width":"half"}	\N	\N
579	612	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
580	613	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
581	614	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
582	615	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
583	616	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
584	617	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
585	618	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
586	619	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
587	620	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
588	621	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
589	622	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
591	624	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
593	626	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
594	627	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
595	628	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
599	632	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
601	634	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
603	636	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
605	638	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
607	640	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
609	642	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
612	645	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
619	652	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
621	654	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
623	656	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
590	623	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
592	625	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
596	629	directus_fields	86	{"sort":11,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_3"}	{"sort":11,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_3"}	\N	\N
597	630	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","width":"half"}	\N	\N
598	631	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
600	633	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
602	635	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
604	637	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
606	639	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
608	641	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
610	643	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
611	644	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
613	646	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
614	647	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
625	658	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
615	648	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
616	649	directus_fields	87	{"sort":12,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_4"}	{"sort":12,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_4"}	\N	\N
617	650	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","width":"half"}	\N	\N
618	651	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
620	653	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
622	655	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
624	657	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
626	659	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
628	661	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
630	663	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
632	665	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
633	666	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
634	667	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
635	668	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
627	660	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
629	662	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
631	664	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
636	669	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","sort":12,"group":"brand"}	\N	\N
637	670	directus_fields	88	{"sort":13,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_5"}	{"sort":13,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_5"}	\N	\N
638	671	directus_fields	88	{"id":88,"collection":"about_page","field":"brand_gallery_5","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_5","width":"half"}	\N	\N
639	672	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
640	673	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
641	674	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
642	675	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
643	676	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
644	677	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
645	678	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
646	679	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
647	680	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
648	681	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
649	682	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
650	683	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
651	684	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
653	686	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
654	687	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
655	688	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
656	689	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
657	690	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","sort":12,"group":"brand"}	\N	\N
658	691	directus_fields	88	{"id":88,"collection":"about_page","field":"brand_gallery_5","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_5","sort":13,"group":"brand"}	\N	\N
659	692	directus_fields	89	{"sort":14,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_6"}	{"sort":14,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_6"}	\N	\N
660	693	directus_fields	89	{"id":89,"collection":"about_page","field":"brand_gallery_6","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_6","width":"half"}	\N	\N
661	694	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
663	696	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
665	698	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
667	700	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
669	702	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
688	721	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
652	685	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
662	695	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
664	697	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
666	699	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
668	701	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
670	703	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
672	705	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
674	707	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
671	704	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
673	706	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
675	708	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
676	709	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
677	710	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
678	711	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
679	712	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","sort":12,"group":"brand"}	\N	\N
680	713	directus_fields	88	{"id":88,"collection":"about_page","field":"brand_gallery_5","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_5","sort":13,"group":"brand"}	\N	\N
681	714	directus_fields	89	{"id":89,"collection":"about_page","field":"brand_gallery_6","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_6","sort":14,"group":"brand"}	\N	\N
682	715	directus_fields	90	{"sort":15,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_7"}	{"sort":15,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_7"}	\N	\N
683	716	directus_fields	90	{"id":90,"collection":"about_page","field":"brand_gallery_7","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_7","width":"half"}	\N	\N
684	717	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
685	718	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
686	719	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
687	720	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
689	722	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
691	724	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
693	726	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
695	728	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
697	730	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
709	742	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
711	744	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
713	746	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
715	748	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
717	750	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
719	752	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
721	754	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
734	767	directus_fields	52	{"id":52,"collection":"about_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"id","sort":1,"group":null}	\N	\N
736	769	directus_fields	53	{"id":53,"collection":"about_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"date_updated","sort":2,"group":null}	\N	\N
738	771	directus_fields	57	{"id":57,"collection":"about_page","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"magnify_fullscreen"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"hero","sort":3,"group":null}	\N	\N
690	723	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
692	725	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
694	727	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
696	729	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
698	731	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
699	732	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
700	733	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
701	734	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
702	735	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","sort":12,"group":"brand"}	\N	\N
703	736	directus_fields	88	{"id":88,"collection":"about_page","field":"brand_gallery_5","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_5","sort":13,"group":"brand"}	\N	\N
704	737	directus_fields	89	{"id":89,"collection":"about_page","field":"brand_gallery_6","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_6","sort":14,"group":"brand"}	\N	\N
705	738	directus_fields	90	{"id":90,"collection":"about_page","field":"brand_gallery_7","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_7","sort":15,"group":"brand"}	\N	\N
706	739	directus_fields	91	{"sort":16,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_8"}	{"sort":16,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_8"}	\N	\N
707	740	directus_fields	91	{"id":91,"collection":"about_page","field":"brand_gallery_8","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_8","width":"half"}	\N	\N
708	741	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
710	743	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
712	745	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
714	747	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
716	749	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
718	751	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
720	753	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
722	755	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
723	756	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
724	757	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
725	758	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
726	759	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","sort":12,"group":"brand"}	\N	\N
727	760	directus_fields	88	{"id":88,"collection":"about_page","field":"brand_gallery_5","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_5","sort":13,"group":"brand"}	\N	\N
728	761	directus_fields	89	{"id":89,"collection":"about_page","field":"brand_gallery_6","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_6","sort":14,"group":"brand"}	\N	\N
729	762	directus_fields	90	{"id":90,"collection":"about_page","field":"brand_gallery_7","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_7","sort":15,"group":"brand"}	\N	\N
730	763	directus_fields	91	{"id":91,"collection":"about_page","field":"brand_gallery_8","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_8","sort":16,"group":"brand"}	\N	\N
731	764	directus_fields	92	{"sort":17,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_9"}	{"sort":17,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"display":"image","collection":"about_page","field":"brand_gallery_9"}	\N	\N
732	765	directus_fields	92	{"id":92,"collection":"about_page","field":"brand_gallery_9","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":17,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_9","width":"half"}	\N	\N
733	766	directus_fields	70	{"id":70,"collection":"about_page","field":"brand_letter_b","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"B\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_b","sort":1,"group":"brand"}	\N	\N
735	768	directus_fields	71	{"id":71,"collection":"about_page","field":"brand_letter_r","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"R\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_r","sort":2,"group":"brand"}	\N	\N
737	770	directus_fields	72	{"id":72,"collection":"about_page","field":"brand_letter_a","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"A\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_a","sort":3,"group":"brand"}	\N	\N
739	772	directus_fields	73	{"id":73,"collection":"about_page","field":"brand_letter_n","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"N\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_n","sort":4,"group":"brand"}	\N	\N
741	774	directus_fields	74	{"id":74,"collection":"about_page","field":"brand_letter_d","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Буква \\"D\\""}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_letter_d","sort":5,"group":"brand"}	\N	\N
743	776	directus_fields	75	{"id":75,"collection":"about_page","field":"brand_hint","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка с видео в блоке BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_hint","sort":6,"group":"brand"}	\N	\N
745	778	directus_fields	82	{"id":82,"collection":"about_page","field":"brand_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_title","sort":7,"group":"brand"}	\N	\N
747	780	directus_fields	83	{"id":83,"collection":"about_page","field":"brand_description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок блока BRAND"}],"note":null,"conditions":null,"required":false,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_description","sort":8,"group":"brand"}	\N	\N
748	781	directus_fields	84	{"id":84,"collection":"about_page","field":"brand_gallery_1","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_1","sort":9,"group":"brand"}	\N	\N
749	782	directus_fields	85	{"id":85,"collection":"about_page","field":"brand_gallery_2","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_2","sort":10,"group":"brand"}	\N	\N
740	773	directus_fields	61	{"id":61,"collection":"about_page","field":"divider-z5vybz","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z5vybz","sort":4,"group":null}	\N	\N
742	775	directus_fields	58	{"id":58,"collection":"about_page","field":"brand","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"brand_family"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Brand\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"brand","sort":5,"group":null}	\N	\N
744	777	directus_fields	60	{"id":60,"collection":"about_page","field":"divider-z-ijz0","special":["alias","no-data"],"interface":"presentation-divider","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"divider-z-ijz0","sort":6,"group":null}	\N	\N
746	779	directus_fields	59	{"id":59,"collection":"about_page","field":"projects","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"work"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Проекты\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"about_page","field":"projects","sort":7,"group":null}	\N	\N
750	783	directus_fields	86	{"id":86,"collection":"about_page","field":"brand_gallery_3","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_3","sort":11,"group":"brand"}	\N	\N
751	784	directus_fields	87	{"id":87,"collection":"about_page","field":"brand_gallery_4","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_4","sort":12,"group":"brand"}	\N	\N
752	785	directus_fields	88	{"id":88,"collection":"about_page","field":"brand_gallery_5","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_5","sort":13,"group":"brand"}	\N	\N
753	786	directus_fields	89	{"id":89,"collection":"about_page","field":"brand_gallery_6","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_6","sort":14,"group":"brand"}	\N	\N
754	787	directus_fields	90	{"id":90,"collection":"about_page","field":"brand_gallery_7","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_7","sort":15,"group":"brand"}	\N	\N
755	788	directus_fields	91	{"id":91,"collection":"about_page","field":"brand_gallery_8","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_8","sort":16,"group":"brand"}	\N	\N
756	789	directus_fields	92	{"id":92,"collection":"about_page","field":"brand_gallery_9","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":17,"width":"half","translations":[{"language":"ru-RU","translation":"Фото галереи BRAND"}],"note":null,"conditions":null,"required":true,"group":"brand","validation":null,"validation_message":null}	{"collection":"about_page","field":"brand_gallery_9","sort":17,"group":"brand"}	\N	\N
757	790	about_page	f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21	{"id":"f88bb5da-5e7d-4f10-a9e7-a5d9a5370b21","date_updated":"2025-11-20T21:13:39.437Z","hero_title":"Помогаю бизнесу зарабатывать.","hero_subtitle":"Консультации по рекламе и брендингу, по личностному росту и ведению бизнеса.","hero_image":"ebce4a72-76fb-48f2-9527-26413b4eb33c","hero_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a","brand_letter_b":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_r":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_a":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_n":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_letter_d":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_hint":"4809efdd-56dc-4117-80e3-a24ce4c4320a","brand_title":"Развиваю личные бренды","brand_description":"На личность —идет наличность","brand_gallery_1":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_2":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_3":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_4":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_5":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_6":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_7":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_8":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_9":"e248aec4-8c7e-4240-9e4c-1fdd2c802240"}	{"brand_title":"Развиваю личные бренды","brand_description":"На личность —идет наличность","brand_gallery_1":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_2":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_3":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_4":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_5":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_6":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_7":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_8":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","brand_gallery_9":"e248aec4-8c7e-4240-9e4c-1fdd2c802240","date_updated":"2025-11-20T21:13:39.437Z"}	\N	\N
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
TMdCfph4cGqE8zaYlOpLx2c50A4YjNx_YlEY3O4czHIneBnGZ13BeZx14I8MLsDf	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-20 20:43:54.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	o4_WVmmJE7dei_zF_5e8H2IRMJm7ZQEaI5PRJbb7ZIapS9Rt1akB9Tc13nssIpgm
o4_WVmmJE7dei_zF_5e8H2IRMJm7ZQEaI5PRJbb7ZIapS9Rt1akB9Tc13nssIpgm	d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	2025-11-21 20:43:44.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Kulaginbrand	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}]	\N	ru-RU	\N	1a2dea75-6b07-4e18-8f78-bab537ed7f48	dark	Directus Default	{}	Directus Default	{}	\N	\N	\N	f	t	\N	\N	\N	t	019aa13c-fa7b-75bb-8488-756ddfa7fac4	f	f	\N	t	\N
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
d05b00f5-2aeb-4f89-ad64-e41ca3b0327a	Kulagin-studio	\N	theplace2024@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$xwBvwoDzOWVZ3nSXT5rt4A$zaYmuZ5rLQb3NR/jKA+YFdDfKbe3u+Vua091riv5vc8	\N	\N	\N	\N	227d60c0-b241-4c94-9f8d-16e8d8eca0d9	\N	\N	active	5a09e807-f654-4501-ab1b-e2bb5f612679	\N	2025-11-20 20:43:44.541+00	/settings/data-model/about_page	default	\N	\N	t	\N	\N	\N	\N	\N	auto
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
-- Data for Name: hint; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.hint (id, date_created, date_updated, title, description, video, button_text) FROM stdin;
4809efdd-56dc-4117-80e3-a24ce4c4320a	2025-11-20 20:03:47.666+00	\N	Хотите развить свой бренд, но не знаете с чего начать?	Мой опыт и знания смогут сократить путь к результатам, экономя несколько лет усилий.	b2138b89-054f-4d84-a389-df871654b76d	Про уникальный опыт
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
-- Data for Name: policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.policies (id, date_created, date_updated, title, content, sort) FROM stdin;
52d487f4-0da3-4004-ae51-1861b9f035b3	2025-11-20 18:37:33.498+00	\N	Политика конфиденциальности	<h2>1. Обзор</h2>\n<h3>1.1 Наши Ценности</h3>\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\n<h3>2.2 Правила Участия</h3>\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\n<h2>2. Проведение Боя</h2>\n<h3>2.1 Уважайте Соперника</h3>\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\n<h2>3. Поведение После Боя</h2>\n<h3>3.1 Поддерживайте Соперников</h3>\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\n<h2>4. Протоколы Безопасности</h2>\n<h3>4.1 Экстренные Процедуры</h3>\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\n<h2>5. Возрастные Требования</h2>\n<h3>5.1 Требования к Участникам</h3>\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\n<h2>6. Свяжитесь с Нами</h2>\n<h3>6.1 Обратная Связь</h3>\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href="https://example.com/" target="_blank" rel="noopener">info@fightclub.com</a>.</p>	3
a37f84bf-f78b-466c-aeb5-97985d4bc059	2025-11-20 18:37:53.232+00	\N	Оферта	<h2>1. Обзор</h2>\n<h3>1.1 Наши Ценности</h3>\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\n<h3>2.2 Правила Участия</h3>\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\n<h2>2. Проведение Боя</h2>\n<h3>2.1 Уважайте Соперника</h3>\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\n<h2>3. Поведение После Боя</h2>\n<h3>3.1 Поддерживайте Соперников</h3>\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\n<h2>4. Протоколы Безопасности</h2>\n<h3>4.1 Экстренные Процедуры</h3>\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\n<h2>5. Возрастные Требования</h2>\n<h3>5.1 Требования к Участникам</h3>\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\n<h2>6. Свяжитесь с Нами</h2>\n<h3>6.1 Обратная Связь</h3>\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href="https://example.com/" target="_blank" rel="noopener">info@fightclub.com</a>.</p>	2
fd3a7ade-7d55-4a2c-93d5-9f539c692a1b	2025-11-20 18:38:03.069+00	\N	Пользовательское соглашение	<h2>1. Обзор</h2>\n<h3>1.1 Наши Ценности</h3>\n<p>В Бойцовском Клубе мы подчёркиваем уважение, дисциплину и товарищество среди наших членов. Этот документ описывает ключевые правила, которые регулируют наш клуб и обеспечивают безопасный и приятный опыт для всех.</p>\n<h3>2.2 Правила Участия</h3>\n<p>Члены должны добровольно соглашаться участвовать в боях и носить подходящее защитное снаряжение. Безопасность является нашим высшим приоритетом.</p>\n<h2>2. Проведение Боя</h2>\n<h3>2.1 Уважайте Соперника</h3>\n<p>Все бойцы должны проявлять уважение к своим соперникам как внутри, так и вне ринга. Личные нападки или недостойное поведение не будут терпимы.</p>\n<h2>3. Поведение После Боя</h2>\n<h3>3.1 Поддерживайте Соперников</h3>\n<p>После боя члены поощряются поздравлять своих соперников и оказывать поддержку, независимо от результата.</p>\n<h2>4. Протоколы Безопасности</h2>\n<h3>4.1 Экстренные Процедуры</h3>\n<p>В случае травмы члены должны немедленно сообщить рефери и при необходимости обратиться за медицинской помощью.</p>\n<h2>5. Возрастные Требования</h2>\n<h3>5.1 Требования к Участникам</h3>\n<p>Участники должны быть не младше 18 лет, чтобы присоединиться к Бойцовскому Клубу.</p>\n<h2>6. Свяжитесь с Нами</h2>\n<h3>6.1 Обратная Связь</h3>\n<p>По любым вопросам или проблемам, касающимся этих правил, пожалуйста, свяжитесь с нами по адресу&nbsp;<a href="https://example.com/" target="_blank" rel="noopener">info@fightclub.com</a>.</p>	1
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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 790, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 92, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 9, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 3, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 28, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 757, true);


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
-- Name: about_page about_page_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_pkey PRIMARY KEY (id);


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
-- Name: hint hint_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.hint
    ADD CONSTRAINT hint_pkey PRIMARY KEY (id);


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
-- Name: policies policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_pkey PRIMARY KEY (id);


--
-- Name: seo seo_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.seo
    ADD CONSTRAINT seo_pkey PRIMARY KEY (id);


--
-- Name: about_page about_page_brand_gallery_1_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_1_foreign FOREIGN KEY (brand_gallery_1) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_2_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_2_foreign FOREIGN KEY (brand_gallery_2) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_3_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_3_foreign FOREIGN KEY (brand_gallery_3) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_4_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_4_foreign FOREIGN KEY (brand_gallery_4) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_5_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_5_foreign FOREIGN KEY (brand_gallery_5) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_6_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_6_foreign FOREIGN KEY (brand_gallery_6) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_7_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_7_foreign FOREIGN KEY (brand_gallery_7) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_8_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_8_foreign FOREIGN KEY (brand_gallery_8) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_gallery_9_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_gallery_9_foreign FOREIGN KEY (brand_gallery_9) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_hint_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_hint_foreign FOREIGN KEY (brand_hint) REFERENCES public.hint(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_letter_a_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_letter_a_foreign FOREIGN KEY (brand_letter_a) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_letter_b_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_letter_b_foreign FOREIGN KEY (brand_letter_b) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_letter_d_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_letter_d_foreign FOREIGN KEY (brand_letter_d) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_letter_n_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_letter_n_foreign FOREIGN KEY (brand_letter_n) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_brand_letter_r_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_brand_letter_r_foreign FOREIGN KEY (brand_letter_r) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_hero_hint_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_hero_hint_foreign FOREIGN KEY (hero_hint) REFERENCES public.hint(id) ON DELETE SET NULL;


--
-- Name: about_page about_page_hero_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.about_page
    ADD CONSTRAINT about_page_hero_image_foreign FOREIGN KEY (hero_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


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
-- Name: hint hint_video_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.hint
    ADD CONSTRAINT hint_video_foreign FOREIGN KEY (video) REFERENCES public.directus_files(id) ON DELETE SET NULL;


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

