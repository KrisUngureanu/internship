--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
f21b95f1-cdc9-4024-8a56-45f1067124be	e1b625ae-5d0c-4550-aad6-332221e110c2
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
b2db6e34-f8c1-4df5-8143-347faeb0daea	\N	auth-cookie	609d82f3-0d9a-41cd-b689-39eaf454deb4	9ed6b3c0-8f3f-4514-be38-7cc61bd5db73	2	10	f	\N	\N
84ecb354-53b4-4254-9a99-6923a62dde6b	\N	auth-spnego	609d82f3-0d9a-41cd-b689-39eaf454deb4	9ed6b3c0-8f3f-4514-be38-7cc61bd5db73	3	20	f	\N	\N
3e50f9a1-f00e-470e-be6a-12a2f82b1805	\N	identity-provider-redirector	609d82f3-0d9a-41cd-b689-39eaf454deb4	9ed6b3c0-8f3f-4514-be38-7cc61bd5db73	2	25	f	\N	\N
c00ffec8-5510-4214-89da-5494389be78c	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	9ed6b3c0-8f3f-4514-be38-7cc61bd5db73	2	30	t	24fdbd0b-9b35-4041-b450-33490dca6640	\N
1259d28b-e1c8-4165-be91-d7e8f4b1cd2c	\N	auth-username-password-form	609d82f3-0d9a-41cd-b689-39eaf454deb4	24fdbd0b-9b35-4041-b450-33490dca6640	0	10	f	\N	\N
77783bc4-ae78-49f7-853c-50955c79bec7	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	24fdbd0b-9b35-4041-b450-33490dca6640	1	20	t	1da1ba2f-48d9-4ed5-887f-bc3a5af5b7fb	\N
2a364a34-1135-44ac-b463-337dadbbad64	\N	conditional-user-configured	609d82f3-0d9a-41cd-b689-39eaf454deb4	1da1ba2f-48d9-4ed5-887f-bc3a5af5b7fb	0	10	f	\N	\N
f309ff40-6460-494e-9bdf-9c80f8ba0a8d	\N	auth-otp-form	609d82f3-0d9a-41cd-b689-39eaf454deb4	1da1ba2f-48d9-4ed5-887f-bc3a5af5b7fb	0	20	f	\N	\N
e69bc1cf-33b0-4265-96e1-367cf1cf1ee3	\N	direct-grant-validate-username	609d82f3-0d9a-41cd-b689-39eaf454deb4	114da2fa-1782-4b18-84ed-d04466537930	0	10	f	\N	\N
6409019a-c5b8-4a46-9f00-f72678a611d2	\N	direct-grant-validate-password	609d82f3-0d9a-41cd-b689-39eaf454deb4	114da2fa-1782-4b18-84ed-d04466537930	0	20	f	\N	\N
e71a58cd-e533-49c3-a109-294386ed33be	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	114da2fa-1782-4b18-84ed-d04466537930	1	30	t	474b54e4-7529-4e95-b263-607aece99a48	\N
27e49318-6e42-46f5-ae3f-db3e2e6d2303	\N	conditional-user-configured	609d82f3-0d9a-41cd-b689-39eaf454deb4	474b54e4-7529-4e95-b263-607aece99a48	0	10	f	\N	\N
0beefc04-781a-4755-ad71-e05d9c1c0b0a	\N	direct-grant-validate-otp	609d82f3-0d9a-41cd-b689-39eaf454deb4	474b54e4-7529-4e95-b263-607aece99a48	0	20	f	\N	\N
c0764ffe-b208-46b9-b761-5a880021b2f2	\N	registration-page-form	609d82f3-0d9a-41cd-b689-39eaf454deb4	48b73316-ae71-4c7a-9b76-daa47170b750	0	10	t	53855963-ad01-4645-beac-5d0033a0b0b6	\N
8bb430ec-07c8-406d-b152-cd0dd8a3c059	\N	registration-user-creation	609d82f3-0d9a-41cd-b689-39eaf454deb4	53855963-ad01-4645-beac-5d0033a0b0b6	0	20	f	\N	\N
0e3a464b-de71-4730-a0c0-15faa313b818	\N	registration-profile-action	609d82f3-0d9a-41cd-b689-39eaf454deb4	53855963-ad01-4645-beac-5d0033a0b0b6	0	40	f	\N	\N
28604ef9-f8f0-457a-9a9b-4ce93a6b5804	\N	registration-password-action	609d82f3-0d9a-41cd-b689-39eaf454deb4	53855963-ad01-4645-beac-5d0033a0b0b6	0	50	f	\N	\N
5cc95e58-f237-47db-8704-8723180a0b50	\N	registration-recaptcha-action	609d82f3-0d9a-41cd-b689-39eaf454deb4	53855963-ad01-4645-beac-5d0033a0b0b6	3	60	f	\N	\N
2c2cc173-a77c-4448-8076-04267b293bce	\N	reset-credentials-choose-user	609d82f3-0d9a-41cd-b689-39eaf454deb4	64af43f5-d94d-4452-965d-8782b6cc9206	0	10	f	\N	\N
829f8a81-f3b5-4446-84bc-1421be66ce7f	\N	reset-credential-email	609d82f3-0d9a-41cd-b689-39eaf454deb4	64af43f5-d94d-4452-965d-8782b6cc9206	0	20	f	\N	\N
0d708203-73c5-4411-854b-9292a41aaa35	\N	reset-password	609d82f3-0d9a-41cd-b689-39eaf454deb4	64af43f5-d94d-4452-965d-8782b6cc9206	0	30	f	\N	\N
0ac5e2bf-bac0-4475-8350-5ecd81bc5fee	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	64af43f5-d94d-4452-965d-8782b6cc9206	1	40	t	b340cf8d-ac76-48a1-b313-ac2e67a55c8d	\N
18fdb0e3-59f7-410b-b189-ef4b5f2c6307	\N	conditional-user-configured	609d82f3-0d9a-41cd-b689-39eaf454deb4	b340cf8d-ac76-48a1-b313-ac2e67a55c8d	0	10	f	\N	\N
8c1b93da-8d77-49f2-a92b-99f271487a33	\N	reset-otp	609d82f3-0d9a-41cd-b689-39eaf454deb4	b340cf8d-ac76-48a1-b313-ac2e67a55c8d	0	20	f	\N	\N
a7ee8dad-3159-4a6e-8aff-97504aaa1a0c	\N	client-secret	609d82f3-0d9a-41cd-b689-39eaf454deb4	60aa64fc-ae41-4144-87a7-f436b1c90901	2	10	f	\N	\N
137ece2f-de15-4e4e-bfe6-fa51f77b8cae	\N	client-jwt	609d82f3-0d9a-41cd-b689-39eaf454deb4	60aa64fc-ae41-4144-87a7-f436b1c90901	2	20	f	\N	\N
c7fc3d2b-0dc9-43e0-9334-a08d8ad41896	\N	client-secret-jwt	609d82f3-0d9a-41cd-b689-39eaf454deb4	60aa64fc-ae41-4144-87a7-f436b1c90901	2	30	f	\N	\N
6b4adde0-e41b-45a5-b8e3-5e0ad67a3e49	\N	client-x509	609d82f3-0d9a-41cd-b689-39eaf454deb4	60aa64fc-ae41-4144-87a7-f436b1c90901	2	40	f	\N	\N
56f23f1a-2e62-4905-a265-3f19511ff556	\N	idp-review-profile	609d82f3-0d9a-41cd-b689-39eaf454deb4	f8421690-2f05-4c0b-9eb2-2ba3541b00a9	0	10	f	\N	93b0ae36-098a-404d-877f-fa9150767c26
21d63815-c900-47f4-862f-1087d384e8b0	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	f8421690-2f05-4c0b-9eb2-2ba3541b00a9	0	20	t	7b0d192d-74b0-4c25-b3f2-a0ee8a5a8e90	\N
c0fc8bfb-5b43-4082-871a-b3d69a37080b	\N	idp-create-user-if-unique	609d82f3-0d9a-41cd-b689-39eaf454deb4	7b0d192d-74b0-4c25-b3f2-a0ee8a5a8e90	2	10	f	\N	5db75f6c-fa75-4a8a-b942-1efe06bd84ae
ca467203-ee07-4f81-b4a0-37e57c3c03a7	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	7b0d192d-74b0-4c25-b3f2-a0ee8a5a8e90	2	20	t	1c187932-fb51-44cb-9fe4-e6924a554d63	\N
05abaef5-8911-4111-adbe-54d1c9772653	\N	idp-confirm-link	609d82f3-0d9a-41cd-b689-39eaf454deb4	1c187932-fb51-44cb-9fe4-e6924a554d63	0	10	f	\N	\N
e8226cd8-dea1-4515-8577-abbe337b2d24	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	1c187932-fb51-44cb-9fe4-e6924a554d63	0	20	t	cc3fe558-dbc9-4ad5-b4e3-b61b4752703d	\N
c369decb-04e8-459b-b81e-c9f111f5b94a	\N	idp-email-verification	609d82f3-0d9a-41cd-b689-39eaf454deb4	cc3fe558-dbc9-4ad5-b4e3-b61b4752703d	2	10	f	\N	\N
453a61f0-6954-40b3-978c-d3ae32294f54	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	cc3fe558-dbc9-4ad5-b4e3-b61b4752703d	2	20	t	bd16db65-3644-482c-b728-1908e2810e95	\N
f8e7dc31-6a6e-4271-996f-465ffbc82b26	\N	idp-username-password-form	609d82f3-0d9a-41cd-b689-39eaf454deb4	bd16db65-3644-482c-b728-1908e2810e95	0	10	f	\N	\N
85b22ddd-7e6a-4b32-bc3c-b9f4c4d70a9d	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	bd16db65-3644-482c-b728-1908e2810e95	1	20	t	6e9b48a4-c8b8-495a-af99-8d13c0bf85f1	\N
cd49a507-0035-4a41-855f-48817f709aa9	\N	conditional-user-configured	609d82f3-0d9a-41cd-b689-39eaf454deb4	6e9b48a4-c8b8-495a-af99-8d13c0bf85f1	0	10	f	\N	\N
320c8d28-80ab-4c05-a615-224cafc1c81a	\N	auth-otp-form	609d82f3-0d9a-41cd-b689-39eaf454deb4	6e9b48a4-c8b8-495a-af99-8d13c0bf85f1	0	20	f	\N	\N
cb26cb7a-0d7b-4ff5-94f8-e5063d168653	\N	http-basic-authenticator	609d82f3-0d9a-41cd-b689-39eaf454deb4	18409505-180e-47eb-99ce-3fc3da034180	0	10	f	\N	\N
a1e20df5-c0d9-4e5b-a350-ab3385c82a54	\N	docker-http-basic-authenticator	609d82f3-0d9a-41cd-b689-39eaf454deb4	ed06eab1-f3ed-4a76-b93a-918d9da3a188	0	10	f	\N	\N
f32e1081-f1b1-4d75-85e2-25df4571fd04	\N	no-cookie-redirect	609d82f3-0d9a-41cd-b689-39eaf454deb4	4f7207e7-5b6d-49c3-8be7-eb6a4dc31dbd	0	10	f	\N	\N
70c3be71-7f8b-4b3a-8a23-d6fa7c150b37	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	4f7207e7-5b6d-49c3-8be7-eb6a4dc31dbd	0	20	t	6749c71b-716b-403e-8191-2df209f2b8b8	\N
c94a881d-383e-4148-8cd6-2ed58b8c5b2e	\N	basic-auth	609d82f3-0d9a-41cd-b689-39eaf454deb4	6749c71b-716b-403e-8191-2df209f2b8b8	0	10	f	\N	\N
2a5b3173-6317-449e-8500-8e4c44c70249	\N	basic-auth-otp	609d82f3-0d9a-41cd-b689-39eaf454deb4	6749c71b-716b-403e-8191-2df209f2b8b8	3	20	f	\N	\N
3ef26233-2a69-4d9d-928f-40e61ae7843a	\N	auth-spnego	609d82f3-0d9a-41cd-b689-39eaf454deb4	6749c71b-716b-403e-8191-2df209f2b8b8	3	30	f	\N	\N
208b96ea-aff2-4834-be5d-1ab4bd0e6527	\N	idp-email-verification	a7de8481-c201-4c82-90be-4f1e0f9402bf	0da713f5-dd83-4ba6-9936-18b849f086d9	2	10	f	\N	\N
cd8a57c8-a2a1-440c-adc0-11b9958536b4	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	0da713f5-dd83-4ba6-9936-18b849f086d9	2	20	t	03954f15-2786-450c-8f68-fe41aa166453	\N
8e114f08-b52a-4ce3-a49b-e8b125e024f2	\N	basic-auth	a7de8481-c201-4c82-90be-4f1e0f9402bf	059321e4-5569-4b58-a3af-20729d098e60	0	10	f	\N	\N
5ae71722-2121-4421-a4ed-87ae3d2ebf01	\N	basic-auth-otp	a7de8481-c201-4c82-90be-4f1e0f9402bf	059321e4-5569-4b58-a3af-20729d098e60	3	20	f	\N	\N
2b818589-07ac-4ad9-9c55-5392e8f53806	\N	auth-spnego	a7de8481-c201-4c82-90be-4f1e0f9402bf	059321e4-5569-4b58-a3af-20729d098e60	3	30	f	\N	\N
006b752f-cdb4-403c-a862-b96bf8c8a976	\N	conditional-user-configured	a7de8481-c201-4c82-90be-4f1e0f9402bf	6d762649-403f-412e-be7c-b890a64ec792	0	10	f	\N	\N
8143b168-8256-4a17-9194-07fa7bd24473	\N	auth-otp-form	a7de8481-c201-4c82-90be-4f1e0f9402bf	6d762649-403f-412e-be7c-b890a64ec792	0	20	f	\N	\N
83823f9c-505b-4256-b448-8a6cb8f46466	\N	conditional-user-configured	a7de8481-c201-4c82-90be-4f1e0f9402bf	2edb80e7-1b8a-47e8-bbe0-31858e1b7af5	0	10	f	\N	\N
9a7f2f9d-317f-4393-8fd1-5c9f8dd71430	\N	direct-grant-validate-otp	a7de8481-c201-4c82-90be-4f1e0f9402bf	2edb80e7-1b8a-47e8-bbe0-31858e1b7af5	0	20	f	\N	\N
dee3821f-0f6a-4e05-9da9-bef22339d2d7	\N	conditional-user-configured	a7de8481-c201-4c82-90be-4f1e0f9402bf	cd1e68a6-2049-4288-80aa-8b2f281f986e	0	10	f	\N	\N
82bbd070-e710-4e99-8185-f77e6854f95b	\N	auth-otp-form	a7de8481-c201-4c82-90be-4f1e0f9402bf	cd1e68a6-2049-4288-80aa-8b2f281f986e	0	20	f	\N	\N
b0ba6a78-7bdf-4682-8d02-eb77d347d1d9	\N	idp-confirm-link	a7de8481-c201-4c82-90be-4f1e0f9402bf	4f98625d-9af8-4dec-a43a-3c7b2b0d3909	0	10	f	\N	\N
103e9812-760f-44ab-acdf-a6320327f941	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	4f98625d-9af8-4dec-a43a-3c7b2b0d3909	0	20	t	0da713f5-dd83-4ba6-9936-18b849f086d9	\N
eb5615c5-aaf2-48f5-bb23-2a783ee4b195	\N	conditional-user-configured	a7de8481-c201-4c82-90be-4f1e0f9402bf	a07f3c90-a3b3-4ebd-858f-eec62139ec9d	0	10	f	\N	\N
890a14dc-a382-43f6-9709-96ce37afa6fd	\N	reset-otp	a7de8481-c201-4c82-90be-4f1e0f9402bf	a07f3c90-a3b3-4ebd-858f-eec62139ec9d	0	20	f	\N	\N
ab7d2de3-c1e8-4c92-9ba0-b07dd5cc8eb1	\N	idp-create-user-if-unique	a7de8481-c201-4c82-90be-4f1e0f9402bf	5651f492-ac06-4801-8fde-eba581fbadea	2	10	f	\N	0c269b5c-1420-4307-b079-d5becc1220c4
eddea8cf-6060-434f-89a2-4b4dc729186b	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	5651f492-ac06-4801-8fde-eba581fbadea	2	20	t	4f98625d-9af8-4dec-a43a-3c7b2b0d3909	\N
32a46789-9ac9-439f-bb2c-26334d2d9c81	\N	idp-username-password-form	a7de8481-c201-4c82-90be-4f1e0f9402bf	03954f15-2786-450c-8f68-fe41aa166453	0	10	f	\N	\N
3ff074b0-b9ef-4fec-8cc7-6fc49aa4b081	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	03954f15-2786-450c-8f68-fe41aa166453	1	20	t	cd1e68a6-2049-4288-80aa-8b2f281f986e	\N
594e4fcd-2f8b-4e62-962a-b05060149d72	\N	auth-cookie	a7de8481-c201-4c82-90be-4f1e0f9402bf	7f1c35ea-70a1-4376-92ba-458f15e90fe0	2	10	f	\N	\N
f3b386ab-6637-4b23-bc86-7db9a6d6949e	\N	auth-spnego	a7de8481-c201-4c82-90be-4f1e0f9402bf	7f1c35ea-70a1-4376-92ba-458f15e90fe0	3	20	f	\N	\N
f447dade-0357-42aa-9e57-752489dd2d35	\N	identity-provider-redirector	a7de8481-c201-4c82-90be-4f1e0f9402bf	7f1c35ea-70a1-4376-92ba-458f15e90fe0	2	25	f	\N	\N
a7c7e2e2-4764-43f2-88bc-c979b0cefa47	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	7f1c35ea-70a1-4376-92ba-458f15e90fe0	2	30	t	dfc3462d-9303-47f3-b522-d28a18512e37	\N
4b47a8d7-2498-4aaf-816a-711cabf2d19a	\N	client-secret	a7de8481-c201-4c82-90be-4f1e0f9402bf	98ec7436-b743-4abd-b6ae-7ce555cd43a6	2	10	f	\N	\N
0ad09539-a819-466f-aa5a-96663091d6b2	\N	client-jwt	a7de8481-c201-4c82-90be-4f1e0f9402bf	98ec7436-b743-4abd-b6ae-7ce555cd43a6	2	20	f	\N	\N
fbffb4bf-d94a-489b-a355-44b16d751d3d	\N	client-secret-jwt	a7de8481-c201-4c82-90be-4f1e0f9402bf	98ec7436-b743-4abd-b6ae-7ce555cd43a6	2	30	f	\N	\N
4f6b64ea-04df-4b9c-a7af-d879527d9cab	\N	client-x509	a7de8481-c201-4c82-90be-4f1e0f9402bf	98ec7436-b743-4abd-b6ae-7ce555cd43a6	2	40	f	\N	\N
ab91b494-2f15-4abb-bf72-01bbfc83eebf	\N	direct-grant-validate-username	a7de8481-c201-4c82-90be-4f1e0f9402bf	d7b6783e-32f6-420c-ac8d-78b6f97c8e60	0	10	f	\N	\N
7f66e46b-0cb0-4c04-a0dd-876b6b2f54f7	\N	direct-grant-validate-password	a7de8481-c201-4c82-90be-4f1e0f9402bf	d7b6783e-32f6-420c-ac8d-78b6f97c8e60	0	20	f	\N	\N
484ce1fe-9879-459c-89f3-3f63fca718c7	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	d7b6783e-32f6-420c-ac8d-78b6f97c8e60	1	30	t	2edb80e7-1b8a-47e8-bbe0-31858e1b7af5	\N
56f401be-0780-46a8-b902-c52b205c735c	\N	docker-http-basic-authenticator	a7de8481-c201-4c82-90be-4f1e0f9402bf	f85b10b2-9822-4267-bcdf-da6313e4ab0e	0	10	f	\N	\N
b50d2410-0caa-4cae-9375-79fad690433c	\N	idp-review-profile	a7de8481-c201-4c82-90be-4f1e0f9402bf	0e5bb836-9c1e-489d-9a08-839b6346444e	0	10	f	\N	d243d442-dfb8-4e08-a295-3883fe22a1fd
e328866f-fcb1-47fc-8aca-67416804a932	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	0e5bb836-9c1e-489d-9a08-839b6346444e	0	20	t	5651f492-ac06-4801-8fde-eba581fbadea	\N
8c339152-44ad-4c1e-bdd4-c947eb7a7796	\N	auth-username-password-form	a7de8481-c201-4c82-90be-4f1e0f9402bf	dfc3462d-9303-47f3-b522-d28a18512e37	0	10	f	\N	\N
f73cd3a6-465d-4f56-a772-68e5cdc4ede5	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	dfc3462d-9303-47f3-b522-d28a18512e37	1	20	t	6d762649-403f-412e-be7c-b890a64ec792	\N
cc8fddfc-fb47-44fd-bcb5-a5c1314d56b6	\N	no-cookie-redirect	a7de8481-c201-4c82-90be-4f1e0f9402bf	6c94626d-4222-47ba-b1e3-0e0ce72e74e6	0	10	f	\N	\N
bb6a50e0-06e9-4221-9278-bd93c9830562	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	6c94626d-4222-47ba-b1e3-0e0ce72e74e6	0	20	t	059321e4-5569-4b58-a3af-20729d098e60	\N
a86362fb-0e55-4a14-98f7-d4af5449a190	\N	registration-page-form	a7de8481-c201-4c82-90be-4f1e0f9402bf	320cab38-46f0-4bc8-96ad-5061e7d5cdb0	0	10	t	22766e75-1bd9-4e0a-8c13-5c6449b2d38b	\N
57471c20-f6d3-4861-ad86-8c65d8c86377	\N	registration-user-creation	a7de8481-c201-4c82-90be-4f1e0f9402bf	22766e75-1bd9-4e0a-8c13-5c6449b2d38b	0	20	f	\N	\N
917a45f8-0a09-4e38-b71e-6e48c17432af	\N	registration-profile-action	a7de8481-c201-4c82-90be-4f1e0f9402bf	22766e75-1bd9-4e0a-8c13-5c6449b2d38b	0	40	f	\N	\N
a60b1b54-bfad-4222-8b4c-f9e1a0fbdb1f	\N	registration-password-action	a7de8481-c201-4c82-90be-4f1e0f9402bf	22766e75-1bd9-4e0a-8c13-5c6449b2d38b	0	50	f	\N	\N
0beff607-ed32-4c6c-af57-e7a1efee5f1a	\N	registration-recaptcha-action	a7de8481-c201-4c82-90be-4f1e0f9402bf	22766e75-1bd9-4e0a-8c13-5c6449b2d38b	3	60	f	\N	\N
335348b1-71cc-4073-b813-bea84acf450c	\N	reset-credentials-choose-user	a7de8481-c201-4c82-90be-4f1e0f9402bf	ffbecce6-835c-4acf-9c16-a1967ba90ade	0	10	f	\N	\N
d88143b4-2059-493c-a43c-7ce6d249944d	\N	reset-credential-email	a7de8481-c201-4c82-90be-4f1e0f9402bf	ffbecce6-835c-4acf-9c16-a1967ba90ade	0	20	f	\N	\N
b92c37f8-f32f-47f0-a244-86aa2066db8a	\N	reset-password	a7de8481-c201-4c82-90be-4f1e0f9402bf	ffbecce6-835c-4acf-9c16-a1967ba90ade	0	30	f	\N	\N
43e2595a-3e22-485a-a17a-f4553095460c	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	ffbecce6-835c-4acf-9c16-a1967ba90ade	1	40	t	a07f3c90-a3b3-4ebd-858f-eec62139ec9d	\N
e9888e9f-a8ff-41d4-aa3e-aef15299eeec	\N	http-basic-authenticator	a7de8481-c201-4c82-90be-4f1e0f9402bf	be8638f7-44f2-46f6-aff1-0f772c2b7df8	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
9ed6b3c0-8f3f-4514-be38-7cc61bd5db73	browser	browser based authentication	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
24fdbd0b-9b35-4041-b450-33490dca6640	forms	Username, password, otp and other auth forms.	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
1da1ba2f-48d9-4ed5-887f-bc3a5af5b7fb	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
114da2fa-1782-4b18-84ed-d04466537930	direct grant	OpenID Connect Resource Owner Grant	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
474b54e4-7529-4e95-b263-607aece99a48	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
48b73316-ae71-4c7a-9b76-daa47170b750	registration	registration flow	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
53855963-ad01-4645-beac-5d0033a0b0b6	registration form	registration form	609d82f3-0d9a-41cd-b689-39eaf454deb4	form-flow	f	t
64af43f5-d94d-4452-965d-8782b6cc9206	reset credentials	Reset credentials for a user if they forgot their password or something	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
b340cf8d-ac76-48a1-b313-ac2e67a55c8d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
60aa64fc-ae41-4144-87a7-f436b1c90901	clients	Base authentication for clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	client-flow	t	t
f8421690-2f05-4c0b-9eb2-2ba3541b00a9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
7b0d192d-74b0-4c25-b3f2-a0ee8a5a8e90	User creation or linking	Flow for the existing/non-existing user alternatives	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
1c187932-fb51-44cb-9fe4-e6924a554d63	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
cc3fe558-dbc9-4ad5-b4e3-b61b4752703d	Account verification options	Method with which to verity the existing account	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
bd16db65-3644-482c-b728-1908e2810e95	Verify Existing Account by Re-authentication	Reauthentication of existing account	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
6e9b48a4-c8b8-495a-af99-8d13c0bf85f1	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
18409505-180e-47eb-99ce-3fc3da034180	saml ecp	SAML ECP Profile Authentication Flow	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
ed06eab1-f3ed-4a76-b93a-918d9da3a188	docker auth	Used by Docker clients to authenticate against the IDP	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
4f7207e7-5b6d-49c3-8be7-eb6a4dc31dbd	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	t	t
6749c71b-716b-403e-8191-2df209f2b8b8	Authentication Options	Authentication options.	609d82f3-0d9a-41cd-b689-39eaf454deb4	basic-flow	f	t
0da713f5-dd83-4ba6-9936-18b849f086d9	Account verification options	Method with which to verity the existing account	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
059321e4-5569-4b58-a3af-20729d098e60	Authentication Options	Authentication options.	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
6d762649-403f-412e-be7c-b890a64ec792	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
2edb80e7-1b8a-47e8-bbe0-31858e1b7af5	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
cd1e68a6-2049-4288-80aa-8b2f281f986e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
4f98625d-9af8-4dec-a43a-3c7b2b0d3909	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
a07f3c90-a3b3-4ebd-858f-eec62139ec9d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
5651f492-ac06-4801-8fde-eba581fbadea	User creation or linking	Flow for the existing/non-existing user alternatives	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
03954f15-2786-450c-8f68-fe41aa166453	Verify Existing Account by Re-authentication	Reauthentication of existing account	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
7f1c35ea-70a1-4376-92ba-458f15e90fe0	browser	browser based authentication	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
98ec7436-b743-4abd-b6ae-7ce555cd43a6	clients	Base authentication for clients	a7de8481-c201-4c82-90be-4f1e0f9402bf	client-flow	t	t
d7b6783e-32f6-420c-ac8d-78b6f97c8e60	direct grant	OpenID Connect Resource Owner Grant	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
f85b10b2-9822-4267-bcdf-da6313e4ab0e	docker auth	Used by Docker clients to authenticate against the IDP	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
0e5bb836-9c1e-489d-9a08-839b6346444e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
dfc3462d-9303-47f3-b522-d28a18512e37	forms	Username, password, otp and other auth forms.	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	f	t
6c94626d-4222-47ba-b1e3-0e0ce72e74e6	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
320cab38-46f0-4bc8-96ad-5061e7d5cdb0	registration	registration flow	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
22766e75-1bd9-4e0a-8c13-5c6449b2d38b	registration form	registration form	a7de8481-c201-4c82-90be-4f1e0f9402bf	form-flow	f	t
ffbecce6-835c-4acf-9c16-a1967ba90ade	reset credentials	Reset credentials for a user if they forgot their password or something	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
be8638f7-44f2-46f6-aff1-0f772c2b7df8	saml ecp	SAML ECP Profile Authentication Flow	a7de8481-c201-4c82-90be-4f1e0f9402bf	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
93b0ae36-098a-404d-877f-fa9150767c26	review profile config	609d82f3-0d9a-41cd-b689-39eaf454deb4
5db75f6c-fa75-4a8a-b942-1efe06bd84ae	create unique user config	609d82f3-0d9a-41cd-b689-39eaf454deb4
0c269b5c-1420-4307-b079-d5becc1220c4	create unique user config	a7de8481-c201-4c82-90be-4f1e0f9402bf
d243d442-dfb8-4e08-a295-3883fe22a1fd	review profile config	a7de8481-c201-4c82-90be-4f1e0f9402bf
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
5db75f6c-fa75-4a8a-b942-1efe06bd84ae	false	require.password.update.after.registration
93b0ae36-098a-404d-877f-fa9150767c26	missing	update.profile.on.first.login
0c269b5c-1420-4307-b079-d5becc1220c4	false	require.password.update.after.registration
d243d442-dfb8-4e08-a295-3883fe22a1fd	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
9c999465-a932-4b28-91bf-1ecbc334f82a	t	f	master-realm	0	f	\N	\N	t	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
d9ae72f1-7b7f-4800-9247-831a3be1de63	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	t	f	broker	0	f	\N	\N	t	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
708212c3-a3b1-4f9c-85e1-f24d748cefb6	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a68a9beb-78c7-4459-b131-885b4ea402ec	t	f	admin-cli	0	t	\N	\N	f	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c078607e-fabe-4720-a857-d964c70b1c6d	t	f	internship-realm	0	f	\N	\N	t	\N	f	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	0	f	f	internship Realm	f	client-secret	\N	\N	\N	t	f	f	f
5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	f	realm-management	0	f	\N	\N	t	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
733b1113-38d8-43ac-a17a-17782dc6b2b1	t	f	account	0	t	\N	/realms/internship/account/	f	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	t	f	account-console	0	t	\N	/realms/internship/account/	f	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ffd8aef0-c7cd-4150-9e34-03a2aa733172	t	f	broker	0	f	\N	\N	t	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
f82ba6ac-1207-4426-9106-0bbc87af410c	t	f	security-admin-console	0	t	\N	/admin/internship/console/	f	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
eabef969-5347-4088-acc4-3da6d674ca3c	t	f	admin-cli	0	t	\N	\N	f	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	t	t	bitlab-internship-client	0	f	2JeVUD3jAntWmL0jZLInL8UrKsYp1EP0	\N	f	\N	f	a7de8481-c201-4c82-90be-4f1e0f9402bf	openid-connect	-1	t	f	bitlab-internship-client	t	client-secret	\N		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
d9ae72f1-7b7f-4800-9247-831a3be1de63	post.logout.redirect.uris	+
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	post.logout.redirect.uris	+
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	pkce.code.challenge.method	S256
708212c3-a3b1-4f9c-85e1-f24d748cefb6	post.logout.redirect.uris	+
708212c3-a3b1-4f9c-85e1-f24d748cefb6	pkce.code.challenge.method	S256
733b1113-38d8-43ac-a17a-17782dc6b2b1	post.logout.redirect.uris	+
5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	post.logout.redirect.uris	+
5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	pkce.code.challenge.method	S256
f82ba6ac-1207-4426-9106-0bbc87af410c	post.logout.redirect.uris	+
f82ba6ac-1207-4426-9106-0bbc87af410c	pkce.code.challenge.method	S256
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	oidc.ciba.grant.enabled	false
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	oauth2.device.authorization.grant.enabled	false
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	client.secret.creation.time	1752932347
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	backchannel.logout.session.required	true
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
02bbbe1c-cfbc-4527-81d1-ab277d95905a	offline_access	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect built-in scope: offline_access	openid-connect
b574f4f4-6844-4038-859e-c6d51a47035e	role_list	609d82f3-0d9a-41cd-b689-39eaf454deb4	SAML role list	saml
535b6410-253a-4a0d-8c1a-4bd0aec312ec	profile	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect built-in scope: profile	openid-connect
8f9f230c-17ff-4837-a662-b77feeaa2131	email	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect built-in scope: email	openid-connect
3c9712aa-d103-4a93-b962-7b3404bb4909	address	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect built-in scope: address	openid-connect
e6738c34-f6f6-4408-8e28-684e8d2eff9b	phone	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect built-in scope: phone	openid-connect
9c031951-cddf-47d5-b957-b0adceb5a3fe	roles	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect scope for add user roles to the access token	openid-connect
7eecca88-6b1c-439e-a65c-297bd3ca7dae	web-origins	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3609e7d3-f301-48b1-985a-9e5a54b5b1f4	microprofile-jwt	609d82f3-0d9a-41cd-b689-39eaf454deb4	Microprofile - JWT built-in scope	openid-connect
327668e9-b045-47cc-b464-75968483daf3	acr	609d82f3-0d9a-41cd-b689-39eaf454deb4	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
edbf367a-3bc2-465f-9cf5-99fbdb42fcda	address	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect built-in scope: address	openid-connect
fc6966d9-fa22-4875-a9c3-013714d4878e	phone	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect built-in scope: phone	openid-connect
e479350a-4890-4bd2-9918-f748f593a400	web-origins	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect scope for add allowed web origins to the access token	openid-connect
874e8392-e528-4423-9b05-71ddbbf8df25	microprofile-jwt	a7de8481-c201-4c82-90be-4f1e0f9402bf	Microprofile - JWT built-in scope	openid-connect
07a06f4b-b81c-4ae6-9be2-adb5353813dc	offline_access	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect built-in scope: offline_access	openid-connect
08deba72-9c2e-4831-8bb2-fe5afed7dfe5	email	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect built-in scope: email	openid-connect
0ffc12e1-ca2e-45d8-bb5a-faeeb65f09d2	role_list	a7de8481-c201-4c82-90be-4f1e0f9402bf	SAML role list	saml
51c12159-de48-43d2-b3af-9a918505673f	acr	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
30b1a4cc-5dad-4170-968e-07328dfaeab6	profile	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect built-in scope: profile	openid-connect
56cbc436-a63e-441c-a6df-56fa9207d10b	roles	a7de8481-c201-4c82-90be-4f1e0f9402bf	OpenID Connect scope for add user roles to the access token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
02bbbe1c-cfbc-4527-81d1-ab277d95905a	true	display.on.consent.screen
02bbbe1c-cfbc-4527-81d1-ab277d95905a	${offlineAccessScopeConsentText}	consent.screen.text
b574f4f4-6844-4038-859e-c6d51a47035e	true	display.on.consent.screen
b574f4f4-6844-4038-859e-c6d51a47035e	${samlRoleListScopeConsentText}	consent.screen.text
535b6410-253a-4a0d-8c1a-4bd0aec312ec	true	display.on.consent.screen
535b6410-253a-4a0d-8c1a-4bd0aec312ec	${profileScopeConsentText}	consent.screen.text
535b6410-253a-4a0d-8c1a-4bd0aec312ec	true	include.in.token.scope
8f9f230c-17ff-4837-a662-b77feeaa2131	true	display.on.consent.screen
8f9f230c-17ff-4837-a662-b77feeaa2131	${emailScopeConsentText}	consent.screen.text
8f9f230c-17ff-4837-a662-b77feeaa2131	true	include.in.token.scope
3c9712aa-d103-4a93-b962-7b3404bb4909	true	display.on.consent.screen
3c9712aa-d103-4a93-b962-7b3404bb4909	${addressScopeConsentText}	consent.screen.text
3c9712aa-d103-4a93-b962-7b3404bb4909	true	include.in.token.scope
e6738c34-f6f6-4408-8e28-684e8d2eff9b	true	display.on.consent.screen
e6738c34-f6f6-4408-8e28-684e8d2eff9b	${phoneScopeConsentText}	consent.screen.text
e6738c34-f6f6-4408-8e28-684e8d2eff9b	true	include.in.token.scope
9c031951-cddf-47d5-b957-b0adceb5a3fe	true	display.on.consent.screen
9c031951-cddf-47d5-b957-b0adceb5a3fe	${rolesScopeConsentText}	consent.screen.text
9c031951-cddf-47d5-b957-b0adceb5a3fe	false	include.in.token.scope
7eecca88-6b1c-439e-a65c-297bd3ca7dae	false	display.on.consent.screen
7eecca88-6b1c-439e-a65c-297bd3ca7dae		consent.screen.text
7eecca88-6b1c-439e-a65c-297bd3ca7dae	false	include.in.token.scope
3609e7d3-f301-48b1-985a-9e5a54b5b1f4	false	display.on.consent.screen
3609e7d3-f301-48b1-985a-9e5a54b5b1f4	true	include.in.token.scope
327668e9-b045-47cc-b464-75968483daf3	false	display.on.consent.screen
327668e9-b045-47cc-b464-75968483daf3	false	include.in.token.scope
edbf367a-3bc2-465f-9cf5-99fbdb42fcda	true	include.in.token.scope
edbf367a-3bc2-465f-9cf5-99fbdb42fcda	true	display.on.consent.screen
edbf367a-3bc2-465f-9cf5-99fbdb42fcda	${addressScopeConsentText}	consent.screen.text
fc6966d9-fa22-4875-a9c3-013714d4878e	true	include.in.token.scope
fc6966d9-fa22-4875-a9c3-013714d4878e	true	display.on.consent.screen
fc6966d9-fa22-4875-a9c3-013714d4878e	${phoneScopeConsentText}	consent.screen.text
e479350a-4890-4bd2-9918-f748f593a400	false	include.in.token.scope
e479350a-4890-4bd2-9918-f748f593a400	false	display.on.consent.screen
e479350a-4890-4bd2-9918-f748f593a400		consent.screen.text
874e8392-e528-4423-9b05-71ddbbf8df25	true	include.in.token.scope
874e8392-e528-4423-9b05-71ddbbf8df25	false	display.on.consent.screen
07a06f4b-b81c-4ae6-9be2-adb5353813dc	${offlineAccessScopeConsentText}	consent.screen.text
07a06f4b-b81c-4ae6-9be2-adb5353813dc	true	display.on.consent.screen
08deba72-9c2e-4831-8bb2-fe5afed7dfe5	true	include.in.token.scope
08deba72-9c2e-4831-8bb2-fe5afed7dfe5	true	display.on.consent.screen
08deba72-9c2e-4831-8bb2-fe5afed7dfe5	${emailScopeConsentText}	consent.screen.text
0ffc12e1-ca2e-45d8-bb5a-faeeb65f09d2	${samlRoleListScopeConsentText}	consent.screen.text
0ffc12e1-ca2e-45d8-bb5a-faeeb65f09d2	true	display.on.consent.screen
51c12159-de48-43d2-b3af-9a918505673f	false	include.in.token.scope
51c12159-de48-43d2-b3af-9a918505673f	false	display.on.consent.screen
30b1a4cc-5dad-4170-968e-07328dfaeab6	true	include.in.token.scope
30b1a4cc-5dad-4170-968e-07328dfaeab6	true	display.on.consent.screen
30b1a4cc-5dad-4170-968e-07328dfaeab6	${profileScopeConsentText}	consent.screen.text
56cbc436-a63e-441c-a6df-56fa9207d10b	false	include.in.token.scope
56cbc436-a63e-441c-a6df-56fa9207d10b	true	display.on.consent.screen
56cbc436-a63e-441c-a6df-56fa9207d10b	${rolesScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
d9ae72f1-7b7f-4800-9247-831a3be1de63	8f9f230c-17ff-4837-a662-b77feeaa2131	t
d9ae72f1-7b7f-4800-9247-831a3be1de63	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
d9ae72f1-7b7f-4800-9247-831a3be1de63	327668e9-b045-47cc-b464-75968483daf3	t
d9ae72f1-7b7f-4800-9247-831a3be1de63	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
d9ae72f1-7b7f-4800-9247-831a3be1de63	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
d9ae72f1-7b7f-4800-9247-831a3be1de63	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
d9ae72f1-7b7f-4800-9247-831a3be1de63	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
d9ae72f1-7b7f-4800-9247-831a3be1de63	3c9712aa-d103-4a93-b962-7b3404bb4909	f
d9ae72f1-7b7f-4800-9247-831a3be1de63	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	8f9f230c-17ff-4837-a662-b77feeaa2131	t
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	327668e9-b045-47cc-b464-75968483daf3	t
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	3c9712aa-d103-4a93-b962-7b3404bb4909	f
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
a68a9beb-78c7-4459-b131-885b4ea402ec	8f9f230c-17ff-4837-a662-b77feeaa2131	t
a68a9beb-78c7-4459-b131-885b4ea402ec	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
a68a9beb-78c7-4459-b131-885b4ea402ec	327668e9-b045-47cc-b464-75968483daf3	t
a68a9beb-78c7-4459-b131-885b4ea402ec	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
a68a9beb-78c7-4459-b131-885b4ea402ec	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
a68a9beb-78c7-4459-b131-885b4ea402ec	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
a68a9beb-78c7-4459-b131-885b4ea402ec	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
a68a9beb-78c7-4459-b131-885b4ea402ec	3c9712aa-d103-4a93-b962-7b3404bb4909	f
a68a9beb-78c7-4459-b131-885b4ea402ec	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	8f9f230c-17ff-4837-a662-b77feeaa2131	t
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	327668e9-b045-47cc-b464-75968483daf3	t
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	3c9712aa-d103-4a93-b962-7b3404bb4909	f
ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
9c999465-a932-4b28-91bf-1ecbc334f82a	8f9f230c-17ff-4837-a662-b77feeaa2131	t
9c999465-a932-4b28-91bf-1ecbc334f82a	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
9c999465-a932-4b28-91bf-1ecbc334f82a	327668e9-b045-47cc-b464-75968483daf3	t
9c999465-a932-4b28-91bf-1ecbc334f82a	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
9c999465-a932-4b28-91bf-1ecbc334f82a	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
9c999465-a932-4b28-91bf-1ecbc334f82a	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
9c999465-a932-4b28-91bf-1ecbc334f82a	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
9c999465-a932-4b28-91bf-1ecbc334f82a	3c9712aa-d103-4a93-b962-7b3404bb4909	f
9c999465-a932-4b28-91bf-1ecbc334f82a	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
708212c3-a3b1-4f9c-85e1-f24d748cefb6	8f9f230c-17ff-4837-a662-b77feeaa2131	t
708212c3-a3b1-4f9c-85e1-f24d748cefb6	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
708212c3-a3b1-4f9c-85e1-f24d748cefb6	327668e9-b045-47cc-b464-75968483daf3	t
708212c3-a3b1-4f9c-85e1-f24d748cefb6	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
708212c3-a3b1-4f9c-85e1-f24d748cefb6	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
708212c3-a3b1-4f9c-85e1-f24d748cefb6	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
708212c3-a3b1-4f9c-85e1-f24d748cefb6	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
708212c3-a3b1-4f9c-85e1-f24d748cefb6	3c9712aa-d103-4a93-b962-7b3404bb4909	f
708212c3-a3b1-4f9c-85e1-f24d748cefb6	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	e479350a-4890-4bd2-9918-f748f593a400	t
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	51c12159-de48-43d2-b3af-9a918505673f	t
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	30b1a4cc-5dad-4170-968e-07328dfaeab6	t
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	56cbc436-a63e-441c-a6df-56fa9207d10b	t
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	08deba72-9c2e-4831-8bb2-fe5afed7dfe5	t
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	edbf367a-3bc2-465f-9cf5-99fbdb42fcda	f
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	fc6966d9-fa22-4875-a9c3-013714d4878e	f
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	07a06f4b-b81c-4ae6-9be2-adb5353813dc	f
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	874e8392-e528-4423-9b05-71ddbbf8df25	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
02bbbe1c-cfbc-4527-81d1-ab277d95905a	d707eab6-9630-4649-b84c-d2858472cc60
07a06f4b-b81c-4ae6-9be2-adb5353813dc	43f9a56a-151f-45fa-9c24-5eecfd3dccd6
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
eb469c32-923f-4128-b9b0-47dd06f61e9c	Trusted Hosts	609d82f3-0d9a-41cd-b689-39eaf454deb4	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	anonymous
0a4c2261-714e-4d78-bef3-a5536c6ef06a	Consent Required	609d82f3-0d9a-41cd-b689-39eaf454deb4	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	anonymous
44f22a3f-a742-45a1-8008-59dc4126854e	Full Scope Disabled	609d82f3-0d9a-41cd-b689-39eaf454deb4	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	anonymous
edeac7b6-ad6f-4e87-9fa3-bda301e08219	Max Clients Limit	609d82f3-0d9a-41cd-b689-39eaf454deb4	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	anonymous
ba466b8a-16da-4209-8be0-b1364445e629	Allowed Protocol Mapper Types	609d82f3-0d9a-41cd-b689-39eaf454deb4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	anonymous
e11e3481-8f2e-4a7e-8343-a4f48140d0a1	Allowed Client Scopes	609d82f3-0d9a-41cd-b689-39eaf454deb4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	anonymous
3d65bb5c-17d1-43f1-8d38-14eb6ed12607	Allowed Protocol Mapper Types	609d82f3-0d9a-41cd-b689-39eaf454deb4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	authenticated
8030ddcb-c6ed-4895-b841-29ddd503d919	Allowed Client Scopes	609d82f3-0d9a-41cd-b689-39eaf454deb4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	authenticated
fc102add-4772-4ec5-8fe1-b92af0abfb3b	rsa-generated	609d82f3-0d9a-41cd-b689-39eaf454deb4	rsa-generated	org.keycloak.keys.KeyProvider	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N
7dba33d8-019b-4929-ab0b-1df095947dc5	rsa-enc-generated	609d82f3-0d9a-41cd-b689-39eaf454deb4	rsa-enc-generated	org.keycloak.keys.KeyProvider	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N
927db376-a235-4e5b-9fb2-600e9baf75e4	hmac-generated	609d82f3-0d9a-41cd-b689-39eaf454deb4	hmac-generated	org.keycloak.keys.KeyProvider	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N
52f37e76-e282-48dc-91b9-8bdcbeecd208	aes-generated	609d82f3-0d9a-41cd-b689-39eaf454deb4	aes-generated	org.keycloak.keys.KeyProvider	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N
bfb733e8-8d98-471b-add3-f40c38ba52ba	Allowed Client Scopes	a7de8481-c201-4c82-90be-4f1e0f9402bf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	anonymous
fd62ba98-ba98-4fc0-884b-567233ec3f12	Allowed Protocol Mapper Types	a7de8481-c201-4c82-90be-4f1e0f9402bf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	authenticated
ab84a838-7e2e-4e44-a1bf-638d1c942fa7	Full Scope Disabled	a7de8481-c201-4c82-90be-4f1e0f9402bf	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	anonymous
7c7e1242-4ff9-46f5-82b7-1d15ff445132	Consent Required	a7de8481-c201-4c82-90be-4f1e0f9402bf	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	anonymous
7e396812-3288-4755-949d-e5993c7e1535	Trusted Hosts	a7de8481-c201-4c82-90be-4f1e0f9402bf	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	anonymous
e3d78707-93ed-47fa-aced-a642797869e4	Max Clients Limit	a7de8481-c201-4c82-90be-4f1e0f9402bf	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	anonymous
ce878577-295d-48d2-9d9c-e280468921b1	Allowed Protocol Mapper Types	a7de8481-c201-4c82-90be-4f1e0f9402bf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	anonymous
bf6709c7-e414-4d05-b436-971b60656fde	Allowed Client Scopes	a7de8481-c201-4c82-90be-4f1e0f9402bf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	authenticated
4f27875c-4771-451e-9027-0d0ec2a836e0	hmac-generated	a7de8481-c201-4c82-90be-4f1e0f9402bf	hmac-generated	org.keycloak.keys.KeyProvider	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N
c59c2908-f6e5-4096-be53-df1a6294ab23	aes-generated	a7de8481-c201-4c82-90be-4f1e0f9402bf	aes-generated	org.keycloak.keys.KeyProvider	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N
ff63d97a-3c33-405b-905a-4d1a5c82b96a	rsa-generated	a7de8481-c201-4c82-90be-4f1e0f9402bf	rsa-generated	org.keycloak.keys.KeyProvider	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N
ec38994d-e1a8-40b2-a510-3b365cf0cb06	rsa-enc-generated	a7de8481-c201-4c82-90be-4f1e0f9402bf	rsa-enc-generated	org.keycloak.keys.KeyProvider	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
05f32e32-7565-498a-99ca-de598c0bcedb	e11e3481-8f2e-4a7e-8343-a4f48140d0a1	allow-default-scopes	true
75f8f743-6055-4de6-9611-bd0cfb391863	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d6a97c36-4265-41b2-8253-30473a5b6cb2	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	saml-role-list-mapper
621ca953-40c7-4218-89ba-e3dfd2ccbc13	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6616fdfe-edb6-493e-b9c1-790cb3fb3192	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	oidc-full-name-mapper
fe738bd4-1704-4e45-8606-cba0d0fe05cb	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	saml-user-attribute-mapper
691306e9-ff23-4239-8fb5-20c1a1da47a9	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	oidc-address-mapper
092f51a4-4777-4081-bbcf-ce16135010b6	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d85d5026-96f2-47d1-9386-20035940e34d	3d65bb5c-17d1-43f1-8d38-14eb6ed12607	allowed-protocol-mapper-types	saml-user-property-mapper
843c48ba-ac52-4ae3-82c6-00a663b1e730	edeac7b6-ad6f-4e87-9fa3-bda301e08219	max-clients	200
b998624e-241c-403f-93d1-dcabf36b15e6	8030ddcb-c6ed-4895-b841-29ddd503d919	allow-default-scopes	true
afa53f26-4b49-4be6-a82e-5d9e87f1a159	eb469c32-923f-4128-b9b0-47dd06f61e9c	host-sending-registration-request-must-match	true
bd3bbd7f-caaa-49fa-a8cb-e3cd3f92bffb	eb469c32-923f-4128-b9b0-47dd06f61e9c	client-uris-must-match	true
7703523b-2b39-4676-91b3-8b969a2ef14c	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1632fc2d-3f42-477e-832c-f83c2dc6306a	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	saml-user-property-mapper
861f2e85-4e92-4e60-8d1c-90a005df86d5	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	saml-role-list-mapper
ab00cf12-399e-4992-8a02-b90d075bef47	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c69161cb-c262-47c1-b544-a0075f5ce6ca	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	saml-user-attribute-mapper
1e20537e-495d-4b7e-8934-c110710cb407	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	oidc-address-mapper
5a51714d-29d6-456b-98e0-de4a391a9213	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8ae2b06e-fbc6-45bb-a466-c1e85234489c	ba466b8a-16da-4209-8be0-b1364445e629	allowed-protocol-mapper-types	oidc-full-name-mapper
84ffbd23-696e-4199-b527-bb248070fdb9	927db376-a235-4e5b-9fb2-600e9baf75e4	secret	ebx1SmtUbW-AP54EI7WGUlLkj_i2iQJILECtTpmgRaYs60d4WIgc5mvWjOJzKtbcY0sxRYETmroEPmLEe7cgJw
830d5ffb-0a2d-41bd-bcdc-121c3b7729a2	927db376-a235-4e5b-9fb2-600e9baf75e4	kid	f2ac05b9-b55a-482d-afcb-b6cc685e2524
c07c8d4b-1d16-48ee-a12f-31ed1e405b93	927db376-a235-4e5b-9fb2-600e9baf75e4	priority	100
3f3a22cb-120c-4c9a-ba32-6b9d05d51ae7	927db376-a235-4e5b-9fb2-600e9baf75e4	algorithm	HS256
66aefaa0-c4bc-4e3e-9669-bce681f385ad	7dba33d8-019b-4929-ab0b-1df095947dc5	certificate	MIICmzCCAYMCBgGYIvtD2TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNzE5MTM1NzI5WhcNMzUwNzE5MTM1OTA5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCj596Whf2v0Sl66HpOZVHZAiWC8pN6BeYWxJ2W9FgASaQJIY8zzWU/tuztNu7nxw/AnBDVo2nXiU+eqp15Bjmh54A/oepRssXlB5ugFs7LDuC+Zw/qfahYt+5xmineMu2TfLEe0HYcpLlzOIJRCAoGueEh1WsLG4DsSCjQPoGK1jHzIjn5WtUPUiLBFzy4iza2FLxsud/VFE1tRCS5wYJxLCuQfQYbZXRGpwLi6cQV8H0v/RCxzcldLyKTL0EoHPcFwih7tIoZauwoLcB7uTHLEFG999W87GRFqNRFTdrRMGe2iT2g27k4Kdtf9YewssLJGwi0X6pe5tmtN2+n92QLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAAHzFAvmPPmbyLiAG2nw3ujUCQntqawmO+xgfSkpJCqxONbyyCMhg/a8tNqaUN3yiBaOkVnrkaUYBgoAcsux2ZYZHjSpi2tgAa1z1iIlSZlF80RjbR9taysOXVuEUSC4yj49tXsRRknRICF2fbvITIF/eo8XCcbk8Haq1/7YuBP/ERHuF3n++OC1rObs8jna7555a/MD7xSlzvO47dyjjbpzuykV9mg1/DlTp3cYja0vNuY5WM22q7FhvyqnoLHO0dzoKzXnaRFdyB7+XvP0ERrgycs2A0qqf6zq8IMU9Jk1b1enBmJdVvgiRoXj8hl5+BPeoLMGwj0LOrPj1KIk2I=
8a5920d7-3296-418f-8de5-4cf0fb1e7416	7dba33d8-019b-4929-ab0b-1df095947dc5	algorithm	RSA-OAEP
d1e3231d-3ea1-4472-bd4f-1cfd94d1f13e	7dba33d8-019b-4929-ab0b-1df095947dc5	priority	100
e978f36a-8bab-4461-93e5-f4b549f83f20	7dba33d8-019b-4929-ab0b-1df095947dc5	privateKey	MIIEogIBAAKCAQEAo+feloX9r9Epeuh6TmVR2QIlgvKTegXmFsSdlvRYAEmkCSGPM81lP7bs7Tbu58cPwJwQ1aNp14lPnqqdeQY5oeeAP6HqUbLF5QeboBbOyw7gvmcP6n2oWLfucZop3jLtk3yxHtB2HKS5cziCUQgKBrnhIdVrCxuA7Ego0D6BitYx8yI5+VrVD1IiwRc8uIs2thS8bLnf1RRNbUQkucGCcSwrkH0GG2V0RqcC4unEFfB9L/0Qsc3JXS8iky9BKBz3BcIoe7SKGWrsKC3Ae7kxyxBRvffVvOxkRajURU3a0TBntok9oNu5OCnbX/WHsLLCyRsItF+qXubZrTdvp/dkCwIDAQABAoIBADjEpazXoppC5M17eGTvpa32FtzoPFjucxceqQAwB8yttMEu3OTRtkgfiKbOOGeRY+zPgOslipKKrcdkC19v3wUq45nmb/w04WKmRGnpjFz6/a8kjfgm5mg36D9zaB3b4LoM3WGxTL819D8qasQ69xIGTinEO6tgrsHnai9Z/s8BO8Z8vPeGVqcgoEUHGgXPSObPdR1zx33fowttpS8R4sv2ZQQX6VpUBMYHm/31m+Epbx5QJIHDR6lNOAkOZW+7In9uxPge2FezEHF1Z4pBhM/3uHwSE0jftKlVt2aLlKb2CN5m40cGyt7iDF0EoakgnYl+zU0wtg/uMMnu4z020VkCgYEA1pYDCkz8Z7qmZF1andGHLpq/dSMU95fW3M84fwNO1dCS9ivhll/8hNqlwgft3SlcO7DK7IFpybvmNACOdrym6G4yX3paDqGcmnHmPRpo3N7Pk5gBShuP/89TS/h9cfBFmHWNOdcOi3GeoQW2TCRabgRp7fjk3TfRSEc1ucC36nkCgYEAw4np0WO7uYEu3yx/S2S1bOH8EuJY/PM2rIKKkO+IO/hnQd9fPrEAYmuZppzmzV1QMaR3tqTorsZuZnO+SJJO8m3uNrL10YVQDqgh6VQMxLgND4McFMfHzPu07sb1Q85w+OZMbUlI4sGQvvHiLd1gWR7Yt02Z1hsksf825xHfoaMCgYARcFOC7Mq+a07GbUfF95cy1GSm0lkL3g0aGMUQnWY0viSTWPGWVOqiqVo7MIXGKWxTdYSoP8QnHtwQcdMiFybBUONLGxhihAPEEWmSoajP+lOIPRwtt5u2QFUWoXUgY1RklXkKsE2AS5WGpH4yJeorcrRhII8I41Zgt1jIZb8MkQKBgERd+fSODFrFwh+hrTgtFAnn0XzAyyBV4S3bzpryRQ3CwkeT0/dVZ68BtA0/Gqt/DsTsnjar3fcNxhfoLAWvsg6tRPa3B5+kHuOhAYpVKsm1GEvuKWlSmJchApfh1GtKyNEdpGcpkmRGDVfVtqEWn9NJJ7ifV0Q25VOeyhFsfGZFAoGALTXpeLg6A7wFER5PEYFKvKP0kUdrcHJJxTk2qOqS+lLvqZQzaT5qEcRei2P46qjv3L/wrMpwa9UUGWY4wnzuEHTo9I/pUEAs3A/kKJgY8zx1TkS91++1/F4PF5Myph6Qc8cVcl/26eKsKRg/USIMZuHVIiizwOwLAm09XLLHpUw=
c83996ba-7aab-444f-98f6-d503bf62c9e8	7dba33d8-019b-4929-ab0b-1df095947dc5	keyUse	ENC
a82f3833-8e6d-478c-a86f-a3523cb2be16	52f37e76-e282-48dc-91b9-8bdcbeecd208	priority	100
bd752126-b04f-48c9-96ca-c433384e4415	52f37e76-e282-48dc-91b9-8bdcbeecd208	secret	rMsBpB842tgmMMt8gYYW9A
6f2dc298-4285-4f50-9129-406b9409a98b	52f37e76-e282-48dc-91b9-8bdcbeecd208	kid	72db40a9-b11b-4f4c-a493-8e87db1a4372
38074875-d4cf-4cd7-9825-b0e80422945e	fc102add-4772-4ec5-8fe1-b92af0abfb3b	keyUse	SIG
ba6e1b79-bcd5-4f7a-8848-1bc5abf542fe	ec38994d-e1a8-40b2-a510-3b365cf0cb06	priority	100
83cdad2c-a466-43a3-aa7e-aa456cf68f72	fc102add-4772-4ec5-8fe1-b92af0abfb3b	privateKey	MIIEowIBAAKCAQEAp0tdXCTc9ZZ8suWc0dIsqtjOJ8dF0zqtmTs62giUL4jrghjYY8EqAvHjPviP4wsbEbH+9RzhAugqK2ea4AZtHC7rJCCV/nRhbDSoojKFWQnn1Xs9VDYXbbpU9THNn1Yvz+9LDb5r87ZbzLEfW2+bjNvmQZkD7v2tbu3vOXOYefE/1CDG1qpEY4QBsVGeWi4OPRRhBoZ3VQ+n/+InQAI91E9R175JrsNHL+U9Kh81Sxee35O0Bgd0vECaVgqvjDCXEAxngFrWQenp8dNLWm9TVp6vJYUHMmoEdouUV2HodawzV8di4xLJS8rrXgHmxgvMwk+4seMFC2pzqOWkmlNYMQIDAQABAoIBAALqX63Bpsq+UQ08g86IZPmDrTjrn9Lr+Pmp5ZHw+sqm3mevoMlLxPHPpv9aYqZmfkCL92VXN+YWjKzBxGo63cYjMfCY2LOvnJafprr1ahDPPl0QcH/IxcuhHEEN7t9D58dIxy2YaTOXuhsLu5qlho/70YQTW2qBR/y40jMK+aq8hK6DJCv5O6rmJ5z4Vb4/lEdJaB0RgeWcCZ0z2mfJWsXZZcCGxnigtqq5IEd9Iif8EXpo+/B1aH0aYNo8lGeZ5a66z2rzW5PWjlIFhdYsZct/7XzvfrXo+pUTXNcnwFvRn3bXE+HJ3/UjcrMYCEgVP7qUlvkoLEPaXq4vB7z8TsECgYEA3YrY2AodjzblBQ1K3flrqiN++i2kdtPiBA5JJDqxsDnJQP6E+xRpSAjUOO4JpdQMpwpef7LTEkdiOgez0kVihtVeqx5/CR0qLXFk82nUpD00Nj4mrm8ljyv3U/RMPhInP2TdkgEnbiFvRHEFHKcAFJ23pTwEAhQwgyuvAsr4HkECgYEAwVCGm8y01ZuJA4h21FhWf8rjR6aUExdgMvmYPY9V7bMkD7xMj2o8pKDhnq2tWYhyiJb8IRgzj4BaWWzhJ59Rrogvk+A+hOdEebbOVcQ8y5jriZATHq44ocCLe3BqEwcIgr9/Iu77uU0S+BZn7Gcb79euHk3OXjemc+qPbqHxnfECgYAIVFASz06NM+MobXeDIP2LSApeHZkxXoYA4Qie9BX6KjIG34rgZcQPkUVpXom+UlqnbRxgcLi+1zA6Pk/kd/dcWmlUxbDBBveu/bRt8mysQCDWaT/LDyK6X0zNO0Iik0wmdgRemOyCl383c4hdq2m1XLiq3bbI3Tl1tQ6/bCIoAQKBgQCK+ybbqi+0hu7ZkGnGPoBpvebrI3K/ywWJgHKYh42CqFFb0sfEL9/LiDLNTxYbEYMuekZoUKr5F5FdS28QenVSImz6RrUL/ez4CJqNhNkkkxt7ug5U93KVsAVXyLkqVtsijSSNa/2j+iqSHCG5D2RBafGvrcaZbC8KlW9rXZiFMQKBgElG3VNgg8nAiO373voDAeblSHMoYW187dtC+E3G+K7OKublW4t/SYrzurYrTkV9nvadFR+BdWV7tj8SwgowMar3tBRqOiJQYeX/0g09Q9URPmIrLEimFc1CxlFBiXutVWi315bFnRG96BpacKlPmdl+BKhFCzay7D2Pr1NQ2lED
e90c6165-d9d2-45e8-a668-2a40e4beb722	fc102add-4772-4ec5-8fe1-b92af0abfb3b	certificate	MIICmzCCAYMCBgGYIvs+8TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNzE5MTM1NzI3WhcNMzUwNzE5MTM1OTA3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnS11cJNz1lnyy5ZzR0iyq2M4nx0XTOq2ZOzraCJQviOuCGNhjwSoC8eM++I/jCxsRsf71HOEC6CorZ5rgBm0cLuskIJX+dGFsNKiiMoVZCefVez1UNhdtulT1Mc2fVi/P70sNvmvztlvMsR9bb5uM2+ZBmQPu/a1u7e85c5h58T/UIMbWqkRjhAGxUZ5aLg49FGEGhndVD6f/4idAAj3UT1HXvkmuw0cv5T0qHzVLF57fk7QGB3S8QJpWCq+MMJcQDGeAWtZB6enx00tab1NWnq8lhQcyagR2i5RXYeh1rDNXx2LjEslLyuteAebGC8zCT7ix4wULanOo5aSaU1gxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAnp6BJ8/dCsuBzMClNhH6+AEIpxgSUUI3lXFUFjfCpGffF6hvWgcuOnmznoBX3a+4bWCOaoop4UycSe1HIk5auIPpAysI2Vkjjwl4SN46Pki2zS7FMpuGzfWHBoSjHuXYl4XR1guhg/yZgVOvNbBzVUplCudy1tPyWGkmqPtKHcGSs07Vwp4xLq+ISSPYfk6LelMj9NDHRrXJkuhLkBlSbEclgapJ2/W9noiyJzcXrCNPKvmCRRd2oNHw5M7x6h8m8Uc6bhZWp0FulBJq8lXOZ419XBUbu6bwD+S4LlVv6JQLKijomWtbbzclwg3I6IxBUSALo7PL6l29tcQSWcR9I=
664bd292-5377-4e95-8774-88045bd60fb1	fc102add-4772-4ec5-8fe1-b92af0abfb3b	priority	100
2205c206-505e-4e47-a272-a43889208c91	4f27875c-4771-451e-9027-0d0ec2a836e0	secret	y7kD2sNO_bIhldX0kjidHhWE5ZmiuN77dH3DBNInH9em8bmphi53OAH5mfW6UjcTaX4DjTI9ncfjT66bQZfLEg
f7aaa4f0-030f-40c6-bac8-eca5668a76ee	4f27875c-4771-451e-9027-0d0ec2a836e0	priority	100
f221044b-0ef7-4236-a318-fe47086ca982	4f27875c-4771-451e-9027-0d0ec2a836e0	kid	7b0956ca-c921-4847-91fb-9cb78b7b234b
442a9a6f-f4cf-461e-b632-198970a397f1	4f27875c-4771-451e-9027-0d0ec2a836e0	algorithm	HS256
913828b1-0b57-4948-bd22-edb2a1f65a19	bfb733e8-8d98-471b-add3-f40c38ba52ba	allow-default-scopes	true
2326712c-ace2-46d2-8cc2-83be2008daa7	c59c2908-f6e5-4096-be53-df1a6294ab23	kid	ff0ee39b-aadc-4a39-8873-0e6dae9d5db4
07d9ffed-618c-40b8-8485-bc003cf5c6ba	c59c2908-f6e5-4096-be53-df1a6294ab23	priority	100
b874ed30-df7a-4819-837b-87f421c0f20b	c59c2908-f6e5-4096-be53-df1a6294ab23	secret	Bq36QV6suXU-ZC8sh1OQ2A
4a0a7a4a-3132-408b-b663-bec5bbaac36b	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	oidc-address-mapper
ea57e51e-da91-48ea-af80-907a32a3506e	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fc53b762-5ea2-473f-a995-68aed7f86ad9	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	saml-user-property-mapper
502dbdc2-36e8-40b7-bc02-5bd75f91e9a4	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	saml-role-list-mapper
7a238318-9050-467f-ba2c-76515e49e92a	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6e301d08-050b-467a-be81-96aa07ce3f44	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	saml-user-attribute-mapper
a7940c33-00da-47de-b23a-0bb80017b119	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	oidc-full-name-mapper
b4fdd21c-ccdf-4fca-b6f9-ad597731f954	fd62ba98-ba98-4fc0-884b-567233ec3f12	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8dd0fd32-96eb-4bc0-81f3-f58b61e8427a	ff63d97a-3c33-405b-905a-4d1a5c82b96a	privateKey	MIIEogIBAAKCAQEAw3H2aReUPK59Tt4ZWhcHLrEdu9Dj2qauKaH3BwlbhmS4lIurOVnBWSTyrRDGRpK8aTzNFBZete309wVwozmYksEvyYw7fzbio57ILJs1QwAh1y4Paj67Nz5aHrHQoNEk+JeLNLIdDijGU/iNYp5nFCnUlKxFh7/I+AGDHFdlDz1MTiKp4sZbfvrCT2ExPXGnFV6FPk4giWKFVYQDuIUayn1s8/giXTcjIvw/1NWD+lPcoMw2Ijk2LZPmZgAudSw5/dUcqoeBQORnZ3o7rOpKMLDfwyowRKK8x8vrojeRaFgcgSGRLrdlbfWi+93qpAevsQJmZ6qAnPVyKKDQVnfyfwIDAQABAoH/MWRCciAI5vPj2GOWXZ1d8IUU6Eu1dfueYP1VyVAOg0xVFmzRXjKIOvPjxF5im8w2mYMzW51tBAd3ym/YShm+i1fXsKhFVcqfT2xLgybXhpyudjhPESZZ/Sy5maQITPTm0kUKpjBGuCvu0aLG9tdT54HMIP4EDrmglb5n6XO9TgXrKK3Ou2Qpk7gbpyBzwhFjImwmYPNTcI8Z3wGR50fP0S2R2IEuMvCZ/DCIPgL/VWbZjK1hwTiv3KwY5TZdlOxJTAyHs9hT+k7pL9Uvi0T8+gDeCFqKYJSiXxQsKibI6bpKC0sGSn7yOQtPYiXgmCzdP6WyHfWu5ASXPBsL1ngBAoGBAOCuxNe8hZH0Q67I31fDuQGRXYBPNcacePelPlQb+foogUQIEDjZYT+sh7ZWUE9ZDjkCCWy08SBoSENTEmwEu2/RhZEjqJBfKMojNiy+hXAdQKnavdqAYDTWT1UnIvGV/fvYdqvMMwizeYyY9d2Uj8j96374lzq6S9Y3zortaUc/AoGBAN6v7UP2174j9TnLmYUdKysUlb5Sp6Cju7b/VPkWbPFHW9VjAnmn1SEt0c1KecNDej8q9G9JhJ3e4oIIPcJkzd76z+KII6Mhn6r2qBbnFlva3pd8Xa4OnodF5BHnj9XCj4VYxaKOvLbJqaJ1ORV6RWXh7Pk6Eq/wk5My4gTyM8TBAoGAU8/977gMX2Ct6sJVxghlt/cA2P8zQS5XVZHXiUqSWkXHypfzbTFxvG3ghhz2glLnIk7nMxzgIcWkxzBy28Z8IP8Ygwa5N3m33od6CwDbB/Jxj6rgTWS7/pm/KDWcLGBWSR77TaSzmNhSTCc29/wWEtTdhxS2XRrndTaGHn7nWcMCgYEAgfc5SaZCKeXAlHegZNEuRZlg/9ArpxSIVPhWNn4BHRxhm3uKkUgDmrasMN1bjTvPmBhQyrakoKLZnbyDlvXQNWg6deKwsd/I2TXVynAaW4e0y8K4xgIgQaDnyA9WohJIQzIZPpOBzkiKKZeytjdDU3/1F0vuZiLJbmqPAQX+csECgYEAwkFp32bujDK0wsZmX6zbIWoeafzDpntToXpSRdwKgSqvy1ipJBrln+AFBKUctEI6PUDbkG6SoQLeHYZMK/JD4UXr0DBZ9GBFIyaVm0xLMe17Jpp/tom7iWCQz9sfS/+zSZv7O0M2zVHJgJHXWx2p90uYqkzPC1+x5CoUgiJgJoo=
7a608340-c8b0-4a51-ad41-0b7b8f0f4af8	ff63d97a-3c33-405b-905a-4d1a5c82b96a	priority	100
630ae4fc-efef-46bc-976b-db4386247d5f	ff63d97a-3c33-405b-905a-4d1a5c82b96a	certificate	MIICozCCAYsCBgGYIvwnyDANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDAppbnRlcm5zaGlwMB4XDTI1MDcxOTEzNTgyN1oXDTM1MDcxOTE0MDAwN1owFTETMBEGA1UEAwwKaW50ZXJuc2hpcDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMNx9mkXlDyufU7eGVoXBy6xHbvQ49qmrimh9wcJW4ZkuJSLqzlZwVkk8q0QxkaSvGk8zRQWXrXt9PcFcKM5mJLBL8mMO3824qOeyCybNUMAIdcuD2o+uzc+Wh6x0KDRJPiXizSyHQ4oxlP4jWKeZxQp1JSsRYe/yPgBgxxXZQ89TE4iqeLGW376wk9hMT1xpxVehT5OIIlihVWEA7iFGsp9bPP4Il03IyL8P9TVg/pT3KDMNiI5Ni2T5mYALnUsOf3VHKqHgUDkZ2d6O6zqSjCw38MqMESivMfL66I3kWhYHIEhkS63ZW31ovvd6qQHr7ECZmeqgJz1ciig0FZ38n8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAn7qrqdsbFhahfj4mjlKFpVy7ZpBRe+k5JgurffI6Blj4PeEAFt+HqRqfGSm2C82JLLhw3WHqY0Z+pavhvmAxWVAnN4JO1wvJmEsTGxiGB2pinbYHUfYBcHthk9WvyOouszD6PQkb//vcugrMpVruH/U/1e2w6ojdWApMN4eVAoCGpF+KwfcO7i7RhM5OLNpljXpsViv6dLN91f1w2avlv6hDTX2wc3++GSo0AMkQKvbdwteuALSl53N+H5ZWZV3WTzbjx3QimqGtQGdqWN0bi2UMxn8QEFUfcI2aR+GmrBZW3ZI8TyLGfShzh7qxyezM4g2eP6pAGnbK++jyIq4kHg==
cd7616fa-35f9-43b3-83bb-5e7c777728b5	ec38994d-e1a8-40b2-a510-3b365cf0cb06	privateKey	MIIEowIBAAKCAQEApz8OlWCGJm5ZdGjpub7sPDFnks2KsgZ9MM5udZp42PfGxIdoxOgAxnF7nblZFclypAs6DrdMtCK2YL61ygZIyOrJmWFaDnqv/T0Fyg2dckPbX1j1RBgOvFRpKI7ifAG6a8I89qxtzR5YIRhCrAzCAa+7/sghQBpq7uDPOBE1kTPUQHK+DHiN808bhBUuce3eQNEM5vG2WnOG2BaZ7sTqrhYPuEMTCDnkJHRtSuSq8n89ODQrFdsI2+rsmW+8StlkPv+ZQZixlNTunZzCp6Xbe4tujDfq60CKc4qxSMgg2aM7zD3DlDAI0W4Hm2ykGhsuoTMa7ZLKnDZp0+zDAdMAJwIDAQABAoIBAC1/nRMMOFKaMKHXrMYIZ7IUaq3oVvQJieNONYSu6nN0LNHoWJtA1n0mAFAvTUn9DMAOAdRhD2/uBZmaKFB2lzR5kzCz6FEKFXiaMkn+nDequDJfPBIzTUb028rZ3EmKGtIX/IfK7vAfcjBGrlSp/9l/mnA8t7b9uNuVsyn4nI8Mjlv5mldJoRlc0k3uj/GW154JgLki/wuziYVEyfOVz/8eZWm/tJwBtlqFIWtLb4wYBeJMliiDolwyjno6h8RRPMj5sc4/pYXirvPAuNuk6rxIXdaeWmAqhS6Qk7SdUmpbqtDQA0iCigxRmIyX4+BvNgHQ6gK9SQ9uMlDQgV5ZtTkCgYEA5ddvKeu9gwCWoBjcRNEerBxz7g6rK0JDFIUlFj3vKNFoha5DOpTJ30/ref5Ws4cWL3JSxOL3iA1kI6tT+oGUxRyCmD8C8ITqQCkEsItzwauTtPbmLnHLykeitnKkp6dNtn0oUbW0SiATH/vMVbomqAcnKtOyXypjl9NdZVX536MCgYEAukff80i4R8V6TLa4zoRTLWt3SQzNryOU5Xf4Sdz6D9g/8k8xIi/GbIZfvfNcX8GRfO7PZrqF9V9c+is/Usgl5IbkLIDRziKfgIQTyk/NyTbq5qQQFrJVA1q0U/UueMGPaYhOLKN8f3WdK/fIKLFwa4kMEdHzNCOmxY2X0gzPla0CgYA7/dlkJcYXdYXbT+HejH7nCZ4w2t9OsUL1DjO59HyCOPaBPhUKK1/ty9x4wSw8O9xMkhiMj3lwp54luUh4MG52bJShzICl6uuBx7MTqbKTMIejSnaWVNmOeNg9qvrTT9X29gAaI8VlO64CQST6k1YXsZZFlXAPau8H6AGOu7w25QKBgQCOE33Cr2cmDn89/Wss0A4kqT98rtA90VSiRANSSsFKznPPWwkteuTLJx3k4bVFr3xInlf/kSnUwRxIDi4o9FC6YQusyb+7ifq/aX0yo/Vfj4xPxzgiJ3fhrA+3rVv5bB/2rKh7MWImUM1EmKLILrWAvzE+cjQdQ0fSizENWwoErQKBgCJxS4AyuO3BUyRW+2xNg66i40QCRgYvZLWOJBwRM0rgVA4azmOafC5g7EJxSJXpzrLvGHnn5DBuWM9q/d742NebFydhZb3TBq8H5UgAgtEg0gof1fIKad1P8iyeu0yDojrhEiqfKmC6qH+g/u58GY2SykFrHryPUkRsz2DgxstG
2556a859-a7ae-4a31-afd6-ef1350fd9c7c	ec38994d-e1a8-40b2-a510-3b365cf0cb06	certificate	MIICozCCAYsCBgGYIvwtWTANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDAppbnRlcm5zaGlwMB4XDTI1MDcxOTEzNTgyOFoXDTM1MDcxOTE0MDAwOFowFTETMBEGA1UEAwwKaW50ZXJuc2hpcDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKc/DpVghiZuWXRo6bm+7DwxZ5LNirIGfTDObnWaeNj3xsSHaMToAMZxe525WRXJcqQLOg63TLQitmC+tcoGSMjqyZlhWg56r/09BcoNnXJD219Y9UQYDrxUaSiO4nwBumvCPPasbc0eWCEYQqwMwgGvu/7IIUAaau7gzzgRNZEz1EByvgx4jfNPG4QVLnHt3kDRDObxtlpzhtgWme7E6q4WD7hDEwg55CR0bUrkqvJ/PTg0KxXbCNvq7JlvvErZZD7/mUGYsZTU7p2cwqel23uLbow36utAinOKsUjIINmjO8w9w5QwCNFuB5tspBobLqEzGu2Sypw2adPswwHTACcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAMeG1r2oEyt9VXJ1MBgJM2lvmVFk2TgZF+C2Gt1WJ+dIl9AP6QKJ65XVM5mbs0RYz8NENLMGQYj3tFIxmYjj1cgfEKoIm0mL02Se3QnR0Q66z3EsZ7hjf3C5DjQoYdeud39ZSAXzEtwU1rjvbW5SzLLVXOSMcNan561mlfawHaqg4KVqACLWTYCcZuJgS9hvASpV8+qmYOmkmdbPuHzuSADeFuI9KtDTh2SnVtoXcajqCbm8u9+1FGTz3zbCuRFdLUESysftzHg43T/FX8L67F0Urk2LR+4Ygo1QmLBPVVrdw/X0ESwOvpCGDve7azrGCUvuuGV0N8Ho+T51tPZDCiQ==
15fd03d8-3b2e-4315-8b28-6359b66b1b0e	ec38994d-e1a8-40b2-a510-3b365cf0cb06	algorithm	RSA-OAEP
870899f9-e910-4749-a640-abc42d82e9e0	7e396812-3288-4755-949d-e5993c7e1535	host-sending-registration-request-must-match	true
506e0e67-a9f5-456c-9814-5db9e6b09e6e	7e396812-3288-4755-949d-e5993c7e1535	client-uris-must-match	true
ce1b8c14-5112-439e-9bcd-cc72bd52e127	e3d78707-93ed-47fa-aced-a642797869e4	max-clients	200
797d0712-e10e-4977-94a3-4a6a3de67ebf	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	oidc-full-name-mapper
573d45bf-53ea-4fb9-96c6-03d872325b4d	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b9bc907d-8573-4dda-a3c7-cf628770fcde	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
eacedddb-e472-4ad5-b78c-f9f21b6fca22	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	saml-role-list-mapper
fd633813-c954-4616-a837-4e9e56563321	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	saml-user-attribute-mapper
cebeaf51-cc11-4487-bd5a-df9616faace6	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	saml-user-property-mapper
3bdadb93-f4e9-4450-b3c8-73110221beb1	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	oidc-address-mapper
2ba77d0b-8ba2-465c-b9da-49668dd62bda	ce878577-295d-48d2-9d9c-e280468921b1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8b4d2169-615a-47ca-a6c5-31be5a41f725	bf6709c7-e414-4d05-b436-971b60656fde	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
f71c3dd0-c426-4b7a-b81c-595ce53eb238	c0ea1d9a-65e8-41b0-a62c-9dca2548b081
f71c3dd0-c426-4b7a-b81c-595ce53eb238	da368b94-73aa-410b-87e2-961f17112711
f71c3dd0-c426-4b7a-b81c-595ce53eb238	a3db6fc0-5d59-48df-8c64-75db0fdf30d2
f71c3dd0-c426-4b7a-b81c-595ce53eb238	3f88d0dd-cca0-4395-952d-0ad4b4e12d06
f71c3dd0-c426-4b7a-b81c-595ce53eb238	f84d2306-827c-4b28-a7e4-0953f5eb06aa
f71c3dd0-c426-4b7a-b81c-595ce53eb238	c1abfc88-9b47-4a1a-9dfc-6dd1710e6115
f71c3dd0-c426-4b7a-b81c-595ce53eb238	610aa7df-98ad-4c09-83cc-6539252c4fc9
f71c3dd0-c426-4b7a-b81c-595ce53eb238	7bbdf24e-f3aa-44b1-9fb5-13f69a7356f8
f71c3dd0-c426-4b7a-b81c-595ce53eb238	5bc55ac4-524f-40d1-a1a7-6231a3e91a86
f71c3dd0-c426-4b7a-b81c-595ce53eb238	c8f52fb7-badc-45e4-a625-065c573336e1
f71c3dd0-c426-4b7a-b81c-595ce53eb238	7c6d4613-5a11-4601-88a3-976abca63bcf
f71c3dd0-c426-4b7a-b81c-595ce53eb238	63170532-22bb-4fcb-ae79-d584a56027e9
f71c3dd0-c426-4b7a-b81c-595ce53eb238	be0030ec-8201-47f0-a9fe-f3279c7b41e9
f71c3dd0-c426-4b7a-b81c-595ce53eb238	4c13c77e-acf4-4e88-bc63-6360bd241055
f71c3dd0-c426-4b7a-b81c-595ce53eb238	3c95d7ec-f965-4c02-ae79-4779d0c96f1b
f71c3dd0-c426-4b7a-b81c-595ce53eb238	47c19639-27ce-4b56-af3f-62d7803c7909
f71c3dd0-c426-4b7a-b81c-595ce53eb238	feabd802-998b-4811-b395-482de813b98b
f71c3dd0-c426-4b7a-b81c-595ce53eb238	969660be-b39c-420c-82b5-f20366d7e859
0d289b57-3ba3-4bce-9688-67dc52a39395	08f99301-f14d-4e72-8b87-fb3685b2639c
3f88d0dd-cca0-4395-952d-0ad4b4e12d06	969660be-b39c-420c-82b5-f20366d7e859
3f88d0dd-cca0-4395-952d-0ad4b4e12d06	3c95d7ec-f965-4c02-ae79-4779d0c96f1b
f84d2306-827c-4b28-a7e4-0953f5eb06aa	47c19639-27ce-4b56-af3f-62d7803c7909
0d289b57-3ba3-4bce-9688-67dc52a39395	8488278c-2db7-43ae-993e-0b78c4fde7c8
8488278c-2db7-43ae-993e-0b78c4fde7c8	d8cd31c0-4ad8-46dd-b413-8c54fdaf9b49
77b5f611-8f58-4222-9b61-70ea541cc4c9	c405dc30-a4e1-4ab2-bc57-fae05e7c277c
f71c3dd0-c426-4b7a-b81c-595ce53eb238	b3f7fcfe-665f-422c-9c48-3fb6956a09e0
0d289b57-3ba3-4bce-9688-67dc52a39395	d707eab6-9630-4649-b84c-d2858472cc60
0d289b57-3ba3-4bce-9688-67dc52a39395	1ecda296-b68d-44be-acbc-325b0910aec4
f71c3dd0-c426-4b7a-b81c-595ce53eb238	84d8a691-5b37-44a6-97b3-8ff6f9fbe43b
f71c3dd0-c426-4b7a-b81c-595ce53eb238	995fb67a-55be-4308-a327-cd5492f4c0b9
f71c3dd0-c426-4b7a-b81c-595ce53eb238	493e76ac-8af6-44c2-b869-cf37e160a5c3
f71c3dd0-c426-4b7a-b81c-595ce53eb238	91736d99-ecfc-4608-9b1d-2fa4506e68ab
f71c3dd0-c426-4b7a-b81c-595ce53eb238	c1ec21fb-9e6d-42bc-80d7-c054bcc383f4
f71c3dd0-c426-4b7a-b81c-595ce53eb238	f3ea56f5-74d3-49ba-b5aa-65e251544c3c
f71c3dd0-c426-4b7a-b81c-595ce53eb238	fb650724-90b4-4e64-8f73-b5a432c18b41
f71c3dd0-c426-4b7a-b81c-595ce53eb238	9df9c0dd-5bb2-4b18-96bd-b9d8f024127d
f71c3dd0-c426-4b7a-b81c-595ce53eb238	5fbbf7fb-4cc1-40f6-9d16-18bd0b7f83ab
f71c3dd0-c426-4b7a-b81c-595ce53eb238	700c9edd-5552-454c-9ce8-986a548ebcc7
f71c3dd0-c426-4b7a-b81c-595ce53eb238	d05f2e3f-da74-4b58-bf07-9ca792421e83
f71c3dd0-c426-4b7a-b81c-595ce53eb238	8913f3ce-ff15-4281-a52f-c03fda9ce38a
f71c3dd0-c426-4b7a-b81c-595ce53eb238	c68fee8f-8b79-4f51-ac08-f12b8bc34aa5
f71c3dd0-c426-4b7a-b81c-595ce53eb238	27d44685-face-4bdd-ab62-c7f721731ec8
f71c3dd0-c426-4b7a-b81c-595ce53eb238	45930519-0cb5-49cd-8101-05aed82c41aa
f71c3dd0-c426-4b7a-b81c-595ce53eb238	4bd99687-dda4-45c0-922d-3e40d7e7fa7f
f71c3dd0-c426-4b7a-b81c-595ce53eb238	b2bdd427-f171-43ed-a183-64e5a7999a5b
493e76ac-8af6-44c2-b869-cf37e160a5c3	27d44685-face-4bdd-ab62-c7f721731ec8
493e76ac-8af6-44c2-b869-cf37e160a5c3	b2bdd427-f171-43ed-a183-64e5a7999a5b
91736d99-ecfc-4608-9b1d-2fa4506e68ab	45930519-0cb5-49cd-8101-05aed82c41aa
48dc8d0b-dc56-40cd-87bd-30d025233327	1a0c8689-5fae-4830-a076-d349fd58e749
48dc8d0b-dc56-40cd-87bd-30d025233327	7730a088-83d9-4a65-8b8d-2824a609a1f3
48dc8d0b-dc56-40cd-87bd-30d025233327	e665abdd-ddb6-4ba2-ab26-c5f2b4e7ceef
48dc8d0b-dc56-40cd-87bd-30d025233327	57ad0429-9cda-4fb5-81a2-a7cbd22bfc0b
48dc8d0b-dc56-40cd-87bd-30d025233327	7cd47cd5-f3c5-4b93-b0f9-137d0d47dde2
48dc8d0b-dc56-40cd-87bd-30d025233327	a0db6a17-bce8-43bd-a527-0efcd8c45b07
48dc8d0b-dc56-40cd-87bd-30d025233327	d62c3f2f-aeef-411b-b92d-42cdb443b89b
48dc8d0b-dc56-40cd-87bd-30d025233327	08752b3e-69da-4a04-8042-2473c269d444
48dc8d0b-dc56-40cd-87bd-30d025233327	589eaab1-72e2-4ea7-9298-a5825ac32349
48dc8d0b-dc56-40cd-87bd-30d025233327	16340e7f-dc46-439a-af1f-ab9d8859ae20
48dc8d0b-dc56-40cd-87bd-30d025233327	0a10e393-92a0-41de-9c15-979e00d5a839
48dc8d0b-dc56-40cd-87bd-30d025233327	8fd9d369-a701-4dea-a211-f7a14d81ae8f
48dc8d0b-dc56-40cd-87bd-30d025233327	d1ad56c7-f4e3-43fc-9478-dccbc134796f
48dc8d0b-dc56-40cd-87bd-30d025233327	e3ca33d9-a2f1-47fc-a3db-14086c65a137
48dc8d0b-dc56-40cd-87bd-30d025233327	f711b8d5-1e94-46e8-896e-7dd7fd17678d
48dc8d0b-dc56-40cd-87bd-30d025233327	08a380c9-d8d9-4347-9e65-2807c3aa73d8
48dc8d0b-dc56-40cd-87bd-30d025233327	b1af7602-2902-4022-a4af-afe460718f67
57ad0429-9cda-4fb5-81a2-a7cbd22bfc0b	f711b8d5-1e94-46e8-896e-7dd7fd17678d
85652830-8607-4af6-8ea4-ddc166fc0f1d	c06670e9-d902-428c-a1a8-e642f4537cbe
e665abdd-ddb6-4ba2-ab26-c5f2b4e7ceef	b1af7602-2902-4022-a4af-afe460718f67
e665abdd-ddb6-4ba2-ab26-c5f2b4e7ceef	e3ca33d9-a2f1-47fc-a3db-14086c65a137
85652830-8607-4af6-8ea4-ddc166fc0f1d	0d4a78dd-dd34-4d13-887a-834541cd33fd
0d4a78dd-dd34-4d13-887a-834541cd33fd	eb70cb12-d8d5-418b-8659-22ae217dd11e
9e638e8a-fcd5-4ec7-84b8-68e371a939a4	0f9678a1-5953-4952-bae7-faa2f6679a3e
f71c3dd0-c426-4b7a-b81c-595ce53eb238	ccf9297d-ae18-438c-b7d2-a551214cebd7
48dc8d0b-dc56-40cd-87bd-30d025233327	ae90bda5-db72-48c1-9044-3f7edd401581
85652830-8607-4af6-8ea4-ddc166fc0f1d	43f9a56a-151f-45fa-9c24-5eecfd3dccd6
85652830-8607-4af6-8ea4-ddc166fc0f1d	af1aa306-0612-4c6b-be82-f749407aba52
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
e1442c10-c0c4-4eb3-803b-570f138766ea	\N	password	ac9b5ddc-703f-4896-af4a-df35265bc770	1752933552938	\N	{"value":"ZCULiEqBBXVH77ZKtLm7LLe7/yLkp1QrUjwSmUePLZgzX0ojmvUyZNrd3a8bU2jXJw8FqzEEMmoYaH9T/tHqOw==","salt":"tgVrC4rAwNGjKSc6nbbzhw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
e2eaa059-ea8b-49f2-8765-94da52f6d0d9	\N	password	fae344b0-24a5-48ed-882b-b1a5f0240952	1752933664817	My password	{"value":"GuyxJOVG+0o8xku2YvsFhE3LH1MkHv3+MKDPOtVE9mc9ShPrvJtAzZcKpcNi5/oBdMd+G4zi14NNz2Q4wevCyQ==","salt":"Bvv15UnEp+JuQAyM9w5AkQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-07-19 13:58:59.753661	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	2933538453
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-07-19 13:58:59.78604	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	2933538453
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-07-19 13:58:59.922075	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	2933538453
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-07-19 13:58:59.933997	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	2933538453
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-07-19 13:59:00.19821	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	2933538453
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-07-19 13:59:00.204387	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	2933538453
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-07-19 13:59:00.433009	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	2933538453
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-07-19 13:59:00.439377	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	2933538453
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-07-19 13:59:00.45267	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	2933538453
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-07-19 13:59:00.677278	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	2933538453
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-07-19 13:59:00.823835	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	2933538453
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-07-19 13:59:00.831106	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	2933538453
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-07-19 13:59:00.87427	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	2933538453
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-19 13:59:00.918285	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	2933538453
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-19 13:59:00.923054	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	2933538453
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-19 13:59:00.930362	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	2933538453
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-19 13:59:00.935404	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	2933538453
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-07-19 13:59:01.029384	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	2933538453
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-07-19 13:59:01.132094	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	2933538453
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-07-19 13:59:01.143942	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	2933538453
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-19 13:59:02.282991	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	2933538453
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-07-19 13:59:01.149716	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	2933538453
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-07-19 13:59:01.166525	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	2933538453
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-07-19 13:59:01.226513	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	2933538453
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-07-19 13:59:01.241938	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	2933538453
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-07-19 13:59:01.249045	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	2933538453
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-07-19 13:59:01.33516	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	2933538453
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-07-19 13:59:01.504556	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	2933538453
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-07-19 13:59:01.512998	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	2933538453
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-07-19 13:59:01.65648	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	2933538453
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-07-19 13:59:01.687515	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	2933538453
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-07-19 13:59:01.731345	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	2933538453
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-07-19 13:59:01.742173	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	2933538453
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-19 13:59:01.755977	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	2933538453
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-19 13:59:01.760883	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	2933538453
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-19 13:59:01.826771	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	2933538453
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-07-19 13:59:01.838417	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	2933538453
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-19 13:59:01.857691	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	2933538453
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-07-19 13:59:01.869265	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	2933538453
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-07-19 13:59:01.881116	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	2933538453
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-07-19 13:59:01.8868	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	2933538453
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-07-19 13:59:01.892514	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	2933538453
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-07-19 13:59:01.909112	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	2933538453
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-07-19 13:59:02.255615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	2933538453
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-07-19 13:59:02.264686	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	2933538453
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-19 13:59:02.297965	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	2933538453
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-19 13:59:02.302975	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	2933538453
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-19 13:59:02.401347	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	2933538453
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-19 13:59:02.413526	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	2933538453
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-07-19 13:59:02.528538	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	2933538453
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-07-19 13:59:02.607155	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	2933538453
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-07-19 13:59:02.616192	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	2933538453
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-07-19 13:59:02.623647	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	2933538453
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-07-19 13:59:02.631516	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	2933538453
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-19 13:59:02.647729	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	2933538453
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-19 13:59:02.658915	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	2933538453
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-19 13:59:02.706827	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	2933538453
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-19 13:59:02.931224	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	2933538453
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-07-19 13:59:02.989729	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	2933538453
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-07-19 13:59:03.003227	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	2933538453
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-07-19 13:59:03.021832	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	2933538453
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-07-19 13:59:03.03451	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	2933538453
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-07-19 13:59:03.043153	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	2933538453
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-07-19 13:59:03.049179	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	2933538453
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-07-19 13:59:03.057156	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	2933538453
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-07-19 13:59:03.089309	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	2933538453
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-07-19 13:59:03.104334	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	2933538453
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-07-19 13:59:03.115865	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	2933538453
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-07-19 13:59:03.1446	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	2933538453
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-07-19 13:59:03.161517	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	2933538453
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-07-19 13:59:03.172815	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	2933538453
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-19 13:59:03.194597	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	2933538453
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-19 13:59:03.22687	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	2933538453
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-19 13:59:03.232117	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	2933538453
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-19 13:59:03.326169	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	2933538453
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-19 13:59:03.347384	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	2933538453
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-19 13:59:03.359284	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	2933538453
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-19 13:59:03.366778	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	2933538453
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-19 13:59:03.431076	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	2933538453
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-19 13:59:03.435959	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	2933538453
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-19 13:59:03.451836	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	2933538453
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-19 13:59:03.4574	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	2933538453
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-19 13:59:03.468643	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	2933538453
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-19 13:59:03.475173	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	2933538453
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-19 13:59:03.495577	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	2933538453
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-07-19 13:59:03.511359	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	2933538453
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-07-19 13:59:03.531928	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	2933538453
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-07-19 13:59:03.552122	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	2933538453
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.566847	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	2933538453
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.582716	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	2933538453
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.598997	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	2933538453
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.621618	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	2933538453
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.626681	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	2933538453
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.643372	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	2933538453
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.647409	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	2933538453
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-19 13:59:03.659398	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	2933538453
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.688084	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	2933538453
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.692624	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	2933538453
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.716027	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	2933538453
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.728754	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	2933538453
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.732885	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	2933538453
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.745244	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	2933538453
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-19 13:59:03.75557	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	2933538453
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-07-19 13:59:03.769696	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	2933538453
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-07-19 13:59:03.782623	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	2933538453
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-07-19 13:59:03.793398	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	2933538453
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-07-19 13:59:03.800635	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	2933538453
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-07-19 13:59:03.812837	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	2933538453
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-07-19 13:59:03.816717	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	2933538453
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-07-19 13:59:03.82939	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	2933538453
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
609d82f3-0d9a-41cd-b689-39eaf454deb4	02bbbe1c-cfbc-4527-81d1-ab277d95905a	f
609d82f3-0d9a-41cd-b689-39eaf454deb4	b574f4f4-6844-4038-859e-c6d51a47035e	t
609d82f3-0d9a-41cd-b689-39eaf454deb4	535b6410-253a-4a0d-8c1a-4bd0aec312ec	t
609d82f3-0d9a-41cd-b689-39eaf454deb4	8f9f230c-17ff-4837-a662-b77feeaa2131	t
609d82f3-0d9a-41cd-b689-39eaf454deb4	3c9712aa-d103-4a93-b962-7b3404bb4909	f
609d82f3-0d9a-41cd-b689-39eaf454deb4	e6738c34-f6f6-4408-8e28-684e8d2eff9b	f
609d82f3-0d9a-41cd-b689-39eaf454deb4	9c031951-cddf-47d5-b957-b0adceb5a3fe	t
609d82f3-0d9a-41cd-b689-39eaf454deb4	7eecca88-6b1c-439e-a65c-297bd3ca7dae	t
609d82f3-0d9a-41cd-b689-39eaf454deb4	3609e7d3-f301-48b1-985a-9e5a54b5b1f4	f
609d82f3-0d9a-41cd-b689-39eaf454deb4	327668e9-b045-47cc-b464-75968483daf3	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	0ffc12e1-ca2e-45d8-bb5a-faeeb65f09d2	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	30b1a4cc-5dad-4170-968e-07328dfaeab6	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	08deba72-9c2e-4831-8bb2-fe5afed7dfe5	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	56cbc436-a63e-441c-a6df-56fa9207d10b	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	e479350a-4890-4bd2-9918-f748f593a400	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	51c12159-de48-43d2-b3af-9a918505673f	t
a7de8481-c201-4c82-90be-4f1e0f9402bf	07a06f4b-b81c-4ae6-9be2-adb5353813dc	f
a7de8481-c201-4c82-90be-4f1e0f9402bf	edbf367a-3bc2-465f-9cf5-99fbdb42fcda	f
a7de8481-c201-4c82-90be-4f1e0f9402bf	fc6966d9-fa22-4875-a9c3-013714d4878e	f
a7de8481-c201-4c82-90be-4f1e0f9402bf	874e8392-e528-4423-9b05-71ddbbf8df25	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
0d289b57-3ba3-4bce-9688-67dc52a39395	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	${role_default-roles}	default-roles-master	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	\N
c0ea1d9a-65e8-41b0-a62c-9dca2548b081	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	${role_create-realm}	create-realm	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	\N
da368b94-73aa-410b-87e2-961f17112711	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_create-client}	create-client	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
a3db6fc0-5d59-48df-8c64-75db0fdf30d2	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_view-realm}	view-realm	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
3f88d0dd-cca0-4395-952d-0ad4b4e12d06	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_view-users}	view-users	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
f84d2306-827c-4b28-a7e4-0953f5eb06aa	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_view-clients}	view-clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
c1abfc88-9b47-4a1a-9dfc-6dd1710e6115	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_view-events}	view-events	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
610aa7df-98ad-4c09-83cc-6539252c4fc9	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_view-identity-providers}	view-identity-providers	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
7bbdf24e-f3aa-44b1-9fb5-13f69a7356f8	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_view-authorization}	view-authorization	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
5bc55ac4-524f-40d1-a1a7-6231a3e91a86	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_manage-realm}	manage-realm	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
c8f52fb7-badc-45e4-a625-065c573336e1	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_manage-users}	manage-users	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
7c6d4613-5a11-4601-88a3-976abca63bcf	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_manage-clients}	manage-clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
63170532-22bb-4fcb-ae79-d584a56027e9	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_manage-events}	manage-events	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
be0030ec-8201-47f0-a9fe-f3279c7b41e9	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_manage-identity-providers}	manage-identity-providers	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
4c13c77e-acf4-4e88-bc63-6360bd241055	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_manage-authorization}	manage-authorization	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
3c95d7ec-f965-4c02-ae79-4779d0c96f1b	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_query-users}	query-users	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
47c19639-27ce-4b56-af3f-62d7803c7909	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_query-clients}	query-clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
feabd802-998b-4811-b395-482de813b98b	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_query-realms}	query-realms	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
f71c3dd0-c426-4b7a-b81c-595ce53eb238	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	${role_admin}	admin	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	\N
969660be-b39c-420c-82b5-f20366d7e859	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_query-groups}	query-groups	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
08f99301-f14d-4e72-8b87-fb3685b2639c	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_view-profile}	view-profile	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
8488278c-2db7-43ae-993e-0b78c4fde7c8	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_manage-account}	manage-account	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
d8cd31c0-4ad8-46dd-b413-8c54fdaf9b49	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_manage-account-links}	manage-account-links	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
0b260513-7256-4e21-a7d0-4ac7f76b01be	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_view-applications}	view-applications	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
c405dc30-a4e1-4ab2-bc57-fae05e7c277c	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_view-consent}	view-consent	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
77b5f611-8f58-4222-9b61-70ea541cc4c9	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_manage-consent}	manage-consent	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
f48cc25c-0fd6-4fa0-8776-a8c461bd6553	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_view-groups}	view-groups	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
bf72c83e-215d-4496-8d68-ec2ccabbe338	d9ae72f1-7b7f-4800-9247-831a3be1de63	t	${role_delete-account}	delete-account	609d82f3-0d9a-41cd-b689-39eaf454deb4	d9ae72f1-7b7f-4800-9247-831a3be1de63	\N
c371082d-6c03-46f8-8562-f9b495a80194	ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	t	${role_read-token}	read-token	609d82f3-0d9a-41cd-b689-39eaf454deb4	ef06ca67-6db7-4bb7-b39f-ed7172d6ca72	\N
b3f7fcfe-665f-422c-9c48-3fb6956a09e0	9c999465-a932-4b28-91bf-1ecbc334f82a	t	${role_impersonation}	impersonation	609d82f3-0d9a-41cd-b689-39eaf454deb4	9c999465-a932-4b28-91bf-1ecbc334f82a	\N
d707eab6-9630-4649-b84c-d2858472cc60	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	${role_offline-access}	offline_access	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	\N
1ecda296-b68d-44be-acbc-325b0910aec4	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	${role_uma_authorization}	uma_authorization	609d82f3-0d9a-41cd-b689-39eaf454deb4	\N	\N
85652830-8607-4af6-8ea4-ddc166fc0f1d	a7de8481-c201-4c82-90be-4f1e0f9402bf	f	${role_default-roles}	default-roles-internship	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N	\N
84d8a691-5b37-44a6-97b3-8ff6f9fbe43b	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_create-client}	create-client	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
995fb67a-55be-4308-a327-cd5492f4c0b9	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_view-realm}	view-realm	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
493e76ac-8af6-44c2-b869-cf37e160a5c3	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_view-users}	view-users	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
91736d99-ecfc-4608-9b1d-2fa4506e68ab	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_view-clients}	view-clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
c1ec21fb-9e6d-42bc-80d7-c054bcc383f4	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_view-events}	view-events	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
f3ea56f5-74d3-49ba-b5aa-65e251544c3c	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_view-identity-providers}	view-identity-providers	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
fb650724-90b4-4e64-8f73-b5a432c18b41	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_view-authorization}	view-authorization	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
9df9c0dd-5bb2-4b18-96bd-b9d8f024127d	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_manage-realm}	manage-realm	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
5fbbf7fb-4cc1-40f6-9d16-18bd0b7f83ab	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_manage-users}	manage-users	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
700c9edd-5552-454c-9ce8-986a548ebcc7	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_manage-clients}	manage-clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
d05f2e3f-da74-4b58-bf07-9ca792421e83	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_manage-events}	manage-events	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
8913f3ce-ff15-4281-a52f-c03fda9ce38a	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_manage-identity-providers}	manage-identity-providers	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
c68fee8f-8b79-4f51-ac08-f12b8bc34aa5	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_manage-authorization}	manage-authorization	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
27d44685-face-4bdd-ab62-c7f721731ec8	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_query-users}	query-users	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
45930519-0cb5-49cd-8101-05aed82c41aa	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_query-clients}	query-clients	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
4bd99687-dda4-45c0-922d-3e40d7e7fa7f	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_query-realms}	query-realms	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
b2bdd427-f171-43ed-a183-64e5a7999a5b	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_query-groups}	query-groups	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
48dc8d0b-dc56-40cd-87bd-30d025233327	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_realm-admin}	realm-admin	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
1a0c8689-5fae-4830-a076-d349fd58e749	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_create-client}	create-client	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
7730a088-83d9-4a65-8b8d-2824a609a1f3	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_view-realm}	view-realm	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
e665abdd-ddb6-4ba2-ab26-c5f2b4e7ceef	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_view-users}	view-users	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
57ad0429-9cda-4fb5-81a2-a7cbd22bfc0b	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_view-clients}	view-clients	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
7cd47cd5-f3c5-4b93-b0f9-137d0d47dde2	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_view-events}	view-events	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
a0db6a17-bce8-43bd-a527-0efcd8c45b07	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_view-identity-providers}	view-identity-providers	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
d62c3f2f-aeef-411b-b92d-42cdb443b89b	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_view-authorization}	view-authorization	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
08752b3e-69da-4a04-8042-2473c269d444	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_manage-realm}	manage-realm	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
589eaab1-72e2-4ea7-9298-a5825ac32349	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_manage-users}	manage-users	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
16340e7f-dc46-439a-af1f-ab9d8859ae20	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_manage-clients}	manage-clients	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
0a10e393-92a0-41de-9c15-979e00d5a839	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_manage-events}	manage-events	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
8fd9d369-a701-4dea-a211-f7a14d81ae8f	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_manage-identity-providers}	manage-identity-providers	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
d1ad56c7-f4e3-43fc-9478-dccbc134796f	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_manage-authorization}	manage-authorization	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
e3ca33d9-a2f1-47fc-a3db-14086c65a137	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_query-users}	query-users	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
f711b8d5-1e94-46e8-896e-7dd7fd17678d	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_query-clients}	query-clients	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
08a380c9-d8d9-4347-9e65-2807c3aa73d8	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_query-realms}	query-realms	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
b1af7602-2902-4022-a4af-afe460718f67	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_query-groups}	query-groups	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
c06670e9-d902-428c-a1a8-e642f4537cbe	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_view-profile}	view-profile	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
0d4a78dd-dd34-4d13-887a-834541cd33fd	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_manage-account}	manage-account	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
eb70cb12-d8d5-418b-8659-22ae217dd11e	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_manage-account-links}	manage-account-links	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
edfa985e-5832-45ef-b65e-315835ba39c5	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_view-applications}	view-applications	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
0f9678a1-5953-4952-bae7-faa2f6679a3e	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_view-consent}	view-consent	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
9e638e8a-fcd5-4ec7-84b8-68e371a939a4	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_manage-consent}	manage-consent	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
40bea016-99a6-41aa-b914-986d95f14d26	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_view-groups}	view-groups	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
8d2b8250-e8ce-458c-aa39-ab281db21d3f	733b1113-38d8-43ac-a17a-17782dc6b2b1	t	${role_delete-account}	delete-account	a7de8481-c201-4c82-90be-4f1e0f9402bf	733b1113-38d8-43ac-a17a-17782dc6b2b1	\N
ccf9297d-ae18-438c-b7d2-a551214cebd7	c078607e-fabe-4720-a857-d964c70b1c6d	t	${role_impersonation}	impersonation	609d82f3-0d9a-41cd-b689-39eaf454deb4	c078607e-fabe-4720-a857-d964c70b1c6d	\N
ae90bda5-db72-48c1-9044-3f7edd401581	5f2dd518-8ac1-4db2-86db-00b0e3471fad	t	${role_impersonation}	impersonation	a7de8481-c201-4c82-90be-4f1e0f9402bf	5f2dd518-8ac1-4db2-86db-00b0e3471fad	\N
376d28ff-b237-414a-9dc5-8dd53d674510	ffd8aef0-c7cd-4150-9e34-03a2aa733172	t	${role_read-token}	read-token	a7de8481-c201-4c82-90be-4f1e0f9402bf	ffd8aef0-c7cd-4150-9e34-03a2aa733172	\N
43f9a56a-151f-45fa-9c24-5eecfd3dccd6	a7de8481-c201-4c82-90be-4f1e0f9402bf	f	${role_offline-access}	offline_access	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N	\N
af1aa306-0612-4c6b-be82-f749407aba52	a7de8481-c201-4c82-90be-4f1e0f9402bf	f	${role_uma_authorization}	uma_authorization	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N	\N
4f606cc1-420a-42e3-b1d5-12957cd5c895	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	t	\N	uma_protection	a7de8481-c201-4c82-90be-4f1e0f9402bf	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	\N
8a9fca05-83d6-4438-9477-5a8510d3f957	a7de8481-c201-4c82-90be-4f1e0f9402bf	f		ADMIN	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N	\N
afc282cd-8a9a-44bf-aeab-ce2409a984ff	a7de8481-c201-4c82-90be-4f1e0f9402bf	f		USER	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N	\N
eb576549-3b06-4d31-bd86-ae7d32476065	a7de8481-c201-4c82-90be-4f1e0f9402bf	f		TEACHER	a7de8481-c201-4c82-90be-4f1e0f9402bf	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
w12oa	20.0.3	1752933544
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
e1b625ae-5d0c-4550-aad6-332221e110c2	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
f21b95f1-cdc9-4024-8a56-45f1067124be	defaultResourceType	urn:bitlab-internship-client:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
9950532e-5506-44d0-bebb-c311d742916f	audience resolve	openid-connect	oidc-audience-resolve-mapper	c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	\N
4e4a85c1-1776-4ccd-aae2-97594f1147ea	locale	openid-connect	oidc-usermodel-attribute-mapper	708212c3-a3b1-4f9c-85e1-f24d748cefb6	\N
4d465499-4750-48e5-a33a-f46ce45c5848	role list	saml	saml-role-list-mapper	\N	b574f4f4-6844-4038-859e-c6d51a47035e
f1ff2659-28ea-4587-b1e6-5523e2356840	full name	openid-connect	oidc-full-name-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
b883c5a9-50f8-4b4d-9bf6-283538137698	family name	openid-connect	oidc-usermodel-property-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
dc154119-2357-414a-9589-0b3da21245b8	given name	openid-connect	oidc-usermodel-property-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
d8f314ec-1d71-4543-93da-f66dabaf7da5	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
4498086b-706e-4307-b0fb-0f490589c00c	username	openid-connect	oidc-usermodel-property-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
7078ed1b-bcad-407e-b5fc-5d228d06e517	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
bb37e2d1-7b08-41bc-80e6-7fa23d722433	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	website	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
3ae4ed58-bc04-4188-913b-8750e1085b6c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
6a5e2b1b-297a-4223-90b3-9fe3d212e774	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
886b5236-871c-49be-b049-4add700d0d74	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
1574914c-8dad-42d9-a731-d1cbc1545580	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	535b6410-253a-4a0d-8c1a-4bd0aec312ec
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	email	openid-connect	oidc-usermodel-property-mapper	\N	8f9f230c-17ff-4837-a662-b77feeaa2131
0f05c89e-7068-4237-81fd-68962c3fade0	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8f9f230c-17ff-4837-a662-b77feeaa2131
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	address	openid-connect	oidc-address-mapper	\N	3c9712aa-d103-4a93-b962-7b3404bb4909
6451b264-1345-4e53-9e6f-65c1d15fa424	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e6738c34-f6f6-4408-8e28-684e8d2eff9b
56ce7539-ba83-4b16-801a-425f3c99729c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e6738c34-f6f6-4408-8e28-684e8d2eff9b
be4bc037-8d76-4a00-81fd-23fcdea79897	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9c031951-cddf-47d5-b957-b0adceb5a3fe
3293d4fb-b293-4172-85bd-4d926198ee87	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9c031951-cddf-47d5-b957-b0adceb5a3fe
27025b2d-f325-4d28-940a-536e6c236541	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9c031951-cddf-47d5-b957-b0adceb5a3fe
12a6d3b1-9fd3-4d0a-878c-523cd0c42eaf	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	7eecca88-6b1c-439e-a65c-297bd3ca7dae
1d87b4c3-47ff-48f9-9a90-33ca9c830060	upn	openid-connect	oidc-usermodel-property-mapper	\N	3609e7d3-f301-48b1-985a-9e5a54b5b1f4
648542a2-60d8-4da9-8154-697990377413	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3609e7d3-f301-48b1-985a-9e5a54b5b1f4
621215d2-78c3-4d1b-bd9f-805ffd714ab8	acr loa level	openid-connect	oidc-acr-mapper	\N	327668e9-b045-47cc-b464-75968483daf3
66cb2680-611f-449a-aea6-5bc4883daf6a	audience resolve	openid-connect	oidc-audience-resolve-mapper	5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	\N
7ab6bf0e-79ff-4f96-9929-786c5b33686f	address	openid-connect	oidc-address-mapper	\N	edbf367a-3bc2-465f-9cf5-99fbdb42fcda
3001eb17-ec8d-4015-a322-8f964d9f4563	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	fc6966d9-fa22-4875-a9c3-013714d4878e
48c85b10-1267-4c2f-ba4c-51be25314297	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	fc6966d9-fa22-4875-a9c3-013714d4878e
c7f75404-50fc-4163-9a8e-ff9be5be47e2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e479350a-4890-4bd2-9918-f748f593a400
aa549125-b145-430e-8eea-85529725a214	upn	openid-connect	oidc-usermodel-property-mapper	\N	874e8392-e528-4423-9b05-71ddbbf8df25
de322a5e-d147-4d3d-b59e-5ee1908281a4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	874e8392-e528-4423-9b05-71ddbbf8df25
61be6563-335f-4a6c-ba58-99f70d5d4310	email verified	openid-connect	oidc-usermodel-property-mapper	\N	08deba72-9c2e-4831-8bb2-fe5afed7dfe5
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	email	openid-connect	oidc-usermodel-property-mapper	\N	08deba72-9c2e-4831-8bb2-fe5afed7dfe5
50f656d8-a006-44be-944b-9d38bd620aff	role list	saml	saml-role-list-mapper	\N	0ffc12e1-ca2e-45d8-bb5a-faeeb65f09d2
170fa110-a9d1-4a25-b4b5-051355b0fcc4	acr loa level	openid-connect	oidc-acr-mapper	\N	51c12159-de48-43d2-b3af-9a918505673f
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
76dbefb7-946f-4d0b-b25c-0ce503899d0f	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
01a229bd-62f8-445d-96f1-53347883bbb8	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
b2dbbabb-0367-4d6e-950c-8d291a40b856	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
428b1699-fdeb-4923-8c3c-97d42000cc9f	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	given name	openid-connect	oidc-usermodel-property-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	website	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
33239849-0c60-4514-9322-6177660f097a	username	openid-connect	oidc-usermodel-property-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
d98c0c14-8396-4add-ac53-e0e9390b3c8d	full name	openid-connect	oidc-full-name-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
2629f2da-cb11-48dc-93da-c5aa010b9052	family name	openid-connect	oidc-usermodel-property-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
0e81a4f9-737e-4a64-a017-e7f459ed6a18	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	30b1a4cc-5dad-4170-968e-07328dfaeab6
9df0a457-b576-4f6a-adc3-5752473c3114	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	56cbc436-a63e-441c-a6df-56fa9207d10b
b454f68a-33b6-40f0-a0ac-f38b977a3a7b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	56cbc436-a63e-441c-a6df-56fa9207d10b
a3da76c1-f12c-45e5-889c-3449ea0a3d52	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	56cbc436-a63e-441c-a6df-56fa9207d10b
e7c1cba2-130f-4283-a96c-43018b4d6e9e	locale	openid-connect	oidc-usermodel-attribute-mapper	f82ba6ac-1207-4426-9106-0bbc87af410c	\N
48c98b32-2a79-4722-87e8-f832a59259ca	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	\N
5435e3a1-d50d-432e-971e-5caacb2f9312	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	\N
2f64409a-453a-4025-b78b-a0c0eadd8569	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
4e4a85c1-1776-4ccd-aae2-97594f1147ea	true	userinfo.token.claim
4e4a85c1-1776-4ccd-aae2-97594f1147ea	locale	user.attribute
4e4a85c1-1776-4ccd-aae2-97594f1147ea	true	id.token.claim
4e4a85c1-1776-4ccd-aae2-97594f1147ea	true	access.token.claim
4e4a85c1-1776-4ccd-aae2-97594f1147ea	locale	claim.name
4e4a85c1-1776-4ccd-aae2-97594f1147ea	String	jsonType.label
4d465499-4750-48e5-a33a-f46ce45c5848	false	single
4d465499-4750-48e5-a33a-f46ce45c5848	Basic	attribute.nameformat
4d465499-4750-48e5-a33a-f46ce45c5848	Role	attribute.name
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	true	userinfo.token.claim
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	website	user.attribute
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	true	id.token.claim
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	true	access.token.claim
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	website	claim.name
0fbf1ad8-2a30-4bb7-8df4-5c95a7620703	String	jsonType.label
1574914c-8dad-42d9-a731-d1cbc1545580	true	userinfo.token.claim
1574914c-8dad-42d9-a731-d1cbc1545580	updatedAt	user.attribute
1574914c-8dad-42d9-a731-d1cbc1545580	true	id.token.claim
1574914c-8dad-42d9-a731-d1cbc1545580	true	access.token.claim
1574914c-8dad-42d9-a731-d1cbc1545580	updated_at	claim.name
1574914c-8dad-42d9-a731-d1cbc1545580	long	jsonType.label
3ae4ed58-bc04-4188-913b-8750e1085b6c	true	userinfo.token.claim
3ae4ed58-bc04-4188-913b-8750e1085b6c	gender	user.attribute
3ae4ed58-bc04-4188-913b-8750e1085b6c	true	id.token.claim
3ae4ed58-bc04-4188-913b-8750e1085b6c	true	access.token.claim
3ae4ed58-bc04-4188-913b-8750e1085b6c	gender	claim.name
3ae4ed58-bc04-4188-913b-8750e1085b6c	String	jsonType.label
4498086b-706e-4307-b0fb-0f490589c00c	true	userinfo.token.claim
4498086b-706e-4307-b0fb-0f490589c00c	username	user.attribute
4498086b-706e-4307-b0fb-0f490589c00c	true	id.token.claim
4498086b-706e-4307-b0fb-0f490589c00c	true	access.token.claim
4498086b-706e-4307-b0fb-0f490589c00c	preferred_username	claim.name
4498086b-706e-4307-b0fb-0f490589c00c	String	jsonType.label
6a5e2b1b-297a-4223-90b3-9fe3d212e774	true	userinfo.token.claim
6a5e2b1b-297a-4223-90b3-9fe3d212e774	birthdate	user.attribute
6a5e2b1b-297a-4223-90b3-9fe3d212e774	true	id.token.claim
6a5e2b1b-297a-4223-90b3-9fe3d212e774	true	access.token.claim
6a5e2b1b-297a-4223-90b3-9fe3d212e774	birthdate	claim.name
6a5e2b1b-297a-4223-90b3-9fe3d212e774	String	jsonType.label
7078ed1b-bcad-407e-b5fc-5d228d06e517	true	userinfo.token.claim
7078ed1b-bcad-407e-b5fc-5d228d06e517	profile	user.attribute
7078ed1b-bcad-407e-b5fc-5d228d06e517	true	id.token.claim
7078ed1b-bcad-407e-b5fc-5d228d06e517	true	access.token.claim
7078ed1b-bcad-407e-b5fc-5d228d06e517	profile	claim.name
7078ed1b-bcad-407e-b5fc-5d228d06e517	String	jsonType.label
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	true	userinfo.token.claim
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	middleName	user.attribute
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	true	id.token.claim
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	true	access.token.claim
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	middle_name	claim.name
77ea5f13-0615-4cdd-9225-d6f4e7e4bff0	String	jsonType.label
886b5236-871c-49be-b049-4add700d0d74	true	userinfo.token.claim
886b5236-871c-49be-b049-4add700d0d74	zoneinfo	user.attribute
886b5236-871c-49be-b049-4add700d0d74	true	id.token.claim
886b5236-871c-49be-b049-4add700d0d74	true	access.token.claim
886b5236-871c-49be-b049-4add700d0d74	zoneinfo	claim.name
886b5236-871c-49be-b049-4add700d0d74	String	jsonType.label
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	true	userinfo.token.claim
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	locale	user.attribute
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	true	id.token.claim
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	true	access.token.claim
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	locale	claim.name
a836fa23-d90b-43f3-bb6e-fd2d2e8b7e16	String	jsonType.label
b883c5a9-50f8-4b4d-9bf6-283538137698	true	userinfo.token.claim
b883c5a9-50f8-4b4d-9bf6-283538137698	lastName	user.attribute
b883c5a9-50f8-4b4d-9bf6-283538137698	true	id.token.claim
b883c5a9-50f8-4b4d-9bf6-283538137698	true	access.token.claim
b883c5a9-50f8-4b4d-9bf6-283538137698	family_name	claim.name
b883c5a9-50f8-4b4d-9bf6-283538137698	String	jsonType.label
bb37e2d1-7b08-41bc-80e6-7fa23d722433	true	userinfo.token.claim
bb37e2d1-7b08-41bc-80e6-7fa23d722433	picture	user.attribute
bb37e2d1-7b08-41bc-80e6-7fa23d722433	true	id.token.claim
bb37e2d1-7b08-41bc-80e6-7fa23d722433	true	access.token.claim
bb37e2d1-7b08-41bc-80e6-7fa23d722433	picture	claim.name
bb37e2d1-7b08-41bc-80e6-7fa23d722433	String	jsonType.label
d8f314ec-1d71-4543-93da-f66dabaf7da5	true	userinfo.token.claim
d8f314ec-1d71-4543-93da-f66dabaf7da5	nickname	user.attribute
d8f314ec-1d71-4543-93da-f66dabaf7da5	true	id.token.claim
d8f314ec-1d71-4543-93da-f66dabaf7da5	true	access.token.claim
d8f314ec-1d71-4543-93da-f66dabaf7da5	nickname	claim.name
d8f314ec-1d71-4543-93da-f66dabaf7da5	String	jsonType.label
dc154119-2357-414a-9589-0b3da21245b8	true	userinfo.token.claim
dc154119-2357-414a-9589-0b3da21245b8	firstName	user.attribute
dc154119-2357-414a-9589-0b3da21245b8	true	id.token.claim
dc154119-2357-414a-9589-0b3da21245b8	true	access.token.claim
dc154119-2357-414a-9589-0b3da21245b8	given_name	claim.name
dc154119-2357-414a-9589-0b3da21245b8	String	jsonType.label
f1ff2659-28ea-4587-b1e6-5523e2356840	true	userinfo.token.claim
f1ff2659-28ea-4587-b1e6-5523e2356840	true	id.token.claim
f1ff2659-28ea-4587-b1e6-5523e2356840	true	access.token.claim
0f05c89e-7068-4237-81fd-68962c3fade0	true	userinfo.token.claim
0f05c89e-7068-4237-81fd-68962c3fade0	emailVerified	user.attribute
0f05c89e-7068-4237-81fd-68962c3fade0	true	id.token.claim
0f05c89e-7068-4237-81fd-68962c3fade0	true	access.token.claim
0f05c89e-7068-4237-81fd-68962c3fade0	email_verified	claim.name
0f05c89e-7068-4237-81fd-68962c3fade0	boolean	jsonType.label
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	true	userinfo.token.claim
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	email	user.attribute
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	true	id.token.claim
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	true	access.token.claim
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	email	claim.name
5758ae94-30fb-41e1-8fbe-303ade4f0eeb	String	jsonType.label
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	formatted	user.attribute.formatted
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	country	user.attribute.country
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	postal_code	user.attribute.postal_code
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	true	userinfo.token.claim
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	street	user.attribute.street
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	true	id.token.claim
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	region	user.attribute.region
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	true	access.token.claim
e30cda1a-2df5-4d79-abf2-efe86c9c9ee1	locality	user.attribute.locality
56ce7539-ba83-4b16-801a-425f3c99729c	true	userinfo.token.claim
56ce7539-ba83-4b16-801a-425f3c99729c	phoneNumberVerified	user.attribute
56ce7539-ba83-4b16-801a-425f3c99729c	true	id.token.claim
56ce7539-ba83-4b16-801a-425f3c99729c	true	access.token.claim
56ce7539-ba83-4b16-801a-425f3c99729c	phone_number_verified	claim.name
56ce7539-ba83-4b16-801a-425f3c99729c	boolean	jsonType.label
6451b264-1345-4e53-9e6f-65c1d15fa424	true	userinfo.token.claim
6451b264-1345-4e53-9e6f-65c1d15fa424	phoneNumber	user.attribute
6451b264-1345-4e53-9e6f-65c1d15fa424	true	id.token.claim
6451b264-1345-4e53-9e6f-65c1d15fa424	true	access.token.claim
6451b264-1345-4e53-9e6f-65c1d15fa424	phone_number	claim.name
6451b264-1345-4e53-9e6f-65c1d15fa424	String	jsonType.label
3293d4fb-b293-4172-85bd-4d926198ee87	true	multivalued
3293d4fb-b293-4172-85bd-4d926198ee87	foo	user.attribute
3293d4fb-b293-4172-85bd-4d926198ee87	true	access.token.claim
3293d4fb-b293-4172-85bd-4d926198ee87	resource_access.${client_id}.roles	claim.name
3293d4fb-b293-4172-85bd-4d926198ee87	String	jsonType.label
be4bc037-8d76-4a00-81fd-23fcdea79897	true	multivalued
be4bc037-8d76-4a00-81fd-23fcdea79897	foo	user.attribute
be4bc037-8d76-4a00-81fd-23fcdea79897	true	access.token.claim
be4bc037-8d76-4a00-81fd-23fcdea79897	realm_access.roles	claim.name
be4bc037-8d76-4a00-81fd-23fcdea79897	String	jsonType.label
1d87b4c3-47ff-48f9-9a90-33ca9c830060	true	userinfo.token.claim
1d87b4c3-47ff-48f9-9a90-33ca9c830060	username	user.attribute
1d87b4c3-47ff-48f9-9a90-33ca9c830060	true	id.token.claim
1d87b4c3-47ff-48f9-9a90-33ca9c830060	true	access.token.claim
1d87b4c3-47ff-48f9-9a90-33ca9c830060	upn	claim.name
1d87b4c3-47ff-48f9-9a90-33ca9c830060	String	jsonType.label
648542a2-60d8-4da9-8154-697990377413	true	multivalued
648542a2-60d8-4da9-8154-697990377413	foo	user.attribute
648542a2-60d8-4da9-8154-697990377413	true	id.token.claim
648542a2-60d8-4da9-8154-697990377413	true	access.token.claim
648542a2-60d8-4da9-8154-697990377413	groups	claim.name
648542a2-60d8-4da9-8154-697990377413	String	jsonType.label
621215d2-78c3-4d1b-bd9f-805ffd714ab8	true	id.token.claim
621215d2-78c3-4d1b-bd9f-805ffd714ab8	true	access.token.claim
7ab6bf0e-79ff-4f96-9929-786c5b33686f	formatted	user.attribute.formatted
7ab6bf0e-79ff-4f96-9929-786c5b33686f	country	user.attribute.country
7ab6bf0e-79ff-4f96-9929-786c5b33686f	postal_code	user.attribute.postal_code
7ab6bf0e-79ff-4f96-9929-786c5b33686f	true	userinfo.token.claim
7ab6bf0e-79ff-4f96-9929-786c5b33686f	street	user.attribute.street
7ab6bf0e-79ff-4f96-9929-786c5b33686f	true	id.token.claim
7ab6bf0e-79ff-4f96-9929-786c5b33686f	region	user.attribute.region
7ab6bf0e-79ff-4f96-9929-786c5b33686f	true	access.token.claim
7ab6bf0e-79ff-4f96-9929-786c5b33686f	locality	user.attribute.locality
3001eb17-ec8d-4015-a322-8f964d9f4563	true	userinfo.token.claim
3001eb17-ec8d-4015-a322-8f964d9f4563	phoneNumberVerified	user.attribute
3001eb17-ec8d-4015-a322-8f964d9f4563	true	id.token.claim
3001eb17-ec8d-4015-a322-8f964d9f4563	true	access.token.claim
3001eb17-ec8d-4015-a322-8f964d9f4563	phone_number_verified	claim.name
3001eb17-ec8d-4015-a322-8f964d9f4563	boolean	jsonType.label
48c85b10-1267-4c2f-ba4c-51be25314297	true	userinfo.token.claim
48c85b10-1267-4c2f-ba4c-51be25314297	phoneNumber	user.attribute
48c85b10-1267-4c2f-ba4c-51be25314297	true	id.token.claim
48c85b10-1267-4c2f-ba4c-51be25314297	true	access.token.claim
48c85b10-1267-4c2f-ba4c-51be25314297	phone_number	claim.name
48c85b10-1267-4c2f-ba4c-51be25314297	String	jsonType.label
aa549125-b145-430e-8eea-85529725a214	true	userinfo.token.claim
aa549125-b145-430e-8eea-85529725a214	username	user.attribute
aa549125-b145-430e-8eea-85529725a214	true	id.token.claim
aa549125-b145-430e-8eea-85529725a214	true	access.token.claim
aa549125-b145-430e-8eea-85529725a214	upn	claim.name
aa549125-b145-430e-8eea-85529725a214	String	jsonType.label
de322a5e-d147-4d3d-b59e-5ee1908281a4	true	multivalued
de322a5e-d147-4d3d-b59e-5ee1908281a4	true	userinfo.token.claim
de322a5e-d147-4d3d-b59e-5ee1908281a4	foo	user.attribute
de322a5e-d147-4d3d-b59e-5ee1908281a4	true	id.token.claim
de322a5e-d147-4d3d-b59e-5ee1908281a4	true	access.token.claim
de322a5e-d147-4d3d-b59e-5ee1908281a4	groups	claim.name
de322a5e-d147-4d3d-b59e-5ee1908281a4	String	jsonType.label
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	true	userinfo.token.claim
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	email	user.attribute
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	true	id.token.claim
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	true	access.token.claim
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	email	claim.name
110ddf9d-9fb7-40b4-aa8b-efc16254fb3c	String	jsonType.label
61be6563-335f-4a6c-ba58-99f70d5d4310	true	userinfo.token.claim
61be6563-335f-4a6c-ba58-99f70d5d4310	emailVerified	user.attribute
61be6563-335f-4a6c-ba58-99f70d5d4310	true	id.token.claim
61be6563-335f-4a6c-ba58-99f70d5d4310	true	access.token.claim
61be6563-335f-4a6c-ba58-99f70d5d4310	email_verified	claim.name
61be6563-335f-4a6c-ba58-99f70d5d4310	boolean	jsonType.label
50f656d8-a006-44be-944b-9d38bd620aff	false	single
50f656d8-a006-44be-944b-9d38bd620aff	Basic	attribute.nameformat
50f656d8-a006-44be-944b-9d38bd620aff	Role	attribute.name
170fa110-a9d1-4a25-b4b5-051355b0fcc4	true	id.token.claim
170fa110-a9d1-4a25-b4b5-051355b0fcc4	true	access.token.claim
170fa110-a9d1-4a25-b4b5-051355b0fcc4	true	userinfo.token.claim
01a229bd-62f8-445d-96f1-53347883bbb8	true	userinfo.token.claim
01a229bd-62f8-445d-96f1-53347883bbb8	nickname	user.attribute
01a229bd-62f8-445d-96f1-53347883bbb8	true	id.token.claim
01a229bd-62f8-445d-96f1-53347883bbb8	true	access.token.claim
01a229bd-62f8-445d-96f1-53347883bbb8	nickname	claim.name
01a229bd-62f8-445d-96f1-53347883bbb8	String	jsonType.label
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	true	userinfo.token.claim
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	profile	user.attribute
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	true	id.token.claim
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	true	access.token.claim
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	profile	claim.name
085482af-4e9c-4e28-b48f-2fc53e1ae6c3	String	jsonType.label
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	true	userinfo.token.claim
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	firstName	user.attribute
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	true	id.token.claim
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	true	access.token.claim
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	given_name	claim.name
0d5a548b-c7ef-42be-ae13-0d7b1e89c99f	String	jsonType.label
0e81a4f9-737e-4a64-a017-e7f459ed6a18	true	userinfo.token.claim
0e81a4f9-737e-4a64-a017-e7f459ed6a18	zoneinfo	user.attribute
0e81a4f9-737e-4a64-a017-e7f459ed6a18	true	id.token.claim
0e81a4f9-737e-4a64-a017-e7f459ed6a18	true	access.token.claim
0e81a4f9-737e-4a64-a017-e7f459ed6a18	zoneinfo	claim.name
0e81a4f9-737e-4a64-a017-e7f459ed6a18	String	jsonType.label
2629f2da-cb11-48dc-93da-c5aa010b9052	true	userinfo.token.claim
2629f2da-cb11-48dc-93da-c5aa010b9052	lastName	user.attribute
2629f2da-cb11-48dc-93da-c5aa010b9052	true	id.token.claim
2629f2da-cb11-48dc-93da-c5aa010b9052	true	access.token.claim
2629f2da-cb11-48dc-93da-c5aa010b9052	family_name	claim.name
2629f2da-cb11-48dc-93da-c5aa010b9052	String	jsonType.label
33239849-0c60-4514-9322-6177660f097a	true	userinfo.token.claim
33239849-0c60-4514-9322-6177660f097a	username	user.attribute
33239849-0c60-4514-9322-6177660f097a	true	id.token.claim
33239849-0c60-4514-9322-6177660f097a	true	access.token.claim
33239849-0c60-4514-9322-6177660f097a	preferred_username	claim.name
33239849-0c60-4514-9322-6177660f097a	String	jsonType.label
428b1699-fdeb-4923-8c3c-97d42000cc9f	true	userinfo.token.claim
428b1699-fdeb-4923-8c3c-97d42000cc9f	updatedAt	user.attribute
428b1699-fdeb-4923-8c3c-97d42000cc9f	true	id.token.claim
428b1699-fdeb-4923-8c3c-97d42000cc9f	true	access.token.claim
428b1699-fdeb-4923-8c3c-97d42000cc9f	updated_at	claim.name
428b1699-fdeb-4923-8c3c-97d42000cc9f	long	jsonType.label
76dbefb7-946f-4d0b-b25c-0ce503899d0f	true	userinfo.token.claim
76dbefb7-946f-4d0b-b25c-0ce503899d0f	birthdate	user.attribute
76dbefb7-946f-4d0b-b25c-0ce503899d0f	true	id.token.claim
76dbefb7-946f-4d0b-b25c-0ce503899d0f	true	access.token.claim
76dbefb7-946f-4d0b-b25c-0ce503899d0f	birthdate	claim.name
76dbefb7-946f-4d0b-b25c-0ce503899d0f	String	jsonType.label
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	true	userinfo.token.claim
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	picture	user.attribute
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	true	id.token.claim
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	true	access.token.claim
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	picture	claim.name
7b83c56b-a1b1-4b9f-a93f-47a487998a1c	String	jsonType.label
b2dbbabb-0367-4d6e-950c-8d291a40b856	true	userinfo.token.claim
b2dbbabb-0367-4d6e-950c-8d291a40b856	locale	user.attribute
b2dbbabb-0367-4d6e-950c-8d291a40b856	true	id.token.claim
b2dbbabb-0367-4d6e-950c-8d291a40b856	true	access.token.claim
b2dbbabb-0367-4d6e-950c-8d291a40b856	locale	claim.name
b2dbbabb-0367-4d6e-950c-8d291a40b856	String	jsonType.label
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	true	userinfo.token.claim
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	middleName	user.attribute
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	true	id.token.claim
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	true	access.token.claim
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	middle_name	claim.name
d1bb8b9f-4bb3-49f4-bab3-a00473dcc7a7	String	jsonType.label
d98c0c14-8396-4add-ac53-e0e9390b3c8d	true	id.token.claim
d98c0c14-8396-4add-ac53-e0e9390b3c8d	true	access.token.claim
d98c0c14-8396-4add-ac53-e0e9390b3c8d	true	userinfo.token.claim
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	true	userinfo.token.claim
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	website	user.attribute
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	true	id.token.claim
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	true	access.token.claim
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	website	claim.name
d9b9cf8e-9faa-4533-bbf6-e75c3c40a0ab	String	jsonType.label
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	true	userinfo.token.claim
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	gender	user.attribute
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	true	id.token.claim
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	true	access.token.claim
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	gender	claim.name
f6a8d7aa-b870-47c5-a9de-be8f410d20f0	String	jsonType.label
9df0a457-b576-4f6a-adc3-5752473c3114	foo	user.attribute
9df0a457-b576-4f6a-adc3-5752473c3114	true	access.token.claim
9df0a457-b576-4f6a-adc3-5752473c3114	resource_access.${client_id}.roles	claim.name
9df0a457-b576-4f6a-adc3-5752473c3114	String	jsonType.label
9df0a457-b576-4f6a-adc3-5752473c3114	true	multivalued
b454f68a-33b6-40f0-a0ac-f38b977a3a7b	foo	user.attribute
b454f68a-33b6-40f0-a0ac-f38b977a3a7b	true	access.token.claim
b454f68a-33b6-40f0-a0ac-f38b977a3a7b	realm_access.roles	claim.name
b454f68a-33b6-40f0-a0ac-f38b977a3a7b	String	jsonType.label
b454f68a-33b6-40f0-a0ac-f38b977a3a7b	true	multivalued
e7c1cba2-130f-4283-a96c-43018b4d6e9e	true	userinfo.token.claim
e7c1cba2-130f-4283-a96c-43018b4d6e9e	locale	user.attribute
e7c1cba2-130f-4283-a96c-43018b4d6e9e	true	id.token.claim
e7c1cba2-130f-4283-a96c-43018b4d6e9e	true	access.token.claim
e7c1cba2-130f-4283-a96c-43018b4d6e9e	locale	claim.name
e7c1cba2-130f-4283-a96c-43018b4d6e9e	String	jsonType.label
2f64409a-453a-4025-b78b-a0c0eadd8569	clientId	user.session.note
2f64409a-453a-4025-b78b-a0c0eadd8569	true	id.token.claim
2f64409a-453a-4025-b78b-a0c0eadd8569	true	access.token.claim
2f64409a-453a-4025-b78b-a0c0eadd8569	clientId	claim.name
2f64409a-453a-4025-b78b-a0c0eadd8569	String	jsonType.label
48c98b32-2a79-4722-87e8-f832a59259ca	clientHost	user.session.note
48c98b32-2a79-4722-87e8-f832a59259ca	true	id.token.claim
48c98b32-2a79-4722-87e8-f832a59259ca	true	access.token.claim
48c98b32-2a79-4722-87e8-f832a59259ca	clientHost	claim.name
48c98b32-2a79-4722-87e8-f832a59259ca	String	jsonType.label
5435e3a1-d50d-432e-971e-5caacb2f9312	clientAddress	user.session.note
5435e3a1-d50d-432e-971e-5caacb2f9312	true	id.token.claim
5435e3a1-d50d-432e-971e-5caacb2f9312	true	access.token.claim
5435e3a1-d50d-432e-971e-5caacb2f9312	clientAddress	claim.name
5435e3a1-d50d-432e-971e-5caacb2f9312	String	jsonType.label
5435e3a1-d50d-432e-971e-5caacb2f9312	true	userinfo.token.claim
48c98b32-2a79-4722-87e8-f832a59259ca	true	userinfo.token.claim
2f64409a-453a-4025-b78b-a0c0eadd8569	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
609d82f3-0d9a-41cd-b689-39eaf454deb4	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	9c999465-a932-4b28-91bf-1ecbc334f82a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	9ed6b3c0-8f3f-4514-be38-7cc61bd5db73	48b73316-ae71-4c7a-9b76-daa47170b750	114da2fa-1782-4b18-84ed-d04466537930	64af43f5-d94d-4452-965d-8782b6cc9206	60aa64fc-ae41-4144-87a7-f436b1c90901	2592000	f	900	t	f	ed06eab1-f3ed-4a76-b93a-918d9da3a188	0	f	0	0	0d289b57-3ba3-4bce-9688-67dc52a39395
a7de8481-c201-4c82-90be-4f1e0f9402bf	60	300	300	\N	\N	\N	t	f	0	\N	internship	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c078607e-fabe-4720-a857-d964c70b1c6d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	7f1c35ea-70a1-4376-92ba-458f15e90fe0	320cab38-46f0-4bc8-96ad-5061e7d5cdb0	d7b6783e-32f6-420c-ac8d-78b6f97c8e60	ffbecce6-835c-4acf-9c16-a1967ba90ade	98ec7436-b743-4abd-b6ae-7ce555cd43a6	2592000	f	900	t	f	f85b10b2-9822-4267-bcdf-da6313e4ab0e	0	f	0	0	85652830-8607-4af6-8ea4-ddc166fc0f1d
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	609d82f3-0d9a-41cd-b689-39eaf454deb4	
_browser_header.xContentTypeOptions	609d82f3-0d9a-41cd-b689-39eaf454deb4	nosniff
_browser_header.xRobotsTag	609d82f3-0d9a-41cd-b689-39eaf454deb4	none
_browser_header.xFrameOptions	609d82f3-0d9a-41cd-b689-39eaf454deb4	SAMEORIGIN
_browser_header.contentSecurityPolicy	609d82f3-0d9a-41cd-b689-39eaf454deb4	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	609d82f3-0d9a-41cd-b689-39eaf454deb4	1; mode=block
_browser_header.strictTransportSecurity	609d82f3-0d9a-41cd-b689-39eaf454deb4	max-age=31536000; includeSubDomains
bruteForceProtected	609d82f3-0d9a-41cd-b689-39eaf454deb4	false
permanentLockout	609d82f3-0d9a-41cd-b689-39eaf454deb4	false
maxFailureWaitSeconds	609d82f3-0d9a-41cd-b689-39eaf454deb4	900
minimumQuickLoginWaitSeconds	609d82f3-0d9a-41cd-b689-39eaf454deb4	60
waitIncrementSeconds	609d82f3-0d9a-41cd-b689-39eaf454deb4	60
quickLoginCheckMilliSeconds	609d82f3-0d9a-41cd-b689-39eaf454deb4	1000
maxDeltaTimeSeconds	609d82f3-0d9a-41cd-b689-39eaf454deb4	43200
failureFactor	609d82f3-0d9a-41cd-b689-39eaf454deb4	30
realmReusableOtpCode	609d82f3-0d9a-41cd-b689-39eaf454deb4	false
displayName	609d82f3-0d9a-41cd-b689-39eaf454deb4	Keycloak
displayNameHtml	609d82f3-0d9a-41cd-b689-39eaf454deb4	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	609d82f3-0d9a-41cd-b689-39eaf454deb4	RS256
offlineSessionMaxLifespanEnabled	609d82f3-0d9a-41cd-b689-39eaf454deb4	false
offlineSessionMaxLifespan	609d82f3-0d9a-41cd-b689-39eaf454deb4	5184000
_browser_header.contentSecurityPolicyReportOnly	a7de8481-c201-4c82-90be-4f1e0f9402bf	
_browser_header.xContentTypeOptions	a7de8481-c201-4c82-90be-4f1e0f9402bf	nosniff
_browser_header.xRobotsTag	a7de8481-c201-4c82-90be-4f1e0f9402bf	none
_browser_header.xFrameOptions	a7de8481-c201-4c82-90be-4f1e0f9402bf	SAMEORIGIN
_browser_header.contentSecurityPolicy	a7de8481-c201-4c82-90be-4f1e0f9402bf	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	a7de8481-c201-4c82-90be-4f1e0f9402bf	1; mode=block
_browser_header.strictTransportSecurity	a7de8481-c201-4c82-90be-4f1e0f9402bf	max-age=31536000; includeSubDomains
bruteForceProtected	a7de8481-c201-4c82-90be-4f1e0f9402bf	false
permanentLockout	a7de8481-c201-4c82-90be-4f1e0f9402bf	false
maxFailureWaitSeconds	a7de8481-c201-4c82-90be-4f1e0f9402bf	900
minimumQuickLoginWaitSeconds	a7de8481-c201-4c82-90be-4f1e0f9402bf	60
waitIncrementSeconds	a7de8481-c201-4c82-90be-4f1e0f9402bf	60
quickLoginCheckMilliSeconds	a7de8481-c201-4c82-90be-4f1e0f9402bf	1000
maxDeltaTimeSeconds	a7de8481-c201-4c82-90be-4f1e0f9402bf	43200
failureFactor	a7de8481-c201-4c82-90be-4f1e0f9402bf	30
realmReusableOtpCode	a7de8481-c201-4c82-90be-4f1e0f9402bf	false
defaultSignatureAlgorithm	a7de8481-c201-4c82-90be-4f1e0f9402bf	RS256
offlineSessionMaxLifespanEnabled	a7de8481-c201-4c82-90be-4f1e0f9402bf	false
offlineSessionMaxLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	5184000
clientSessionIdleTimeout	a7de8481-c201-4c82-90be-4f1e0f9402bf	0
clientSessionMaxLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	0
clientOfflineSessionIdleTimeout	a7de8481-c201-4c82-90be-4f1e0f9402bf	0
clientOfflineSessionMaxLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	0
actionTokenGeneratedByAdminLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	43200
actionTokenGeneratedByUserLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	300
oauth2DeviceCodeLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	600
oauth2DevicePollingInterval	a7de8481-c201-4c82-90be-4f1e0f9402bf	5
webAuthnPolicyRpEntityName	a7de8481-c201-4c82-90be-4f1e0f9402bf	keycloak
webAuthnPolicySignatureAlgorithms	a7de8481-c201-4c82-90be-4f1e0f9402bf	ES256
webAuthnPolicyRpId	a7de8481-c201-4c82-90be-4f1e0f9402bf	
webAuthnPolicyAttestationConveyancePreference	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyAuthenticatorAttachment	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyRequireResidentKey	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyUserVerificationRequirement	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyCreateTimeout	a7de8481-c201-4c82-90be-4f1e0f9402bf	0
webAuthnPolicyAvoidSameAuthenticatorRegister	a7de8481-c201-4c82-90be-4f1e0f9402bf	false
webAuthnPolicyRpEntityNamePasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	ES256
webAuthnPolicyRpIdPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	
webAuthnPolicyAttestationConveyancePreferencePasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyRequireResidentKeyPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	not specified
webAuthnPolicyCreateTimeoutPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	false
cibaBackchannelTokenDeliveryMode	a7de8481-c201-4c82-90be-4f1e0f9402bf	poll
cibaExpiresIn	a7de8481-c201-4c82-90be-4f1e0f9402bf	120
cibaInterval	a7de8481-c201-4c82-90be-4f1e0f9402bf	5
cibaAuthRequestedUserHint	a7de8481-c201-4c82-90be-4f1e0f9402bf	login_hint
parRequestUriLifespan	a7de8481-c201-4c82-90be-4f1e0f9402bf	60
client-policies.profiles	a7de8481-c201-4c82-90be-4f1e0f9402bf	{"profiles":[]}
client-policies.policies	a7de8481-c201-4c82-90be-4f1e0f9402bf	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
609d82f3-0d9a-41cd-b689-39eaf454deb4	jboss-logging
a7de8481-c201-4c82-90be-4f1e0f9402bf	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	609d82f3-0d9a-41cd-b689-39eaf454deb4
password	password	t	t	a7de8481-c201-4c82-90be-4f1e0f9402bf
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
d9ae72f1-7b7f-4800-9247-831a3be1de63	/realms/master/account/*
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	/realms/master/account/*
708212c3-a3b1-4f9c-85e1-f24d748cefb6	/admin/master/console/*
733b1113-38d8-43ac-a17a-17782dc6b2b1	/realms/internship/account/*
5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	/realms/internship/account/*
f82ba6ac-1207-4426-9106-0bbc87af410c	/admin/internship/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
4caaad52-52d2-4082-83f2-6704e83fd994	VERIFY_EMAIL	Verify Email	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	VERIFY_EMAIL	50
3c4fbc34-7874-4f1e-a888-26dfd4accb15	UPDATE_PROFILE	Update Profile	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	UPDATE_PROFILE	40
7e287bec-2d0a-49db-90a4-1eebab1357ea	CONFIGURE_TOTP	Configure OTP	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	CONFIGURE_TOTP	10
bb53386d-e6f5-4415-8f27-94a16d079241	UPDATE_PASSWORD	Update Password	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	UPDATE_PASSWORD	30
9cf04688-addf-4804-b641-9ccbf4b8ea08	terms_and_conditions	Terms and Conditions	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	f	terms_and_conditions	20
99227c97-4094-4404-b9f7-8157426ca652	delete_account	Delete Account	609d82f3-0d9a-41cd-b689-39eaf454deb4	f	f	delete_account	60
7de980d7-cd6b-4d8b-9bcb-f0382de1d426	update_user_locale	Update User Locale	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	update_user_locale	1000
59a10fa2-3cf9-45b5-9428-5268564b8002	webauthn-register	Webauthn Register	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	webauthn-register	70
b4e3c73b-f473-469e-84f6-f279e4a4928a	webauthn-register-passwordless	Webauthn Register Passwordless	609d82f3-0d9a-41cd-b689-39eaf454deb4	t	f	webauthn-register-passwordless	80
66581d92-433e-45c3-b32d-d3eaef770f44	CONFIGURE_TOTP	Configure OTP	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	CONFIGURE_TOTP	10
11c29f2a-b10d-4624-93bb-50330538dc17	terms_and_conditions	Terms and Conditions	a7de8481-c201-4c82-90be-4f1e0f9402bf	f	f	terms_and_conditions	20
225b8c93-057c-42c0-8814-80a4954a023b	UPDATE_PASSWORD	Update Password	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	UPDATE_PASSWORD	30
fb3863de-e3e4-4536-b71c-f1751aadc0a7	UPDATE_PROFILE	Update Profile	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	UPDATE_PROFILE	40
0a74c055-be6f-4c89-bcd3-e483c01c71e7	VERIFY_EMAIL	Verify Email	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	VERIFY_EMAIL	50
c8b1d157-8a58-403e-8da9-c93d0f77cac5	delete_account	Delete Account	a7de8481-c201-4c82-90be-4f1e0f9402bf	f	f	delete_account	60
aa2323e4-0818-42a8-a501-07ae19dca5aa	webauthn-register	Webauthn Register	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	webauthn-register	70
35a29885-3146-4b69-b01c-71aae8f8dbc9	webauthn-register-passwordless	Webauthn Register Passwordless	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	webauthn-register-passwordless	80
4390980d-5690-4284-afcd-d8aeef161ae3	update_user_locale	Update User Locale	a7de8481-c201-4c82-90be-4f1e0f9402bf	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
e1b625ae-5d0c-4550-aad6-332221e110c2	Default Policy	A policy that grants access only for users within this realm	js	0	0	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	\N
f21b95f1-cdc9-4024-8a56-45f1067124be	Default Permission	A permission that applies to the default resource type	resource	1	0	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
17173578-ffdf-49d1-9db4-5aa3cc9b9b70	Default Resource	urn:bitlab-internship-client:resources:default	\N	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
17173578-ffdf-49d1-9db4-5aa3cc9b9b70	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	f48cc25c-0fd6-4fa0-8776-a8c461bd6553
c07d679d-79b4-4f5f-9cf0-3a84ef3bcea8	8488278c-2db7-43ae-993e-0b78c4fde7c8
5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	0d4a78dd-dd34-4d13-887a-834541cd33fd
5e49ae94-2202-4f46-bc20-1b5e8a4b8e8b	40bea016-99a6-41aa-b914-986d95f14d26
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
ac9b5ddc-703f-4896-af4a-df35265bc770	\N	d576b41c-ce6a-4e33-a5db-457c5255f455	f	t	\N	\N	\N	609d82f3-0d9a-41cd-b689-39eaf454deb4	admin	1752933551592	\N	0
0b8d34d2-32d2-448d-9412-aa4dfe56ecbc	\N	20cfddc2-2f6a-45e6-b600-df7aba28e7b2	f	t	\N	\N	\N	a7de8481-c201-4c82-90be-4f1e0f9402bf	service-account-bitlab-internship-client	1752933620568	85b4e61d-6e24-4e8c-a77a-246f2b83a4e7	0
fae344b0-24a5-48ed-882b-b1a5f0240952	bitlab_admin@mail.ru	bitlab_admin@mail.ru	t	t	\N	Bitlab	Admin	a7de8481-c201-4c82-90be-4f1e0f9402bf	bitlab_admin	1752933655211	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
0d289b57-3ba3-4bce-9688-67dc52a39395	ac9b5ddc-703f-4896-af4a-df35265bc770
f71c3dd0-c426-4b7a-b81c-595ce53eb238	ac9b5ddc-703f-4896-af4a-df35265bc770
84d8a691-5b37-44a6-97b3-8ff6f9fbe43b	ac9b5ddc-703f-4896-af4a-df35265bc770
995fb67a-55be-4308-a327-cd5492f4c0b9	ac9b5ddc-703f-4896-af4a-df35265bc770
493e76ac-8af6-44c2-b869-cf37e160a5c3	ac9b5ddc-703f-4896-af4a-df35265bc770
91736d99-ecfc-4608-9b1d-2fa4506e68ab	ac9b5ddc-703f-4896-af4a-df35265bc770
c1ec21fb-9e6d-42bc-80d7-c054bcc383f4	ac9b5ddc-703f-4896-af4a-df35265bc770
f3ea56f5-74d3-49ba-b5aa-65e251544c3c	ac9b5ddc-703f-4896-af4a-df35265bc770
fb650724-90b4-4e64-8f73-b5a432c18b41	ac9b5ddc-703f-4896-af4a-df35265bc770
9df9c0dd-5bb2-4b18-96bd-b9d8f024127d	ac9b5ddc-703f-4896-af4a-df35265bc770
5fbbf7fb-4cc1-40f6-9d16-18bd0b7f83ab	ac9b5ddc-703f-4896-af4a-df35265bc770
700c9edd-5552-454c-9ce8-986a548ebcc7	ac9b5ddc-703f-4896-af4a-df35265bc770
d05f2e3f-da74-4b58-bf07-9ca792421e83	ac9b5ddc-703f-4896-af4a-df35265bc770
8913f3ce-ff15-4281-a52f-c03fda9ce38a	ac9b5ddc-703f-4896-af4a-df35265bc770
c68fee8f-8b79-4f51-ac08-f12b8bc34aa5	ac9b5ddc-703f-4896-af4a-df35265bc770
27d44685-face-4bdd-ab62-c7f721731ec8	ac9b5ddc-703f-4896-af4a-df35265bc770
45930519-0cb5-49cd-8101-05aed82c41aa	ac9b5ddc-703f-4896-af4a-df35265bc770
4bd99687-dda4-45c0-922d-3e40d7e7fa7f	ac9b5ddc-703f-4896-af4a-df35265bc770
b2bdd427-f171-43ed-a183-64e5a7999a5b	ac9b5ddc-703f-4896-af4a-df35265bc770
85652830-8607-4af6-8ea4-ddc166fc0f1d	0b8d34d2-32d2-448d-9412-aa4dfe56ecbc
4f606cc1-420a-42e3-b1d5-12957cd5c895	0b8d34d2-32d2-448d-9412-aa4dfe56ecbc
85652830-8607-4af6-8ea4-ddc166fc0f1d	fae344b0-24a5-48ed-882b-b1a5f0240952
589eaab1-72e2-4ea7-9298-a5825ac32349	fae344b0-24a5-48ed-882b-b1a5f0240952
e665abdd-ddb6-4ba2-ab26-c5f2b4e7ceef	fae344b0-24a5-48ed-882b-b1a5f0240952
8a9fca05-83d6-4438-9477-5a8510d3f957	fae344b0-24a5-48ed-882b-b1a5f0240952
afc282cd-8a9a-44bf-aeab-ce2409a984ff	fae344b0-24a5-48ed-882b-b1a5f0240952
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
708212c3-a3b1-4f9c-85e1-f24d748cefb6	+
f82ba6ac-1207-4426-9106-0bbc87af410c	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

