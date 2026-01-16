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
-- Name: articles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.articles (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    content text,
    cover uuid
);


ALTER TABLE public.articles OWNER TO directus;

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
-- Name: home_hero; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_hero (
    id uuid NOT NULL,
    title character varying(255),
    subtitle text,
    file uuid
);


ALTER TABLE public.home_hero OWNER TO directus;

--
-- Name: home_page; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_page (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone
);


ALTER TABLE public.home_page OWNER TO directus;

--
-- Name: home_page_home_hero; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_page_home_hero (
    id integer NOT NULL,
    home_page_id uuid,
    home_hero_id uuid
);


ALTER TABLE public.home_page_home_hero OWNER TO directus;

--
-- Name: home_page_home_hero_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.home_page_home_hero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.home_page_home_hero_id_seq OWNER TO directus;

--
-- Name: home_page_home_hero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.home_page_home_hero_id_seq OWNED BY public.home_page_home_hero.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    hero_title character varying(255),
    hero_subtitle text,
    hero_advant json,
    hero_image uuid,
    about_title character varying(255),
    about_content text,
    banner_value character varying(255),
    banner_unit character varying(255),
    banner_description character varying(255),
    banner_content text,
    banner_article uuid,
    gallery_title character varying(255),
    faq_tag character varying(255),
    faq_title character varying(255),
    faq_items json,
    articles_title character varying(255),
    docs_title character varying(255),
    test json,
    test_2 character varying(255)
);


ALTER TABLE public.services OWNER TO directus;

--
-- Name: services_articles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services_articles (
    id integer NOT NULL,
    services_id uuid,
    articles_id uuid
);


ALTER TABLE public.services_articles OWNER TO directus;

--
-- Name: services_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.services_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_articles_id_seq OWNER TO directus;

--
-- Name: services_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.services_articles_id_seq OWNED BY public.services_articles.id;


--
-- Name: services_docs; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services_docs (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    file uuid
);


ALTER TABLE public.services_docs OWNER TO directus;

--
-- Name: services_gallery; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services_gallery (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    description text,
    image uuid
);


ALTER TABLE public.services_gallery OWNER TO directus;

--
-- Name: services_services_docs; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services_services_docs (
    id integer NOT NULL,
    services_id uuid,
    services_docs_id uuid
);


ALTER TABLE public.services_services_docs OWNER TO directus;

--
-- Name: services_services_docs_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.services_services_docs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_services_docs_id_seq OWNER TO directus;

--
-- Name: services_services_docs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.services_services_docs_id_seq OWNED BY public.services_services_docs.id;


--
-- Name: services_services_gallery; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services_services_gallery (
    id integer NOT NULL,
    services_id uuid,
    services_gallery_id uuid
);


ALTER TABLE public.services_services_gallery OWNER TO directus;

--
-- Name: services_services_gallery_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.services_services_gallery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_services_gallery_id_seq OWNER TO directus;

--
-- Name: services_services_gallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.services_services_gallery_id_seq OWNED BY public.services_services_gallery.id;


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
-- Name: home_page_home_hero id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_hero ALTER COLUMN id SET DEFAULT nextval('public.home_page_home_hero_id_seq'::regclass);


--
-- Name: services_articles id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_articles ALTER COLUMN id SET DEFAULT nextval('public.services_articles_id_seq'::regclass);


--
-- Name: services_services_docs id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_docs ALTER COLUMN id SET DEFAULT nextval('public.services_services_docs_id_seq'::regclass);


--
-- Name: services_services_gallery id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_gallery ALTER COLUMN id SET DEFAULT nextval('public.services_services_gallery_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.articles (id, date_created, date_updated, title, content, cover) FROM stdin;
a84591e7-b802-422e-b279-dfe4b65ca1ed	2026-01-16 11:52:41.316+00	2026-01-16 11:53:41.761+00	Оптимизация производства: новые решения для вашего бизнеса	<h2>Введение</h2>\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\n<ol>\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\n</ol>\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto, provident tempora. Ipsam quo eum expedita. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\n<h2>Сертификаты и патенты</h2>\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta sunt quas ratione dolorem hic tempore labore dolorum quod eum distinctio? Quia consectetur libero cumque ipsam. Assumenda minima, quod ad magni libero, consequuntur fuga quos, quaerat quidem possimus facere laudantium nemo quasi odio sunt. Laboriosam beatae ducimus sapiente dolorum veritatis odit, sit autem pariatur animi exercitationem porro officiis excepturi. Corrupti nulla enim non consectetur voluptatibus eaque perspiciatis modi amet sunt quisquam, tempora corporis a eius dignissimos temporibus laboriosam deserunt commodi cupiditate id ipsam ipsa blanditiis? Enim esse, impedit qui deserunt culpa, officiis nostrum et iure in explicabo beatae harum molestias a, nemo eum blanditiis libero ratione dicta placeat. Ex, asperiores sed. Sapiente animi officia aliquam possimus eius unde laboriosam ad aut.</p>\n<p><img src="http://localhost:8055/assets/945e858e-7c9f-431a-81c1-0e2b69dd879c.jpg?width=1331&amp;height=2000" alt="Temp Image"></p>\n<h2>Что с остальными площадками</h2>\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\n<ul>\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\n</ul>\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\n<h2>Итог</h2>\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>	945e858e-7c9f-431a-81c1-0e2b69dd879c
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
a5db4067-66d0-48a6-add0-e4ef74a90341	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
84861c52-d13b-49d7-bea8-403696fde1e9	248b16cc-2f00-4d66-8c41-37ace87b3700	\N	78737d26-2431-4a63-b030-187e3a80ad7d	\N
cdd28041-a05a-447f-8dd2-210c72aaeea9	\N	d4295245-40c0-42d4-a8ab-bc53814683de	7a111883-0504-42cf-a632-eca505befeb4	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:48:36.331+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_users	77886b68-dd80-4e99-825c-6c747cad7e16	http://localhost:8055
2	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:48:39.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_settings	1	http://localhost:8055
3	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:49:23.364+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_users	77886b68-dd80-4e99-825c-6c747cad7e16	http://localhost:8055
4	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:51:17.737+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_files	eff7d61a-70b5-4056-9980-108f0827fa25	http://localhost:8055
5	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:51:24.092+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_users	77886b68-dd80-4e99-825c-6c747cad7e16	http://localhost:8055
6	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:52:48.636+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	1	http://localhost:8055
7	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:52:48.642+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	2	http://localhost:8055
8	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:52:48.648+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	3	http://localhost:8055
9	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:52:48.654+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_policies	7a111883-0504-42cf-a632-eca505befeb4	http://localhost:8055
10	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:52:48.659+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_access	cdd28041-a05a-447f-8dd2-210c72aaeea9	http://localhost:8055
11	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:52:48.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_users	d4295245-40c0-42d4-a8ab-bc53814683de	http://localhost:8055
12	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:53:13.823+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
13	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:53:13.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	2	http://localhost:8055
14	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:53:13.832+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
15	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:53:13.839+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
16	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:53:50.416+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
17	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:54:06.576+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
18	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:54:20.972+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
19	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:54:20.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
20	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:54:40.694+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
21	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:02.528+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	4	http://localhost:8055
22	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:02.533+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	5	http://localhost:8055
23	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:02.536+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	6	http://localhost:8055
24	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:02.543+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
25	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:27.334+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
26	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:31.954+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
27	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:31.963+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
28	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:31.972+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
29	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:45.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
30	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:45.957+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
31	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:45.963+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
32	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:55:54.544+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	test	http://localhost:8055
33	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:00.031+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
34	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:00.078+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
35	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:00.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
36	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:00.094+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	test	http://localhost:8055
37	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:04.738+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
38	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:04.743+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	test	http://localhost:8055
39	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:04.751+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
40	delete	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:10.379+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
53	delete	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:57:03.424+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	test	http://localhost:8055
41	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:27.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
42	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:38.864+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
43	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:38.874+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	test	http://localhost:8055
44	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:38.879+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
45	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:38.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
46	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:52.918+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
47	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:55.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page	http://localhost:8055
48	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:56.002+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	test	http://localhost:8055
49	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:56.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
50	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:56.022+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
51	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:56.03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
52	delete	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:56:59.763+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
54	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:57:10.318+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
55	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:57:10.325+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
56	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:57:15.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
57	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:57:15.356+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
58	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:57:28.542+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
59	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:07:49.676+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	7	http://localhost:8055
60	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:07:49.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_hero	http://localhost:8055
61	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:08:28.721+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
62	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:08:41.541+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
63	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:09:18.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	9	http://localhost:8055
64	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:10:48.328+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	10	http://localhost:8055
65	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:11:48.176+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_hero	http://localhost:8055
66	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:11:50.972+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_hero	http://localhost:8055
67	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:11:51.079+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
68	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:11:51.089+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
69	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:11:53.796+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_hero	http://localhost:8055
70	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:14:16.001+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
71	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:14:16.117+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	12	http://localhost:8055
72	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:14:16.123+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page_home_hero	http://localhost:8055
73	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:14:16.168+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	13	http://localhost:8055
74	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:14:16.227+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	14	http://localhost:8055
75	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.812+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	4	http://localhost:8055
76	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.817+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	5	http://localhost:8055
77	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.822+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	6	http://localhost:8055
78	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	7	http://localhost:8055
79	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.831+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_policies	7a111883-0504-42cf-a632-eca505befeb4	http://localhost:8055
80	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.838+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_access	cdd28041-a05a-447f-8dd2-210c72aaeea9	http://localhost:8055
81	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:49.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_users	d4295245-40c0-42d4-a8ab-bc53814683de	http://localhost:8055
82	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:55.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_page_home_hero	http://localhost:8055
83	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:55.941+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
84	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:15:55.948+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
85	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:24:45.144+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	8	http://localhost:8055
86	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:24:45.149+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
87	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:25.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_files	93633b0d-f4ae-446b-8c44-3fa11c67dca7	http://localhost:8055
88	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:51.513+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_files	945e858e-7c9f-431a-81c1-0e2b69dd879c	http://localhost:8055
89	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:55.722+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	home_hero	007afdd3-d37e-4f4d-b440-97f691b15c3b	http://localhost:8055
90	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:55.728+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	home_page_home_hero	1	http://localhost:8055
91	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:55.734+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	home_hero	779b9d7b-0f1d-4fba-8fbb-357c92c55a7d	http://localhost:8055
92	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:55.739+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	home_page_home_hero	2	http://localhost:8055
93	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:55.745+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	home_page	2d3e873e-75f2-4147-a0ed-a1aa76bd561d	http://localhost:8055
94	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:29:06.515+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_hero	http://localhost:8055
95	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:29:28.638+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	home_hero	http://localhost:8055
96	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 09:59:39.066+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
97	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 09:59:39.074+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
98	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 09:59:39.079+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
99	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 09:59:39.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
100	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:01:03.453+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
101	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:01:07.087+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
102	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:01:07.093+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
103	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:01:07.097+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
104	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:00.934+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
105	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:45.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
106	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:47.864+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
107	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:47.901+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
108	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:47.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
109	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:47.965+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
110	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:03:47.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
111	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:21.619+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	20	http://localhost:8055
112	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:23.425+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
113	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:23.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
114	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:23.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
115	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:23.454+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
116	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:23.474+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
117	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:04:23.486+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	20	http://localhost:8055
118	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:15.166+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
119	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.257+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
120	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
121	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.29+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
122	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.307+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
123	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
124	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.33+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	20	http://localhost:8055
125	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:18.341+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
126	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:06:32.078+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
127	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:27.957+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	22	http://localhost:8055
128	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.5+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
129	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.511+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
130	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.518+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
131	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.527+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
132	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.562+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
133	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.577+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	20	http://localhost:8055
134	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.593+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
135	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:07:31.602+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	22	http://localhost:8055
136	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:09:37.526+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
137	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:09.952+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	24	http://localhost:8055
138	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:12.042+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
139	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:12.051+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
140	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:12.059+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
141	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:12.065+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
142	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:12.075+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
143	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:10:12.082+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	24	http://localhost:8055
144	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:49.114+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	25	http://localhost:8055
145	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.687+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
146	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.694+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
147	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.702+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
148	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.711+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
149	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.724+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
150	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	24	http://localhost:8055
151	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:12:54.741+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	25	http://localhost:8055
152	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:17:53.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
153	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:19:58.108+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
154	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.454+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
155	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.464+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
156	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
157	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.506+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
159	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.52+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
160	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.534+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
158	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:20:00.508+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
161	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:51.9+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
162	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.575+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
163	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.583+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
164	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.595+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
165	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.611+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
166	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.612+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
167	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.627+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
168	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.629+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
169	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:21:54.64+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
170	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:38.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	29	http://localhost:8055
171	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.448+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
172	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.461+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
173	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.47+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
174	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.484+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
175	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.487+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
176	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.499+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
177	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.504+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
178	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.511+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
179	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:22:42.517+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	29	http://localhost:8055
180	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:48.673+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
181	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.904+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
182	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.912+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
183	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.925+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
184	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.933+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
185	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.947+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
186	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.949+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
187	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.956+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
188	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
189	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	29	http://localhost:8055
190	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:23:50.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
191	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:24:14.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
192	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:24:18.374+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
193	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:50.739+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	31	http://localhost:8055
194	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.702+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
195	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
196	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.722+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
197	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.729+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
198	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
199	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.746+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
200	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.761+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
201	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.762+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
202	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.787+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	29	http://localhost:8055
203	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.81+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
204	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:28:54.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	31	http://localhost:8055
205	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:31:23.318+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
206	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:36:57.743+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	33	http://localhost:8055
207	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.087+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
208	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.096+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
209	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
210	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.113+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
211	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.124+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	33	http://localhost:8055
212	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.127+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
213	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.143+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
214	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:00.153+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
215	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:20.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
216	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:20.175+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
217	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:20.181+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
218	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:20.185+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_gallery	http://localhost:8055
219	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:47.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
220	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:37:54.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
221	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:38:32.474+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
222	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:14.53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
223	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:18.763+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
238	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	33	http://localhost:8055
240	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.175+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
224	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:23.537+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_gallery	http://localhost:8055
225	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:23.621+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
226	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:23.625+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
227	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:23.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
228	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:39:50.706+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_gallery	http://localhost:8055
229	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:04.663+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
230	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:04.757+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
231	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:04.764+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_services_gallery	http://localhost:8055
232	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:04.808+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
233	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:04.901+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	43	http://localhost:8055
234	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.128+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
235	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.138+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
236	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.148+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
237	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
239	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.17+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
241	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.182+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
242	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:41:08.192+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
243	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:43:44.896+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
244	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:44:19.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_services_gallery	http://localhost:8055
245	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:44:19.765+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
246	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:44:19.77+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
247	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:44:19.776+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
248	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:56.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	45	http://localhost:8055
249	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:58.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
250	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.004+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
251	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
252	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.02+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
253	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.034+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
254	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.035+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	45	http://localhost:8055
263	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.734+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	45	http://localhost:8055
265	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.747+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	46	http://localhost:8055
255	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.045+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
256	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
257	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:45:59.081+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
258	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:22.843+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	46	http://localhost:8055
259	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
260	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.707+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
261	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.716+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
262	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.723+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
264	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.735+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
266	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.748+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
267	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.762+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
268	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:46:25.769+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
269	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:05.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	47	http://localhost:8055
270	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.678+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
271	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.688+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
272	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.693+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
273	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
274	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.719+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
275	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.721+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	45	http://localhost:8055
276	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.727+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
277	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.731+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	46	http://localhost:8055
278	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.736+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
279	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.74+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	47	http://localhost:8055
280	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:49:08.748+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
281	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:02.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
282	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:38.129+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	49	http://localhost:8055
283	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.035+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
284	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.047+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
285	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.056+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
286	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.067+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
287	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.079+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	49	http://localhost:8055
288	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
289	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.102+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
290	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.112+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
291	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.122+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
292	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:51:41.133+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
293	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:14.605+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	50	http://localhost:8055
294	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:14.72+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	51	http://localhost:8055
295	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:14.723+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_articles	http://localhost:8055
296	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:14.766+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	52	http://localhost:8055
297	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:14.86+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	53	http://localhost:8055
298	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.778+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
299	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.788+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
300	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.795+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
301	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
302	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.815+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
303	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.817+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	49	http://localhost:8055
304	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.826+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
305	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	50	http://localhost:8055
306	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
307	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.853+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
308	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:18.862+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
309	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:52:53.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	54	http://localhost:8055
310	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:55.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	55	http://localhost:8055
311	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.095+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
312	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.103+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
313	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.11+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
314	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.117+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
315	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.128+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
316	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.13+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	55	http://localhost:8055
317	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.141+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
318	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.15+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
319	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.162+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
320	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.171+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
321	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:53:57.18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	54	http://localhost:8055
322	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:25.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_gallery	http://localhost:8055
323	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:25.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_articles	http://localhost:8055
324	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:25.529+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
325	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:25.533+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
326	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:25.539+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
327	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:41.089+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	56	http://localhost:8055
328	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:41.092+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	57	http://localhost:8055
329	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:41.097+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	58	http://localhost:8055
330	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:54:41.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_docs	http://localhost:8055
331	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:55:13.691+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	59	http://localhost:8055
332	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:55:19.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	59	http://localhost:8055
333	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:55:50.008+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	60	http://localhost:8055
334	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:14.516+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_docs	http://localhost:8055
335	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:18.125+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_gallery	http://localhost:8055
336	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:18.131+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_articles	http://localhost:8055
337	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:18.138+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_docs	http://localhost:8055
338	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:18.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
339	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:18.209+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
340	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:18.215+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
341	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:20.471+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_docs	http://localhost:8055
342	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:58.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
343	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:58.387+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	62	http://localhost:8055
344	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:58.39+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_services_docs	http://localhost:8055
345	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:58.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	63	http://localhost:8055
346	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:56:58.535+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	64	http://localhost:8055
347	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.781+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
348	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.789+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
349	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.797+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
350	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.804+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
351	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.811+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
353	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.83+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
355	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.84+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
356	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.852+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
357	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.86+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
358	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.87+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	54	http://localhost:8055
363	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:59:43.472+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_settings	1	http://localhost:8055
352	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.824+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	55	http://localhost:8055
354	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:57:10.837+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
359	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:59:15.437+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services_services_docs	http://localhost:8055
360	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:59:15.499+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	services	http://localhost:8055
361	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:59:15.503+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
362	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 10:59:15.508+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	content	http://localhost:8055
364	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.519+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	9	http://localhost:8055
365	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.525+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	10	http://localhost:8055
366	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.529+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	11	http://localhost:8055
367	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	12	http://localhost:8055
368	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.537+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	13	http://localhost:8055
369	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.542+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_permissions	14	http://localhost:8055
370	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.545+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_policies	7a111883-0504-42cf-a632-eca505befeb4	http://localhost:8055
371	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_access	cdd28041-a05a-447f-8dd2-210c72aaeea9	http://localhost:8055
372	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:17:06.558+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_users	d4295245-40c0-42d4-a8ab-bc53814683de	http://localhost:8055
373	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:29:13.832+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_files	ceeff03b-bfb2-4087-8518-f4b8cdc873ce	http://localhost:8055
374	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.879+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_gallery	479d6f1e-6b5d-438c-88d9-40b597d08b30	http://localhost:8055
375	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.885+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_gallery	1	http://localhost:8055
376	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.89+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_gallery	487f12fa-bbc9-43a7-ba68-774b3e6cd5d3	http://localhost:8055
377	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.893+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_gallery	2	http://localhost:8055
378	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.896+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_gallery	ac4e3498-3f6d-4951-9f95-b9c6b94bef64	http://localhost:8055
379	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.902+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_gallery	3	http://localhost:8055
380	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.907+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_gallery	6e610eb7-8a62-4a9a-a909-af92e616e047	http://localhost:8055
381	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.909+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_gallery	4	http://localhost:8055
382	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.914+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_gallery	47e8b195-e62c-4ace-9028-a2a0f39ca31f	http://localhost:8055
383	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.918+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_gallery	5	http://localhost:8055
384	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.922+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_gallery	b4bfe25f-92e2-4431-844e-f3761b6fea53	http://localhost:8055
385	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_gallery	6	http://localhost:8055
386	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_docs	654e2b24-9544-4569-8311-6cd6384e89f4	http://localhost:8055
387	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.936+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_docs	1	http://localhost:8055
388	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.941+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_docs	e1cf9edb-522b-4c31-a964-1681d6dd181b	http://localhost:8055
389	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.944+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_docs	2	http://localhost:8055
390	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.951+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_docs	2b5c11da-eaed-4525-9991-08925dc248b1	http://localhost:8055
391	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.955+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_docs	3	http://localhost:8055
392	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_docs	8b9b2041-95fb-45a7-8afb-c97a5cd6e522	http://localhost:8055
393	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.962+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_docs	4	http://localhost:8055
394	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.967+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_docs	9e96ab51-6a9b-426c-81e6-45b7b762ce48	http://localhost:8055
395	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.969+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_services_docs	5	http://localhost:8055
396	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:03.973+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	http://localhost:8055
397	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:17.58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
398	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:23.695+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	45	http://localhost:8055
399	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:36:58.463+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	http://localhost:8055
400	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:38:37.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
401	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:39:00.489+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
402	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:48:30.984+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	65	http://localhost:8055
403	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:50:44.816+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
404	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:52:41.318+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	articles	a84591e7-b802-422e-b279-dfe4b65ca1ed	http://localhost:8055
405	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:32.257+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	67	http://localhost:8055
406	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:34.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	4	http://localhost:8055
407	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:34.89+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	5	http://localhost:8055
408	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:34.898+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	6	http://localhost:8055
409	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:34.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	67	http://localhost:8055
410	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:34.915+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	65	http://localhost:8055
411	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:34.926+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
412	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:53:41.763+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	articles	a84591e7-b802-422e-b279-dfe4b65ca1ed	http://localhost:8055
413	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:54:46.111+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_collections	articles	http://localhost:8055
414	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:55:10.064+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services_articles	1	http://localhost:8055
415	update	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:55:10.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	services	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	http://localhost:8055
416	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 12:47:07.676+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	68	http://localhost:8055
417	create	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 12:48:34.074+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
services_services_gallery	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	services_gallery	open	\N	f
home_page	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}]	\N	t	\N	\N	\N	all	\N	\N	1	content	open	\N	f
services_gallery	\N	\N	{{image.$thumbnail}}  |  {{title}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	services	open	\N	f
services_articles	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	services	open	\N	f
services_docs	\N	\N	{{file.$thumbnail}}  |  {{title}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	3	services	open	\N	f
services_services_docs	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	services_docs	open	\N	f
services	precision_manufacturing	\N	\N	f	f	[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}]	\N	t	\N	\N	\N	all	\N	\N	1	\N	open	\N	f
content	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	3	\N	open	\N	f
home_page_home_hero	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	home_hero	open	\N	f
home_hero	\N	\N	{{file.$thumbnail}}  |  {{title}}	t	f	[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}]	\N	t	\N	\N	\N	all	\N	\N	1	home_page	open	\N	f
articles	article	\N	{{cover.$thumbnail}}  |  {{title}}	f	f	[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}]	\N	t	\N	\N	\N	all	\N	\N	2	\N	open	\N	f
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
1	home_page	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
2	home_page	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
3	home_page	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
7	home_hero	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
8	home_hero	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок слайда"}]	\N	\N	t	\N	{"_and":[{"title":{"_nempty":true}}]}	\N
9	home_hero	subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Описание слайда"}]	\N	\N	t	\N	\N	\N
10	home_hero	file	file	file	\N	image	\N	f	f	4	full	[{"language":"ru-RU","translation":"Фоновое изображение/видео"}]	\N	\N	t	\N	\N	\N
11	home_page	hero	m2m	list-m2m	{"enableSelect":false}	related-values	\N	f	f	4	full	[{"language":"ru-RU","translation":"Слайдер"}]	\N	\N	t	\N	\N	\N
12	home_page_home_hero	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
13	home_page_home_hero	home_page_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
14	home_page_home_hero	home_hero_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
19	services	hero_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок"}]	\N	\N	t	hero	\N	\N
20	services	hero_subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Подзаголовок"}]	\N	\N	t	hero	\N	\N
21	services	hero_advant	cast-json	list	{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]}	labels	{"showAsDot":true,"choices":null}	f	f	3	full	[{"language":"ru-RU","translation":"Теги"}]	\N	\N	t	hero	\N	\N
22	services	hero_image	file	file-image	\N	image	\N	f	f	4	full	[{"language":"ru-RU","translation":"Фоновое изображение"}]	\N	\N	t	hero	\N	\N
37	services_gallery	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок слайда"}]	\N	\N	t	\N	\N	\N
4	articles	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
23	services	about	alias,no-data,group	group-detail	{"headerIcon":"text_ad"}	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Информационный блок"}]	\N	\N	f	\N	\N	\N
15	services	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
29	services	banner_description	\N	input	{"iconLeft":"text_fields"}	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Описание баннера"}]	\N	\N	f	banner	\N	\N
30	services	banner_content	\N	input-multiline	\N	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Текстовое содержание баннера"}]	\N	\N	f	banner	\N	\N
16	services	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
17	services	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
18	services	hero	alias,no-data,group	group-detail	{"headerIcon":"call_to_action"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Главный экран"}]	\N	\N	f	\N	\N	\N
34	services_gallery	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
24	services	about_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок информационного блока"}]	\N	\N	t	about	\N	\N
25	services	about_content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h1","h2","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","removeformat","customLink","customImage","hr","fullscreen"]}	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Содержание информационного блока"}]	\N	\N	t	about	\N	\N
35	services_gallery	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
38	services_gallery	description	\N	input-multiline	\N	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Описание слайда"}]	\N	\N	t	\N	\N	\N
31	services	banner_article	m2o	select-dropdown-m2o	{"enableCreate":false}	related-values	\N	f	f	5	full	[{"language":"ru-RU","translation":"Связанная статья"}]	Добавление кнопки с ссылкой на статью	\N	f	banner	\N	\N
40	services	gallery_slides	m2m	list-m2m	{"enableSelect":false}	related-values	\N	f	f	2	full	[{"language":"ru-RU","translation":"Слайды галереи"}]	\N	\N	f	gallery	\N	\N
27	services	banner_value	\N	input	{"iconLeft":"bar_chart_4_bars"}	formatted-value	\N	f	f	1	half	[{"language":"ru-RU","translation":"Заголовок баннера"}]	Предполагается какая либо числовая метрика	\N	f	banner	\N	\N
26	services	banner	alias,no-data,group	group-detail	{"headerIcon":"chat_info"}	\N	\N	f	f	6	full	[{"language":"ru-RU","translation":"Банер"}]	\N	\N	f	\N	\N	\N
36	services_gallery	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
39	services_gallery	image	file	file-image	\N	image	\N	f	f	6	full	[{"language":"ru-RU","translation":"Изображение слайда"}]	\N	\N	t	\N	\N	\N
41	services_services_gallery	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
42	services_services_gallery	services_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
43	services_services_gallery	services_gallery_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
28	services	banner_unit	\N	input	{"iconLeft":"wb_iridescent","softLength":5}	formatted-value	\N	f	f	2	half	[{"language":"ru-RU","translation":"Подзаголовок баннера"}]	Предполагается единица измерения числового значения	\N	f	banner	\N	\N
33	services	gallery_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок галереи"}]	\N	\N	f	gallery	\N	\N
44	services	faq	alias,no-data,group	group-detail	{"headerIcon":"question_mark"}	\N	\N	f	f	8	full	[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}]	\N	\N	f	\N	\N	\N
5	articles	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
6	articles	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
68	services	test	cast-json	input-block-editor	{"tools":["header","nestedlist","paragraph","code","image","attaches","table","quote","underline","inlinecode","checklist","raw"]}	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N
56	services_docs	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
57	services_docs	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
58	services_docs	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
69	services	test_2	\N	input-code	{"language":"JSON"}	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N
46	services	faq_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок блока"}]	\N	\N	f	faq	\N	\N
47	services	faq_items	cast-json	list	{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","numlist","bullist","forecolor","backcolor","customLink","customImage","hr","fullscreen"]}}}]}	formatted-json-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Карточки блока"}]	Блоки с частыми вопросами или информацией	\N	f	faq	\N	\N
59	services_docs	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Название документа"}]	\N	\N	t	\N	\N	\N
60	services_docs	file	file	file	\N	image	\N	f	f	5	full	[{"language":"ru-RU","translation":"Файл"}]	\N	\N	t	\N	\N	\N
51	services_articles	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
52	services_articles	services_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
53	services_articles	articles_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
49	services	articles_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок блока"}]	\N	\N	f	articles	\N	\N
50	services	articles_items	m2m	list-m2m	{"enableCreate":false}	related-values	\N	f	f	2	full	[{"language":"ru-RU","translation":"Статьи"}]	\N	\N	f	articles	\N	\N
62	services_services_docs	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
63	services_services_docs	services_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
64	services_services_docs	services_docs_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
55	services	docs_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок блока"}]	\N	\N	f	docs	\N	\N
61	services	docs_items	m2m	list-m2m	\N	related-values	\N	f	f	2	full	[{"language":"ru-RU","translation":"Документы/сертификаты"}]	\N	\N	f	docs	\N	\N
32	services	gallery	alias,no-data,group	group-detail	{"headerIcon":"transition_slide"}	\N	\N	f	f	7	full	[{"language":"ru-RU","translation":"Галерея карточек"}]	\N	\N	f	\N	\N	\N
48	services	articles	alias,no-data,group	group-detail	{"headerIcon":"article"}	\N	\N	f	f	9	full	[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}]	Ссылки на статьи по теме	\N	f	\N	\N	\N
54	services	docs	alias,no-data,group	group-detail	{"headerIcon":"docs"}	\N	\N	f	f	10	full	[{"language":"ru-RU","translation":"Документы и сертификаты"}]	\N	\N	f	\N	\N	\N
45	services	faq_tag	\N	input	{"iconLeft":"tag","softLength":25}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Тег блока"}]	Отображается над заголовком блока	\N	f	faq	\N	\N
67	articles	cover	file	file-image	\N	image	\N	f	f	4	full	[{"language":"ru-RU","translation":"Обложка статьи"}]	\N	\N	t	\N	\N	\N
65	articles	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Заголовок статьи"}]	\N	\N	t	\N	\N	\N
66	articles	content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","customLink","customImage","customMedia","hr","fullscreen"]}	formatted-value	\N	f	f	6	full	[{"language":"ru-RU","translation":"Контент статьи"}]	\N	\N	t	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
eff7d61a-70b5-4056-9980-108f0827fa25	local	eff7d61a-70b5-4056-9980-108f0827fa25.png	theplace.png	Theplace	image/png	\N	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 07:51:17.734+00	\N	2026-01-16 07:51:17.785+00	\N	1343	180	180	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-16 07:51:17.784+00
93633b0d-f4ae-446b-8c44-3fa11c67dca7	local	93633b0d-f4ae-446b-8c44-3fa11c67dca7.mp4	temp-video.mp4	Temp Video	video/mp4	\N	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:25.7+00	\N	2026-01-16 08:28:25.748+00	\N	1631105	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-01-16 08:28:25.747+00
945e858e-7c9f-431a-81c1-0e2b69dd879c	local	945e858e-7c9f-431a-81c1-0e2b69dd879c.jpg	temp-image.jpg	Temp Image	image/jpeg	\N	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 08:28:51.51+00	\N	2026-01-16 08:28:51.557+00	\N	283534	1331	2000	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-16 08:28:51.556+00
ceeff03b-bfb2-4087-8518-f4b8cdc873ce	local	ceeff03b-bfb2-4087-8518-f4b8cdc873ce.jpg	temp-image2.jpg	Temp Image2	image/jpeg	\N	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-16 11:29:13.831+00	\N	2026-01-16 11:29:13.872+00	\N	54071	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-16 11:29:13.871+00
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
20201028A	Remove Collection Foreign Keys	2026-01-16 07:46:34.94357+00
20201029A	Remove System Relations	2026-01-16 07:46:34.949775+00
20201029B	Remove System Collections	2026-01-16 07:46:34.95852+00
20201029C	Remove System Fields	2026-01-16 07:46:34.968176+00
20201105A	Add Cascade System Relations	2026-01-16 07:46:35.013493+00
20201105B	Change Webhook URL Type	2026-01-16 07:46:35.021406+00
20210225A	Add Relations Sort Field	2026-01-16 07:46:35.027783+00
20210304A	Remove Locked Fields	2026-01-16 07:46:35.031805+00
20210312A	Webhooks Collections Text	2026-01-16 07:46:35.039352+00
20210331A	Add Refresh Interval	2026-01-16 07:46:35.043032+00
20210415A	Make Filesize Nullable	2026-01-16 07:46:35.051339+00
20210416A	Add Collections Accountability	2026-01-16 07:46:35.056164+00
20210422A	Remove Files Interface	2026-01-16 07:46:35.059219+00
20210506A	Rename Interfaces	2026-01-16 07:46:35.081716+00
20210510A	Restructure Relations	2026-01-16 07:46:35.098442+00
20210518A	Add Foreign Key Constraints	2026-01-16 07:46:35.105155+00
20210519A	Add System Fk Triggers	2026-01-16 07:46:35.131414+00
20210521A	Add Collections Icon Color	2026-01-16 07:46:35.134757+00
20210525A	Add Insights	2026-01-16 07:46:35.15523+00
20210608A	Add Deep Clone Config	2026-01-16 07:46:35.158869+00
20210626A	Change Filesize Bigint	2026-01-16 07:46:35.17332+00
20210716A	Add Conditions to Fields	2026-01-16 07:46:35.177169+00
20210721A	Add Default Folder	2026-01-16 07:46:35.183957+00
20210802A	Replace Groups	2026-01-16 07:46:35.188616+00
20210803A	Add Required to Fields	2026-01-16 07:46:35.192026+00
20210805A	Update Groups	2026-01-16 07:46:35.197348+00
20210805B	Change Image Metadata Structure	2026-01-16 07:46:35.201676+00
20210811A	Add Geometry Config	2026-01-16 07:46:35.205145+00
20210831A	Remove Limit Column	2026-01-16 07:46:35.20856+00
20210903A	Add Auth Provider	2026-01-16 07:46:35.227196+00
20210907A	Webhooks Collections Not Null	2026-01-16 07:46:35.235079+00
20210910A	Move Module Setup	2026-01-16 07:46:35.239754+00
20210920A	Webhooks URL Not Null	2026-01-16 07:46:35.247034+00
20210924A	Add Collection Organization	2026-01-16 07:46:35.253377+00
20210927A	Replace Fields Group	2026-01-16 07:46:35.261977+00
20210927B	Replace M2M Interface	2026-01-16 07:46:35.264732+00
20210929A	Rename Login Action	2026-01-16 07:46:35.26747+00
20211007A	Update Presets	2026-01-16 07:46:35.274981+00
20211009A	Add Auth Data	2026-01-16 07:46:35.278274+00
20211016A	Add Webhook Headers	2026-01-16 07:46:35.281604+00
20211103A	Set Unique to User Token	2026-01-16 07:46:35.287832+00
20211103B	Update Special Geometry	2026-01-16 07:46:35.290862+00
20211104A	Remove Collections Listing	2026-01-16 07:46:35.294371+00
20211118A	Add Notifications	2026-01-16 07:46:35.311728+00
20211211A	Add Shares	2026-01-16 07:46:35.331926+00
20211230A	Add Project Descriptor	2026-01-16 07:46:35.335666+00
20220303A	Remove Default Project Color	2026-01-16 07:46:35.342957+00
20220308A	Add Bookmark Icon and Color	2026-01-16 07:46:35.346393+00
20220314A	Add Translation Strings	2026-01-16 07:46:35.349843+00
20220322A	Rename Field Typecast Flags	2026-01-16 07:46:35.354095+00
20220323A	Add Field Validation	2026-01-16 07:46:35.357599+00
20220325A	Fix Typecast Flags	2026-01-16 07:46:35.361919+00
20220325B	Add Default Language	2026-01-16 07:46:35.371843+00
20220402A	Remove Default Value Panel Icon	2026-01-16 07:46:35.379122+00
20220429A	Add Flows	2026-01-16 07:46:35.41594+00
20220429B	Add Color to Insights Icon	2026-01-16 07:46:35.419291+00
20220429C	Drop Non Null From IP of Activity	2026-01-16 07:46:35.42273+00
20220429D	Drop Non Null From Sender of Notifications	2026-01-16 07:46:35.426405+00
20220614A	Rename Hook Trigger to Event	2026-01-16 07:46:35.429815+00
20220801A	Update Notifications Timestamp Column	2026-01-16 07:46:35.437596+00
20220802A	Add Custom Aspect Ratios	2026-01-16 07:46:35.440913+00
20220826A	Add Origin to Accountability	2026-01-16 07:46:35.445676+00
20230401A	Update Material Icons	2026-01-16 07:46:35.453613+00
20230525A	Add Preview Settings	2026-01-16 07:46:35.456839+00
20230526A	Migrate Translation Strings	2026-01-16 07:46:35.473361+00
20230721A	Require Shares Fields	2026-01-16 07:46:35.482486+00
20230823A	Add Content Versioning	2026-01-16 07:46:35.506276+00
20230927A	Themes	2026-01-16 07:46:35.52625+00
20231009A	Update CSV Fields to Text	2026-01-16 07:46:35.531415+00
20231009B	Update Panel Options	2026-01-16 07:46:35.534528+00
20231010A	Add Extensions	2026-01-16 07:46:35.540889+00
20231215A	Add Focalpoints	2026-01-16 07:46:35.544387+00
20240122A	Add Report URL Fields	2026-01-16 07:46:35.547797+00
20240204A	Marketplace	2026-01-16 07:46:35.573449+00
20240305A	Change Useragent Type	2026-01-16 07:46:35.585083+00
20240311A	Deprecate Webhooks	2026-01-16 07:46:35.596582+00
20240422A	Public Registration	2026-01-16 07:46:35.603096+00
20240515A	Add Session Window	2026-01-16 07:46:35.607+00
20240701A	Add Tus Data	2026-01-16 07:46:35.610815+00
20240716A	Update Files Date Fields	2026-01-16 07:46:35.619278+00
20240806A	Permissions Policies	2026-01-16 07:46:35.666629+00
20240817A	Update Icon Fields Length	2026-01-16 07:46:35.695776+00
20240909A	Separate Comments	2026-01-16 07:46:35.709776+00
20240909B	Consolidate Content Versioning	2026-01-16 07:46:35.713189+00
20240924A	Migrate Legacy Comments	2026-01-16 07:46:35.720694+00
20240924B	Populate Versioning Deltas	2026-01-16 07:46:35.725813+00
20250224A	Visual Editor	2026-01-16 07:46:35.730645+00
20250609A	License Banner	2026-01-16 07:46:35.736652+00
20250613A	Add Project ID	2026-01-16 07:46:35.760733+00
20250718A	Add Direction	2026-01-16 07:46:35.765606+00
20250813A	Add MCP	2026-01-16 07:46:35.773578+00
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
1	directus_fields	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
2	directus_files	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
3	directus_relations	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
4	articles	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
5	home_hero	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
6	home_page	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
7	home_page_home_hero	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
8	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
9	services	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
10	services_articles	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
11	services_docs	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
12	services_gallery	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
13	services_services_docs	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
14	services_services_gallery	read	\N	\N	\N	*	7a111883-0504-42cf-a632-eca505befeb4
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
78737d26-2431-4a63-b030-187e3a80ad7d	Administrator	verified	$t:admin_description	\N	f	t	t
7a111883-0504-42cf-a632-eca505befeb4	read_only	badge	\N	\N	f	f	f
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	77886b68-dd80-4e99-825c-6c747cad7e16	\N	directus_users	\N	cards	{"cards":{"sort":["email"]}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":3}}	\N	\N	bookmark	\N
2	\N	77886b68-dd80-4e99-825c-6c747cad7e16	\N	services	\N	\N	{"tabular":{"fields":["hero_image","hero_title","hero_subtitle"]}}	{"tabular":{"widths":{"hero_image":54,"hero_title":346,"hero_subtitle":338}}}	\N	\N	bookmark	\N
3	\N	77886b68-dd80-4e99-825c-6c747cad7e16	\N	articles	\N	\N	{"tabular":{"fields":["cover.$thumbnail","title"]}}	{"tabular":{"widths":{"cover.$thumbnail":57,"title":651}}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	home_hero	file	directus_files	\N	\N	\N	\N	\N	nullify
2	home_page_home_hero	home_hero_id	home_hero	\N	\N	\N	home_page_id	\N	nullify
3	home_page_home_hero	home_page_id	home_page	hero	\N	\N	home_hero_id	\N	nullify
4	services	hero_image	directus_files	\N	\N	\N	\N	\N	nullify
5	services	banner_article	articles	\N	\N	\N	\N	\N	nullify
6	services_gallery	image	directus_files	\N	\N	\N	\N	\N	nullify
7	services_services_gallery	services_gallery_id	services_gallery	\N	\N	\N	services_id	\N	nullify
8	services_services_gallery	services_id	services	gallery_slides	\N	\N	services_gallery_id	\N	delete
9	services_articles	articles_id	articles	\N	\N	\N	services_id	\N	nullify
10	services_articles	services_id	services	articles_items	\N	\N	articles_id	\N	nullify
11	services_docs	file	directus_files	\N	\N	\N	\N	\N	nullify
12	services_services_docs	services_docs_id	services_docs	\N	\N	\N	services_id	\N	nullify
13	services_services_docs	services_id	services	docs_items	\N	\N	services_docs_id	\N	delete
14	articles	cover	directus_files	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019bc5c5-3a6e-7256-bd4c-4dfdee6ecf18","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"accepted_terms":true}	\N	\N
2	3	directus_users	77886b68-dd80-4e99-825c-6c747cad7e16	{"id":"77886b68-dd80-4e99-825c-6c747cad7e16","first_name":"Технический","last_name":"Аккаунт","email":"theplace2024@yandex.ru","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":"ru-RU","tfa_secret":null,"status":"active","role":"248b16cc-2f00-4d66-8c41-37ace87b3700","token":null,"last_access":"2026-01-16T07:48:36.336Z","last_page":"/users/77886b68-dd80-4e99-825c-6c747cad7e16","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"first_name":"Технический","last_name":"Аккаунт","language":"ru-RU"}	\N	\N
3	4	directus_files	eff7d61a-70b5-4056-9980-108f0827fa25	{"title":"Theplace","filename_download":"theplace.png","type":"image/png","storage":"local"}	{"title":"Theplace","filename_download":"theplace.png","type":"image/png","storage":"local"}	\N	\N
4	5	directus_users	77886b68-dd80-4e99-825c-6c747cad7e16	{"id":"77886b68-dd80-4e99-825c-6c747cad7e16","first_name":"Kulagin-Studio","last_name":null,"email":"theplace2024@yandex.ru","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":"eff7d61a-70b5-4056-9980-108f0827fa25","language":"ru-RU","tfa_secret":null,"status":"active","role":"248b16cc-2f00-4d66-8c41-37ace87b3700","token":null,"last_access":"2026-01-16T07:48:36.336Z","last_page":"/users/77886b68-dd80-4e99-825c-6c747cad7e16","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"first_name":"Kulagin-Studio","last_name":null,"avatar":"eff7d61a-70b5-4056-9980-108f0827fa25"}	\N	\N
5	6	directus_permissions	1	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"}	8	\N
6	7	directus_permissions	2	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	8	\N
7	8	directus_permissions	3	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}	8	\N
70	74	directus_fields	14	{"sort":3,"hidden":true,"collection":"home_page_home_hero","field":"home_hero_id"}	{"sort":3,"hidden":true,"collection":"home_page_home_hero","field":"home_hero_id"}	\N	\N
408	417	directus_fields	69	{"sort":12,"interface":"input-code","special":null,"options":{"language":"JSON"},"collection":"services","field":"test_2"}	{"sort":12,"interface":"input-code","special":null,"options":{"language":"JSON"},"collection":"services","field":"test_2"}	\N	\N
8	9	directus_policies	7a111883-0504-42cf-a632-eca505befeb4	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}],"update":[],"delete":[]}}	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}],"update":[],"delete":[]}}	9	\N
10	11	directus_users	d4295245-40c0-42d4-a8ab-bc53814683de	{"first_name":"frontend","policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]},"token":"**********"}	{"first_name":"frontend","policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]},"token":"**********"}	\N	\N
9	10	directus_access	cdd28041-a05a-447f-8dd2-210c72aaeea9	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"d4295245-40c0-42d4-a8ab-bc53814683de"}	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"},{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_relations","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"d4295245-40c0-42d4-a8ab-bc53814683de"}	10	\N
11	12	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_page"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_page"}	\N	\N
12	13	directus_fields	2	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"home_page"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"home_page"}	\N	\N
13	14	directus_fields	3	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"home_page"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"home_page"}	\N	\N
14	15	directus_collections	home_page	{"singleton":true,"collection":"home_page"}	{"singleton":true,"collection":"home_page"}	\N	\N
15	16	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}]}	\N	\N
16	17	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	\N	\N
17	18	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
18	19	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
19	20	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"collapse":"open"}	\N	\N
20	21	directus_fields	4	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"articles"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"articles"}	\N	\N
21	22	directus_fields	5	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"articles"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"articles"}	\N	\N
22	23	directus_fields	6	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"articles"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"articles"}	\N	\N
23	24	directus_collections	articles	{"singleton":true,"collection":"articles"}	{"singleton":true,"collection":"articles"}	\N	\N
24	25	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"article","translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}]}	\N	\N
39	41	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":null}	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":null}	\N	\N
40	42	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
41	43	directus_collections	test	{"collection":"test","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
42	44	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
43	45	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
44	46	directus_collections	content	{"collection":"content","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	{"collection":"content","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	\N	\N
45	47	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"content","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"content"}	\N	\N
46	48	directus_collections	test	{"collection":"test","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
47	49	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
48	50	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
49	51	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
50	54	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
51	55	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
25	26	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
26	27	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
27	28	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
28	29	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
29	30	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
30	31	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
31	32	directus_collections	test	{"collection":"test","icon":"folder","note":null,"color":null,"translations":null}	{"collection":"test","icon":"folder","note":null,"color":null,"translations":null}	\N	\N
32	33	directus_collections	home_page	{"collection":"home_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"test","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"test"}	\N	\N
33	34	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
34	35	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
35	36	directus_collections	test	{"collection":"test","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
36	37	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
37	38	directus_collections	test	{"collection":"test","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
38	39	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
52	56	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
53	57	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
54	58	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"singleton":false}	\N	\N
55	59	directus_fields	7	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_hero"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_hero"}	\N	\N
56	60	directus_collections	home_hero	{"singleton":false,"collection":"home_hero"}	{"singleton":false,"collection":"home_hero"}	\N	\N
57	61	directus_fields	8	{"sort":2,"interface":"input","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"home_hero","field":"title"}	{"sort":2,"interface":"input","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"home_hero","field":"title"}	\N	\N
58	62	directus_fields	8	{"id":8,"collection":"home_hero","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"note":null,"conditions":null,"required":true,"group":null,"validation":{"_and":[{"title":{"_nempty":true}}]},"validation_message":null}	{"collection":"home_hero","field":"title","validation":{"_and":[{"title":{"_nempty":true}}]}}	\N	\N
59	63	directus_fields	9	{"sort":3,"special":null,"interface":"input-multiline","required":true,"translations":[{"language":"ru-RU","translation":"Описание слайда"}],"display":"formatted-value","collection":"home_hero","field":"subtitle"}	{"sort":3,"special":null,"interface":"input-multiline","required":true,"translations":[{"language":"ru-RU","translation":"Описание слайда"}],"display":"formatted-value","collection":"home_hero","field":"subtitle"}	\N	\N
60	64	directus_fields	10	{"sort":4,"special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение/видео"}],"interface":"file","display":"image","collection":"home_hero","field":"file"}	{"sort":4,"special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение/видео"}],"interface":"file","display":"image","collection":"home_hero","field":"file"}	\N	\N
61	65	directus_collections	home_hero	{"collection":"home_hero","icon":null,"note":null,"display_template":"{{file.$thumbnail}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{file.$thumbnail}}{{title}}","translations":[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}]}	\N	\N
62	66	directus_collections	home_hero	{"collection":"home_hero","icon":null,"note":null,"display_template":"{{file.$thumbnail}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_page","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"home_page"}	\N	\N
63	67	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
64	68	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
65	69	directus_collections	home_hero	{"collection":"home_hero","icon":null,"note":null,"display_template":"{{file.$thumbnail}}{{title}}","hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_page","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
66	70	directus_fields	11	{"sort":4,"interface":"list-m2m","special":["m2m"],"required":true,"translations":[{"language":"ru-RU","translation":"Слайдер"}],"options":{"enableSelect":false},"display":"related-values","collection":"home_page","field":"hero"}	{"sort":4,"interface":"list-m2m","special":["m2m"],"required":true,"translations":[{"language":"ru-RU","translation":"Слайдер"}],"options":{"enableSelect":false},"display":"related-values","collection":"home_page","field":"hero"}	\N	\N
67	71	directus_fields	12	{"sort":1,"hidden":true,"field":"id","collection":"home_page_home_hero"}	{"sort":1,"hidden":true,"field":"id","collection":"home_page_home_hero"}	\N	\N
68	72	directus_collections	home_page_home_hero	{"hidden":true,"icon":"import_export","collection":"home_page_home_hero"}	{"hidden":true,"icon":"import_export","collection":"home_page_home_hero"}	\N	\N
69	73	directus_fields	13	{"sort":2,"hidden":true,"collection":"home_page_home_hero","field":"home_page_id"}	{"sort":2,"hidden":true,"collection":"home_page_home_hero","field":"home_page_id"}	\N	\N
71	75	directus_permissions	4	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"articles","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"articles","action":"read"}	\N	\N
72	76	directus_permissions	5	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_hero","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_hero","action":"read"}	\N	\N
73	77	directus_permissions	6	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page","action":"read"}	\N	\N
74	78	directus_permissions	7	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page_home_hero","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_page_home_hero","action":"read"}	\N	\N
75	80	directus_access	cdd28041-a05a-447f-8dd2-210c72aaeea9	{"id":"cdd28041-a05a-447f-8dd2-210c72aaeea9","role":null,"user":"d4295245-40c0-42d4-a8ab-bc53814683de","policy":"7a111883-0504-42cf-a632-eca505befeb4","sort":1}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4"}	\N	\N
76	82	directus_collections	home_page_home_hero	{"collection":"home_page_home_hero","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_hero","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"home_hero"}	\N	\N
77	83	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
78	84	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
79	85	directus_permissions	8	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
80	87	directus_files	93633b0d-f4ae-446b-8c44-3fa11c67dca7	{"title":"Temp Video","filename_download":"temp-video.mp4","type":"video/mp4","storage":"local"}	{"title":"Temp Video","filename_download":"temp-video.mp4","type":"video/mp4","storage":"local"}	\N	\N
81	88	directus_files	945e858e-7c9f-431a-81c1-0e2b69dd879c	{"title":"Temp Image","filename_download":"temp-image.jpg","type":"image/jpeg","storage":"local"}	{"title":"Temp Image","filename_download":"temp-image.jpg","type":"image/jpeg","storage":"local"}	\N	\N
82	89	home_hero	007afdd3-d37e-4f4d-b440-97f691b15c3b	{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"93633b0d-f4ae-446b-8c44-3fa11c67dca7"}	{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"93633b0d-f4ae-446b-8c44-3fa11c67dca7"}	83	\N
88	95	directus_collections	home_hero	{"collection":"home_hero","icon":null,"note":null,"display_template":"{{file.$thumbnail}}  |  {{title}}","hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_page","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{file.$thumbnail}}  |  {{title}}"}	\N	\N
361	368	directus_permissions	13	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_services_docs","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_services_docs","action":"read"}	\N	\N
362	369	directus_permissions	14	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_services_gallery","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_services_gallery","action":"read"}	\N	\N
363	371	directus_access	cdd28041-a05a-447f-8dd2-210c72aaeea9	{"id":"cdd28041-a05a-447f-8dd2-210c72aaeea9","role":null,"user":"d4295245-40c0-42d4-a8ab-bc53814683de","policy":"7a111883-0504-42cf-a632-eca505befeb4","sort":1}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4"}	\N	\N
383	392	services_docs	8b9b2041-95fb-45a7-8afb-c97a5cd6e522	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	384	\N
385	394	services_docs	9e96ab51-6a9b-426c-81e6-45b7b762ce48	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	386	\N
84	91	home_hero	779b9d7b-0f1d-4fba-8fbb-357c92c55a7d	{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	85	\N
86	93	home_page	2d3e873e-75f2-4147-a0ed-a1aa76bd561d	{"hero":{"create":[{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"93633b0d-f4ae-446b-8c44-3fa11c67dca7"}},{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}}],"update":[],"delete":[]}}	{"hero":{"create":[{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"93633b0d-f4ae-446b-8c44-3fa11c67dca7"}},{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}}],"update":[],"delete":[]}}	\N	\N
83	90	home_page_home_hero	1	{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"93633b0d-f4ae-446b-8c44-3fa11c67dca7"},"home_page_id":"2d3e873e-75f2-4147-a0ed-a1aa76bd561d"}	{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"93633b0d-f4ae-446b-8c44-3fa11c67dca7"},"home_page_id":"2d3e873e-75f2-4147-a0ed-a1aa76bd561d"}	86	\N
85	92	home_page_home_hero	2	{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"home_page_id":"2d3e873e-75f2-4147-a0ed-a1aa76bd561d"}	{"home_hero_id":{"title":"Решение нестандартных задач через стандартное оборудование","subtitle":"Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"home_page_id":"2d3e873e-75f2-4147-a0ed-a1aa76bd561d"}	86	\N
87	94	directus_collections	home_hero	{"collection":"home_hero","icon":null,"note":null,"display_template":"{{file.$thumbnail}} {{title}}","hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Хироскрин","singular":"Хироскрин","plural":"Хироскрины"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"home_page","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{file.$thumbnail}} {{title}}"}	\N	\N
89	96	directus_fields	15	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services"}	\N	\N
90	97	directus_fields	16	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services"}	\N	\N
91	98	directus_fields	17	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services"}	\N	\N
92	99	directus_collections	services	{"singleton":false,"collection":"services"}	{"singleton":false,"collection":"services"}	\N	\N
93	100	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"precision_manufacturing","translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}]}	\N	\N
94	101	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
95	102	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
96	103	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
97	104	directus_fields	18	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Главный экран"}],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"collection":"services","field":"hero"}	{"sort":4,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Главный экран"}],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"collection":"services","field":"hero"}	\N	\N
98	105	directus_fields	19	{"sort":5,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services","field":"hero_title"}	{"sort":5,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services","field":"hero_title"}	\N	\N
99	106	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
100	107	directus_fields	19	{"id":19,"collection":"services","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_title","sort":1,"group":"hero"}	\N	\N
101	108	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
102	109	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
103	110	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
104	111	directus_fields	20	{"sort":5,"special":null,"interface":"input-multiline","required":true,"translations":[{"language":"ru-RU","translation":"Подзаголовок"}],"display":"formatted-value","collection":"services","field":"hero_subtitle"}	{"sort":5,"special":null,"interface":"input-multiline","required":true,"translations":[{"language":"ru-RU","translation":"Подзаголовок"}],"display":"formatted-value","collection":"services","field":"hero_subtitle"}	\N	\N
105	112	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
106	113	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
107	114	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
108	115	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
364	373	directus_files	ceeff03b-bfb2-4087-8518-f4b8cdc873ce	{"title":"Temp Image2","filename_download":"temp-image2.jpg","type":"image/jpeg","storage":"local"}	{"title":"Temp Image2","filename_download":"temp-image2.jpg","type":"image/jpeg","storage":"local"}	\N	\N
109	116	directus_fields	19	{"id":19,"collection":"services","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_title","sort":1,"group":"hero"}	\N	\N
110	117	directus_fields	20	{"id":20,"collection":"services","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
111	118	directus_fields	21	{"sort":5,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Теги"}],"options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"formatted-json-value","collection":"services","field":"hero_advant"}	{"sort":5,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Теги"}],"options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"formatted-json-value","collection":"services","field":"hero_advant"}	\N	\N
112	119	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
113	120	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
114	121	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
115	122	directus_fields	19	{"id":19,"collection":"services","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_title","sort":1,"group":"hero"}	\N	\N
116	123	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
117	124	directus_fields	20	{"id":20,"collection":"services","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
118	125	directus_fields	21	{"id":21,"collection":"services","field":"hero_advant","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Теги"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_advant","sort":3,"group":"hero"}	\N	\N
119	126	directus_fields	21	{"id":21,"collection":"services","field":"hero_advant","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Теги"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_advant","required":true}	\N	\N
120	127	directus_fields	22	{"sort":5,"interface":"file-image","special":["file"],"required":true,"note":null,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"display":"image","collection":"services","field":"hero_image"}	{"sort":5,"interface":"file-image","special":["file"],"required":true,"note":null,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"display":"image","collection":"services","field":"hero_image"}	\N	\N
121	128	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
122	129	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
123	130	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
124	131	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
125	132	directus_fields	19	{"id":19,"collection":"services","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_title","sort":1,"group":"hero"}	\N	\N
126	133	directus_fields	20	{"id":20,"collection":"services","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
127	134	directus_fields	21	{"id":21,"collection":"services","field":"hero_advant","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Теги"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_advant","sort":3,"group":"hero"}	\N	\N
128	135	directus_fields	22	{"id":22,"collection":"services","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_image","sort":4,"group":"hero"}	\N	\N
129	136	directus_fields	23	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Информационный блок"}],"interface":"group-detail","options":{"headerIcon":"text_ad"},"collection":"services","field":"about"}	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Информационный блок"}],"interface":"group-detail","options":{"headerIcon":"text_ad"},"collection":"services","field":"about"}	\N	\N
130	137	directus_fields	24	{"sort":6,"interface":"input","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок информационного блока"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services","field":"about_title"}	{"sort":6,"interface":"input","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок информационного блока"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services","field":"about_title"}	\N	\N
131	138	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
132	139	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
133	140	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
134	141	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
135	142	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
136	143	directus_fields	24	{"id":24,"collection":"services","field":"about_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок информационного блока"}],"note":null,"conditions":null,"required":true,"group":"about","validation":null,"validation_message":null}	{"collection":"services","field":"about_title","sort":1,"group":"about"}	\N	\N
137	144	directus_fields	25	{"sort":6,"interface":"input-rich-text-html","special":null,"required":true,"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h1","h2","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","removeformat","customLink","customImage","hr","fullscreen"]},"translations":[{"language":"ru-RU","translation":"Содержание информационного блока"}],"display":"formatted-value","collection":"services","field":"about_content"}	{"sort":6,"interface":"input-rich-text-html","special":null,"required":true,"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h1","h2","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","removeformat","customLink","customImage","hr","fullscreen"]},"translations":[{"language":"ru-RU","translation":"Содержание информационного блока"}],"display":"formatted-value","collection":"services","field":"about_content"}	\N	\N
138	145	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
139	146	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
140	147	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
141	148	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
142	150	directus_fields	24	{"id":24,"collection":"services","field":"about_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок информационного блока"}],"note":null,"conditions":null,"required":true,"group":"about","validation":null,"validation_message":null}	{"collection":"services","field":"about_title","sort":1,"group":"about"}	\N	\N
143	149	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
144	151	directus_fields	25	{"id":25,"collection":"services","field":"about_content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h1","h2","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Содержание информационного блока"}],"note":null,"conditions":null,"required":true,"group":"about","validation":null,"validation_message":null}	{"collection":"services","field":"about_content","sort":2,"group":"about"}	\N	\N
145	152	directus_fields	26	{"sort":6,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Банер"}],"interface":"group-detail","options":{"headerIcon":"chat_info"},"collection":"services","field":"banner"}	{"sort":6,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Банер"}],"interface":"group-detail","options":{"headerIcon":"chat_info"},"collection":"services","field":"banner"}	\N	\N
146	153	directus_fields	27	{"sort":7,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","collection":"services","field":"banner_value"}	{"sort":7,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","collection":"services","field":"banner_value"}	\N	\N
147	154	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
148	155	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
149	156	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
150	157	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
152	159	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
153	160	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
151	158	directus_fields	27	{"id":27,"collection":"services","field":"banner_value","special":null,"interface":"input","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_value","sort":1,"group":"banner"}	\N	\N
154	161	directus_fields	28	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"wb_iridescent","softLength":5},"translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","display":"formatted-value","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"collection":"services","field":"banner_unit"}	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"wb_iridescent","softLength":5},"translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","display":"formatted-value","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"collection":"services","field":"banner_unit"}	\N	\N
155	162	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
156	163	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
157	164	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
158	165	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
159	166	directus_fields	27	{"id":27,"collection":"services","field":"banner_value","special":null,"interface":"input","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_value","sort":1,"group":"banner"}	\N	\N
160	167	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
161	168	directus_fields	28	{"id":28,"collection":"services","field":"banner_unit","special":null,"interface":"input","options":{"iconLeft":"wb_iridescent","softLength":5},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","conditions":null,"required":false,"group":"banner","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"validation_message":null}	{"collection":"services","field":"banner_unit","sort":2,"group":"banner"}	\N	\N
162	169	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
163	170	directus_fields	29	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"text_fields"},"translations":[{"language":"ru-RU","translation":"Описание баннера"}],"display":"formatted-value","collection":"services","field":"banner_description"}	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"text_fields"},"translations":[{"language":"ru-RU","translation":"Описание баннера"}],"display":"formatted-value","collection":"services","field":"banner_description"}	\N	\N
164	171	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
165	172	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
166	173	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
167	174	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
169	176	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
171	178	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
168	175	directus_fields	27	{"id":27,"collection":"services","field":"banner_value","special":null,"interface":"input","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_value","sort":1,"group":"banner"}	\N	\N
170	177	directus_fields	28	{"id":28,"collection":"services","field":"banner_unit","special":null,"interface":"input","options":{"iconLeft":"wb_iridescent","softLength":5},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","conditions":null,"required":false,"group":"banner","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"validation_message":null}	{"collection":"services","field":"banner_unit","sort":2,"group":"banner"}	\N	\N
172	179	directus_fields	29	{"id":29,"collection":"services","field":"banner_description","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_description","sort":3,"group":"banner"}	\N	\N
173	180	directus_fields	30	{"sort":7,"interface":"input-multiline","special":null,"translations":[{"language":"ru-RU","translation":"Текстовое содержание баннера"}],"display":"formatted-value","collection":"services","field":"banner_content"}	{"sort":7,"interface":"input-multiline","special":null,"translations":[{"language":"ru-RU","translation":"Текстовое содержание баннера"}],"display":"formatted-value","collection":"services","field":"banner_content"}	\N	\N
174	181	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
175	182	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
176	183	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
177	184	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
178	185	directus_fields	27	{"id":27,"collection":"services","field":"banner_value","special":null,"interface":"input","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_value","sort":1,"group":"banner"}	\N	\N
179	186	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
180	187	directus_fields	28	{"id":28,"collection":"services","field":"banner_unit","special":null,"interface":"input","options":{"iconLeft":"wb_iridescent","softLength":5},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","conditions":null,"required":false,"group":"banner","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"validation_message":null}	{"collection":"services","field":"banner_unit","sort":2,"group":"banner"}	\N	\N
181	188	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
182	189	directus_fields	29	{"id":29,"collection":"services","field":"banner_description","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_description","sort":3,"group":"banner"}	\N	\N
183	190	directus_fields	30	{"id":30,"collection":"services","field":"banner_content","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Текстовое содержание баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_content","sort":4,"group":"banner"}	\N	\N
184	191	directus_fields	27	{"id":27,"collection":"services","field":"banner_value","special":null,"interface":"input","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_value","width":"half"}	\N	\N
185	192	directus_fields	28	{"id":28,"collection":"services","field":"banner_unit","special":null,"interface":"input","options":{"iconLeft":"wb_iridescent","softLength":5},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","conditions":null,"required":false,"group":"banner","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"validation_message":null}	{"collection":"services","field":"banner_unit","width":"half"}	\N	\N
186	193	directus_fields	31	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableCreate":false},"translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Добавление кнопки с ссылкой на статью","display":"related-values","collection":"services","field":"banner_article"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableCreate":false},"translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Добавление кнопки с ссылкой на статью","display":"related-values","collection":"services","field":"banner_article"}	\N	\N
187	194	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
188	195	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
189	196	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
190	197	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
191	198	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
192	199	directus_fields	27	{"id":27,"collection":"services","field":"banner_value","special":null,"interface":"input","options":{"iconLeft":"bar_chart_4_bars"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":"Предполагается какая либо числовая метрика","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_value","sort":1,"group":"banner"}	\N	\N
193	200	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
194	201	directus_fields	28	{"id":28,"collection":"services","field":"banner_unit","special":null,"interface":"input","options":{"iconLeft":"wb_iridescent","softLength":5},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","conditions":null,"required":false,"group":"banner","validation":{"_and":[{"banner_unit":{"_lte":"5"}}]},"validation_message":null}	{"collection":"services","field":"banner_unit","sort":2,"group":"banner"}	\N	\N
195	202	directus_fields	29	{"id":29,"collection":"services","field":"banner_description","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_description","sort":3,"group":"banner"}	\N	\N
196	203	directus_fields	30	{"id":30,"collection":"services","field":"banner_content","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Текстовое содержание баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_content","sort":4,"group":"banner"}	\N	\N
406	415	services	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	{"id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409","date_created":"2026-01-16T11:36:03.870Z","date_updated":"2026-01-16T11:55:10.060Z","hero_title":"Электротехническое оборудование","hero_subtitle":"Пром комплект заказ (ПКЗ) занимается разработкой стандартов, обучением и поддержкой своих участников, а также популяризацией безопасных практик в этой области","hero_advant":[{"content":"100% соответствие характеристикам"},{"content":"От 1 ГВт до 100 000 ГВт"},{"content":"Помощь в продвижении продукции"},{"content":"Техническая поддержка 24/7"}],"hero_image":"945e858e-7c9f-431a-81c1-0e2b69dd879c","about_title":"Широкий выбор электротехнического оборудования","about_content":"<h2>Где используется</h2>\\n<p>Принципиальные схемы представляют собой графическое изображение всех компонентов и соединений системы, позволяя легко визуализировать ее структуру и функциональность.</p>\\n<p>Они помогают инженерам и проектировщикам полностью понять структуру и работу системы, быстро определять место возникновения проблемы, легко передавать информацию другим специалистам, таким как: монтажники, электрики или техническая поддержка</p>\\n<h2>Принципиальные особенности</h2>\\n<p>Компании &laquo;Пром Комплект Заказ&raquo; уже 21 год, а начинали мы свой путь с 2004 года как небольшое предприятие, специализирующееся на инженерных системах. За два десятилетия активной работы она выросла в одного из лидеров отрасли, завоевав доверие клиентов благодаря высокому качеству услуг и профессионализму своих сотрудников.</p>\\n<p>Вот несколько достижений, которыми мы гордимся:</p>\\n<ul>\\n<li>Получение сертификата качества ISO 9001;</li>\\n<li>Завоевание награды \\"Лучший поставщик года\\" в 2015, 2018,2019 годах;</li>\\n<li>Участие в крупных проектах инфраструктурного развития;</li>\\n<li>Развитие программы корпоративной социальной ответственности;</li>\\n<li>Открытие 3 филиалов в городах Казань, Сызрань, Тольятти.</li>\\n</ul>","banner_value":"5 000 000","banner_unit":"ГВт","banner_description":"(гигаватт)","banner_content":"Суммарная мощность нашего оборудования, которое мы поставили клиентам за 2025 год","banner_article":"a84591e7-b802-422e-b279-dfe4b65ca1ed","gallery_title":"Виды оборудования","faq_tag":"Этапы работы","faq_title":"Что включает ПОСТАВКА электротехнического оборудования","faq_items":[{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"}],"articles_title":"примеры решений","docs_title":"соответствует требованиям ТР ТС и Росстандарта","gallery_slides":[1,2,3,4,5,6],"articles_items":[1],"docs_items":[1,2,3,4,5]}	{"banner_article":"a84591e7-b802-422e-b279-dfe4b65ca1ed","date_updated":"2026-01-16T11:55:10.060Z"}	\N	\N
197	204	directus_fields	31	{"id":31,"collection":"services","field":"banner_article","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Добавление кнопки с ссылкой на статью","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_article","sort":5,"group":"banner"}	\N	\N
198	205	directus_fields	32	{"sort":7,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"collection":"services","field":"gallery"}	{"sort":7,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"collection":"services","field":"gallery"}	\N	\N
199	206	directus_fields	33	{"sort":8,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок галереи"}],"display":"formatted-value","collection":"services","field":"gallery_title"}	{"sort":8,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок галереи"}],"display":"formatted-value","collection":"services","field":"gallery_title"}	\N	\N
200	207	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
201	208	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
202	209	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
203	210	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
204	211	directus_fields	33	{"id":33,"collection":"services","field":"gallery_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок галереи"}],"note":null,"conditions":null,"required":false,"group":"gallery","validation":null,"validation_message":null}	{"collection":"services","field":"gallery_title","sort":1,"group":"gallery"}	\N	\N
205	212	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
206	213	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
207	214	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
208	215	directus_fields	34	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services_gallery"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services_gallery"}	\N	\N
209	216	directus_fields	35	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services_gallery"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services_gallery"}	\N	\N
210	217	directus_fields	36	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services_gallery"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services_gallery"}	\N	\N
211	218	directus_collections	services_gallery	{"singleton":false,"collection":"services_gallery"}	{"singleton":false,"collection":"services_gallery"}	\N	\N
212	219	directus_fields	37	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"display":"formatted-value","collection":"services_gallery","field":"title"}	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"display":"formatted-value","collection":"services_gallery","field":"title"}	\N	\N
213	220	directus_fields	37	{"id":37,"collection":"services_gallery","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок слайда"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services_gallery","field":"title","required":true}	\N	\N
214	221	directus_fields	38	{"sort":5,"interface":"input-multiline","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Описание слайда"}],"display":"formatted-value","collection":"services_gallery","field":"description"}	{"sort":5,"interface":"input-multiline","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Описание слайда"}],"display":"formatted-value","collection":"services_gallery","field":"description"}	\N	\N
215	222	directus_fields	39	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение слайда"}],"display":"image","collection":"services_gallery","field":"image"}	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение слайда"}],"display":"image","collection":"services_gallery","field":"image"}	\N	\N
216	223	directus_fields	39	{"id":39,"collection":"services_gallery","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение слайда"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services_gallery","field":"image","required":true}	\N	\N
231	238	directus_fields	33	{"id":33,"collection":"services","field":"gallery_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок галереи"}],"note":null,"conditions":null,"required":false,"group":"gallery","validation":null,"validation_message":null}	{"collection":"services","field":"gallery_title","sort":1,"group":"gallery"}	\N	\N
233	240	directus_fields	40	{"id":40,"collection":"services","field":"gallery_slides","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Слайды галереи"}],"note":null,"conditions":null,"required":false,"group":"gallery","validation":null,"validation_message":null}	{"collection":"services","field":"gallery_slides","sort":2,"group":"gallery"}	\N	\N
217	224	directus_collections	services_gallery	{"collection":"services_gallery","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"services"}	\N	\N
218	225	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
219	226	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
220	227	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
221	228	directus_collections	services_gallery	{"collection":"services_gallery","icon":null,"note":null,"display_template":"{{image.$thumbnail}}  |  {{title}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image.$thumbnail}}  |  {{title}}","hidden":true}	\N	\N
222	229	directus_fields	40	{"sort":8,"interface":"list-m2m","special":["m2m"],"options":{"enableSelect":false},"translations":[{"language":"ru-RU","translation":"Слайды галереи"}],"display":"related-values","collection":"services","field":"gallery_slides"}	{"sort":8,"interface":"list-m2m","special":["m2m"],"options":{"enableSelect":false},"translations":[{"language":"ru-RU","translation":"Слайды галереи"}],"display":"related-values","collection":"services","field":"gallery_slides"}	\N	\N
223	230	directus_fields	41	{"sort":1,"hidden":true,"field":"id","collection":"services_services_gallery"}	{"sort":1,"hidden":true,"field":"id","collection":"services_services_gallery"}	\N	\N
224	231	directus_collections	services_services_gallery	{"hidden":true,"icon":"import_export","collection":"services_services_gallery"}	{"hidden":true,"icon":"import_export","collection":"services_services_gallery"}	\N	\N
225	232	directus_fields	42	{"sort":2,"hidden":true,"collection":"services_services_gallery","field":"services_id"}	{"sort":2,"hidden":true,"collection":"services_services_gallery","field":"services_id"}	\N	\N
226	233	directus_fields	43	{"sort":3,"hidden":true,"collection":"services_services_gallery","field":"services_gallery_id"}	{"sort":3,"hidden":true,"collection":"services_services_gallery","field":"services_gallery_id"}	\N	\N
227	234	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
228	235	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
229	236	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
230	237	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
232	239	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
234	241	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
235	242	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
236	243	directus_fields	44	{"sort":8,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"interface":"group-detail","options":{"headerIcon":"question_mark"},"collection":"services","field":"faq"}	{"sort":8,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"interface":"group-detail","options":{"headerIcon":"question_mark"},"collection":"services","field":"faq"}	\N	\N
237	244	directus_collections	services_services_gallery	{"collection":"services_services_gallery","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"services_gallery","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"services_gallery"}	\N	\N
238	245	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
239	246	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
240	247	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
241	248	directus_fields	45	{"sort":9,"interface":"input","special":null,"options":{"iconLeft":"tag","softLength":25},"translations":[{"language":"ru-RU","translation":"Тег блока"}],"note":"Отображается над заголовком блока","display":"formatted-value","validation":{"_and":[{"faq_tag":{"_gte":"25"}}]},"collection":"services","field":"faq_tag"}	{"sort":9,"interface":"input","special":null,"options":{"iconLeft":"tag","softLength":25},"translations":[{"language":"ru-RU","translation":"Тег блока"}],"note":"Отображается над заголовком блока","display":"formatted-value","validation":{"_and":[{"faq_tag":{"_gte":"25"}}]},"collection":"services","field":"faq_tag"}	\N	\N
242	249	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
243	250	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
244	251	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
245	252	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
246	253	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
247	254	directus_fields	45	{"id":45,"collection":"services","field":"faq_tag","special":null,"interface":"input","options":{"iconLeft":"tag","softLength":25},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока"}],"note":"Отображается над заголовком блока","conditions":null,"required":false,"group":"faq","validation":{"_and":[{"faq_tag":{"_gte":"25"}}]},"validation_message":null}	{"collection":"services","field":"faq_tag","sort":1,"group":"faq"}	\N	\N
248	255	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
249	256	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
250	257	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
251	258	directus_fields	46	{"sort":9,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"services","field":"faq_title"}	{"sort":9,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"services","field":"faq_title"}	\N	\N
252	259	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
253	260	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
254	261	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
255	262	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
257	264	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
259	266	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
260	267	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
261	268	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
262	269	directus_fields	47	{"sort":9,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Карточки блока"}],"note":"Блоки с частыми вопросами или информацией","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","numlist","bullist","forecolor","backcolor","customLink","customImage","hr","fullscreen"]}}}]},"display":"formatted-json-value","collection":"services","field":"faq_items"}	{"sort":9,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Карточки блока"}],"note":"Блоки с частыми вопросами или информацией","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","numlist","bullist","forecolor","backcolor","customLink","customImage","hr","fullscreen"]}}}]},"display":"formatted-json-value","collection":"services","field":"faq_items"}	\N	\N
263	270	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
264	271	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
256	263	directus_fields	45	{"id":45,"collection":"services","field":"faq_tag","special":null,"interface":"input","options":{"iconLeft":"tag","softLength":25},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока"}],"note":"Отображается над заголовком блока","conditions":null,"required":false,"group":"faq","validation":{"_and":[{"faq_tag":{"_gte":"25"}}]},"validation_message":null}	{"collection":"services","field":"faq_tag","sort":1,"group":"faq"}	\N	\N
258	265	directus_fields	46	{"id":46,"collection":"services","field":"faq_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"services","field":"faq_title","sort":2,"group":"faq"}	\N	\N
265	272	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
266	273	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
267	274	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
268	275	directus_fields	45	{"id":45,"collection":"services","field":"faq_tag","special":null,"interface":"input","options":{"iconLeft":"tag","softLength":25},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока"}],"note":"Отображается над заголовком блока","conditions":null,"required":false,"group":"faq","validation":{"_and":[{"faq_tag":{"_gte":"25"}}]},"validation_message":null}	{"collection":"services","field":"faq_tag","sort":1,"group":"faq"}	\N	\N
269	276	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
270	277	directus_fields	46	{"id":46,"collection":"services","field":"faq_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"services","field":"faq_title","sort":2,"group":"faq"}	\N	\N
271	278	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
272	279	directus_fields	47	{"id":47,"collection":"services","field":"faq_items","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","numlist","bullist","forecolor","backcolor","customLink","customImage","hr","fullscreen"]}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Карточки блока"}],"note":"Блоки с частыми вопросами или информацией","conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"services","field":"faq_items","sort":3,"group":"faq"}	\N	\N
273	280	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
274	281	directus_fields	48	{"sort":9,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}],"note":"Ссылки на статьи по теме","interface":"group-detail","options":{"headerIcon":"article"},"collection":"services","field":"articles"}	{"sort":9,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}],"note":"Ссылки на статьи по теме","interface":"group-detail","options":{"headerIcon":"article"},"collection":"services","field":"articles"}	\N	\N
275	282	directus_fields	49	{"sort":10,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"services","field":"articles_title"}	{"sort":10,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"services","field":"articles_title"}	\N	\N
276	283	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
277	284	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
405	414	services_articles	1	{"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409","articles_id":{"id":"a84591e7-b802-422e-b279-dfe4b65ca1ed"}}	{"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409","articles_id":{"id":"a84591e7-b802-422e-b279-dfe4b65ca1ed"}}	406	\N
278	285	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
279	286	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
280	287	directus_fields	49	{"id":49,"collection":"services","field":"articles_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"articles","validation":null,"validation_message":null}	{"collection":"services","field":"articles_title","sort":1,"group":"articles"}	\N	\N
281	288	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
282	289	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
283	290	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
284	291	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
285	292	directus_fields	48	{"id":48,"collection":"services","field":"articles","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}],"note":"Ссылки на статьи по теме","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"articles","sort":9,"group":null}	\N	\N
286	293	directus_fields	50	{"sort":10,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"translations":[{"language":"ru-RU","translation":"Статьи"}],"display":"related-values","collection":"services","field":"articles_items"}	{"sort":10,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"translations":[{"language":"ru-RU","translation":"Статьи"}],"display":"related-values","collection":"services","field":"articles_items"}	\N	\N
287	294	directus_fields	51	{"sort":1,"hidden":true,"field":"id","collection":"services_articles"}	{"sort":1,"hidden":true,"field":"id","collection":"services_articles"}	\N	\N
288	295	directus_collections	services_articles	{"hidden":true,"icon":"import_export","collection":"services_articles"}	{"hidden":true,"icon":"import_export","collection":"services_articles"}	\N	\N
289	296	directus_fields	52	{"sort":2,"hidden":true,"collection":"services_articles","field":"services_id"}	{"sort":2,"hidden":true,"collection":"services_articles","field":"services_id"}	\N	\N
290	297	directus_fields	53	{"sort":3,"hidden":true,"collection":"services_articles","field":"articles_id"}	{"sort":3,"hidden":true,"collection":"services_articles","field":"articles_id"}	\N	\N
291	298	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
292	299	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
293	300	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
294	301	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
295	302	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
297	304	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
299	306	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
300	307	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
301	308	directus_fields	48	{"id":48,"collection":"services","field":"articles","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}],"note":"Ссылки на статьи по теме","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"articles","sort":9,"group":null}	\N	\N
302	309	directus_fields	54	{"sort":10,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Документы и сертификаты"}],"interface":"group-detail","options":{"headerIcon":"docs"},"collection":"services","field":"docs"}	{"sort":10,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Документы и сертификаты"}],"interface":"group-detail","options":{"headerIcon":"docs"},"collection":"services","field":"docs"}	\N	\N
303	310	directus_fields	55	{"sort":11,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"services","field":"docs_title"}	{"sort":11,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"services","field":"docs_title"}	\N	\N
304	311	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
305	312	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
306	313	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
307	314	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
308	315	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
310	317	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
311	318	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
296	303	directus_fields	49	{"id":49,"collection":"services","field":"articles_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"articles","validation":null,"validation_message":null}	{"collection":"services","field":"articles_title","sort":1,"group":"articles"}	\N	\N
298	305	directus_fields	50	{"id":50,"collection":"services","field":"articles_items","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Статьи"}],"note":null,"conditions":null,"required":false,"group":"articles","validation":null,"validation_message":null}	{"collection":"services","field":"articles_items","sort":2,"group":"articles"}	\N	\N
309	316	directus_fields	55	{"id":55,"collection":"services","field":"docs_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"docs","validation":null,"validation_message":null}	{"collection":"services","field":"docs_title","sort":1,"group":"docs"}	\N	\N
312	319	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
313	320	directus_fields	48	{"id":48,"collection":"services","field":"articles","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}],"note":"Ссылки на статьи по теме","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"articles","sort":9,"group":null}	\N	\N
314	321	directus_fields	54	{"id":54,"collection":"services","field":"docs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"docs"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Документы и сертификаты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"docs","sort":10,"group":null}	\N	\N
315	322	directus_collections	services_gallery	{"collection":"services_gallery","icon":null,"note":null,"display_template":"{{image.$thumbnail}}  |  {{title}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"services"}	\N	\N
316	323	directus_collections	services_articles	{"collection":"services_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"services"}	\N	\N
317	324	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
318	325	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
319	326	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
320	327	directus_fields	56	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services_docs"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services_docs"}	\N	\N
321	328	directus_fields	57	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services_docs"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services_docs"}	\N	\N
322	329	directus_fields	58	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services_docs"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services_docs"}	\N	\N
323	330	directus_collections	services_docs	{"singleton":false,"collection":"services_docs"}	{"singleton":false,"collection":"services_docs"}	\N	\N
324	331	directus_fields	59	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Название документа"}],"display":"formatted-value","collection":"services_docs","field":"title"}	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Название документа"}],"display":"formatted-value","collection":"services_docs","field":"title"}	\N	\N
325	332	directus_fields	59	{"id":59,"collection":"services_docs","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Название документа"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services_docs","field":"title","required":true}	\N	\N
326	333	directus_fields	60	{"sort":5,"interface":"file","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Файл"}],"display":"image","collection":"services_docs","field":"file"}	{"sort":5,"interface":"file","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Файл"}],"display":"image","collection":"services_docs","field":"file"}	\N	\N
327	334	directus_collections	services_docs	{"collection":"services_docs","icon":null,"note":null,"display_template":"{{file.$thumbnail}}  |  {{title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{file.$thumbnail}}  |  {{title}}"}	\N	\N
328	335	directus_collections	services_gallery	{"collection":"services_gallery","icon":null,"note":null,"display_template":"{{image.$thumbnail}}  |  {{title}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"services"}	\N	\N
329	336	directus_collections	services_articles	{"collection":"services_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"services"}	\N	\N
330	337	directus_collections	services_docs	{"collection":"services_docs","icon":null,"note":null,"display_template":"{{file.$thumbnail}}  |  {{title}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"services"}	\N	\N
331	338	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
332	339	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
333	340	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
334	341	directus_collections	services_docs	{"collection":"services_docs","icon":null,"note":null,"display_template":"{{file.$thumbnail}}  |  {{title}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"services","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
335	342	directus_fields	61	{"sort":11,"interface":"list-m2m","special":["m2m"],"translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"display":"related-values","collection":"services","field":"docs_items"}	{"sort":11,"interface":"list-m2m","special":["m2m"],"translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"display":"related-values","collection":"services","field":"docs_items"}	\N	\N
336	343	directus_fields	62	{"sort":1,"hidden":true,"field":"id","collection":"services_services_docs"}	{"sort":1,"hidden":true,"field":"id","collection":"services_services_docs"}	\N	\N
337	344	directus_collections	services_services_docs	{"hidden":true,"icon":"import_export","collection":"services_services_docs"}	{"hidden":true,"icon":"import_export","collection":"services_services_docs"}	\N	\N
338	345	directus_fields	63	{"sort":2,"hidden":true,"collection":"services_services_docs","field":"services_id"}	{"sort":2,"hidden":true,"collection":"services_services_docs","field":"services_id"}	\N	\N
339	346	directus_fields	64	{"sort":3,"hidden":true,"collection":"services_services_docs","field":"services_docs_id"}	{"sort":3,"hidden":true,"collection":"services_services_docs","field":"services_docs_id"}	\N	\N
340	347	directus_fields	15	{"id":15,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
341	348	directus_fields	16	{"id":16,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
342	349	directus_fields	17	{"id":17,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
343	350	directus_fields	18	{"id":18,"collection":"services","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"call_to_action"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"hero","sort":4,"group":null}	\N	\N
344	351	directus_fields	23	{"id":23,"collection":"services","field":"about","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"text_ad"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"about","sort":5,"group":null}	\N	\N
345	352	directus_fields	55	{"id":55,"collection":"services","field":"docs_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"docs","validation":null,"validation_message":null}	{"collection":"services","field":"docs_title","sort":1,"group":"docs"}	\N	\N
347	354	directus_fields	61	{"id":61,"collection":"services","field":"docs_items","special":["m2m"],"interface":"list-m2m","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"note":null,"conditions":null,"required":false,"group":"docs","validation":null,"validation_message":null}	{"collection":"services","field":"docs_items","sort":2,"group":"docs"}	\N	\N
346	353	directus_fields	26	{"id":26,"collection":"services","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"chat_info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Банер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"banner","sort":6,"group":null}	\N	\N
348	355	directus_fields	32	{"id":32,"collection":"services","field":"gallery","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"transition_slide"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея карточек"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"gallery","sort":7,"group":null}	\N	\N
349	356	directus_fields	44	{"id":44,"collection":"services","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Вопрос-Ответ\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"faq","sort":8,"group":null}	\N	\N
350	357	directus_fields	48	{"id":48,"collection":"services","field":"articles","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Связанные статьи\\""}],"note":"Ссылки на статьи по теме","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"articles","sort":9,"group":null}	\N	\N
351	358	directus_fields	54	{"id":54,"collection":"services","field":"docs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"docs"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Документы и сертификаты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"docs","sort":10,"group":null}	\N	\N
352	359	directus_collections	services_services_docs	{"collection":"services_services_docs","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"services_docs","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"services_docs"}	\N	\N
353	360	directus_collections	services	{"collection":"services","icon":"precision_manufacturing","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Оборудование","singular":"Оборудование","plural":"Оборудование"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
354	361	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
355	362	directus_collections	content	{"collection":"content","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
356	363	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#4E6A4C","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019bc5c5-3a6e-7256-bd4c-4dfdee6ecf18","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#4E6A4C"}	\N	\N
357	364	directus_permissions	9	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services","action":"read"}	\N	\N
358	365	directus_permissions	10	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_articles","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_articles","action":"read"}	\N	\N
359	366	directus_permissions	11	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_docs","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_docs","action":"read"}	\N	\N
360	367	directus_permissions	12	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_gallery","action":"read"}	{"policy":"7a111883-0504-42cf-a632-eca505befeb4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_gallery","action":"read"}	\N	\N
365	374	services_gallery	479d6f1e-6b5d-438c-88d9-40b597d08b30	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	366	\N
367	376	services_gallery	487f12fa-bbc9-43a7-ba68-774b3e6cd5d3	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	368	\N
369	378	services_gallery	ac4e3498-3f6d-4951-9f95-b9c6b94bef64	{"description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","title":"Lorem ipsum dolor sit amet","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","title":"Lorem ipsum dolor sit amet","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	370	\N
371	380	services_gallery	6e610eb7-8a62-4a9a-a909-af92e616e047	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	372	\N
373	382	services_gallery	47e8b195-e62c-4ace-9028-a2a0f39ca31f	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	374	\N
375	384	services_gallery	b4bfe25f-92e2-4431-844e-f3761b6fea53	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	376	\N
377	386	services_docs	654e2b24-9544-4569-8311-6cd6384e89f4	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	378	\N
379	388	services_docs	e1cf9edb-522b-4c31-a964-1681d6dd181b	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}	380	\N
381	390	services_docs	2b5c11da-eaed-4525-9991-08925dc248b1	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	382	\N
387	396	services	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	{"hero_title":"Электротехническое оборудование","hero_subtitle":"Пром комплект заказ (ПКЗ) занимается разработкой стандартов, обучением и поддержкой своих участников, а также популяризацией безопасных практик в этой области","hero_advant":[{"content":"100% соответствие характеристикам"},{"content":"От 1 ГВт до 100 000 ГВт"},{"content":"Помощь в продвижении продукции"},{"content":"Техническая поддержка 24/7"}],"hero_image":"945e858e-7c9f-431a-81c1-0e2b69dd879c","about_title":"Широкий выбор электротехнического оборудования","about_content":"<h2>Где используется</h2>\\n<p>Принципиальные схемы представляют собой графическое изображение всех компонентов и соединений системы, позволяя легко визуализировать ее структуру и функциональность.</p>\\n<p>Они помогают инженерам и проектировщикам полностью понять структуру и работу системы, быстро определять место возникновения проблемы, легко передавать информацию другим специалистам, таким как: монтажники, электрики или техническая поддержка</p>\\n<h2>Принципиальные особенности</h2>\\n<p>Компании &laquo;Пром Комплект Заказ&raquo; уже 21 год, а начинали мы свой путь с 2004 года как небольшое предприятие, специализирующееся на инженерных системах. За два десятилетия активной работы она выросла в одного из лидеров отрасли, завоевав доверие клиентов благодаря высокому качеству услуг и профессионализму своих сотрудников.</p>\\n<p>Вот несколько достижений, которыми мы гордимся:</p>\\n<ul>\\n<li>Получение сертификата качества ISO 9001;</li>\\n<li>Завоевание награды \\"Лучший поставщик года\\" в 2015, 2018,2019 годах;</li>\\n<li>Участие в крупных проектах инфраструктурного развития;</li>\\n<li>Развитие программы корпоративной социальной ответственности;</li>\\n<li>Открытие 3 филиалов в городах Казань, Сызрань, Тольятти.</li>\\n</ul>","banner_value":"5 000 000","banner_description":"(гигаватт)","banner_content":"Суммарная мощность нашего оборудования, которое мы поставили клиентам за 2025 год","gallery_title":"Виды оборудования","gallery_slides":{"create":[{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","title":"Lorem ipsum dolor sit amet","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}}],"update":[],"delete":[]},"faq_title":"Что включает ПОСТАВКА электротехнического оборудования","faq_items":[{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"}],"articles_title":"примеры решений","docs_title":"соответствует требованиям ТР ТС и Росстандарта","docs_items":{"create":[{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}}],"update":[],"delete":[]},"faq_tag":"25","banner_unit":"5"}	{"hero_title":"Электротехническое оборудование","hero_subtitle":"Пром комплект заказ (ПКЗ) занимается разработкой стандартов, обучением и поддержкой своих участников, а также популяризацией безопасных практик в этой области","hero_advant":[{"content":"100% соответствие характеристикам"},{"content":"От 1 ГВт до 100 000 ГВт"},{"content":"Помощь в продвижении продукции"},{"content":"Техническая поддержка 24/7"}],"hero_image":"945e858e-7c9f-431a-81c1-0e2b69dd879c","about_title":"Широкий выбор электротехнического оборудования","about_content":"<h2>Где используется</h2>\\n<p>Принципиальные схемы представляют собой графическое изображение всех компонентов и соединений системы, позволяя легко визуализировать ее структуру и функциональность.</p>\\n<p>Они помогают инженерам и проектировщикам полностью понять структуру и работу системы, быстро определять место возникновения проблемы, легко передавать информацию другим специалистам, таким как: монтажники, электрики или техническая поддержка</p>\\n<h2>Принципиальные особенности</h2>\\n<p>Компании &laquo;Пром Комплект Заказ&raquo; уже 21 год, а начинали мы свой путь с 2004 года как небольшое предприятие, специализирующееся на инженерных системах. За два десятилетия активной работы она выросла в одного из лидеров отрасли, завоевав доверие клиентов благодаря высокому качеству услуг и профессионализму своих сотрудников.</p>\\n<p>Вот несколько достижений, которыми мы гордимся:</p>\\n<ul>\\n<li>Получение сертификата качества ISO 9001;</li>\\n<li>Завоевание награды \\"Лучший поставщик года\\" в 2015, 2018,2019 годах;</li>\\n<li>Участие в крупных проектах инфраструктурного развития;</li>\\n<li>Развитие программы корпоративной социальной ответственности;</li>\\n<li>Открытие 3 филиалов в городах Казань, Сызрань, Тольятти.</li>\\n</ul>","banner_value":"5 000 000","banner_description":"(гигаватт)","banner_content":"Суммарная мощность нашего оборудования, которое мы поставили клиентам за 2025 год","gallery_title":"Виды оборудования","gallery_slides":{"create":[{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","title":"Lorem ipsum dolor sit amet","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}}],"update":[],"delete":[]},"faq_title":"Что включает ПОСТАВКА электротехнического оборудования","faq_items":[{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"}],"articles_title":"примеры решений","docs_title":"соответствует требованиям ТР ТС и Росстандарта","docs_items":{"create":[{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"}},{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}}],"update":[],"delete":[]},"faq_tag":"25","banner_unit":"5"}	\N	\N
366	375	services_services_gallery	1	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
368	377	services_services_gallery	2	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
370	379	services_services_gallery	3	{"services_gallery_id":{"description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","title":"Lorem ipsum dolor sit amet","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_gallery_id":{"description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","title":"Lorem ipsum dolor sit amet","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
372	381	services_services_gallery	4	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
374	383	services_services_gallery	5	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
376	385	services_services_gallery	6	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_gallery_id":{"title":"Lorem ipsum dolor sit amet","description":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.","image":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
378	387	services_services_docs	1	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
380	389	services_services_docs	2	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
382	391	services_services_docs	3	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
384	393	services_services_docs	4	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"ceeff03b-bfb2-4087-8518-f4b8cdc873ce"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
386	395	services_services_docs	5	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	{"services_docs_id":{"title":"Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi","file":"945e858e-7c9f-431a-81c1-0e2b69dd879c"},"services_id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409"}	387	\N
388	397	directus_fields	28	{"id":28,"collection":"services","field":"banner_unit","special":null,"interface":"input","options":{"iconLeft":"wb_iridescent","softLength":5},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Подзаголовок баннера"}],"note":"Предполагается единица измерения числового значения","conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"services","field":"banner_unit","validation":null}	\N	\N
389	398	directus_fields	45	{"id":45,"collection":"services","field":"faq_tag","special":null,"interface":"input","options":{"iconLeft":"tag","softLength":25},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока"}],"note":"Отображается над заголовком блока","conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"services","field":"faq_tag","validation":null}	\N	\N
390	399	services	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	{"id":"c19ec0b2-3f68-4ac0-8892-ca74d6ac0409","date_created":"2026-01-16T11:36:03.870Z","date_updated":"2026-01-16T11:36:58.460Z","hero_title":"Электротехническое оборудование","hero_subtitle":"Пром комплект заказ (ПКЗ) занимается разработкой стандартов, обучением и поддержкой своих участников, а также популяризацией безопасных практик в этой области","hero_advant":[{"content":"100% соответствие характеристикам"},{"content":"От 1 ГВт до 100 000 ГВт"},{"content":"Помощь в продвижении продукции"},{"content":"Техническая поддержка 24/7"}],"hero_image":"945e858e-7c9f-431a-81c1-0e2b69dd879c","about_title":"Широкий выбор электротехнического оборудования","about_content":"<h2>Где используется</h2>\\n<p>Принципиальные схемы представляют собой графическое изображение всех компонентов и соединений системы, позволяя легко визуализировать ее структуру и функциональность.</p>\\n<p>Они помогают инженерам и проектировщикам полностью понять структуру и работу системы, быстро определять место возникновения проблемы, легко передавать информацию другим специалистам, таким как: монтажники, электрики или техническая поддержка</p>\\n<h2>Принципиальные особенности</h2>\\n<p>Компании &laquo;Пром Комплект Заказ&raquo; уже 21 год, а начинали мы свой путь с 2004 года как небольшое предприятие, специализирующееся на инженерных системах. За два десятилетия активной работы она выросла в одного из лидеров отрасли, завоевав доверие клиентов благодаря высокому качеству услуг и профессионализму своих сотрудников.</p>\\n<p>Вот несколько достижений, которыми мы гордимся:</p>\\n<ul>\\n<li>Получение сертификата качества ISO 9001;</li>\\n<li>Завоевание награды \\"Лучший поставщик года\\" в 2015, 2018,2019 годах;</li>\\n<li>Участие в крупных проектах инфраструктурного развития;</li>\\n<li>Развитие программы корпоративной социальной ответственности;</li>\\n<li>Открытие 3 филиалов в городах Казань, Сызрань, Тольятти.</li>\\n</ul>","banner_value":"5 000 000","banner_unit":"ГВт","banner_description":"(гигаватт)","banner_content":"Суммарная мощность нашего оборудования, которое мы поставили клиентам за 2025 год","banner_article":null,"gallery_title":"Виды оборудования","faq_tag":"Этапы работы","faq_title":"Что включает ПОСТАВКА электротехнического оборудования","faq_items":[{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"}],"articles_title":"примеры решений","docs_title":"соответствует требованиям ТР ТС и Росстандарта","gallery_slides":[1,2,3,4,5,6],"articles_items":[],"docs_items":[1,2,3,4,5]}	{"banner_unit":"ГВт","faq_tag":"Этапы работы","date_updated":"2026-01-16T11:36:58.460Z"}	\N	\N
391	400	directus_fields	21	{"id":21,"collection":"services","field":"hero_advant","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Теги"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_advant","display":"labels"}	\N	\N
392	401	directus_fields	21	{"id":21,"collection":"services","field":"hero_advant","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"content","name":"content","type":"string","meta":{"field":"content","type":"string","required":true,"note":"Тег","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}}]},"display":"labels","display_options":{"showAsDot":true,"choices":null},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Теги"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"services","field":"hero_advant","display_options":{"showAsDot":true,"choices":null}}	\N	\N
393	402	directus_fields	65	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок статьи"}],"display":"formatted-value","collection":"articles","field":"title"}	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок статьи"}],"display":"formatted-value","collection":"articles","field":"title"}	\N	\N
394	403	directus_fields	66	{"sort":5,"interface":"input-rich-text-html","special":null,"required":true,"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","customLink","customImage","customMedia","hr","fullscreen"]},"translations":[{"language":"ru-RU","translation":"Контент статьи"}],"display":"formatted-value","collection":"articles","field":"content"}	{"sort":5,"interface":"input-rich-text-html","special":null,"required":true,"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","customLink","customImage","customMedia","hr","fullscreen"]},"translations":[{"language":"ru-RU","translation":"Контент статьи"}],"display":"formatted-value","collection":"articles","field":"content"}	\N	\N
407	416	directus_fields	68	{"sort":11,"interface":"input-block-editor","special":["cast-json"],"options":{"tools":["header","nestedlist","paragraph","code","image","attaches","table","quote","underline","inlinecode","checklist","raw"]},"collection":"services","field":"test"}	{"sort":11,"interface":"input-block-editor","special":["cast-json"],"options":{"tools":["header","nestedlist","paragraph","code","image","attaches","table","quote","underline","inlinecode","checklist","raw"]},"collection":"services","field":"test"}	\N	\N
395	404	articles	a84591e7-b802-422e-b279-dfe4b65ca1ed	{"title":"Оптимизация производства: новые решения для вашего бизнеса","content":"<h2>Введение</h2>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\\n<ol>\\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\\n</ol>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto, provident tempora. Ipsam quo eum expedita. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\\n<h2>Сертификаты и патенты</h2>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta sunt quas ratione dolorem hic tempore labore dolorum quod eum distinctio? Quia consectetur libero cumque ipsam. Assumenda minima, quod ad magni libero, consequuntur fuga quos, quaerat quidem possimus facere laudantium nemo quasi odio sunt. Laboriosam beatae ducimus sapiente dolorum veritatis odit, sit autem pariatur animi exercitationem porro officiis excepturi. Corrupti nulla enim non consectetur voluptatibus eaque perspiciatis modi amet sunt quisquam, tempora corporis a eius dignissimos temporibus laboriosam deserunt commodi cupiditate id ipsam ipsa blanditiis? Enim esse, impedit qui deserunt culpa, officiis nostrum et iure in explicabo beatae harum molestias a, nemo eum blanditiis libero ratione dicta placeat. Ex, asperiores sed. Sapiente animi officia aliquam possimus eius unde laboriosam ad aut.</p>\\n<p><img src=\\"http://localhost:8055/assets/945e858e-7c9f-431a-81c1-0e2b69dd879c.jpg?width=1331&amp;height=2000\\" alt=\\"Temp Image\\"></p>\\n<h2>Что с остальными площадками</h2>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<ul>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n</ul>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<h2>Итог</h2>\\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>\\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>"}	{"title":"Оптимизация производства: новые решения для вашего бизнеса","content":"<h2>Введение</h2>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\\n<ol>\\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\\n</ol>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto, provident tempora. Ipsam quo eum expedita. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\\n<h2>Сертификаты и патенты</h2>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta sunt quas ratione dolorem hic tempore labore dolorum quod eum distinctio? Quia consectetur libero cumque ipsam. Assumenda minima, quod ad magni libero, consequuntur fuga quos, quaerat quidem possimus facere laudantium nemo quasi odio sunt. Laboriosam beatae ducimus sapiente dolorum veritatis odit, sit autem pariatur animi exercitationem porro officiis excepturi. Corrupti nulla enim non consectetur voluptatibus eaque perspiciatis modi amet sunt quisquam, tempora corporis a eius dignissimos temporibus laboriosam deserunt commodi cupiditate id ipsam ipsa blanditiis? Enim esse, impedit qui deserunt culpa, officiis nostrum et iure in explicabo beatae harum molestias a, nemo eum blanditiis libero ratione dicta placeat. Ex, asperiores sed. Sapiente animi officia aliquam possimus eius unde laboriosam ad aut.</p>\\n<p><img src=\\"http://localhost:8055/assets/945e858e-7c9f-431a-81c1-0e2b69dd879c.jpg?width=1331&amp;height=2000\\" alt=\\"Temp Image\\"></p>\\n<h2>Что с остальными площадками</h2>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<ul>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n</ul>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<h2>Итог</h2>\\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>\\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>"}	\N	\N
396	405	directus_fields	67	{"sort":6,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Обложка статьи"}],"display":"image","collection":"articles","field":"cover"}	{"sort":6,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Обложка статьи"}],"display":"image","collection":"articles","field":"cover"}	\N	\N
397	406	directus_fields	4	{"id":4,"collection":"articles","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"id","sort":1,"group":null}	\N	\N
398	407	directus_fields	5	{"id":5,"collection":"articles","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"date_created","sort":2,"group":null}	\N	\N
399	408	directus_fields	6	{"id":6,"collection":"articles","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"date_updated","sort":3,"group":null}	\N	\N
400	409	directus_fields	67	{"id":67,"collection":"articles","field":"cover","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Обложка статьи"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"cover","sort":4,"group":null}	\N	\N
401	410	directus_fields	65	{"id":65,"collection":"articles","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок статьи"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"title","sort":5,"group":null}	\N	\N
402	411	directus_fields	66	{"id":66,"collection":"articles","field":"content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","forecolor","backcolor","customLink","customImage","customMedia","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Контент статьи"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"content","sort":6,"group":null}	\N	\N
403	412	articles	a84591e7-b802-422e-b279-dfe4b65ca1ed	{"id":"a84591e7-b802-422e-b279-dfe4b65ca1ed","date_created":"2026-01-16T11:52:41.316Z","date_updated":"2026-01-16T11:53:41.761Z","title":"Оптимизация производства: новые решения для вашего бизнеса","content":"<h2>Введение</h2>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\\n<ol>\\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\\n<li>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda provident distinctio molestiae obcaecati aut impedit!</li>\\n</ol>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto, provident tempora. Ipsam quo eum expedita. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis delectus explicabo maiores, eaque eius aliquid sint quas, culpa illo, repellendus officia! Tenetur tempora quidem incidunt!</p>\\n<h2>Сертификаты и патенты</h2>\\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta sunt quas ratione dolorem hic tempore labore dolorum quod eum distinctio? Quia consectetur libero cumque ipsam. Assumenda minima, quod ad magni libero, consequuntur fuga quos, quaerat quidem possimus facere laudantium nemo quasi odio sunt. Laboriosam beatae ducimus sapiente dolorum veritatis odit, sit autem pariatur animi exercitationem porro officiis excepturi. Corrupti nulla enim non consectetur voluptatibus eaque perspiciatis modi amet sunt quisquam, tempora corporis a eius dignissimos temporibus laboriosam deserunt commodi cupiditate id ipsam ipsa blanditiis? Enim esse, impedit qui deserunt culpa, officiis nostrum et iure in explicabo beatae harum molestias a, nemo eum blanditiis libero ratione dicta placeat. Ex, asperiores sed. Sapiente animi officia aliquam possimus eius unde laboriosam ad aut.</p>\\n<p><img src=\\"http://localhost:8055/assets/945e858e-7c9f-431a-81c1-0e2b69dd879c.jpg?width=1331&amp;height=2000\\" alt=\\"Temp Image\\"></p>\\n<h2>Что с остальными площадками</h2>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<ul>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Dolores dolor totam nostrum corrupti! Officia vitae accusantium asperiores omnis accusamus adipisci obcaecati, recusandae ex consequatur nam. Nemo amet suscipit perferendis obcaecati?</li>\\n</ul>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eligendi quas sunt rerum dignissimos, nostrum error iusto dolore, laboriosam, repellat molestiae quisquam. Nam quaerat amet distinctio ratione sint maxime temporibus dolorem?</p>\\n<h2>Итог</h2>\\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>\\n<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Totam fugiat iusto fugit quos ipsa voluptatum ipsam deserunt. Numquam quaerat deserunt quisquam quis. Blanditiis qui animi reprehenderit cum est perferendis vero?</p>","cover":"945e858e-7c9f-431a-81c1-0e2b69dd879c"}	{"cover":"945e858e-7c9f-431a-81c1-0e2b69dd879c","date_updated":"2026-01-16T11:53:41.761Z"}	\N	\N
404	413	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{cover.$thumbnail}}  |  {{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{cover.$thumbnail}}  |  {{title}}"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
248b16cc-2f00-4d66-8c41-37ace87b3700	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
qGhK8MprsoGESY0_rU78Sn7v0IdtpJ4JASWkekcyKB8Qir5TYbgLrHunC7OuuBQ9	77886b68-dd80-4e99-825c-6c747cad7e16	2026-01-23 07:48:36.32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 OPR/125.0.0.0 (Edition std-2)	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Directus	\N	#4E6A4C	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	019bc5c5-3a6e-7256-bd4c-4dfdee6ecf18	f	f	\N	t	\N
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
d4295245-40c0-42d4-a8ab-bc53814683de	frontend	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	active	\N	pXigLqp37qP0zo67TGZCIDQEhVOmU6NQ	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N	auto
77886b68-dd80-4e99-825c-6c747cad7e16	Kulagin-Studio	\N	theplace2024@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$TkZnwy98cdN5gxkQkzAQqA$/5dxiCkQ7tCOf7ckA0saGVur2EJQk2cpMFZAZEPBDWY	\N	\N	\N	\N	eff7d61a-70b5-4056-9980-108f0827fa25	ru-RU	\N	active	248b16cc-2f00-4d66-8c41-37ace87b3700	\N	2026-01-16 07:48:36.336+00	/content/services/c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	default	\N	\N	t	\N	\N	\N	\N	\N	auto
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
-- Data for Name: home_hero; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_hero (id, title, subtitle, file) FROM stdin;
007afdd3-d37e-4f4d-b440-97f691b15c3b	Решение нестандартных задач через стандартное оборудование	Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу	93633b0d-f4ae-446b-8c44-3fa11c67dca7
779b9d7b-0f1d-4fba-8fbb-357c92c55a7d	Решение нестандартных задач через стандартное оборудование	Отправьте нам техническое задание — мы подберем и доставим оборудование под вашу задачу	945e858e-7c9f-431a-81c1-0e2b69dd879c
\.


--
-- Data for Name: home_page; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_page (id, date_created, date_updated) FROM stdin;
2d3e873e-75f2-4147-a0ed-a1aa76bd561d	2026-01-16 08:28:55.715+00	\N
\.


--
-- Data for Name: home_page_home_hero; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_page_home_hero (id, home_page_id, home_hero_id) FROM stdin;
1	2d3e873e-75f2-4147-a0ed-a1aa76bd561d	007afdd3-d37e-4f4d-b440-97f691b15c3b
2	2d3e873e-75f2-4147-a0ed-a1aa76bd561d	779b9d7b-0f1d-4fba-8fbb-357c92c55a7d
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services (id, date_created, date_updated, hero_title, hero_subtitle, hero_advant, hero_image, about_title, about_content, banner_value, banner_unit, banner_description, banner_content, banner_article, gallery_title, faq_tag, faq_title, faq_items, articles_title, docs_title, test, test_2) FROM stdin;
c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	2026-01-16 11:36:03.87+00	2026-01-16 11:55:10.06+00	Электротехническое оборудование	Пром комплект заказ (ПКЗ) занимается разработкой стандартов, обучением и поддержкой своих участников, а также популяризацией безопасных практик в этой области	[{"content":"100% соответствие характеристикам"},{"content":"От 1 ГВт до 100 000 ГВт"},{"content":"Помощь в продвижении продукции"},{"content":"Техническая поддержка 24/7"}]	945e858e-7c9f-431a-81c1-0e2b69dd879c	Широкий выбор электротехнического оборудования	<h2>Где используется</h2>\n<p>Принципиальные схемы представляют собой графическое изображение всех компонентов и соединений системы, позволяя легко визуализировать ее структуру и функциональность.</p>\n<p>Они помогают инженерам и проектировщикам полностью понять структуру и работу системы, быстро определять место возникновения проблемы, легко передавать информацию другим специалистам, таким как: монтажники, электрики или техническая поддержка</p>\n<h2>Принципиальные особенности</h2>\n<p>Компании &laquo;Пром Комплект Заказ&raquo; уже 21 год, а начинали мы свой путь с 2004 года как небольшое предприятие, специализирующееся на инженерных системах. За два десятилетия активной работы она выросла в одного из лидеров отрасли, завоевав доверие клиентов благодаря высокому качеству услуг и профессионализму своих сотрудников.</p>\n<p>Вот несколько достижений, которыми мы гордимся:</p>\n<ul>\n<li>Получение сертификата качества ISO 9001;</li>\n<li>Завоевание награды "Лучший поставщик года" в 2015, 2018,2019 годах;</li>\n<li>Участие в крупных проектах инфраструктурного развития;</li>\n<li>Развитие программы корпоративной социальной ответственности;</li>\n<li>Открытие 3 филиалов в городах Казань, Сызрань, Тольятти.</li>\n</ul>	5 000 000	ГВт	(гигаватт)	Суммарная мощность нашего оборудования, которое мы поставили клиентам за 2025 год	a84591e7-b802-422e-b279-dfe4b65ca1ed	Виды оборудования	Этапы работы	Что включает ПОСТАВКА электротехнического оборудования	[{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"},{"title":"Подбор оборудования и техническое сопровождение проекта","content":"<ul>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n<li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae quibusdam harum ea facere! Dolores at perspiciatis suscipit consectetur aperiam dolore blanditiis nobis repellendus atque voluptatem!</li>\\n</ul>"}]	примеры решений	соответствует требованиям ТР ТС и Росстандарта	\N	\N
\.


--
-- Data for Name: services_articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services_articles (id, services_id, articles_id) FROM stdin;
1	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	a84591e7-b802-422e-b279-dfe4b65ca1ed
\.


--
-- Data for Name: services_docs; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services_docs (id, date_created, date_updated, title, file) FROM stdin;
654e2b24-9544-4569-8311-6cd6384e89f4	2026-01-16 11:36:03.928+00	\N	Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi	945e858e-7c9f-431a-81c1-0e2b69dd879c
e1cf9edb-522b-4c31-a964-1681d6dd181b	2026-01-16 11:36:03.94+00	\N	Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
2b5c11da-eaed-4525-9991-08925dc248b1	2026-01-16 11:36:03.95+00	\N	Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi	945e858e-7c9f-431a-81c1-0e2b69dd879c
8b9b2041-95fb-45a7-8afb-c97a5cd6e522	2026-01-16 11:36:03.957+00	\N	Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
9e96ab51-6a9b-426c-81e6-45b7b762ce48	2026-01-16 11:36:03.966+00	\N	Lorem ipsum, dolor sit amet consectetur adipisicing eli nisi	945e858e-7c9f-431a-81c1-0e2b69dd879c
\.


--
-- Data for Name: services_gallery; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services_gallery (id, date_created, date_updated, title, description, image) FROM stdin;
479d6f1e-6b5d-438c-88d9-40b597d08b30	2026-01-16 11:36:03.877+00	\N	Lorem ipsum dolor sit amet	Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
487f12fa-bbc9-43a7-ba68-774b3e6cd5d3	2026-01-16 11:36:03.889+00	\N	Lorem ipsum dolor sit amet	Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
ac4e3498-3f6d-4951-9f95-b9c6b94bef64	2026-01-16 11:36:03.895+00	\N	Lorem ipsum dolor sit amet	Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
6e610eb7-8a62-4a9a-a909-af92e616e047	2026-01-16 11:36:03.906+00	\N	Lorem ipsum dolor sit amet	Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
47e8b195-e62c-4ace-9028-a2a0f39ca31f	2026-01-16 11:36:03.912+00	\N	Lorem ipsum dolor sit amet	Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
b4bfe25f-92e2-4431-844e-f3761b6fea53	2026-01-16 11:36:03.921+00	\N	Lorem ipsum dolor sit amet	Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus mollitia, non atque eligendi iste, necessitatibus voluptatem dolore fuga illum quis ullam unde neque culpa voluptatum amet quo! Quam consequuntur commodi laborum, molestiae quidem veritatis fugiat. Mollitia magnam soluta facilis doloremque reprehenderit nostrum veritatis facere nihil tempora, fugiat deleniti suscipit autem ullam ad.	ceeff03b-bfb2-4087-8518-f4b8cdc873ce
\.


--
-- Data for Name: services_services_docs; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services_services_docs (id, services_id, services_docs_id) FROM stdin;
1	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	654e2b24-9544-4569-8311-6cd6384e89f4
2	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	e1cf9edb-522b-4c31-a964-1681d6dd181b
3	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	2b5c11da-eaed-4525-9991-08925dc248b1
4	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	8b9b2041-95fb-45a7-8afb-c97a5cd6e522
5	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	9e96ab51-6a9b-426c-81e6-45b7b762ce48
\.


--
-- Data for Name: services_services_gallery; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services_services_gallery (id, services_id, services_gallery_id) FROM stdin;
1	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	479d6f1e-6b5d-438c-88d9-40b597d08b30
2	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	487f12fa-bbc9-43a7-ba68-774b3e6cd5d3
3	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	ac4e3498-3f6d-4951-9f95-b9c6b94bef64
4	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	6e610eb7-8a62-4a9a-a909-af92e616e047
5	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	47e8b195-e62c-4ace-9028-a2a0f39ca31f
6	c19ec0b2-3f68-4ac0-8892-ca74d6ac0409	b4bfe25f-92e2-4431-844e-f3761b6fea53
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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 417, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 69, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 14, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 3, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 14, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 408, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: home_page_home_hero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.home_page_home_hero_id_seq', 2, true);


--
-- Name: services_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.services_articles_id_seq', 1, true);


--
-- Name: services_services_docs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.services_services_docs_id_seq', 5, true);


--
-- Name: services_services_gallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.services_services_gallery_id_seq', 6, true);


--
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: directus
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


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
-- Name: home_hero home_hero_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_hero
    ADD CONSTRAINT home_hero_pkey PRIMARY KEY (id);


--
-- Name: home_page_home_hero home_page_home_hero_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_hero
    ADD CONSTRAINT home_page_home_hero_pkey PRIMARY KEY (id);


--
-- Name: home_page home_page_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page
    ADD CONSTRAINT home_page_pkey PRIMARY KEY (id);


--
-- Name: services_articles services_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_articles
    ADD CONSTRAINT services_articles_pkey PRIMARY KEY (id);


--
-- Name: services_docs services_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_docs
    ADD CONSTRAINT services_docs_pkey PRIMARY KEY (id);


--
-- Name: services_gallery services_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_gallery
    ADD CONSTRAINT services_gallery_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: services_services_docs services_services_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_docs
    ADD CONSTRAINT services_services_docs_pkey PRIMARY KEY (id);


--
-- Name: services_services_gallery services_services_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_gallery
    ADD CONSTRAINT services_services_gallery_pkey PRIMARY KEY (id);


--
-- Name: articles articles_cover_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_cover_foreign FOREIGN KEY (cover) REFERENCES public.directus_files(id);


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
-- Name: home_hero home_hero_file_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_hero
    ADD CONSTRAINT home_hero_file_foreign FOREIGN KEY (file) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: home_page_home_hero home_page_home_hero_home_hero_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_hero
    ADD CONSTRAINT home_page_home_hero_home_hero_id_foreign FOREIGN KEY (home_hero_id) REFERENCES public.home_hero(id) ON DELETE CASCADE;


--
-- Name: home_page_home_hero home_page_home_hero_home_page_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_page_home_hero
    ADD CONSTRAINT home_page_home_hero_home_page_id_foreign FOREIGN KEY (home_page_id) REFERENCES public.home_page(id) ON DELETE SET NULL;


--
-- Name: services_articles services_articles_articles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_articles
    ADD CONSTRAINT services_articles_articles_id_foreign FOREIGN KEY (articles_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: services_articles services_articles_services_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_articles
    ADD CONSTRAINT services_articles_services_id_foreign FOREIGN KEY (services_id) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: services services_banner_article_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_banner_article_foreign FOREIGN KEY (banner_article) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: services_docs services_docs_file_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_docs
    ADD CONSTRAINT services_docs_file_foreign FOREIGN KEY (file) REFERENCES public.directus_files(id) ON DELETE CASCADE;


--
-- Name: services_gallery services_gallery_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_gallery
    ADD CONSTRAINT services_gallery_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE CASCADE;


--
-- Name: services services_hero_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_hero_image_foreign FOREIGN KEY (hero_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: services_services_docs services_services_docs_services_docs_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_docs
    ADD CONSTRAINT services_services_docs_services_docs_id_foreign FOREIGN KEY (services_docs_id) REFERENCES public.services_docs(id) ON DELETE CASCADE;


--
-- Name: services_services_docs services_services_docs_services_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_docs
    ADD CONSTRAINT services_services_docs_services_id_foreign FOREIGN KEY (services_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: services_services_gallery services_services_gallery_services_gallery_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_gallery
    ADD CONSTRAINT services_services_gallery_services_gallery_id_foreign FOREIGN KEY (services_gallery_id) REFERENCES public.services_gallery(id) ON DELETE CASCADE;


--
-- Name: services_services_gallery services_services_gallery_services_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_services_gallery
    ADD CONSTRAINT services_services_gallery_services_id_foreign FOREIGN KEY (services_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

