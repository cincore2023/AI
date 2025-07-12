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
-- Name: User; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public."User" (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    open_id text,
    nickname text,
    phone_number text,
    salesperson bigint,
    relationship_channel bigint,
    benefit_level bigint,
    withdrawable_income numeric,
    cumulative_income numeric,
    membership_expiry_date timestamp with time zone,
    membership_redemption_code text,
    activity_redemption_code text,
    is_active boolean,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint
);


ALTER TABLE public."User" OWNER TO gva;

--
-- Name: COLUMN "User".created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public."User".created_by IS '创建者';


--
-- Name: COLUMN "User".updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public."User".updated_by IS '更新者';


--
-- Name: COLUMN "User".deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public."User".deleted_by IS '删除者';


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public."User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO gva;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: casbin_rule; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.casbin_rule (
    id bigint NOT NULL,
    ptype character varying(100),
    v0 character varying(100),
    v1 character varying(100),
    v2 character varying(100),
    v3 character varying(100),
    v4 character varying(100),
    v5 character varying(100)
);


ALTER TABLE public.casbin_rule OWNER TO gva;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.casbin_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.casbin_rule_id_seq OWNER TO gva;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.casbin_rule_id_seq OWNED BY public.casbin_rule.id;


--
-- Name: core_activities; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.core_activities (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    activity_name text,
    price numeric,
    category bigint,
    cover_picture text,
    actual_enrollment bigint DEFAULT 100,
    status boolean DEFAULT true,
    sort_order bigint,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    show_start_time timestamp with time zone,
    show_end_time timestamp with time zone,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint
);


ALTER TABLE public.core_activities OWNER TO gva;

--
-- Name: COLUMN core_activities.created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_activities.created_by IS '创建者';


--
-- Name: COLUMN core_activities.updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_activities.updated_by IS '更新者';


--
-- Name: COLUMN core_activities.deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_activities.deleted_by IS '删除者';


--
-- Name: core_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.core_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_activities_id_seq OWNER TO gva;

--
-- Name: core_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.core_activities_id_seq OWNED BY public.core_activities.id;


--
-- Name: core_courses; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.core_courses (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    course_title text,
    teacher bigint,
    category bigint,
    cover_image text,
    type text DEFAULT 'img'::text,
    price numeric,
    original_price numeric,
    on_sale boolean DEFAULT true,
    sort bigint,
    view_details text,
    course_details text,
    apprentice_count bigint,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint
);


ALTER TABLE public.core_courses OWNER TO gva;

--
-- Name: COLUMN core_courses.course_title; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.course_title IS '课程名称';


--
-- Name: COLUMN core_courses.teacher; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.teacher IS '讲师';


--
-- Name: COLUMN core_courses.category; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.category IS '课程分类';


--
-- Name: COLUMN core_courses.cover_image; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.cover_image IS '封面图片';


--
-- Name: COLUMN core_courses.type; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.type IS '图文或视频';


--
-- Name: COLUMN core_courses.price; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.price IS '课程售价';


--
-- Name: COLUMN core_courses.original_price; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.original_price IS '标注原价';


--
-- Name: COLUMN core_courses.on_sale; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.on_sale IS '表示课程是否已上架销售';


--
-- Name: COLUMN core_courses.sort; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.sort IS '排序显示';


--
-- Name: COLUMN core_courses.view_details; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.view_details IS '试看详情';


--
-- Name: COLUMN core_courses.course_details; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.course_details IS '课程介绍等内容';


--
-- Name: COLUMN core_courses.apprentice_count; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.apprentice_count IS '虚拟人数';


--
-- Name: COLUMN core_courses.created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.created_by IS '创建者';


--
-- Name: COLUMN core_courses.updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.updated_by IS '更新者';


--
-- Name: COLUMN core_courses.deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.core_courses.deleted_by IS '删除者';


--
-- Name: core_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.core_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_courses_id_seq OWNER TO gva;

--
-- Name: core_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.core_courses_id_seq OWNED BY public.core_courses.id;


--
-- Name: exa_attachment_category; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.exa_attachment_category (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    name character varying(255) DEFAULT NULL::character varying,
    pid bigint DEFAULT 0
);


ALTER TABLE public.exa_attachment_category OWNER TO gva;

--
-- Name: COLUMN exa_attachment_category.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_attachment_category.name IS '分类名称';


--
-- Name: COLUMN exa_attachment_category.pid; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_attachment_category.pid IS '父节点ID';


--
-- Name: exa_attachment_category_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.exa_attachment_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exa_attachment_category_id_seq OWNER TO gva;

--
-- Name: exa_attachment_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.exa_attachment_category_id_seq OWNED BY public.exa_attachment_category.id;


--
-- Name: exa_customers; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.exa_customers (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    customer_name text,
    customer_phone_data text,
    sys_user_id bigint,
    sys_user_authority_id bigint
);


ALTER TABLE public.exa_customers OWNER TO gva;

--
-- Name: COLUMN exa_customers.customer_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_customers.customer_name IS '客户名';


--
-- Name: COLUMN exa_customers.customer_phone_data; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_customers.customer_phone_data IS '客户手机号';


--
-- Name: COLUMN exa_customers.sys_user_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_customers.sys_user_id IS '管理ID';


--
-- Name: COLUMN exa_customers.sys_user_authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_customers.sys_user_authority_id IS '管理角色ID';


--
-- Name: exa_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.exa_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exa_customers_id_seq OWNER TO gva;

--
-- Name: exa_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.exa_customers_id_seq OWNED BY public.exa_customers.id;


--
-- Name: exa_file_chunks; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.exa_file_chunks (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    exa_file_id bigint,
    file_chunk_number bigint,
    file_chunk_path text
);


ALTER TABLE public.exa_file_chunks OWNER TO gva;

--
-- Name: exa_file_chunks_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.exa_file_chunks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exa_file_chunks_id_seq OWNER TO gva;

--
-- Name: exa_file_chunks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.exa_file_chunks_id_seq OWNED BY public.exa_file_chunks.id;


--
-- Name: exa_file_upload_and_downloads; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.exa_file_upload_and_downloads (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    name text,
    class_id bigint DEFAULT 0,
    url text,
    tag text,
    key text
);


ALTER TABLE public.exa_file_upload_and_downloads OWNER TO gva;

--
-- Name: COLUMN exa_file_upload_and_downloads.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_file_upload_and_downloads.name IS '文件名';


--
-- Name: COLUMN exa_file_upload_and_downloads.class_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_file_upload_and_downloads.class_id IS '分类id';


--
-- Name: COLUMN exa_file_upload_and_downloads.url; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_file_upload_and_downloads.url IS '文件地址';


--
-- Name: COLUMN exa_file_upload_and_downloads.tag; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_file_upload_and_downloads.tag IS '文件标签';


--
-- Name: COLUMN exa_file_upload_and_downloads.key; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.exa_file_upload_and_downloads.key IS '编号';


--
-- Name: exa_file_upload_and_downloads_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.exa_file_upload_and_downloads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exa_file_upload_and_downloads_id_seq OWNER TO gva;

--
-- Name: exa_file_upload_and_downloads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.exa_file_upload_and_downloads_id_seq OWNED BY public.exa_file_upload_and_downloads.id;


--
-- Name: exa_files; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.exa_files (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    file_name text,
    file_md5 text,
    file_path text,
    chunk_total bigint,
    is_finish boolean
);


ALTER TABLE public.exa_files OWNER TO gva;

--
-- Name: exa_files_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.exa_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exa_files_id_seq OWNER TO gva;

--
-- Name: exa_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.exa_files_id_seq OWNED BY public.exa_files.id;


--
-- Name: finance_code; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.finance_code (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    transaction_id text,
    username text,
    phone_number text,
    transaction_type bigint,
    code_type bigint,
    quantity bigint,
    remaining_quantity bigint,
    details text,
    transaction_time timestamp with time zone
);


ALTER TABLE public.finance_code OWNER TO gva;

--
-- Name: COLUMN finance_code.transaction_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.transaction_id IS '唯一标识每笔交易的编号';


--
-- Name: COLUMN finance_code.username; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.username IS '用户的昵称或名称';


--
-- Name: COLUMN finance_code.phone_number; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.phone_number IS '用户的联系电话号码';


--
-- Name: COLUMN finance_code.transaction_type; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.transaction_type IS '记录交易的性质，如增加、扣除等';


--
-- Name: COLUMN finance_code.code_type; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.code_type IS '指明是会员兑换码还是活动兑换码';


--
-- Name: COLUMN finance_code.quantity; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.quantity IS '表示本次交易的兑换码数量，正数表示增加，负数表示减少';


--
-- Name: COLUMN finance_code.remaining_quantity; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.remaining_quantity IS '显示交易后的兑换码剩余数量';


--
-- Name: COLUMN finance_code.details; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.details IS '提供关于该交易的额外信息，例如系统赠送、开通会员、报名活动等';


--
-- Name: COLUMN finance_code.transaction_time; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.finance_code.transaction_time IS '记录交易发生的具体时间';


--
-- Name: finance_code_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.finance_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_code_id_seq OWNER TO gva;

--
-- Name: finance_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.finance_code_id_seq OWNED BY public.finance_code.id;


--
-- Name: gva_announcements_info; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.gva_announcements_info (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    title text,
    content text,
    user_id bigint,
    attachments jsonb
);


ALTER TABLE public.gva_announcements_info OWNER TO gva;

--
-- Name: COLUMN gva_announcements_info.title; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.gva_announcements_info.title IS '公告标题';


--
-- Name: COLUMN gva_announcements_info.content; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.gva_announcements_info.content IS '公告内容';


--
-- Name: COLUMN gva_announcements_info.user_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.gva_announcements_info.user_id IS '发布者';


--
-- Name: COLUMN gva_announcements_info.attachments; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.gva_announcements_info.attachments IS '相关附件';


--
-- Name: gva_announcements_info_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.gva_announcements_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gva_announcements_info_id_seq OWNER TO gva;

--
-- Name: gva_announcements_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.gva_announcements_info_id_seq OWNED BY public.gva_announcements_info.id;


--
-- Name: jwt_blacklists; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.jwt_blacklists (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    jwt text
);


ALTER TABLE public.jwt_blacklists OWNER TO gva;

--
-- Name: COLUMN jwt_blacklists.jwt; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.jwt_blacklists.jwt IS 'jwt';


--
-- Name: jwt_blacklists_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.jwt_blacklists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jwt_blacklists_id_seq OWNER TO gva;

--
-- Name: jwt_blacklists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.jwt_blacklists_id_seq OWNED BY public.jwt_blacklists.id;


--
-- Name: program_banner; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.program_banner (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    image_url text,
    link_url text,
    "order" bigint,
    status bigint,
    type text DEFAULT 'home'::text
);


ALTER TABLE public.program_banner OWNER TO gva;

--
-- Name: COLUMN program_banner.image_url; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_banner.image_url IS '轮播图图片地址';


--
-- Name: COLUMN program_banner.link_url; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_banner.link_url IS '点击图片跳转的链接';


--
-- Name: COLUMN program_banner."order"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_banner."order" IS '轮播图顺序';


--
-- Name: COLUMN program_banner.status; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_banner.status IS '轮播图状态，例如：1-启用，0-禁用';


--
-- Name: program_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.program_banner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_banner_id_seq OWNER TO gva;

--
-- Name: program_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.program_banner_id_seq OWNED BY public.program_banner.id;


--
-- Name: program_benefit; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.program_benefit (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    level numeric,
    level_name text,
    member_commission numeric,
    activity_commission numeric,
    digital_person_commission numeric,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint
);


ALTER TABLE public.program_benefit OWNER TO gva;

--
-- Name: COLUMN program_benefit.created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_benefit.created_by IS '创建者';


--
-- Name: COLUMN program_benefit.updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_benefit.updated_by IS '更新者';


--
-- Name: COLUMN program_benefit.deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_benefit.deleted_by IS '删除者';


--
-- Name: program_benefit_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.program_benefit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_benefit_id_seq OWNER TO gva;

--
-- Name: program_benefit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.program_benefit_id_seq OWNED BY public.program_benefit.id;


--
-- Name: program_categories; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.program_categories (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    category_name text,
    status boolean DEFAULT true,
    sort_order bigint,
    type text DEFAULT 'course'::text,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    parent_id bigint
);


ALTER TABLE public.program_categories OWNER TO gva;

--
-- Name: COLUMN program_categories.created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_categories.created_by IS '创建者';


--
-- Name: COLUMN program_categories.updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_categories.updated_by IS '更新者';


--
-- Name: COLUMN program_categories.deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_categories.deleted_by IS '删除者';


--
-- Name: COLUMN program_categories.parent_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_categories.parent_id IS '父节点';


--
-- Name: program_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.program_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_categories_id_seq OWNER TO gva;

--
-- Name: program_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.program_categories_id_seq OWNED BY public.program_categories.id;


--
-- Name: program_poster; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.program_poster (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    text text,
    bg_img text,
    switch_button boolean,
    size_slider text,
    radius text,
    top text,
    "left" text
);


ALTER TABLE public.program_poster OWNER TO gva;

--
-- Name: COLUMN program_poster.switch_button; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_poster.switch_button IS '控制功能开启与关闭';


--
-- Name: COLUMN program_poster.size_slider; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_poster.size_slider IS '改变元素大小';


--
-- Name: COLUMN program_poster.radius; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_poster.radius IS '圆角';


--
-- Name: COLUMN program_poster.top; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_poster.top IS '距离顶部';


--
-- Name: program_poster_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.program_poster_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_poster_id_seq OWNER TO gva;

--
-- Name: program_poster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.program_poster_id_seq OWNED BY public.program_poster.id;


--
-- Name: program_teacher; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.program_teacher (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    avatar text,
    name text,
    description text,
    introduction text,
    sort bigint DEFAULT 0,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint
);


ALTER TABLE public.program_teacher OWNER TO gva;

--
-- Name: COLUMN program_teacher.created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_teacher.created_by IS '创建者';


--
-- Name: COLUMN program_teacher.updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_teacher.updated_by IS '更新者';


--
-- Name: COLUMN program_teacher.deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.program_teacher.deleted_by IS '删除者';


--
-- Name: program_teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.program_teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_teacher_id_seq OWNER TO gva;

--
-- Name: program_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.program_teacher_id_seq OWNED BY public.program_teacher.id;


--
-- Name: sys_apis; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_apis (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    path text,
    description text,
    api_group text,
    method text DEFAULT 'POST'::text
);


ALTER TABLE public.sys_apis OWNER TO gva;

--
-- Name: COLUMN sys_apis.path; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_apis.path IS 'api路径';


--
-- Name: COLUMN sys_apis.description; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_apis.description IS 'api中文描述';


--
-- Name: COLUMN sys_apis.api_group; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_apis.api_group IS 'api组';


--
-- Name: COLUMN sys_apis.method; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_apis.method IS '方法';


--
-- Name: sys_apis_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_apis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_apis_id_seq OWNER TO gva;

--
-- Name: sys_apis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_apis_id_seq OWNED BY public.sys_apis.id;


--
-- Name: sys_authorities; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_authorities (
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    authority_id bigint NOT NULL,
    authority_name text,
    parent_id bigint,
    default_router text DEFAULT 'dashboard'::text
);


ALTER TABLE public.sys_authorities OWNER TO gva;

--
-- Name: COLUMN sys_authorities.authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authorities.authority_id IS '角色ID';


--
-- Name: COLUMN sys_authorities.authority_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authorities.authority_name IS '角色名';


--
-- Name: COLUMN sys_authorities.parent_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authorities.parent_id IS '父角色ID';


--
-- Name: COLUMN sys_authorities.default_router; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authorities.default_router IS '默认菜单';


--
-- Name: sys_authorities_authority_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_authorities_authority_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_authorities_authority_id_seq OWNER TO gva;

--
-- Name: sys_authorities_authority_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_authorities_authority_id_seq OWNED BY public.sys_authorities.authority_id;


--
-- Name: sys_authority_btns; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_authority_btns (
    authority_id bigint,
    sys_menu_id bigint,
    sys_base_menu_btn_id bigint
);


ALTER TABLE public.sys_authority_btns OWNER TO gva;

--
-- Name: COLUMN sys_authority_btns.authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authority_btns.authority_id IS '角色ID';


--
-- Name: COLUMN sys_authority_btns.sys_menu_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authority_btns.sys_menu_id IS '菜单ID';


--
-- Name: COLUMN sys_authority_btns.sys_base_menu_btn_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authority_btns.sys_base_menu_btn_id IS '菜单按钮ID';


--
-- Name: sys_authority_menus; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_authority_menus (
    sys_base_menu_id bigint NOT NULL,
    sys_authority_authority_id bigint NOT NULL
);


ALTER TABLE public.sys_authority_menus OWNER TO gva;

--
-- Name: COLUMN sys_authority_menus.sys_authority_authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_authority_menus.sys_authority_authority_id IS '角色ID';


--
-- Name: sys_auto_code_histories; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_auto_code_histories (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    table_name text,
    package text,
    request text,
    struct_name text,
    abbreviation text,
    business_db text,
    description text,
    templates text,
    "Injections" text,
    flag bigint,
    api_ids text,
    menu_id bigint,
    export_template_id bigint,
    package_id bigint
);


ALTER TABLE public.sys_auto_code_histories OWNER TO gva;

--
-- Name: COLUMN sys_auto_code_histories.table_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.table_name IS '表名';


--
-- Name: COLUMN sys_auto_code_histories.package; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.package IS '模块名/插件名';


--
-- Name: COLUMN sys_auto_code_histories.request; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.request IS '前端传入的结构化信息';


--
-- Name: COLUMN sys_auto_code_histories.struct_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.struct_name IS '结构体名称';


--
-- Name: COLUMN sys_auto_code_histories.abbreviation; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.abbreviation IS '结构体名称缩写';


--
-- Name: COLUMN sys_auto_code_histories.business_db; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.business_db IS '业务库';


--
-- Name: COLUMN sys_auto_code_histories.description; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.description IS 'Struct中文名称';


--
-- Name: COLUMN sys_auto_code_histories.templates; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.templates IS '模板信息';


--
-- Name: COLUMN sys_auto_code_histories."Injections"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories."Injections" IS '注入路径';


--
-- Name: COLUMN sys_auto_code_histories.flag; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.flag IS '[0:创建,1:回滚]';


--
-- Name: COLUMN sys_auto_code_histories.api_ids; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.api_ids IS 'api表注册内容';


--
-- Name: COLUMN sys_auto_code_histories.menu_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.menu_id IS '菜单ID';


--
-- Name: COLUMN sys_auto_code_histories.export_template_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.export_template_id IS '导出模板ID';


--
-- Name: COLUMN sys_auto_code_histories.package_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_histories.package_id IS '包ID';


--
-- Name: sys_auto_code_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_auto_code_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_auto_code_histories_id_seq OWNER TO gva;

--
-- Name: sys_auto_code_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_auto_code_histories_id_seq OWNED BY public.sys_auto_code_histories.id;


--
-- Name: sys_auto_code_packages; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_auto_code_packages (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    "desc" text,
    label text,
    template text,
    package_name text,
    module text
);


ALTER TABLE public.sys_auto_code_packages OWNER TO gva;

--
-- Name: COLUMN sys_auto_code_packages."desc"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_packages."desc" IS '描述';


--
-- Name: COLUMN sys_auto_code_packages.label; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_packages.label IS '展示名';


--
-- Name: COLUMN sys_auto_code_packages.template; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_packages.template IS '模版';


--
-- Name: COLUMN sys_auto_code_packages.package_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_auto_code_packages.package_name IS '包名';


--
-- Name: sys_auto_code_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_auto_code_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_auto_code_packages_id_seq OWNER TO gva;

--
-- Name: sys_auto_code_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_auto_code_packages_id_seq OWNED BY public.sys_auto_code_packages.id;


--
-- Name: sys_base_menu_btns; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_base_menu_btns (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    name text,
    "desc" text,
    sys_base_menu_id bigint
);


ALTER TABLE public.sys_base_menu_btns OWNER TO gva;

--
-- Name: COLUMN sys_base_menu_btns.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menu_btns.name IS '按钮关键key';


--
-- Name: COLUMN sys_base_menu_btns.sys_base_menu_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menu_btns.sys_base_menu_id IS '菜单ID';


--
-- Name: sys_base_menu_btns_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_base_menu_btns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_base_menu_btns_id_seq OWNER TO gva;

--
-- Name: sys_base_menu_btns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_base_menu_btns_id_seq OWNED BY public.sys_base_menu_btns.id;


--
-- Name: sys_base_menu_parameters; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_base_menu_parameters (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    sys_base_menu_id bigint,
    type text,
    key text,
    value text
);


ALTER TABLE public.sys_base_menu_parameters OWNER TO gva;

--
-- Name: COLUMN sys_base_menu_parameters.type; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menu_parameters.type IS '地址栏携带参数为params还是query';


--
-- Name: COLUMN sys_base_menu_parameters.key; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menu_parameters.key IS '地址栏携带参数的key';


--
-- Name: COLUMN sys_base_menu_parameters.value; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menu_parameters.value IS '地址栏携带参数的值';


--
-- Name: sys_base_menu_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_base_menu_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_base_menu_parameters_id_seq OWNER TO gva;

--
-- Name: sys_base_menu_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_base_menu_parameters_id_seq OWNED BY public.sys_base_menu_parameters.id;


--
-- Name: sys_base_menus; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_base_menus (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    menu_level bigint,
    parent_id bigint,
    path text,
    name text,
    hidden boolean,
    component text,
    sort bigint,
    active_name text,
    keep_alive boolean,
    default_menu boolean,
    title text,
    icon text,
    close_tab boolean,
    transition_type text
);


ALTER TABLE public.sys_base_menus OWNER TO gva;

--
-- Name: COLUMN sys_base_menus.parent_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.parent_id IS '父菜单ID';


--
-- Name: COLUMN sys_base_menus.path; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.path IS '路由path';


--
-- Name: COLUMN sys_base_menus.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.name IS '路由name';


--
-- Name: COLUMN sys_base_menus.hidden; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.hidden IS '是否在列表隐藏';


--
-- Name: COLUMN sys_base_menus.component; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.component IS '对应前端文件路径';


--
-- Name: COLUMN sys_base_menus.sort; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.sort IS '排序标记';


--
-- Name: COLUMN sys_base_menus.active_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.active_name IS '高亮菜单';


--
-- Name: COLUMN sys_base_menus.keep_alive; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.keep_alive IS '是否缓存';


--
-- Name: COLUMN sys_base_menus.default_menu; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.default_menu IS '是否是基础路由（开发中）';


--
-- Name: COLUMN sys_base_menus.title; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.title IS '菜单名';


--
-- Name: COLUMN sys_base_menus.icon; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.icon IS '菜单图标';


--
-- Name: COLUMN sys_base_menus.close_tab; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.close_tab IS '自动关闭tab';


--
-- Name: COLUMN sys_base_menus.transition_type; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_base_menus.transition_type IS '路由切换动画';


--
-- Name: sys_base_menus_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_base_menus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_base_menus_id_seq OWNER TO gva;

--
-- Name: sys_base_menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_base_menus_id_seq OWNED BY public.sys_base_menus.id;


--
-- Name: sys_data_authority_id; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_data_authority_id (
    sys_authority_authority_id bigint NOT NULL,
    data_authority_id_authority_id bigint NOT NULL
);


ALTER TABLE public.sys_data_authority_id OWNER TO gva;

--
-- Name: COLUMN sys_data_authority_id.sys_authority_authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_data_authority_id.sys_authority_authority_id IS '角色ID';


--
-- Name: COLUMN sys_data_authority_id.data_authority_id_authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_data_authority_id.data_authority_id_authority_id IS '角色ID';


--
-- Name: sys_dictionaries; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_dictionaries (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    name text,
    type text,
    status boolean,
    "desc" text
);


ALTER TABLE public.sys_dictionaries OWNER TO gva;

--
-- Name: COLUMN sys_dictionaries.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionaries.name IS '字典名（中）';


--
-- Name: COLUMN sys_dictionaries.type; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionaries.type IS '字典名（英）';


--
-- Name: COLUMN sys_dictionaries.status; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionaries.status IS '状态';


--
-- Name: COLUMN sys_dictionaries."desc"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionaries."desc" IS '描述';


--
-- Name: sys_dictionaries_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_dictionaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_dictionaries_id_seq OWNER TO gva;

--
-- Name: sys_dictionaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_dictionaries_id_seq OWNED BY public.sys_dictionaries.id;


--
-- Name: sys_dictionary_details; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_dictionary_details (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    label text,
    value text,
    extend text,
    status boolean,
    sort bigint,
    sys_dictionary_id bigint
);


ALTER TABLE public.sys_dictionary_details OWNER TO gva;

--
-- Name: COLUMN sys_dictionary_details.label; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionary_details.label IS '展示值';


--
-- Name: COLUMN sys_dictionary_details.value; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionary_details.value IS '字典值';


--
-- Name: COLUMN sys_dictionary_details.extend; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionary_details.extend IS '扩展值';


--
-- Name: COLUMN sys_dictionary_details.status; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionary_details.status IS '启用状态';


--
-- Name: COLUMN sys_dictionary_details.sort; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionary_details.sort IS '排序标记';


--
-- Name: COLUMN sys_dictionary_details.sys_dictionary_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_dictionary_details.sys_dictionary_id IS '关联标记';


--
-- Name: sys_dictionary_details_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_dictionary_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_dictionary_details_id_seq OWNER TO gva;

--
-- Name: sys_dictionary_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_dictionary_details_id_seq OWNED BY public.sys_dictionary_details.id;


--
-- Name: sys_export_template_condition; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_export_template_condition (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    template_id text,
    "from" text,
    "column" text,
    operator text
);


ALTER TABLE public.sys_export_template_condition OWNER TO gva;

--
-- Name: COLUMN sys_export_template_condition.template_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_condition.template_id IS '模板标识';


--
-- Name: COLUMN sys_export_template_condition."from"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_condition."from" IS '条件取的key';


--
-- Name: COLUMN sys_export_template_condition."column"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_condition."column" IS '作为查询条件的字段';


--
-- Name: COLUMN sys_export_template_condition.operator; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_condition.operator IS '操作符';


--
-- Name: sys_export_template_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_export_template_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_export_template_condition_id_seq OWNER TO gva;

--
-- Name: sys_export_template_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_export_template_condition_id_seq OWNED BY public.sys_export_template_condition.id;


--
-- Name: sys_export_template_join; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_export_template_join (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    template_id text,
    joins text,
    "table" text,
    "on" text
);


ALTER TABLE public.sys_export_template_join OWNER TO gva;

--
-- Name: COLUMN sys_export_template_join.template_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_join.template_id IS '模板标识';


--
-- Name: COLUMN sys_export_template_join.joins; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_join.joins IS '关联';


--
-- Name: COLUMN sys_export_template_join."table"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_join."table" IS '关联表';


--
-- Name: COLUMN sys_export_template_join."on"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_template_join."on" IS '关联条件';


--
-- Name: sys_export_template_join_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_export_template_join_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_export_template_join_id_seq OWNER TO gva;

--
-- Name: sys_export_template_join_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_export_template_join_id_seq OWNED BY public.sys_export_template_join.id;


--
-- Name: sys_export_templates; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_export_templates (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    db_name text,
    name text,
    table_name text,
    template_id text,
    template_info text,
    "limit" bigint,
    "order" text
);


ALTER TABLE public.sys_export_templates OWNER TO gva;

--
-- Name: COLUMN sys_export_templates.db_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_templates.db_name IS '数据库名称';


--
-- Name: COLUMN sys_export_templates.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_templates.name IS '模板名称';


--
-- Name: COLUMN sys_export_templates.table_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_templates.table_name IS '表名称';


--
-- Name: COLUMN sys_export_templates.template_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_templates.template_id IS '模板标识';


--
-- Name: COLUMN sys_export_templates."limit"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_templates."limit" IS '导出限制';


--
-- Name: COLUMN sys_export_templates."order"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_export_templates."order" IS '排序';


--
-- Name: sys_export_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_export_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_export_templates_id_seq OWNER TO gva;

--
-- Name: sys_export_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_export_templates_id_seq OWNED BY public.sys_export_templates.id;


--
-- Name: sys_ignore_apis; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_ignore_apis (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    path text,
    method text DEFAULT 'POST'::text
);


ALTER TABLE public.sys_ignore_apis OWNER TO gva;

--
-- Name: COLUMN sys_ignore_apis.path; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_ignore_apis.path IS 'api路径';


--
-- Name: COLUMN sys_ignore_apis.method; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_ignore_apis.method IS '方法';


--
-- Name: sys_ignore_apis_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_ignore_apis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_ignore_apis_id_seq OWNER TO gva;

--
-- Name: sys_ignore_apis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_ignore_apis_id_seq OWNED BY public.sys_ignore_apis.id;


--
-- Name: sys_operation_records; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_operation_records (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    ip text,
    method text,
    path text,
    status bigint,
    latency bigint,
    agent text,
    error_message text,
    body text,
    resp text,
    user_id bigint
);


ALTER TABLE public.sys_operation_records OWNER TO gva;

--
-- Name: COLUMN sys_operation_records.ip; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.ip IS '请求ip';


--
-- Name: COLUMN sys_operation_records.method; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.method IS '请求方法';


--
-- Name: COLUMN sys_operation_records.path; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.path IS '请求路径';


--
-- Name: COLUMN sys_operation_records.status; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.status IS '请求状态';


--
-- Name: COLUMN sys_operation_records.latency; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.latency IS '延迟';


--
-- Name: COLUMN sys_operation_records.agent; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.agent IS '代理';


--
-- Name: COLUMN sys_operation_records.error_message; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.error_message IS '错误信息';


--
-- Name: COLUMN sys_operation_records.body; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.body IS '请求Body';


--
-- Name: COLUMN sys_operation_records.resp; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.resp IS '响应Body';


--
-- Name: COLUMN sys_operation_records.user_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_operation_records.user_id IS '用户id';


--
-- Name: sys_operation_records_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_operation_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_operation_records_id_seq OWNER TO gva;

--
-- Name: sys_operation_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_operation_records_id_seq OWNED BY public.sys_operation_records.id;


--
-- Name: sys_params; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_params (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    name text,
    key text,
    value text,
    "desc" text
);


ALTER TABLE public.sys_params OWNER TO gva;

--
-- Name: COLUMN sys_params.name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_params.name IS '参数名称';


--
-- Name: COLUMN sys_params.key; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_params.key IS '参数键';


--
-- Name: COLUMN sys_params.value; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_params.value IS '参数值';


--
-- Name: COLUMN sys_params."desc"; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_params."desc" IS '参数说明';


--
-- Name: sys_params_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_params_id_seq OWNER TO gva;

--
-- Name: sys_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_params_id_seq OWNED BY public.sys_params.id;


--
-- Name: sys_user_authority; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_user_authority (
    sys_user_id bigint NOT NULL,
    sys_authority_authority_id bigint NOT NULL
);


ALTER TABLE public.sys_user_authority OWNER TO gva;

--
-- Name: COLUMN sys_user_authority.sys_authority_authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_user_authority.sys_authority_authority_id IS '角色ID';


--
-- Name: sys_users; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.sys_users (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    uuid text,
    username text,
    password text,
    nick_name text DEFAULT '系统用户'::text,
    header_img text DEFAULT 'https://qmplusimg.henrongyi.top/gva_header.jpg'::text,
    authority_id bigint DEFAULT 888,
    phone text,
    email text,
    enable bigint DEFAULT 1,
    origin_setting text
);


ALTER TABLE public.sys_users OWNER TO gva;

--
-- Name: COLUMN sys_users.uuid; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.uuid IS '用户UUID';


--
-- Name: COLUMN sys_users.username; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.username IS '用户登录名';


--
-- Name: COLUMN sys_users.password; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.password IS '用户登录密码';


--
-- Name: COLUMN sys_users.nick_name; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.nick_name IS '用户昵称';


--
-- Name: COLUMN sys_users.header_img; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.header_img IS '用户头像';


--
-- Name: COLUMN sys_users.authority_id; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.authority_id IS '用户角色ID';


--
-- Name: COLUMN sys_users.phone; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.phone IS '用户手机号';


--
-- Name: COLUMN sys_users.email; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.email IS '用户邮箱';


--
-- Name: COLUMN sys_users.enable; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.enable IS '用户是否被冻结 1正常 2冻结';


--
-- Name: COLUMN sys_users.origin_setting; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.sys_users.origin_setting IS '配置';


--
-- Name: sys_users_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.sys_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_users_id_seq OWNER TO gva;

--
-- Name: sys_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.sys_users_id_seq OWNED BY public.sys_users.id;


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: casbin_rule id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.casbin_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_rule_id_seq'::regclass);


--
-- Name: core_activities id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.core_activities ALTER COLUMN id SET DEFAULT nextval('public.core_activities_id_seq'::regclass);


--
-- Name: core_courses id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.core_courses ALTER COLUMN id SET DEFAULT nextval('public.core_courses_id_seq'::regclass);


--
-- Name: exa_attachment_category id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_attachment_category ALTER COLUMN id SET DEFAULT nextval('public.exa_attachment_category_id_seq'::regclass);


--
-- Name: exa_customers id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_customers ALTER COLUMN id SET DEFAULT nextval('public.exa_customers_id_seq'::regclass);


--
-- Name: exa_file_chunks id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_file_chunks ALTER COLUMN id SET DEFAULT nextval('public.exa_file_chunks_id_seq'::regclass);


--
-- Name: exa_file_upload_and_downloads id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_file_upload_and_downloads ALTER COLUMN id SET DEFAULT nextval('public.exa_file_upload_and_downloads_id_seq'::regclass);


--
-- Name: exa_files id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_files ALTER COLUMN id SET DEFAULT nextval('public.exa_files_id_seq'::regclass);


--
-- Name: finance_code id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.finance_code ALTER COLUMN id SET DEFAULT nextval('public.finance_code_id_seq'::regclass);


--
-- Name: gva_announcements_info id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.gva_announcements_info ALTER COLUMN id SET DEFAULT nextval('public.gva_announcements_info_id_seq'::regclass);


--
-- Name: jwt_blacklists id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.jwt_blacklists ALTER COLUMN id SET DEFAULT nextval('public.jwt_blacklists_id_seq'::regclass);


--
-- Name: program_banner id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_banner ALTER COLUMN id SET DEFAULT nextval('public.program_banner_id_seq'::regclass);


--
-- Name: program_benefit id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_benefit ALTER COLUMN id SET DEFAULT nextval('public.program_benefit_id_seq'::regclass);


--
-- Name: program_categories id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_categories ALTER COLUMN id SET DEFAULT nextval('public.program_categories_id_seq'::regclass);


--
-- Name: program_poster id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_poster ALTER COLUMN id SET DEFAULT nextval('public.program_poster_id_seq'::regclass);


--
-- Name: program_teacher id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_teacher ALTER COLUMN id SET DEFAULT nextval('public.program_teacher_id_seq'::regclass);


--
-- Name: sys_apis id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_apis ALTER COLUMN id SET DEFAULT nextval('public.sys_apis_id_seq'::regclass);


--
-- Name: sys_authorities authority_id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_authorities ALTER COLUMN authority_id SET DEFAULT nextval('public.sys_authorities_authority_id_seq'::regclass);


--
-- Name: sys_auto_code_histories id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_auto_code_histories ALTER COLUMN id SET DEFAULT nextval('public.sys_auto_code_histories_id_seq'::regclass);


--
-- Name: sys_auto_code_packages id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_auto_code_packages ALTER COLUMN id SET DEFAULT nextval('public.sys_auto_code_packages_id_seq'::regclass);


--
-- Name: sys_base_menu_btns id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_base_menu_btns ALTER COLUMN id SET DEFAULT nextval('public.sys_base_menu_btns_id_seq'::regclass);


--
-- Name: sys_base_menu_parameters id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_base_menu_parameters ALTER COLUMN id SET DEFAULT nextval('public.sys_base_menu_parameters_id_seq'::regclass);


--
-- Name: sys_base_menus id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_base_menus ALTER COLUMN id SET DEFAULT nextval('public.sys_base_menus_id_seq'::regclass);


--
-- Name: sys_dictionaries id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_dictionaries ALTER COLUMN id SET DEFAULT nextval('public.sys_dictionaries_id_seq'::regclass);


--
-- Name: sys_dictionary_details id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_dictionary_details ALTER COLUMN id SET DEFAULT nextval('public.sys_dictionary_details_id_seq'::regclass);


--
-- Name: sys_export_template_condition id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_export_template_condition ALTER COLUMN id SET DEFAULT nextval('public.sys_export_template_condition_id_seq'::regclass);


--
-- Name: sys_export_template_join id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_export_template_join ALTER COLUMN id SET DEFAULT nextval('public.sys_export_template_join_id_seq'::regclass);


--
-- Name: sys_export_templates id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_export_templates ALTER COLUMN id SET DEFAULT nextval('public.sys_export_templates_id_seq'::regclass);


--
-- Name: sys_ignore_apis id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_ignore_apis ALTER COLUMN id SET DEFAULT nextval('public.sys_ignore_apis_id_seq'::regclass);


--
-- Name: sys_operation_records id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_operation_records ALTER COLUMN id SET DEFAULT nextval('public.sys_operation_records_id_seq'::regclass);


--
-- Name: sys_params id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_params ALTER COLUMN id SET DEFAULT nextval('public.sys_params_id_seq'::regclass);


--
-- Name: sys_users id; Type: DEFAULT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_users ALTER COLUMN id SET DEFAULT nextval('public.sys_users_id_seq'::regclass);


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public."User" (id, created_at, updated_at, deleted_at, open_id, nickname, phone_number, salesperson, relationship_channel, benefit_level, withdrawable_income, cumulative_income, membership_expiry_date, membership_redemption_code, activity_redemption_code, is_active, created_by, updated_by, deleted_by) FROM stdin;
\.


--
-- Data for Name: casbin_rule; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.casbin_rule (id, ptype, v0, v1, v2, v3, v4, v5) FROM stdin;
1	p	888	/user/admin_register	POST			
2	p	888	/api/createApi	POST			
3	p	888	/api/getApiList	POST			
4	p	888	/api/getApiById	POST			
5	p	888	/api/deleteApi	POST			
6	p	888	/api/updateApi	POST			
7	p	888	/api/getAllApis	POST			
8	p	888	/api/deleteApisByIds	DELETE			
9	p	888	/api/syncApi	GET			
10	p	888	/api/getApiGroups	GET			
11	p	888	/api/enterSyncApi	POST			
12	p	888	/api/ignoreApi	POST			
13	p	888	/authority/copyAuthority	POST			
14	p	888	/authority/updateAuthority	PUT			
15	p	888	/authority/createAuthority	POST			
16	p	888	/authority/deleteAuthority	POST			
17	p	888	/authority/getAuthorityList	POST			
18	p	888	/authority/setDataAuthority	POST			
19	p	888	/menu/getMenu	POST			
20	p	888	/menu/getMenuList	POST			
21	p	888	/menu/addBaseMenu	POST			
22	p	888	/menu/getBaseMenuTree	POST			
23	p	888	/menu/addMenuAuthority	POST			
24	p	888	/menu/getMenuAuthority	POST			
25	p	888	/menu/deleteBaseMenu	POST			
26	p	888	/menu/updateBaseMenu	POST			
27	p	888	/menu/getBaseMenuById	POST			
28	p	888	/user/getUserInfo	GET			
29	p	888	/user/setUserInfo	PUT			
30	p	888	/user/setSelfInfo	PUT			
31	p	888	/user/getUserList	POST			
32	p	888	/user/deleteUser	DELETE			
33	p	888	/user/changePassword	POST			
34	p	888	/user/setUserAuthority	POST			
35	p	888	/user/setUserAuthorities	POST			
36	p	888	/user/resetPassword	POST			
37	p	888	/user/setSelfSetting	PUT			
38	p	888	/fileUploadAndDownload/findFile	GET			
39	p	888	/fileUploadAndDownload/breakpointContinueFinish	POST			
40	p	888	/fileUploadAndDownload/breakpointContinue	POST			
41	p	888	/fileUploadAndDownload/removeChunk	POST			
42	p	888	/fileUploadAndDownload/upload	POST			
43	p	888	/fileUploadAndDownload/deleteFile	POST			
44	p	888	/fileUploadAndDownload/editFileName	POST			
45	p	888	/fileUploadAndDownload/getFileList	POST			
46	p	888	/fileUploadAndDownload/importURL	POST			
47	p	888	/casbin/updateCasbin	POST			
48	p	888	/casbin/getPolicyPathByAuthorityId	POST			
49	p	888	/jwt/jsonInBlacklist	POST			
50	p	888	/system/getSystemConfig	POST			
51	p	888	/system/setSystemConfig	POST			
52	p	888	/system/getServerInfo	POST			
53	p	888	/customer/customer	GET			
54	p	888	/customer/customer	PUT			
55	p	888	/customer/customer	POST			
56	p	888	/customer/customer	DELETE			
57	p	888	/customer/customerList	GET			
58	p	888	/autoCode/getDB	GET			
59	p	888	/autoCode/getMeta	POST			
60	p	888	/autoCode/preview	POST			
61	p	888	/autoCode/getTables	GET			
62	p	888	/autoCode/getColumn	GET			
63	p	888	/autoCode/rollback	POST			
64	p	888	/autoCode/createTemp	POST			
65	p	888	/autoCode/delSysHistory	POST			
66	p	888	/autoCode/getSysHistory	POST			
67	p	888	/autoCode/createPackage	POST			
68	p	888	/autoCode/getTemplates	GET			
69	p	888	/autoCode/getPackage	POST			
70	p	888	/autoCode/delPackage	POST			
71	p	888	/autoCode/createPlug	POST			
72	p	888	/autoCode/installPlugin	POST			
73	p	888	/autoCode/pubPlug	POST			
74	p	888	/autoCode/addFunc	POST			
75	p	888	/autoCode/mcp	POST			
76	p	888	/autoCode/mcpTest	POST			
77	p	888	/autoCode/mcpList	POST			
78	p	888	/sysDictionaryDetail/findSysDictionaryDetail	GET			
79	p	888	/sysDictionaryDetail/updateSysDictionaryDetail	PUT			
80	p	888	/sysDictionaryDetail/createSysDictionaryDetail	POST			
81	p	888	/sysDictionaryDetail/getSysDictionaryDetailList	GET			
82	p	888	/sysDictionaryDetail/deleteSysDictionaryDetail	DELETE			
83	p	888	/sysDictionary/findSysDictionary	GET			
84	p	888	/sysDictionary/updateSysDictionary	PUT			
85	p	888	/sysDictionary/getSysDictionaryList	GET			
86	p	888	/sysDictionary/createSysDictionary	POST			
87	p	888	/sysDictionary/deleteSysDictionary	DELETE			
88	p	888	/sysOperationRecord/findSysOperationRecord	GET			
89	p	888	/sysOperationRecord/updateSysOperationRecord	PUT			
90	p	888	/sysOperationRecord/createSysOperationRecord	POST			
91	p	888	/sysOperationRecord/getSysOperationRecordList	GET			
92	p	888	/sysOperationRecord/deleteSysOperationRecord	DELETE			
93	p	888	/sysOperationRecord/deleteSysOperationRecordByIds	DELETE			
94	p	888	/email/emailTest	POST			
95	p	888	/email/sendEmail	POST			
96	p	888	/simpleUploader/upload	POST			
97	p	888	/simpleUploader/checkFileMd5	GET			
98	p	888	/simpleUploader/mergeFileMd5	GET			
99	p	888	/authorityBtn/setAuthorityBtn	POST			
100	p	888	/authorityBtn/getAuthorityBtn	POST			
101	p	888	/authorityBtn/canRemoveAuthorityBtn	POST			
102	p	888	/sysExportTemplate/createSysExportTemplate	POST			
103	p	888	/sysExportTemplate/deleteSysExportTemplate	DELETE			
104	p	888	/sysExportTemplate/deleteSysExportTemplateByIds	DELETE			
105	p	888	/sysExportTemplate/updateSysExportTemplate	PUT			
106	p	888	/sysExportTemplate/findSysExportTemplate	GET			
107	p	888	/sysExportTemplate/getSysExportTemplateList	GET			
108	p	888	/sysExportTemplate/exportExcel	GET			
109	p	888	/sysExportTemplate/exportTemplate	GET			
110	p	888	/sysExportTemplate/importExcel	POST			
111	p	888	/info/createInfo	POST			
112	p	888	/info/deleteInfo	DELETE			
113	p	888	/info/deleteInfoByIds	DELETE			
114	p	888	/info/updateInfo	PUT			
115	p	888	/info/findInfo	GET			
116	p	888	/info/getInfoList	GET			
117	p	888	/sysParams/createSysParams	POST			
118	p	888	/sysParams/deleteSysParams	DELETE			
119	p	888	/sysParams/deleteSysParamsByIds	DELETE			
120	p	888	/sysParams/updateSysParams	PUT			
121	p	888	/sysParams/findSysParams	GET			
122	p	888	/sysParams/getSysParamsList	GET			
123	p	888	/sysParams/getSysParam	GET			
124	p	888	/attachmentCategory/getCategoryList	GET			
125	p	888	/attachmentCategory/addCategory	POST			
126	p	888	/attachmentCategory/deleteCategory	POST			
127	p	8881	/user/admin_register	POST			
128	p	8881	/api/createApi	POST			
129	p	8881	/api/getApiList	POST			
130	p	8881	/api/getApiById	POST			
131	p	8881	/api/deleteApi	POST			
132	p	8881	/api/updateApi	POST			
133	p	8881	/api/getAllApis	POST			
134	p	8881	/authority/createAuthority	POST			
135	p	8881	/authority/deleteAuthority	POST			
136	p	8881	/authority/getAuthorityList	POST			
137	p	8881	/authority/setDataAuthority	POST			
138	p	8881	/menu/getMenu	POST			
139	p	8881	/menu/getMenuList	POST			
140	p	8881	/menu/addBaseMenu	POST			
141	p	8881	/menu/getBaseMenuTree	POST			
142	p	8881	/menu/addMenuAuthority	POST			
143	p	8881	/menu/getMenuAuthority	POST			
144	p	8881	/menu/deleteBaseMenu	POST			
145	p	8881	/menu/updateBaseMenu	POST			
146	p	8881	/menu/getBaseMenuById	POST			
147	p	8881	/user/changePassword	POST			
148	p	8881	/user/getUserList	POST			
149	p	8881	/user/setUserAuthority	POST			
150	p	8881	/fileUploadAndDownload/upload	POST			
151	p	8881	/fileUploadAndDownload/getFileList	POST			
152	p	8881	/fileUploadAndDownload/deleteFile	POST			
153	p	8881	/fileUploadAndDownload/editFileName	POST			
154	p	8881	/fileUploadAndDownload/importURL	POST			
155	p	8881	/casbin/updateCasbin	POST			
156	p	8881	/casbin/getPolicyPathByAuthorityId	POST			
157	p	8881	/jwt/jsonInBlacklist	POST			
158	p	8881	/system/getSystemConfig	POST			
159	p	8881	/system/setSystemConfig	POST			
160	p	8881	/customer/customer	POST			
161	p	8881	/customer/customer	PUT			
162	p	8881	/customer/customer	DELETE			
163	p	8881	/customer/customer	GET			
164	p	8881	/customer/customerList	GET			
165	p	8881	/user/getUserInfo	GET			
166	p	9528	/user/admin_register	POST			
167	p	9528	/api/createApi	POST			
168	p	9528	/api/getApiList	POST			
169	p	9528	/api/getApiById	POST			
170	p	9528	/api/deleteApi	POST			
171	p	9528	/api/updateApi	POST			
172	p	9528	/api/getAllApis	POST			
173	p	9528	/authority/createAuthority	POST			
174	p	9528	/authority/deleteAuthority	POST			
175	p	9528	/authority/getAuthorityList	POST			
176	p	9528	/authority/setDataAuthority	POST			
177	p	9528	/menu/getMenu	POST			
178	p	9528	/menu/getMenuList	POST			
179	p	9528	/menu/addBaseMenu	POST			
180	p	9528	/menu/getBaseMenuTree	POST			
181	p	9528	/menu/addMenuAuthority	POST			
182	p	9528	/menu/getMenuAuthority	POST			
183	p	9528	/menu/deleteBaseMenu	POST			
184	p	9528	/menu/updateBaseMenu	POST			
185	p	9528	/menu/getBaseMenuById	POST			
186	p	9528	/user/changePassword	POST			
187	p	9528	/user/getUserList	POST			
188	p	9528	/user/setUserAuthority	POST			
189	p	9528	/fileUploadAndDownload/upload	POST			
190	p	9528	/fileUploadAndDownload/getFileList	POST			
191	p	9528	/fileUploadAndDownload/deleteFile	POST			
192	p	9528	/fileUploadAndDownload/editFileName	POST			
193	p	9528	/fileUploadAndDownload/importURL	POST			
194	p	9528	/casbin/updateCasbin	POST			
195	p	9528	/casbin/getPolicyPathByAuthorityId	POST			
196	p	9528	/jwt/jsonInBlacklist	POST			
197	p	9528	/system/getSystemConfig	POST			
198	p	9528	/system/setSystemConfig	POST			
199	p	9528	/customer/customer	PUT			
200	p	9528	/customer/customer	GET			
201	p	9528	/customer/customer	POST			
202	p	9528	/customer/customer	DELETE			
203	p	9528	/customer/customerList	GET			
204	p	9528	/autoCode/createTemp	POST			
205	p	9528	/user/getUserInfo	GET			
\.


--
-- Data for Name: core_activities; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.core_activities (id, created_at, updated_at, deleted_at, activity_name, price, category, cover_picture, actual_enrollment, status, sort_order, start_time, end_time, show_start_time, show_end_time, created_by, updated_by, deleted_by) FROM stdin;
\.


--
-- Data for Name: core_courses; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.core_courses (id, created_at, updated_at, deleted_at, course_title, teacher, category, cover_image, type, price, original_price, on_sale, sort, view_details, course_details, apprentice_count, created_by, updated_by, deleted_by) FROM stdin;
\.


--
-- Data for Name: exa_attachment_category; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.exa_attachment_category (id, created_at, updated_at, deleted_at, name, pid) FROM stdin;
\.


--
-- Data for Name: exa_customers; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.exa_customers (id, created_at, updated_at, deleted_at, customer_name, customer_phone_data, sys_user_id, sys_user_authority_id) FROM stdin;
\.


--
-- Data for Name: exa_file_chunks; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.exa_file_chunks (id, created_at, updated_at, deleted_at, exa_file_id, file_chunk_number, file_chunk_path) FROM stdin;
\.


--
-- Data for Name: exa_file_upload_and_downloads; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.exa_file_upload_and_downloads (id, created_at, updated_at, deleted_at, name, class_id, url, tag, key) FROM stdin;
1	2025-07-12 04:34:44.945368+00	2025-07-12 04:34:44.945368+00	\N	10.png	0	https://qmplusimg.henrongyi.top/gvalogo.png	png	158787308910.png
2	2025-07-12 04:34:44.945368+00	2025-07-12 04:34:44.945368+00	\N	logo.png	0	https://qmplusimg.henrongyi.top/1576554439myAvatar.png	png	1587973709logo.png
\.


--
-- Data for Name: exa_files; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.exa_files (id, created_at, updated_at, deleted_at, file_name, file_md5, file_path, chunk_total, is_finish) FROM stdin;
\.


--
-- Data for Name: finance_code; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.finance_code (id, created_at, updated_at, deleted_at, transaction_id, username, phone_number, transaction_type, code_type, quantity, remaining_quantity, details, transaction_time) FROM stdin;
\.


--
-- Data for Name: gva_announcements_info; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.gva_announcements_info (id, created_at, updated_at, deleted_at, title, content, user_id, attachments) FROM stdin;
\.


--
-- Data for Name: jwt_blacklists; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.jwt_blacklists (id, created_at, updated_at, deleted_at, jwt) FROM stdin;
\.


--
-- Data for Name: program_banner; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.program_banner (id, created_at, updated_at, deleted_at, image_url, link_url, "order", status, type) FROM stdin;
\.


--
-- Data for Name: program_benefit; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.program_benefit (id, created_at, updated_at, deleted_at, level, level_name, member_commission, activity_commission, digital_person_commission, created_by, updated_by, deleted_by) FROM stdin;
\.


--
-- Data for Name: program_categories; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.program_categories (id, created_at, updated_at, deleted_at, category_name, status, sort_order, type, created_by, updated_by, deleted_by, parent_id) FROM stdin;
\.


--
-- Data for Name: program_poster; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.program_poster (id, created_at, updated_at, deleted_at, text, bg_img, switch_button, size_slider, radius, top, "left") FROM stdin;
\.


--
-- Data for Name: program_teacher; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.program_teacher (id, created_at, updated_at, deleted_at, avatar, name, description, introduction, sort, created_by, updated_by, deleted_by) FROM stdin;
\.


--
-- Data for Name: sys_apis; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_apis (id, created_at, updated_at, deleted_at, path, description, api_group, method) FROM stdin;
1	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/jwt/jsonInBlacklist	jwt加入黑名单(退出，必选)	jwt	POST
2	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/deleteUser	删除用户	系统用户	DELETE
3	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/admin_register	用户注册	系统用户	POST
4	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/getUserList	获取用户列表	系统用户	POST
5	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/setUserInfo	设置用户信息	系统用户	PUT
6	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/setSelfInfo	设置自身信息(必选)	系统用户	PUT
7	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/getUserInfo	获取自身信息(必选)	系统用户	GET
8	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/setUserAuthorities	设置权限组	系统用户	POST
9	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/changePassword	修改密码（建议选择)	系统用户	POST
10	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/setUserAuthority	修改用户角色(必选)	系统用户	POST
11	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/resetPassword	重置用户密码	系统用户	POST
12	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/user/setSelfSetting	用户界面配置	系统用户	PUT
13	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/createApi	创建api	api	POST
14	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/deleteApi	删除Api	api	POST
15	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/updateApi	更新Api	api	POST
16	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/getApiList	获取api列表	api	POST
17	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/getAllApis	获取所有api	api	POST
18	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/getApiById	获取api详细信息	api	POST
19	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/deleteApisByIds	批量删除api	api	DELETE
20	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/syncApi	获取待同步API	api	GET
21	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/getApiGroups	获取路由组	api	GET
22	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/enterSyncApi	确认同步API	api	POST
23	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/api/ignoreApi	忽略API	api	POST
24	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authority/copyAuthority	拷贝角色	角色	POST
25	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authority/createAuthority	创建角色	角色	POST
26	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authority/deleteAuthority	删除角色	角色	POST
27	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authority/updateAuthority	更新角色信息	角色	PUT
28	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authority/getAuthorityList	获取角色列表	角色	POST
29	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authority/setDataAuthority	设置角色资源权限	角色	POST
30	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/casbin/updateCasbin	更改角色api权限	casbin	POST
31	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/casbin/getPolicyPathByAuthorityId	获取权限列表	casbin	POST
32	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/addBaseMenu	新增菜单	菜单	POST
33	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/getMenu	获取菜单树(必选)	菜单	POST
34	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/deleteBaseMenu	删除菜单	菜单	POST
35	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/updateBaseMenu	更新菜单	菜单	POST
36	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/getBaseMenuById	根据id获取菜单	菜单	POST
37	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/getMenuList	分页获取基础menu列表	菜单	POST
38	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/getBaseMenuTree	获取用户动态路由	菜单	POST
39	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/getMenuAuthority	获取指定角色menu	菜单	POST
40	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/menu/addMenuAuthority	增加menu和角色关联关系	菜单	POST
41	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/findFile	寻找目标文件（秒传）	分片上传	GET
42	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/breakpointContinue	断点续传	分片上传	POST
43	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/breakpointContinueFinish	断点续传完成	分片上传	POST
44	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/removeChunk	上传完成移除文件	分片上传	POST
45	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/upload	文件上传（建议选择）	文件上传与下载	POST
46	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/deleteFile	删除文件	文件上传与下载	POST
47	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/editFileName	文件名或者备注编辑	文件上传与下载	POST
48	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/getFileList	获取上传文件列表	文件上传与下载	POST
49	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/fileUploadAndDownload/importURL	导入URL	文件上传与下载	POST
50	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/system/getServerInfo	获取服务器信息	系统服务	POST
51	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/system/getSystemConfig	获取配置文件内容	系统服务	POST
52	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/system/setSystemConfig	设置配置文件内容	系统服务	POST
53	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/customer/customer	更新客户	客户	PUT
54	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/customer/customer	创建客户	客户	POST
55	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/customer/customer	删除客户	客户	DELETE
56	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/customer/customer	获取单一客户	客户	GET
57	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/customer/customerList	获取客户列表	客户	GET
58	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getDB	获取所有数据库	代码生成器	GET
59	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getTables	获取数据库表	代码生成器	GET
60	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/createTemp	自动化代码	代码生成器	POST
61	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/preview	预览自动化代码	代码生成器	POST
62	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getColumn	获取所选table的所有字段	代码生成器	GET
63	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/installPlugin	安装插件	代码生成器	POST
64	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/pubPlug	打包插件	代码生成器	POST
65	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/mcp	自动生成 MCP Tool 模板	代码生成器	POST
66	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/mcpTest	MCP Tool 测试	代码生成器	POST
67	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/mcpList	获取 MCP ToolList	代码生成器	POST
68	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/createPackage	配置模板	模板配置	POST
69	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getTemplates	获取模板文件	模板配置	GET
70	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getPackage	获取所有模板	模板配置	POST
71	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/delPackage	删除模板	模板配置	POST
72	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getMeta	获取meta信息	代码生成器历史	POST
73	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/rollback	回滚自动生成代码	代码生成器历史	POST
74	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/getSysHistory	查询回滚记录	代码生成器历史	POST
75	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/delSysHistory	删除回滚记录	代码生成器历史	POST
76	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/autoCode/addFunc	增加模板方法	代码生成器历史	POST
77	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionaryDetail/updateSysDictionaryDetail	更新字典内容	系统字典详情	PUT
78	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionaryDetail/createSysDictionaryDetail	新增字典内容	系统字典详情	POST
79	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionaryDetail/deleteSysDictionaryDetail	删除字典内容	系统字典详情	DELETE
80	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionaryDetail/findSysDictionaryDetail	根据ID获取字典内容	系统字典详情	GET
81	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionaryDetail/getSysDictionaryDetailList	获取字典内容列表	系统字典详情	GET
82	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionary/createSysDictionary	新增字典	系统字典	POST
83	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionary/deleteSysDictionary	删除字典	系统字典	DELETE
84	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionary/updateSysDictionary	更新字典	系统字典	PUT
85	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionary/findSysDictionary	根据ID获取字典（建议选择）	系统字典	GET
86	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysDictionary/getSysDictionaryList	获取字典列表	系统字典	GET
87	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysOperationRecord/createSysOperationRecord	新增操作记录	操作记录	POST
88	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysOperationRecord/findSysOperationRecord	根据ID获取操作记录	操作记录	GET
89	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysOperationRecord/getSysOperationRecordList	获取操作记录列表	操作记录	GET
90	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysOperationRecord/deleteSysOperationRecord	删除操作记录	操作记录	DELETE
91	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysOperationRecord/deleteSysOperationRecordByIds	批量删除操作历史	操作记录	DELETE
92	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/simpleUploader/upload	插件版分片上传	断点续传(插件版)	POST
93	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/simpleUploader/checkFileMd5	文件完整度验证	断点续传(插件版)	GET
94	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/simpleUploader/mergeFileMd5	上传完成合并文件	断点续传(插件版)	GET
95	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/email/emailTest	发送测试邮件	email	POST
96	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/email/sendEmail	发送邮件	email	POST
97	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authorityBtn/setAuthorityBtn	设置按钮权限	按钮权限	POST
98	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authorityBtn/getAuthorityBtn	获取已有按钮权限	按钮权限	POST
99	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/authorityBtn/canRemoveAuthorityBtn	删除按钮	按钮权限	POST
100	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/createSysExportTemplate	新增导出模板	导出模板	POST
101	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/deleteSysExportTemplate	删除导出模板	导出模板	DELETE
102	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/deleteSysExportTemplateByIds	批量删除导出模板	导出模板	DELETE
103	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/updateSysExportTemplate	更新导出模板	导出模板	PUT
104	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/findSysExportTemplate	根据ID获取导出模板	导出模板	GET
105	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/getSysExportTemplateList	获取导出模板列表	导出模板	GET
106	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/exportExcel	导出Excel	导出模板	GET
107	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/exportTemplate	下载模板	导出模板	GET
108	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysExportTemplate/importExcel	导入Excel	导出模板	POST
109	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/info/createInfo	新建公告	公告	POST
110	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/info/deleteInfo	删除公告	公告	DELETE
111	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/info/deleteInfoByIds	批量删除公告	公告	DELETE
112	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/info/updateInfo	更新公告	公告	PUT
113	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/info/findInfo	根据ID获取公告	公告	GET
114	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/info/getInfoList	获取公告列表	公告	GET
115	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/createSysParams	新建参数	参数管理	POST
116	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/deleteSysParams	删除参数	参数管理	DELETE
117	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/deleteSysParamsByIds	批量删除参数	参数管理	DELETE
118	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/updateSysParams	更新参数	参数管理	PUT
119	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/findSysParams	根据ID获取参数	参数管理	GET
120	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/getSysParamsList	获取参数列表	参数管理	GET
121	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/sysParams/getSysParam	获取参数列表	参数管理	GET
122	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/attachmentCategory/getCategoryList	分类列表	媒体库分类	GET
123	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/attachmentCategory/addCategory	添加/编辑分类	媒体库分类	POST
124	2025-07-12 04:34:44.677349+00	2025-07-12 04:34:44.677349+00	\N	/attachmentCategory/deleteCategory	删除分类	媒体库分类	POST
125	2025-07-12 04:51:11.189733+00	2025-07-12 04:51:11.189733+00	2025-07-12 04:52:36.987988+00	/category/createCategory	新增分类	分类	POST
126	2025-07-12 04:51:11.191891+00	2025-07-12 04:51:11.191891+00	2025-07-12 04:52:36.987988+00	/category/deleteCategory	删除分类	分类	DELETE
127	2025-07-12 04:51:11.193276+00	2025-07-12 04:51:11.193276+00	2025-07-12 04:52:36.987988+00	/category/deleteCategoryByIds	批量删除分类	分类	DELETE
128	2025-07-12 04:51:11.195056+00	2025-07-12 04:51:11.195056+00	2025-07-12 04:52:36.987988+00	/category/updateCategory	更新分类	分类	PUT
129	2025-07-12 04:51:11.196769+00	2025-07-12 04:51:11.196769+00	2025-07-12 04:52:36.987988+00	/category/findCategory	根据ID获取分类	分类	GET
130	2025-07-12 04:51:11.198186+00	2025-07-12 04:51:11.198186+00	2025-07-12 04:52:36.987988+00	/category/getCategoryList	获取分类列表	分类	GET
131	2025-07-12 04:55:10.931865+00	2025-07-12 04:55:10.931865+00	\N	/category/createCategory	新增分类	分类	POST
132	2025-07-12 04:55:10.934879+00	2025-07-12 04:55:10.934879+00	\N	/category/deleteCategory	删除分类	分类	DELETE
133	2025-07-12 04:55:10.936681+00	2025-07-12 04:55:10.936681+00	\N	/category/deleteCategoryByIds	批量删除分类	分类	DELETE
134	2025-07-12 04:55:10.938081+00	2025-07-12 04:55:10.938081+00	\N	/category/updateCategory	更新分类	分类	PUT
135	2025-07-12 04:55:10.939299+00	2025-07-12 04:55:10.939299+00	\N	/category/findCategory	根据ID获取分类	分类	GET
136	2025-07-12 04:55:10.940444+00	2025-07-12 04:55:10.940444+00	\N	/category/getCategoryList	获取分类列表	分类	GET
137	2025-07-12 05:07:06.57253+00	2025-07-12 05:07:06.57253+00	\N	/poster/createPoster	新增推广海报	推广海报	POST
138	2025-07-12 05:07:06.574271+00	2025-07-12 05:07:06.574271+00	\N	/poster/deletePoster	删除推广海报	推广海报	DELETE
139	2025-07-12 05:07:06.575466+00	2025-07-12 05:07:06.575466+00	\N	/poster/deletePosterByIds	批量删除推广海报	推广海报	DELETE
140	2025-07-12 05:07:06.576758+00	2025-07-12 05:07:06.576758+00	\N	/poster/updatePoster	更新推广海报	推广海报	PUT
141	2025-07-12 05:07:06.578146+00	2025-07-12 05:07:06.578146+00	\N	/poster/findPoster	根据ID获取推广海报	推广海报	GET
142	2025-07-12 05:07:06.579359+00	2025-07-12 05:07:06.579359+00	\N	/poster/getPosterList	获取推广海报列表	推广海报	GET
143	2025-07-12 05:11:27.151989+00	2025-07-12 05:11:27.151989+00	\N	/banner/createBanner	新增轮播管理	轮播管理	POST
144	2025-07-12 05:11:27.155086+00	2025-07-12 05:11:27.155086+00	\N	/banner/deleteBanner	删除轮播管理	轮播管理	DELETE
145	2025-07-12 05:11:27.156861+00	2025-07-12 05:11:27.156861+00	\N	/banner/deleteBannerByIds	批量删除轮播管理	轮播管理	DELETE
146	2025-07-12 05:11:27.158357+00	2025-07-12 05:11:27.158357+00	\N	/banner/updateBanner	更新轮播管理	轮播管理	PUT
147	2025-07-12 05:11:27.159611+00	2025-07-12 05:11:27.159611+00	\N	/banner/findBanner	根据ID获取轮播管理	轮播管理	GET
148	2025-07-12 05:11:27.160752+00	2025-07-12 05:11:27.160752+00	\N	/banner/getBannerList	获取轮播管理列表	轮播管理	GET
149	2025-07-12 05:15:14.52703+00	2025-07-12 05:15:14.52703+00	\N	/teacher/createTeacher	新增讲师管理	讲师管理	POST
150	2025-07-12 05:15:14.530113+00	2025-07-12 05:15:14.530113+00	\N	/teacher/deleteTeacher	删除讲师管理	讲师管理	DELETE
151	2025-07-12 05:15:14.531953+00	2025-07-12 05:15:14.531953+00	\N	/teacher/deleteTeacherByIds	批量删除讲师管理	讲师管理	DELETE
152	2025-07-12 05:15:14.533338+00	2025-07-12 05:15:14.533338+00	\N	/teacher/updateTeacher	更新讲师管理	讲师管理	PUT
153	2025-07-12 05:15:14.534734+00	2025-07-12 05:15:14.534734+00	\N	/teacher/findTeacher	根据ID获取讲师管理	讲师管理	GET
154	2025-07-12 05:15:14.536273+00	2025-07-12 05:15:14.536273+00	\N	/teacher/getTeacherList	获取讲师管理列表	讲师管理	GET
155	2025-07-12 05:20:17.8444+00	2025-07-12 05:20:17.8444+00	\N	/benefit/createBenefit	新增权益等级	权益等级	POST
156	2025-07-12 05:20:17.846743+00	2025-07-12 05:20:17.846743+00	\N	/benefit/deleteBenefit	删除权益等级	权益等级	DELETE
157	2025-07-12 05:20:17.848228+00	2025-07-12 05:20:17.848228+00	\N	/benefit/deleteBenefitByIds	批量删除权益等级	权益等级	DELETE
158	2025-07-12 05:20:17.850349+00	2025-07-12 05:20:17.850349+00	\N	/benefit/updateBenefit	更新权益等级	权益等级	PUT
159	2025-07-12 05:20:17.851973+00	2025-07-12 05:20:17.851973+00	\N	/benefit/findBenefit	根据ID获取权益等级	权益等级	GET
160	2025-07-12 05:20:17.853469+00	2025-07-12 05:20:17.853469+00	\N	/benefit/getBenefitList	获取权益等级列表	权益等级	GET
161	2025-07-12 05:40:53.594986+00	2025-07-12 05:40:53.594986+00	\N	/course/createCourse	新增课程管理	课程管理	POST
162	2025-07-12 05:40:53.596599+00	2025-07-12 05:40:53.596599+00	\N	/course/deleteCourse	删除课程管理	课程管理	DELETE
163	2025-07-12 05:40:53.597592+00	2025-07-12 05:40:53.597592+00	\N	/course/deleteCourseByIds	批量删除课程管理	课程管理	DELETE
164	2025-07-12 05:40:53.598571+00	2025-07-12 05:40:53.598571+00	\N	/course/updateCourse	更新课程管理	课程管理	PUT
165	2025-07-12 05:40:53.599525+00	2025-07-12 05:40:53.599525+00	\N	/course/findCourse	根据ID获取课程管理	课程管理	GET
166	2025-07-12 05:40:53.600758+00	2025-07-12 05:40:53.600758+00	\N	/course/getCourseList	获取课程管理列表	课程管理	GET
173	2025-07-12 06:03:26.271309+00	2025-07-12 06:03:26.271309+00	\N	/wxUser/createWechatUser	新增用户管理	用户管理	POST
174	2025-07-12 06:03:26.273285+00	2025-07-12 06:03:26.273285+00	\N	/wxUser/deleteWechatUser	删除用户管理	用户管理	DELETE
175	2025-07-12 06:03:26.274322+00	2025-07-12 06:03:26.274322+00	\N	/wxUser/deleteWechatUserByIds	批量删除用户管理	用户管理	DELETE
176	2025-07-12 06:03:26.275459+00	2025-07-12 06:03:26.275459+00	\N	/wxUser/updateWechatUser	更新用户管理	用户管理	PUT
177	2025-07-12 06:03:26.276916+00	2025-07-12 06:03:26.276916+00	\N	/wxUser/findWechatUser	根据ID获取用户管理	用户管理	GET
178	2025-07-12 06:03:26.278256+00	2025-07-12 06:03:26.278256+00	\N	/wxUser/getWechatUserList	获取用户管理列表	用户管理	GET
179	2025-07-12 06:11:25.927526+00	2025-07-12 06:11:25.927526+00	\N	/code/createCode	新增兑换码明细	兑换码明细	POST
180	2025-07-12 06:11:25.929011+00	2025-07-12 06:11:25.929011+00	\N	/code/deleteCode	删除兑换码明细	兑换码明细	DELETE
181	2025-07-12 06:11:25.929915+00	2025-07-12 06:11:25.929915+00	\N	/code/deleteCodeByIds	批量删除兑换码明细	兑换码明细	DELETE
182	2025-07-12 06:11:25.931087+00	2025-07-12 06:11:25.931087+00	\N	/code/updateCode	更新兑换码明细	兑换码明细	PUT
183	2025-07-12 06:11:25.934095+00	2025-07-12 06:11:25.934095+00	\N	/code/findCode	根据ID获取兑换码明细	兑换码明细	GET
184	2025-07-12 06:11:25.935195+00	2025-07-12 06:11:25.935195+00	\N	/code/getCodeList	获取兑换码明细列表	兑换码明细	GET
167	2025-07-12 05:54:20.949096+00	2025-07-12 05:54:20.949096+00	2025-07-12 06:13:56.639323+00	/activities/createActivities	新增活动管理	活动管理	POST
168	2025-07-12 05:54:20.950781+00	2025-07-12 05:54:20.950781+00	2025-07-12 06:13:56.639323+00	/activities/deleteActivities	删除活动管理	活动管理	DELETE
169	2025-07-12 05:54:20.951738+00	2025-07-12 05:54:20.951738+00	2025-07-12 06:13:56.639323+00	/activities/deleteActivitiesByIds	批量删除活动管理	活动管理	DELETE
170	2025-07-12 05:54:20.952693+00	2025-07-12 05:54:20.952693+00	2025-07-12 06:13:56.639323+00	/activities/updateActivities	更新活动管理	活动管理	PUT
171	2025-07-12 05:54:20.953694+00	2025-07-12 05:54:20.953694+00	2025-07-12 06:13:56.639323+00	/activities/findActivities	根据ID获取活动管理	活动管理	GET
172	2025-07-12 05:54:20.954608+00	2025-07-12 05:54:20.954608+00	2025-07-12 06:13:56.639323+00	/activities/getActivitiesList	获取活动管理列表	活动管理	GET
185	2025-07-12 06:14:24.753559+00	2025-07-12 06:14:24.753559+00	\N	/activities/createActivities	新增活动管理	活动管理	POST
186	2025-07-12 06:14:24.755283+00	2025-07-12 06:14:24.755283+00	\N	/activities/deleteActivities	删除活动管理	活动管理	DELETE
187	2025-07-12 06:14:24.756387+00	2025-07-12 06:14:24.756387+00	\N	/activities/deleteActivitiesByIds	批量删除活动管理	活动管理	DELETE
188	2025-07-12 06:14:24.757355+00	2025-07-12 06:14:24.757355+00	\N	/activities/updateActivities	更新活动管理	活动管理	PUT
189	2025-07-12 06:14:24.758321+00	2025-07-12 06:14:24.758321+00	\N	/activities/findActivities	根据ID获取活动管理	活动管理	GET
190	2025-07-12 06:14:24.75923+00	2025-07-12 06:14:24.75923+00	\N	/activities/getActivitiesList	获取活动管理列表	活动管理	GET
\.


--
-- Data for Name: sys_authorities; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_authorities (created_at, updated_at, deleted_at, authority_id, authority_name, parent_id, default_router) FROM stdin;
2025-07-12 04:34:44.697423+00	2025-07-12 04:34:44.910245+00	\N	888	普通用户	0	dashboard
2025-07-12 04:34:44.697423+00	2025-07-12 04:34:44.922142+00	\N	9528	测试角色	0	dashboard
2025-07-12 04:34:44.697423+00	2025-07-12 04:34:44.931745+00	\N	8881	普通用户子角色	888	dashboard
\.


--
-- Data for Name: sys_authority_btns; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_authority_btns (authority_id, sys_menu_id, sys_base_menu_btn_id) FROM stdin;
\.


--
-- Data for Name: sys_authority_menus; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_authority_menus (sys_base_menu_id, sys_authority_authority_id) FROM stdin;
1	888
2	888
3	888
4	888
5	888
6	888
8	888
9	888
10	888
11	888
12	888
13	888
14	888
15	888
16	888
17	888
18	888
19	888
20	888
21	888
22	888
23	888
24	888
25	888
26	888
27	888
28	888
29	888
30	888
31	888
32	888
33	888
34	888
1	9528
2	9528
4	9528
8	9528
1	8881
2	8881
3	8881
4	8881
5	8881
6	8881
8	8881
9	8881
17	8881
18	8881
19	8881
20	8881
21	8881
22	8881
23	8881
24	8881
25	8881
26	8881
27	8881
28	8881
29	8881
\.


--
-- Data for Name: sys_auto_code_histories; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_auto_code_histories (id, created_at, updated_at, deleted_at, table_name, package, request, struct_name, abbreviation, business_db, description, templates, "Injections", flag, api_ids, menu_id, export_template_id, package_id) FROM stdin;
3	2025-07-12 05:07:06.58653+00	2025-07-12 05:07:06.58653+00	\N	program_poster	system	{"package":"system","tableName":"program_poster","businessDB":"","structName":"Poster","packageName":"program_poster","description":"推广海报","abbreviation":"poster","humpPackageName":"program_poster","gvaModel":true,"autoMigrate":true,"autoCreateResource":false,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"Text","fieldDesc":"二维码信息","fieldType":"string","fieldJson":"text","dataTypeLong":"","comment":"","columnName":"text","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"BgImg","fieldDesc":"背景图","fieldType":"picture","fieldJson":"bgImg","dataTypeLong":"","comment":"","columnName":"bg_img","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"SwitchButton","fieldDesc":"开关","fieldType":"bool","fieldJson":"switchButton","dataTypeLong":"","comment":"控制功能开启与关闭","columnName":"switch_button","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"SizeSlider","fieldDesc":"大小","fieldType":"string","fieldJson":"size","dataTypeLong":"","comment":"改变元素大小","columnName":"size_slider","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Radius","fieldDesc":"圆角","fieldType":"string","fieldJson":"radius","dataTypeLong":"","comment":"圆角","columnName":"radius","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Top","fieldDesc":"距离顶部","fieldType":"string","fieldJson":"top","dataTypeLong":"","comment":"距离顶部","columnName":"top","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Left","fieldDesc":"距离左侧","fieldType":"string","fieldJson":"left","dataTypeLong":"","comment":"","columnName":"left","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Poster	Poster		推广海报	{"resource/package/server/api/api.go.tpl":"api/v1/system/program_poster.go","resource/package/server/model/model.go.tpl":"model/system/program_poster.go","resource/package/server/model/request/request.go.tpl":"model/system/request/program_poster.go","resource/package/server/router/router.go.tpl":"router/system/program_poster.go","resource/package/server/service/service.go.tpl":"service/system/program_poster.go","resource/package/web/api/api.js.tpl":"api/system/program_poster.js","resource/package/web/view/form.vue.tpl":"view/system/program_poster/program_posterForm.vue","resource/package/web/view/table.vue.tpl":"view/system/program_poster/program_poster.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"PosterApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"posterService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"PosterService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Poster\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitPosterRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"PosterRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"posterApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"PosterApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"PosterService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[137,138,139,140,141,142]	37	0	0
2	2025-07-12 04:55:10.946817+00	2025-07-12 04:55:10.946817+00	\N	program_categories	system	{"package":"system","tableName":"program_categories","businessDB":"","structName":"Category","packageName":"program_category","description":"分类","abbreviation":"category","humpPackageName":"program_category","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":true,"treeJson":"CategoryName","isAdd":false,"fields":[{"fieldName":"CategoryName","fieldDesc":"分类名称","fieldType":"string","fieldJson":"categoryName","dataTypeLong":"","comment":"","columnName":"category_name","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Status","fieldDesc":"状态","fieldType":"bool","fieldJson":"status","dataTypeLong":"","comment":"","columnName":"status","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"true","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"SortOrder","fieldDesc":"排序","fieldType":"int","fieldJson":"sortOrder","dataTypeLong":"","comment":"","columnName":"sort_order","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Type","fieldDesc":"分类类型","fieldType":"string","fieldJson":"type","dataTypeLong":"","comment":"","columnName":"type","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":false,"excel":false,"require":false,"defaultValue":"course","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Category	Category		分类	{"resource/package/server/api/api.go.tpl":"api/v1/system/program_category.go","resource/package/server/model/model.go.tpl":"model/system/program_category.go","resource/package/server/model/request/request.go.tpl":"model/system/request/program_category.go","resource/package/server/router/router.go.tpl":"router/system/program_category.go","resource/package/server/service/service.go.tpl":"service/system/program_category.go","resource/package/web/api/api.js.tpl":"api/system/program_category.js","resource/package/web/view/form.vue.tpl":"view/system/program_category/program_categoryForm.vue","resource/package/web/view/table.vue.tpl":"view/system/program_category/program_category.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"CategoryApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"categoryService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"CategoryService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Category\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitCategoryRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"CategoryRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"categoryApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"CategoryApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"CategoryService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[131,132,133,134,135,136]	36	0	0
1	2025-07-12 04:51:11.206662+00	2025-07-12 04:52:44.713378+00	2025-07-12 04:55:19.643406+00	program_categories	system	{"package":"system","tableName":"program_categories","businessDB":"","structName":"Category","packageName":"program_category","description":"分类","abbreviation":"category","humpPackageName":"program_category","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":true,"treeJson":"CategoryName","isAdd":false,"fields":[{"fieldName":"CategoryName","fieldDesc":"分类名称","fieldType":"string","fieldJson":"categoryName","dataTypeLong":"","comment":"","columnName":"category_name","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Status","fieldDesc":"状态","fieldType":"bool","fieldJson":"status","dataTypeLong":"","comment":"","columnName":"status","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"true","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"SortOrder","fieldDesc":"排序","fieldType":"int","fieldJson":"sortOrder","dataTypeLong":"","comment":"","columnName":"sort_order","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Category	Category		分类	{"resource/package/server/api/api.go.tpl":"api/v1/system/program_category.go","resource/package/server/model/model.go.tpl":"model/system/program_category.go","resource/package/server/model/request/request.go.tpl":"model/system/request/program_category.go","resource/package/server/router/router.go.tpl":"router/system/program_category.go","resource/package/server/service/service.go.tpl":"service/system/program_category.go","resource/package/web/api/api.js.tpl":"api/system/program_category.js","resource/package/web/view/form.vue.tpl":"view/system/program_category/program_categoryForm.vue","resource/package/web/view/table.vue.tpl":"view/system/program_category/program_category.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"CategoryApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"categoryService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"CategoryService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Category\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitCategoryRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"CategoryRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"categoryApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"CategoryApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"CategoryService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	1	[125,126,127,128,129,130]	35	0	0
4	2025-07-12 05:11:27.169074+00	2025-07-12 05:11:27.169074+00	\N	program_banner	system	{"package":"system","tableName":"program_banner","businessDB":"","structName":"Banner","packageName":"program_banner","description":"轮播管理","abbreviation":"banner","humpPackageName":"program_banner","gvaModel":true,"autoMigrate":true,"autoCreateResource":false,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"ImageUrl","fieldDesc":"图片URL","fieldType":"string","fieldJson":"imageUrl","dataTypeLong":"","comment":"轮播图图片地址","columnName":"image_url","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"LinkUrl","fieldDesc":"链接URL","fieldType":"string","fieldJson":"linkUrl","dataTypeLong":"","comment":"点击图片跳转的链接","columnName":"link_url","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Order","fieldDesc":"排序","fieldType":"int","fieldJson":"order","dataTypeLong":"","comment":"轮播图顺序","columnName":"order","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Status","fieldDesc":"状态","fieldType":"int","fieldJson":"status","dataTypeLong":"","comment":"轮播图状态，例如：1-启用，0-禁用","columnName":"status","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Type","fieldDesc":"轮播图位置","fieldType":"string","fieldJson":"type","dataTypeLong":"","comment":"","columnName":"type","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"home","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Banner	Banner		轮播管理	{"resource/package/server/api/api.go.tpl":"api/v1/system/program_banner.go","resource/package/server/model/model.go.tpl":"model/system/program_banner.go","resource/package/server/model/request/request.go.tpl":"model/system/request/program_banner.go","resource/package/server/router/router.go.tpl":"router/system/program_banner.go","resource/package/server/service/service.go.tpl":"service/system/program_banner.go","resource/package/web/api/api.js.tpl":"api/system/program_banner.js","resource/package/web/view/form.vue.tpl":"view/system/program_banner/program_bannerForm.vue","resource/package/web/view/table.vue.tpl":"view/system/program_banner/program_banner.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"BannerApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"bannerService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"BannerService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Banner\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitBannerRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"BannerRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"bannerApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"BannerApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"BannerService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[143,144,145,146,147,148]	38	0	0
10	2025-07-12 06:11:25.941699+00	2025-07-12 06:11:25.941699+00	\N	finance_code	system	{"package":"system","tableName":"finance_code","businessDB":"","structName":"Code","packageName":"finance_code","description":"兑换码明细","abbreviation":"code","humpPackageName":"finance_code","gvaModel":true,"autoMigrate":true,"autoCreateResource":false,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"TransactionID","fieldDesc":"交易编号","fieldType":"string","fieldJson":"transactionId","dataTypeLong":"","comment":"唯一标识每笔交易的编号","columnName":"transaction_id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Username","fieldDesc":"用户昵称","fieldType":"string","fieldJson":"username","dataTypeLong":"","comment":"用户的昵称或名称","columnName":"username","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"PhoneNumber","fieldDesc":"手机号","fieldType":"string","fieldJson":"phoneNumber","dataTypeLong":"","comment":"用户的联系电话号码","columnName":"phone_number","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"TransactionType","fieldDesc":"交易类型","fieldType":"int","fieldJson":"transactionType","dataTypeLong":"","comment":"记录交易的性质，如增加、扣除等","columnName":"transaction_type","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"CodeType","fieldDesc":"兑换码类型","fieldType":"int","fieldJson":"codeType","dataTypeLong":"","comment":"指明是会员兑换码还是活动兑换码","columnName":"code_type","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Quantity","fieldDesc":"数量","fieldType":"int","fieldJson":"quantity","dataTypeLong":"","comment":"表示本次交易的兑换码数量，正数表示增加，负数表示减少","columnName":"quantity","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"RemainingQuantity","fieldDesc":"交易后余量","fieldType":"int","fieldJson":"remainingQuantity","dataTypeLong":"","comment":"显示交易后的兑换码剩余数量","columnName":"remaining_quantity","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Details","fieldDesc":"详情","fieldType":"string","fieldJson":"details","dataTypeLong":"","comment":"提供关于该交易的额外信息，例如系统赠送、开通会员、报名活动等","columnName":"details","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"TransactionTime","fieldDesc":"交易时间","fieldType":"time.Time","fieldJson":"transactionTime","dataTypeLong":"","comment":"记录交易发生的具体时间","columnName":"transaction_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Code	Code		兑换码明细	{"resource/package/server/api/api.go.tpl":"api/v1/system/finance_code.go","resource/package/server/model/model.go.tpl":"model/system/finance_code.go","resource/package/server/model/request/request.go.tpl":"model/system/request/finance_code.go","resource/package/server/router/router.go.tpl":"router/system/finance_code.go","resource/package/server/service/service.go.tpl":"service/system/finance_code.go","resource/package/web/api/api.js.tpl":"api/system/finance_code.js","resource/package/web/view/form.vue.tpl":"view/system/finance_code/finance_codeForm.vue","resource/package/web/view/table.vue.tpl":"view/system/finance_code/finance_code.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"CodeApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"codeService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"CodeService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Code\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitCodeRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"CodeRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"codeApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"CodeApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"CodeService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[179,180,181,182,183,184]	44	0	0
5	2025-07-12 05:15:14.543543+00	2025-07-12 05:15:14.543543+00	\N	program_teacher	system	{"package":"system","tableName":"program_teacher","businessDB":"","structName":"Teacher","packageName":"program_teacher","description":"讲师管理","abbreviation":"teacher","humpPackageName":"program_teacher","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"Avatar","fieldDesc":"头像","fieldType":"picture","fieldJson":"avatar","dataTypeLong":"","comment":"","columnName":"avatar","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Name","fieldDesc":"讲师姓名","fieldType":"string","fieldJson":"name","dataTypeLong":"","comment":"","columnName":"name","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Description","fieldDesc":"讲师描述","fieldType":"string","fieldJson":"description","dataTypeLong":"","comment":"","columnName":"description","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Introduction","fieldDesc":"讲师介绍","fieldType":"richtext","fieldJson":"introduction","dataTypeLong":"","comment":"","columnName":"introduction","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Sort","fieldDesc":"讲师排序","fieldType":"int","fieldJson":"sort","dataTypeLong":"","comment":"","columnName":"sort","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"0","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Teacher	Teacher		讲师管理	{"resource/package/server/api/api.go.tpl":"api/v1/system/program_teacher.go","resource/package/server/model/model.go.tpl":"model/system/program_teacher.go","resource/package/server/model/request/request.go.tpl":"model/system/request/program_teacher.go","resource/package/server/router/router.go.tpl":"router/system/program_teacher.go","resource/package/server/service/service.go.tpl":"service/system/program_teacher.go","resource/package/web/api/api.js.tpl":"api/system/program_teacher.js","resource/package/web/view/form.vue.tpl":"view/system/program_teacher/program_teacherForm.vue","resource/package/web/view/table.vue.tpl":"view/system/program_teacher/program_teacher.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"TeacherApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"teacherService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"TeacherService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Teacher\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitTeacherRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"TeacherRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"teacherApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"TeacherApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"TeacherService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[149,150,151,152,153,154]	39	0	0
6	2025-07-12 05:20:17.866072+00	2025-07-12 05:20:17.866072+00	\N	program_benefit	system	{"package":"system","tableName":"program_benefit","businessDB":"","structName":"Benefit","packageName":"program_benefit","description":"权益等级","abbreviation":"benefit","humpPackageName":"program_benefit","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"Level","fieldDesc":"等级","fieldType":"float64","fieldJson":"level","dataTypeLong":"","comment":"","columnName":"level","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"LevelName","fieldDesc":"名称","fieldType":"string","fieldJson":"levelName","dataTypeLong":"","comment":"","columnName":"level_name","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"MemberCommission","fieldDesc":"会员提成","fieldType":"float64","fieldJson":"memberCommission","dataTypeLong":"","comment":"","columnName":"member_commission","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ActivityCommission","fieldDesc":"活动提成","fieldType":"float64","fieldJson":"activityCommission","dataTypeLong":"","comment":"","columnName":"activity_commission","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"DigitalPersonCommission","fieldDesc":"数字人提成","fieldType":"float64","fieldJson":"digitalPersonCommission","dataTypeLong":"","comment":"","columnName":"digital_person_commission","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Benefit	Benefit		权益等级	{"resource/package/server/api/api.go.tpl":"api/v1/system/program_benefit.go","resource/package/server/model/model.go.tpl":"model/system/program_benefit.go","resource/package/server/model/request/request.go.tpl":"model/system/request/program_benefit.go","resource/package/server/router/router.go.tpl":"router/system/program_benefit.go","resource/package/server/service/service.go.tpl":"service/system/program_benefit.go","resource/package/web/api/api.js.tpl":"api/system/program_benefit.js","resource/package/web/view/form.vue.tpl":"view/system/program_benefit/program_benefitForm.vue","resource/package/web/view/table.vue.tpl":"view/system/program_benefit/program_benefit.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"BenefitApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"benefitService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"BenefitService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Benefit\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitBenefitRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"BenefitRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"benefitApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"BenefitApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"BenefitService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[155,156,157,158,159,160]	40	0	0
7	2025-07-12 05:40:53.607193+00	2025-07-12 05:40:53.607193+00	\N	core_courses	system	{"package":"system","tableName":"core_courses","businessDB":"","structName":"Course","packageName":"core_course","description":"课程管理","abbreviation":"course","humpPackageName":"core_course","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"CourseTitle","fieldDesc":"课程名称","fieldType":"string","fieldJson":"courseTitle","dataTypeLong":"","comment":"课程名称","columnName":"course_title","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Teacher","fieldDesc":"讲师","fieldType":"int","fieldJson":"teacher","dataTypeLong":"","comment":"讲师","columnName":"teacher","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"program_teacher","label":"name","value":"id","association":1,"hasDeletedAt":true},"checkDataSource":true,"fieldIndexType":""},{"fieldName":"Category","fieldDesc":"分类","fieldType":"int","fieldJson":"category","dataTypeLong":"","comment":"课程分类","columnName":"category","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"program_categories","label":"category_name","value":"id","association":1,"hasDeletedAt":true},"checkDataSource":true,"fieldIndexType":""},{"fieldName":"CoverImage","fieldDesc":"封面图","fieldType":"picture","fieldJson":"coverImage","dataTypeLong":"","comment":"封面图片","columnName":"cover_image","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":false,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Type","fieldDesc":"类型","fieldType":"string","fieldJson":"type","dataTypeLong":"","comment":"图文或视频","columnName":"type","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"img","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Price","fieldDesc":"价格","fieldType":"float64","fieldJson":"price","dataTypeLong":"","comment":"课程售价","columnName":"price","fieldSearchType":"BETWEEN","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"OriginalPrice","fieldDesc":"划线价格","fieldType":"float64","fieldJson":"originalPrice","dataTypeLong":"","comment":"标注原价","columnName":"original_price","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":false,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"OnSale","fieldDesc":"上架状态","fieldType":"bool","fieldJson":"onSale","dataTypeLong":"","comment":"表示课程是否已上架销售","columnName":"on_sale","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"true","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Sort","fieldDesc":"排序","fieldType":"int","fieldJson":"sort","dataTypeLong":"","comment":"排序显示","columnName":"sort","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ViewDetails","fieldDesc":"试看详情","fieldType":"richtext","fieldJson":"viewDetails","dataTypeLong":"","comment":"试看详情","columnName":"view_details","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":false,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"CourseDetails","fieldDesc":"课程详情","fieldType":"richtext","fieldJson":"courseDetails","dataTypeLong":"","comment":"课程介绍等内容","columnName":"course_details","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":false,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ApprenticeCount","fieldDesc":"展示学习人数","fieldType":"int","fieldJson":"apprenticeCount","dataTypeLong":"","comment":"虚拟人数","columnName":"apprentice_count","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Course	Course		课程管理	{"resource/package/server/api/api.go.tpl":"api/v1/system/core_course.go","resource/package/server/model/model.go.tpl":"model/system/core_course.go","resource/package/server/model/request/request.go.tpl":"model/system/request/core_course.go","resource/package/server/router/router.go.tpl":"router/system/core_course.go","resource/package/server/service/service.go.tpl":"service/system/core_course.go","resource/package/web/api/api.js.tpl":"api/system/core_course.js","resource/package/web/view/form.vue.tpl":"view/system/core_course/core_courseForm.vue","resource/package/web/view/table.vue.tpl":"view/system/core_course/core_course.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"CourseApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"courseService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"CourseService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Course\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitCourseRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"CourseRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"courseApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"CourseApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"CourseService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[161,162,163,164,165,166]	41	0	0
9	2025-07-12 06:03:26.284604+00	2025-07-12 06:03:26.284604+00	\N	User	system	{"package":"system","tableName":"User","businessDB":"","structName":"WechatUser","packageName":"usermanagement","description":"用户管理","abbreviation":"wxUser","humpPackageName":"usermanagement","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"OpenId","fieldDesc":"小程序Id","fieldType":"string","fieldJson":"openId","dataTypeLong":"","comment":"","columnName":"open_id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":true,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Nickname","fieldDesc":"昵称","fieldType":"string","fieldJson":"nickname","dataTypeLong":"","comment":"","columnName":"nickname","fieldSearchType":"LIKE","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"PhoneNumber","fieldDesc":"手机号","fieldType":"string","fieldJson":"phone_number","dataTypeLong":"","comment":"","columnName":"phone_number","fieldSearchType":"LIKE","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Salesperson","fieldDesc":"销售员","fieldType":"int","fieldJson":"salesperson","dataTypeLong":"","comment":"","columnName":"salesperson","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"RelationshipChannel","fieldDesc":"关系渠道","fieldType":"int","fieldJson":"relationship_channel","dataTypeLong":"","comment":"","columnName":"relationship_channel","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"BenefitLevel","fieldDesc":"权益等级","fieldType":"int","fieldJson":"benefit_level","dataTypeLong":"","comment":"","columnName":"benefit_level","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"WithdrawableIncome","fieldDesc":"可提现收入","fieldType":"float64","fieldJson":"withdrawable_income","dataTypeLong":"","comment":"","columnName":"withdrawable_income","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"CumulativeIncome","fieldDesc":"累计收入","fieldType":"float64","fieldJson":"cumulative_income","dataTypeLong":"","comment":"","columnName":"cumulative_income","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"MembershipExpiryDate","fieldDesc":"会员到期时间","fieldType":"time.Time","fieldJson":"membership_expiry_date","dataTypeLong":"","comment":"","columnName":"membership_expiry_date","fieldSearchType":"BETWEEN","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"MembershipRedemptionCode","fieldDesc":"会员兑换码","fieldType":"string","fieldJson":"membership_redemption_code","dataTypeLong":"","comment":"","columnName":"membership_redemption_code","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ActivityRedemptionCode","fieldDesc":"活动兑换码","fieldType":"string","fieldJson":"activity_redemption_code","dataTypeLong":"","comment":"","columnName":"activity_redemption_code","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"IsActive","fieldDesc":"是否启用","fieldType":"bool","fieldJson":"is_active","dataTypeLong":"","comment":"","columnName":"is_active","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	WechatUser	WechatUser		用户管理	{"resource/package/server/api/api.go.tpl":"api/v1/system/usermanagement.go","resource/package/server/model/model.go.tpl":"model/system/usermanagement.go","resource/package/server/model/request/request.go.tpl":"model/system/request/usermanagement.go","resource/package/server/router/router.go.tpl":"router/system/usermanagement.go","resource/package/server/service/service.go.tpl":"service/system/usermanagement.go","resource/package/web/api/api.js.tpl":"api/system/usermanagement.js","resource/package/web/view/form.vue.tpl":"view/system/usermanagement/usermanagementForm.vue","resource/package/web/view/table.vue.tpl":"view/system/usermanagement/usermanagement.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"WechatUserApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"wxUserService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"WechatUserService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"WechatUser\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitWechatUserRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"WechatUserRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"wxUserApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"WechatUserApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"WechatUserService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[173,174,175,176,177,178]	43	0	0
11	2025-07-12 06:14:24.766693+00	2025-07-12 06:14:24.766693+00	\N	core_activities	system	{"package":"system","tableName":"core_activities","businessDB":"","structName":"Activities","packageName":"core_activities","description":"活动管理","abbreviation":"activities","humpPackageName":"core_activities","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"ActivityName","fieldDesc":"活动名称","fieldType":"string","fieldJson":"activityName","dataTypeLong":"","comment":"","columnName":"activity_name","fieldSearchType":"LIKE","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Price","fieldDesc":"活动价格","fieldType":"float64","fieldJson":"price","dataTypeLong":"","comment":"","columnName":"price","fieldSearchType":"BETWEEN","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Category","fieldDesc":"分类","fieldType":"int","fieldJson":"category","dataTypeLong":"","comment":"","columnName":"category","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"program_categories","label":"category_name","value":"id","association":1,"hasDeletedAt":true},"checkDataSource":true,"fieldIndexType":""},{"fieldName":"CoverPicture","fieldDesc":"封面图","fieldType":"string","fieldJson":"coverPicture","dataTypeLong":"","comment":"","columnName":"cover_picture","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ActualEnrollment","fieldDesc":"展示报名人数","fieldType":"int","fieldJson":"actualEnrollment","dataTypeLong":"","comment":"","columnName":"actual_enrollment","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"100","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Status","fieldDesc":"状态","fieldType":"bool","fieldJson":"status","dataTypeLong":"","comment":"","columnName":"status","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"true","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"SortOrder","fieldDesc":"排序","fieldType":"int","fieldJson":"sortOrder","dataTypeLong":"","comment":"","columnName":"sort_order","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"StartTime","fieldDesc":"开始时间","fieldType":"time.Time","fieldJson":"startTime","dataTypeLong":"","comment":"","columnName":"start_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"EndTime","fieldDesc":"结束时间","fieldType":"time.Time","fieldJson":"endTime","dataTypeLong":"","comment":"","columnName":"end_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ShowStartTime","fieldDesc":"展示开始时间","fieldType":"time.Time","fieldJson":"showStartTime","dataTypeLong":"","comment":"","columnName":"show_start_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ShowEndTime","fieldDesc":"展示结束时间","fieldType":"time.Time","fieldJson":"showEndTime","dataTypeLong":"","comment":"","columnName":"show_end_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Activities	Activities		活动管理	{"resource/package/server/api/api.go.tpl":"api/v1/system/core_activities.go","resource/package/server/model/model.go.tpl":"model/system/core_activities.go","resource/package/server/model/request/request.go.tpl":"model/system/request/core_activities.go","resource/package/server/router/router.go.tpl":"router/system/core_activities.go","resource/package/server/service/service.go.tpl":"service/system/core_activities.go","resource/package/web/api/api.js.tpl":"api/system/core_activities.js","resource/package/web/view/form.vue.tpl":"view/system/core_activities/core_activitiesForm.vue","resource/package/web/view/table.vue.tpl":"view/system/core_activities/core_activities.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"ActivitiesApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"activitiesService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"ActivitiesService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Activities\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitActivitiesRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"ActivitiesRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"activitiesApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"ActivitiesApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"ActivitiesService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	0	[185,186,187,188,189,190]	45	3	0
8	2025-07-12 05:54:20.964081+00	2025-07-12 06:13:56.676397+00	2025-07-12 06:14:34.75357+00	core_activities	system	{"package":"system","tableName":"core_activities","businessDB":"","structName":"Activities","packageName":"core_activities","description":"活动管理","abbreviation":"activities","humpPackageName":"core_activities","gvaModel":true,"autoMigrate":true,"autoCreateResource":true,"autoCreateApiToSql":true,"autoCreateMenuToSql":true,"autoCreateBtnAuth":false,"onlyTemplate":false,"isTree":false,"treeJson":"","isAdd":false,"fields":[{"fieldName":"ActivityName","fieldDesc":"活动名称","fieldType":"string","fieldJson":"activityName","dataTypeLong":"","comment":"","columnName":"activity_name","fieldSearchType":"LIKE","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Price","fieldDesc":"活动价格","fieldType":"float64","fieldJson":"price","dataTypeLong":"","comment":"","columnName":"price","fieldSearchType":"BETWEEN","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":{"dbName":"","table":"","label":"","value":"","association":1,"hasDeletedAt":false},"checkDataSource":false,"fieldIndexType":""},{"fieldName":"Category","fieldDesc":"分类","fieldType":"int","fieldJson":"category","dataTypeLong":"","comment":"","columnName":"category","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":{"dbName":"","table":"program_categories","label":"category_name","value":"id","association":1,"hasDeletedAt":true},"checkDataSource":true,"fieldIndexType":""},{"fieldName":"CoverPicture","fieldDesc":"封面图","fieldType":"string","fieldJson":"coverPicture","dataTypeLong":"","comment":"","columnName":"cover_picture","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ActualEnrollment","fieldDesc":"展示报名人数","fieldType":"int","fieldJson":"actualEnrollment","dataTypeLong":"","comment":"","columnName":"actual_enrollment","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"100","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"上架状态","fieldDesc":"状态","fieldType":"bool","fieldJson":"status","dataTypeLong":"","comment":"","columnName":"status","fieldSearchType":"=","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"true","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"SortOrder","fieldDesc":"排序","fieldType":"int","fieldJson":"sortOrder","dataTypeLong":"","comment":"","columnName":"sort_order","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":true,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"StartTime","fieldDesc":"开始时间","fieldType":"time.Time","fieldJson":"startTime","dataTypeLong":"","comment":"","columnName":"start_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"EndTime","fieldDesc":"结束时间","fieldType":"time.Time","fieldJson":"endTime","dataTypeLong":"","comment":"","columnName":"end_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ShowStartTime","fieldDesc":"展示开始时间","fieldType":"time.Time","fieldJson":"showStartTime","dataTypeLong":"","comment":"","columnName":"show_start_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""},{"fieldName":"ShowEndTime","fieldDesc":"展示结束时间","fieldType":"time.Time","fieldJson":"showEndTime","dataTypeLong":"","comment":"","columnName":"show_end_time","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":true,"table":true,"desc":true,"excel":true,"require":true,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}],"generateWeb":true,"generateServer":true,"primaryField":{"fieldName":"ID","fieldDesc":"ID","fieldType":"uint","fieldJson":"ID","dataTypeLong":"20","comment":"主键ID","columnName":"id","fieldSearchType":"","fieldSearchHide":false,"dictType":"","form":false,"table":false,"desc":false,"excel":false,"require":false,"defaultValue":"","errorText":"","clearable":false,"sort":false,"primaryKey":false,"dataSource":null,"checkDataSource":false,"fieldIndexType":""}}	Activities	Activities		活动管理	{"resource/package/server/api/api.go.tpl":"api/v1/system/core_activities.go","resource/package/server/model/model.go.tpl":"model/system/core_activities.go","resource/package/server/model/request/request.go.tpl":"model/system/request/core_activities.go","resource/package/server/router/router.go.tpl":"router/system/core_activities.go","resource/package/server/service/service.go.tpl":"service/system/core_activities.go","resource/package/web/api/api.js.tpl":"api/system/core_activities.js","resource/package/web/view/form.vue.tpl":"view/system/core_activities/core_activitiesForm.vue","resource/package/web/view/table.vue.tpl":"view/system/core_activities/core_activities.vue"}	{"PackageApiEnter":"{\\"Type\\":\\"PackageApiEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1/system\\\\\\"\\",\\"StructName\\":\\"SystemApiGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"api/v1/enter.go\\",\\"PackageStructName\\":\\"ApiGroup\\"}","PackageApiModuleEnter":"{\\"Type\\":\\"PackageApiModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/api/v1/system/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service\\\\\\"\\",\\"RelativePath\\":\\"api/v1/system/enter.go\\",\\"StructName\\":\\"ActivitiesApi\\",\\"AppName\\":\\"ServiceGroupApp\\",\\"GroupName\\":\\"SystemServiceGroup\\",\\"ModuleName\\":\\"activitiesService\\",\\"PackageName\\":\\"service\\",\\"ServiceName\\":\\"ActivitiesService\\"}","PackageInitializeGorm":"{\\"Type\\":\\"PackageInitializeGorm\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/gorm_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/model/system\\\\\\"\\",\\"Business\\":\\"\\",\\"StructName\\":\\"Activities\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"initialize/gorm_biz.go\\",\\"IsNew\\":true}","PackageInitializeRouter":"{\\"Type\\":\\"PackageInitializeRouter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/initialize/router_biz.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router\\\\\\"\\",\\"RelativePath\\":\\"initialize/router_biz.go\\",\\"AppName\\":\\"RouterGroupApp\\",\\"GroupName\\":\\"System\\",\\"ModuleName\\":\\"systemRouter\\",\\"PackageName\\":\\"router\\",\\"FunctionName\\":\\"InitActivitiesRouter\\",\\"RouterGroupName\\":\\"\\",\\"LeftRouterGroupName\\":\\"privateGroup\\",\\"RightRouterGroupName\\":\\"publicGroup\\"}","PackageRouterEnter":"{\\"Type\\":\\"PackageRouterEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/router/system\\\\\\"\\",\\"StructName\\":\\"System\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"router/enter.go\\",\\"PackageStructName\\":\\"RouterGroup\\"}","PackageRouterModuleEnter":"{\\"Type\\":\\"PackageRouterModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/router/system/enter.go\\",\\"ImportPath\\":\\"api \\\\\\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\\\\\\"\\",\\"RelativePath\\":\\"router/system/enter.go\\",\\"StructName\\":\\"ActivitiesRouter\\",\\"AppName\\":\\"ApiGroupApp\\",\\"GroupName\\":\\"SystemApiGroup\\",\\"ModuleName\\":\\"activitiesApi\\",\\"PackageName\\":\\"api\\",\\"ServiceName\\":\\"ActivitiesApi\\"}","PackageServiceEnter":"{\\"Type\\":\\"PackageServiceEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/enter.go\\",\\"ImportPath\\":\\"\\\\\\"github.com/flipped-aurora/gin-vue-admin/server/service/system\\\\\\"\\",\\"StructName\\":\\"SystemServiceGroup\\",\\"PackageName\\":\\"system\\",\\"RelativePath\\":\\"service/enter.go\\",\\"PackageStructName\\":\\"ServiceGroup\\"}","PackageServiceModuleEnter":"{\\"Type\\":\\"PackageServiceModuleEnter\\",\\"Path\\":\\"/Users/sado/code/cincore/AI/gin-vue-admin/server/service/system/enter.go\\",\\"ImportPath\\":\\"\\",\\"RelativePath\\":\\"service/system/enter.go\\",\\"StructName\\":\\"ActivitiesService\\",\\"AppName\\":\\"\\",\\"GroupName\\":\\"\\",\\"ModuleName\\":\\"\\",\\"PackageName\\":\\"\\",\\"ServiceName\\":\\"\\"}"}	1	[167,168,169,170,171,172]	42	2	0
\.


--
-- Data for Name: sys_auto_code_packages; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_auto_code_packages (id, created_at, updated_at, deleted_at, "desc", label, template, package_name, module) FROM stdin;
1	2025-07-12 04:35:49.314901+00	2025-07-12 04:35:49.314901+00	\N	系统自动读取example包	example包	package	example	github.com/flipped-aurora/gin-vue-admin/server
2	2025-07-12 04:35:49.314901+00	2025-07-12 04:35:49.314901+00	\N	系统自动读取system包	system包	package	system	github.com/flipped-aurora/gin-vue-admin/server
3	2025-07-12 04:35:49.314901+00	2025-07-12 04:35:49.314901+00	\N	系统自动读取announcement插件，使用前请确认是否为v2版本插件	announcement插件	plugin	announcement	github.com/flipped-aurora/gin-vue-admin/server
\.


--
-- Data for Name: sys_base_menu_btns; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_base_menu_btns (id, created_at, updated_at, deleted_at, name, "desc", sys_base_menu_id) FROM stdin;
\.


--
-- Data for Name: sys_base_menu_parameters; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_base_menu_parameters (id, created_at, updated_at, deleted_at, sys_base_menu_id, type, key, value) FROM stdin;
\.


--
-- Data for Name: sys_base_menus; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_base_menus (id, created_at, updated_at, deleted_at, menu_level, parent_id, path, name, hidden, component, sort, active_name, keep_alive, default_menu, title, icon, close_tab, transition_type) FROM stdin;
1	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	dashboard	dashboard	f	view/dashboard/index.vue	1		f	f	仪表盘	odometer	f	
2	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	about	about	f	view/about/index.vue	9		f	f	关于我们	info-filled	f	
3	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	admin	superAdmin	f	view/superAdmin/index.vue	3		f	f	超级管理员	user	f	
4	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	person	person	t	view/person/person.vue	4		f	f	个人信息	message	f	
5	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	example	example	f	view/example/index.vue	7		f	f	示例文件	management	f	
6	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	systemTools	systemTools	f	view/systemTools/index.vue	5		f	f	系统工具	tools	f	
8	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	state	state	f	view/system/state.vue	8		f	f	服务器状态	cloudy	f	
9	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	\N	0	0	plugin	plugin	f	view/routerHolder.vue	6		f	f	插件系统	cherry	f	
10	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	authority	authority	f	view/superAdmin/authority/authority.vue	1		f	f	角色管理	avatar	f	
11	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	menu	menu	f	view/superAdmin/menu/menu.vue	2		t	f	菜单管理	tickets	f	
12	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	api	api	f	view/superAdmin/api/api.vue	3		t	f	api管理	platform	f	
13	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	user	user	f	view/superAdmin/user/user.vue	4		f	f	用户管理	coordinate	f	
14	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	dictionary	dictionary	f	view/superAdmin/dictionary/sysDictionary.vue	5		f	f	字典管理	notebook	f	
15	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	operation	operation	f	view/superAdmin/operation/sysOperationRecord.vue	6		f	f	操作历史	pie-chart	f	
16	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	3	sysParams	sysParams	f	view/superAdmin/params/sysParams.vue	7		f	f	参数管理	compass	f	
17	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	5	upload	upload	f	view/example/upload/upload.vue	5		f	f	媒体库（上传下载）	upload	f	
18	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	5	breakpoint	breakpoint	f	view/example/breakpoint/breakpoint.vue	6		f	f	断点续传	upload-filled	f	
19	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	5	customer	customer	f	view/example/customer/customer.vue	7		f	f	客户列表（资源示例）	avatar	f	
20	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	autoCode	autoCode	f	view/systemTools/autoCode/index.vue	1		t	f	代码生成器	cpu	f	
21	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	formCreate	formCreate	f	view/systemTools/formCreate/index.vue	3		t	f	表单生成器	magic-stick	f	
22	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	system	system	f	view/systemTools/system/system.vue	4		f	f	系统配置	operation	f	
23	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	autoCodeAdmin	autoCodeAdmin	f	view/systemTools/autoCodeAdmin/index.vue	2		f	f	自动化代码管理	magic-stick	f	
24	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	autoCodeEdit/:id	autoCodeEdit	t	view/systemTools/autoCode/index.vue	0		f	f	自动化代码-${id}	magic-stick	f	
25	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	autoPkg	autoPkg	f	view/systemTools/autoPkg/autoPkg.vue	0		f	f	模板配置	folder	f	
26	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	exportTemplate	exportTemplate	f	view/systemTools/exportTemplate/exportTemplate.vue	5		f	f	导出模板	reading	f	
27	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	picture	picture	f	view/systemTools/autoCode/picture.vue	6		f	f	AI页面绘制	picture-filled	f	
28	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	mcpTool	mcpTool	f	view/systemTools/autoCode/mcp.vue	7		f	f	Mcp Tools模板	magnet	f	
29	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	6	mcpTest	mcpTest	f	view/systemTools/autoCode/mcpTest.vue	7		f	f	Mcp Tools测试	partly-cloudy	f	
30	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	9	https://plugin.gin-vue-admin.com/	https://plugin.gin-vue-admin.com/	f	https://plugin.gin-vue-admin.com/	0		f	f	插件市场	shop	f	
31	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	9	installPlugin	installPlugin	f	view/systemTools/installPlugin/index.vue	1		f	f	插件安装	box	f	
32	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	9	pubPlug	pubPlug	f	view/systemTools/pubPlug/pubPlug.vue	3		f	f	打包插件	files	f	
33	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	9	plugin-email	plugin-email	f	plugin/email/view/index.vue	4		f	f	邮件插件	message	f	
34	2025-07-12 04:34:44.741897+00	2025-07-12 04:34:44.741897+00	\N	1	9	anInfo	anInfo	f	plugin/announcement/view/info.vue	5		f	f	公告管理[示例]	scaleToOriginal	f	
7	2025-07-12 04:34:44.739433+00	2025-07-12 04:34:44.739433+00	2025-07-12 04:40:51.993947+00	0	0	https://www.gin-vue-admin.com	https://www.gin-vue-admin.com	f	/	0		f	f	官方网站	customer-gva	f	
35	2025-07-12 04:51:11.203294+00	2025-07-12 04:51:11.203294+00	2025-07-12 04:52:37.011009+00	0	0	category	category	f	view/system/program_category/program_category.vue	0		f	f	分类		f	
36	2025-07-12 04:55:10.944143+00	2025-07-12 04:55:10.944143+00	\N	0	0	category	category	f	view/system/program_category/program_category.vue	0		f	f	分类		f	
37	2025-07-12 05:07:06.583279+00	2025-07-12 05:07:06.583279+00	\N	0	0	poster	poster	f	view/system/program_poster/program_poster.vue	0		f	f	推广海报		f	
38	2025-07-12 05:11:27.164009+00	2025-07-12 05:11:27.164009+00	\N	0	0	banner	banner	f	view/system/program_banner/program_banner.vue	0		f	f	轮播管理		f	
39	2025-07-12 05:15:14.540606+00	2025-07-12 05:15:14.540606+00	\N	0	0	teacher	teacher	f	view/system/program_teacher/program_teacher.vue	0		f	f	讲师管理		f	
40	2025-07-12 05:20:17.862557+00	2025-07-12 05:20:17.862557+00	\N	0	0	benefit	benefit	f	view/system/program_benefit/program_benefit.vue	0		f	f	权益等级		f	
41	2025-07-12 05:40:53.604704+00	2025-07-12 05:40:53.604704+00	\N	0	0	course	course	f	view/system/core_course/core_course.vue	0		f	f	课程管理		f	
43	2025-07-12 06:03:26.282232+00	2025-07-12 06:03:26.282232+00	\N	0	0	wxUser	wxUser	f	view/system/usermanagement/usermanagement.vue	0		f	f	用户管理		f	
44	2025-07-12 06:11:25.939243+00	2025-07-12 06:11:25.939243+00	\N	0	0	code	code	f	view/system/finance_code/finance_code.vue	0		f	f	兑换码明细		f	
42	2025-07-12 05:54:20.959179+00	2025-07-12 05:54:20.959179+00	2025-07-12 06:13:56.656439+00	0	0	activities	activities	f	view/system/core_activities/core_activities.vue	0		f	f	活动管理		f	
45	2025-07-12 06:14:24.762394+00	2025-07-12 06:14:24.762394+00	\N	0	0	activities	activities	f	view/system/core_activities/core_activities.vue	0		f	f	活动管理		f	
\.


--
-- Data for Name: sys_data_authority_id; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_data_authority_id (sys_authority_authority_id, data_authority_id_authority_id) FROM stdin;
888	888
888	9528
888	8881
9528	9528
9528	8881
\.


--
-- Data for Name: sys_dictionaries; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_dictionaries (id, created_at, updated_at, deleted_at, name, type, status, "desc") FROM stdin;
1	2025-07-12 04:34:44.711834+00	2025-07-12 04:34:44.715622+00	\N	性别	gender	t	性别字典
2	2025-07-12 04:34:44.711834+00	2025-07-12 04:34:44.719999+00	\N	数据库int类型	int	t	int类型对应的数据库类型
3	2025-07-12 04:34:44.711834+00	2025-07-12 04:34:44.723735+00	\N	数据库时间日期类型	time.Time	t	数据库时间日期类型
4	2025-07-12 04:34:44.711834+00	2025-07-12 04:34:44.727398+00	\N	数据库浮点型	float64	t	数据库浮点型
5	2025-07-12 04:34:44.711834+00	2025-07-12 04:34:44.731136+00	\N	数据库字符串	string	t	数据库字符串
6	2025-07-12 04:34:44.711834+00	2025-07-12 04:34:44.735398+00	\N	数据库bool类型	bool	t	数据库bool类型
\.


--
-- Data for Name: sys_dictionary_details; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_dictionary_details (id, created_at, updated_at, deleted_at, label, value, extend, status, sort, sys_dictionary_id) FROM stdin;
1	2025-07-12 04:34:44.716355+00	2025-07-12 04:34:44.716355+00	\N	男	1		t	1	1
2	2025-07-12 04:34:44.716355+00	2025-07-12 04:34:44.716355+00	\N	女	2		t	2	1
3	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	smallint	1	mysql	t	1	2
4	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	mediumint	2	mysql	t	2	2
5	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	int	3	mysql	t	3	2
6	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	bigint	4	mysql	t	4	2
7	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	int2	5	pgsql	t	5	2
8	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	int4	6	pgsql	t	6	2
9	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	int6	7	pgsql	t	7	2
10	2025-07-12 04:34:44.720411+00	2025-07-12 04:34:44.720411+00	\N	int8	8	pgsql	t	8	2
11	2025-07-12 04:34:44.72414+00	2025-07-12 04:34:44.72414+00	\N	date			t	0	3
12	2025-07-12 04:34:44.72414+00	2025-07-12 04:34:44.72414+00	\N	time	1	mysql	t	1	3
13	2025-07-12 04:34:44.72414+00	2025-07-12 04:34:44.72414+00	\N	year	2	mysql	t	2	3
14	2025-07-12 04:34:44.72414+00	2025-07-12 04:34:44.72414+00	\N	datetime	3	mysql	t	3	3
15	2025-07-12 04:34:44.72414+00	2025-07-12 04:34:44.72414+00	\N	timestamp	5	mysql	t	5	3
16	2025-07-12 04:34:44.72414+00	2025-07-12 04:34:44.72414+00	\N	timestamptz	6	pgsql	t	5	3
17	2025-07-12 04:34:44.727792+00	2025-07-12 04:34:44.727792+00	\N	float			t	0	4
18	2025-07-12 04:34:44.727792+00	2025-07-12 04:34:44.727792+00	\N	double	1	mysql	t	1	4
19	2025-07-12 04:34:44.727792+00	2025-07-12 04:34:44.727792+00	\N	decimal	2	mysql	t	2	4
20	2025-07-12 04:34:44.727792+00	2025-07-12 04:34:44.727792+00	\N	numeric	3	pgsql	t	3	4
21	2025-07-12 04:34:44.727792+00	2025-07-12 04:34:44.727792+00	\N	smallserial	4	pgsql	t	4	4
22	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	char			t	0	5
23	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	varchar	1	mysql	t	1	5
24	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	tinyblob	2	mysql	t	2	5
25	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	tinytext	3	mysql	t	3	5
26	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	text	4	mysql	t	4	5
27	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	blob	5	mysql	t	5	5
28	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	mediumblob	6	mysql	t	6	5
29	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	mediumtext	7	mysql	t	7	5
30	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	longblob	8	mysql	t	8	5
31	2025-07-12 04:34:44.73154+00	2025-07-12 04:34:44.73154+00	\N	longtext	9	mysql	t	9	5
32	2025-07-12 04:34:44.735844+00	2025-07-12 04:34:44.735844+00	\N	tinyint	1	mysql	t	0	6
33	2025-07-12 04:34:44.735844+00	2025-07-12 04:34:44.735844+00	\N	bool	2	pgsql	t	0	6
\.


--
-- Data for Name: sys_export_template_condition; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_export_template_condition (id, created_at, updated_at, deleted_at, template_id, "from", "column", operator) FROM stdin;
\.


--
-- Data for Name: sys_export_template_join; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_export_template_join (id, created_at, updated_at, deleted_at, template_id, joins, "table", "on") FROM stdin;
\.


--
-- Data for Name: sys_export_templates; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_export_templates (id, created_at, updated_at, deleted_at, db_name, name, table_name, template_id, template_info, "limit", "order") FROM stdin;
1	2025-07-12 04:34:44.902961+00	2025-07-12 04:34:44.902961+00	\N		api	sys_apis	api	{\n"path":"路径",\n"method":"方法（大写）",\n"description":"方法介绍",\n"api_group":"方法分组"\n}	\N	
2	2025-07-12 05:54:20.961611+00	2025-07-12 05:54:20.961611+00	2025-07-12 06:13:56.627956+00		system_Activities	core_activities	system_Activities	{"activity_name":"活动名称","actual_enrollment":"展示报名人数","category":"分类","cover_picture":"封面图","end_time":"结束时间","price":"活动价格","show_end_time":"展示结束时间","show_start_time":"展示开始时间","sort_order":"排序","start_time":"开始时间","status":"状态"}	\N	
3	2025-07-12 06:14:24.764544+00	2025-07-12 06:14:24.764544+00	\N		system_Activities	core_activities	system_Activities	{"activity_name":"活动名称","actual_enrollment":"展示报名人数","category":"分类","cover_picture":"封面图","end_time":"结束时间","price":"活动价格","show_end_time":"展示结束时间","show_start_time":"展示开始时间","sort_order":"排序","start_time":"开始时间","status":"状态"}	\N	
\.


--
-- Data for Name: sys_ignore_apis; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_ignore_apis (id, created_at, updated_at, deleted_at, path, method) FROM stdin;
1	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/swagger/*any	GET
2	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/api/freshCasbin	GET
3	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/uploads/file/*filepath	GET
4	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/health	GET
5	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/uploads/file/*filepath	HEAD
6	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/autoCode/llmAuto	POST
7	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/system/reloadSystem	POST
8	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/base/login	POST
9	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/base/captcha	POST
10	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/init/initdb	POST
11	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/init/checkdb	POST
12	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/info/getInfoDataSource	GET
13	2025-07-12 04:34:44.683523+00	2025-07-12 04:34:44.683523+00	\N	/info/getInfoPublic	GET
\.


--
-- Data for Name: sys_operation_records; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_operation_records (id, created_at, updated_at, deleted_at, ip, method, path, status, latency, agent, error_message, body, resp, user_id) FROM stdin;
1	2025-07-12 04:40:52.01082+00	2025-07-12 04:40:52.01082+00	\N	127.0.0.1	POST	/menu/deleteBaseMenu	200	21803006	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36		{"ID":7}	{"code":0,"data":{},"msg":"删除成功"}	1
\.


--
-- Data for Name: sys_params; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_params (id, created_at, updated_at, deleted_at, name, key, value, "desc") FROM stdin;
\.


--
-- Data for Name: sys_user_authority; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_user_authority (sys_user_id, sys_authority_authority_id) FROM stdin;
1	888
1	9528
1	8881
2	888
\.


--
-- Data for Name: sys_users; Type: TABLE DATA; Schema: public; Owner: gva
--

COPY public.sys_users (id, created_at, updated_at, deleted_at, uuid, username, password, nick_name, header_img, authority_id, phone, email, enable, origin_setting) FROM stdin;
1	2025-07-12 04:34:44.878894+00	2025-07-12 04:34:44.884667+00	\N	18d4e4cb-37c7-4eb8-be7e-2dd5f0e257b9	admin	$2a$10$12DTj9A4f.81WqUWj7x6G.xQbynwjc/AZdBu.bN6Y.EiWBAhBc29K	Mr.奇淼	https://qmplusimg.henrongyi.top/gva_header.jpg	888	17611111111	333333333@qq.com	1	\N
2	2025-07-12 04:34:44.878894+00	2025-07-12 04:34:44.892421+00	\N	334126b6-2e48-4209-9b19-f2d80370909d	a303176530	$2a$10$k7yPlSP0gbm6du619D4IQui3Jz6cPOQwlJFl4425BCLHxylqU84uy	用户1	https:///qmplusimg.henrongyi.top/1572075907logo.png	9528	17611111111	333333333@qq.com	1	\N
\.


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: casbin_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.casbin_rule_id_seq', 205, true);


--
-- Name: core_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.core_activities_id_seq', 1, false);


--
-- Name: core_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.core_courses_id_seq', 1, false);


--
-- Name: exa_attachment_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.exa_attachment_category_id_seq', 1, false);


--
-- Name: exa_customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.exa_customers_id_seq', 1, false);


--
-- Name: exa_file_chunks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.exa_file_chunks_id_seq', 1, false);


--
-- Name: exa_file_upload_and_downloads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.exa_file_upload_and_downloads_id_seq', 2, true);


--
-- Name: exa_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.exa_files_id_seq', 1, false);


--
-- Name: finance_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.finance_code_id_seq', 1, false);


--
-- Name: gva_announcements_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.gva_announcements_info_id_seq', 1, false);


--
-- Name: jwt_blacklists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.jwt_blacklists_id_seq', 1, false);


--
-- Name: program_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.program_banner_id_seq', 1, false);


--
-- Name: program_benefit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.program_benefit_id_seq', 1, false);


--
-- Name: program_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.program_categories_id_seq', 1, false);


--
-- Name: program_poster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.program_poster_id_seq', 1, false);


--
-- Name: program_teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.program_teacher_id_seq', 1, false);


--
-- Name: sys_apis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_apis_id_seq', 190, true);


--
-- Name: sys_authorities_authority_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_authorities_authority_id_seq', 1, false);


--
-- Name: sys_auto_code_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_auto_code_histories_id_seq', 11, true);


--
-- Name: sys_auto_code_packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_auto_code_packages_id_seq', 3, true);


--
-- Name: sys_base_menu_btns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_base_menu_btns_id_seq', 1, false);


--
-- Name: sys_base_menu_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_base_menu_parameters_id_seq', 1, false);


--
-- Name: sys_base_menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_base_menus_id_seq', 45, true);


--
-- Name: sys_dictionaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_dictionaries_id_seq', 6, true);


--
-- Name: sys_dictionary_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_dictionary_details_id_seq', 33, true);


--
-- Name: sys_export_template_condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_export_template_condition_id_seq', 1, false);


--
-- Name: sys_export_template_join_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_export_template_join_id_seq', 1, false);


--
-- Name: sys_export_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_export_templates_id_seq', 3, true);


--
-- Name: sys_ignore_apis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_ignore_apis_id_seq', 13, true);


--
-- Name: sys_operation_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_operation_records_id_seq', 1, true);


--
-- Name: sys_params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_params_id_seq', 1, false);


--
-- Name: sys_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gva
--

SELECT pg_catalog.setval('public.sys_users_id_seq', 2, true);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: casbin_rule casbin_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.casbin_rule
    ADD CONSTRAINT casbin_rule_pkey PRIMARY KEY (id);


--
-- Name: core_activities core_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.core_activities
    ADD CONSTRAINT core_activities_pkey PRIMARY KEY (id);


--
-- Name: core_courses core_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.core_courses
    ADD CONSTRAINT core_courses_pkey PRIMARY KEY (id);


--
-- Name: exa_attachment_category exa_attachment_category_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_attachment_category
    ADD CONSTRAINT exa_attachment_category_pkey PRIMARY KEY (id);


--
-- Name: exa_customers exa_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_customers
    ADD CONSTRAINT exa_customers_pkey PRIMARY KEY (id);


--
-- Name: exa_file_chunks exa_file_chunks_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_file_chunks
    ADD CONSTRAINT exa_file_chunks_pkey PRIMARY KEY (id);


--
-- Name: exa_file_upload_and_downloads exa_file_upload_and_downloads_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_file_upload_and_downloads
    ADD CONSTRAINT exa_file_upload_and_downloads_pkey PRIMARY KEY (id);


--
-- Name: exa_files exa_files_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.exa_files
    ADD CONSTRAINT exa_files_pkey PRIMARY KEY (id);


--
-- Name: finance_code finance_code_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.finance_code
    ADD CONSTRAINT finance_code_pkey PRIMARY KEY (id);


--
-- Name: gva_announcements_info gva_announcements_info_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.gva_announcements_info
    ADD CONSTRAINT gva_announcements_info_pkey PRIMARY KEY (id);


--
-- Name: jwt_blacklists jwt_blacklists_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.jwt_blacklists
    ADD CONSTRAINT jwt_blacklists_pkey PRIMARY KEY (id);


--
-- Name: program_banner program_banner_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_banner
    ADD CONSTRAINT program_banner_pkey PRIMARY KEY (id);


--
-- Name: program_benefit program_benefit_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_benefit
    ADD CONSTRAINT program_benefit_pkey PRIMARY KEY (id);


--
-- Name: program_categories program_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_categories
    ADD CONSTRAINT program_categories_pkey PRIMARY KEY (id);


--
-- Name: program_poster program_poster_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_poster
    ADD CONSTRAINT program_poster_pkey PRIMARY KEY (id);


--
-- Name: program_teacher program_teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.program_teacher
    ADD CONSTRAINT program_teacher_pkey PRIMARY KEY (id);


--
-- Name: sys_apis sys_apis_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_apis
    ADD CONSTRAINT sys_apis_pkey PRIMARY KEY (id);


--
-- Name: sys_authority_menus sys_authority_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_authority_menus
    ADD CONSTRAINT sys_authority_menus_pkey PRIMARY KEY (sys_base_menu_id, sys_authority_authority_id);


--
-- Name: sys_auto_code_histories sys_auto_code_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_auto_code_histories
    ADD CONSTRAINT sys_auto_code_histories_pkey PRIMARY KEY (id);


--
-- Name: sys_auto_code_packages sys_auto_code_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_auto_code_packages
    ADD CONSTRAINT sys_auto_code_packages_pkey PRIMARY KEY (id);


--
-- Name: sys_base_menu_btns sys_base_menu_btns_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_base_menu_btns
    ADD CONSTRAINT sys_base_menu_btns_pkey PRIMARY KEY (id);


--
-- Name: sys_base_menu_parameters sys_base_menu_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_base_menu_parameters
    ADD CONSTRAINT sys_base_menu_parameters_pkey PRIMARY KEY (id);


--
-- Name: sys_base_menus sys_base_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_base_menus
    ADD CONSTRAINT sys_base_menus_pkey PRIMARY KEY (id);


--
-- Name: sys_data_authority_id sys_data_authority_id_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_data_authority_id
    ADD CONSTRAINT sys_data_authority_id_pkey PRIMARY KEY (sys_authority_authority_id, data_authority_id_authority_id);


--
-- Name: sys_dictionaries sys_dictionaries_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_dictionaries
    ADD CONSTRAINT sys_dictionaries_pkey PRIMARY KEY (id);


--
-- Name: sys_dictionary_details sys_dictionary_details_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_dictionary_details
    ADD CONSTRAINT sys_dictionary_details_pkey PRIMARY KEY (id);


--
-- Name: sys_export_template_condition sys_export_template_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_export_template_condition
    ADD CONSTRAINT sys_export_template_condition_pkey PRIMARY KEY (id);


--
-- Name: sys_export_template_join sys_export_template_join_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_export_template_join
    ADD CONSTRAINT sys_export_template_join_pkey PRIMARY KEY (id);


--
-- Name: sys_export_templates sys_export_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_export_templates
    ADD CONSTRAINT sys_export_templates_pkey PRIMARY KEY (id);


--
-- Name: sys_ignore_apis sys_ignore_apis_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_ignore_apis
    ADD CONSTRAINT sys_ignore_apis_pkey PRIMARY KEY (id);


--
-- Name: sys_operation_records sys_operation_records_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_operation_records
    ADD CONSTRAINT sys_operation_records_pkey PRIMARY KEY (id);


--
-- Name: sys_params sys_params_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_params
    ADD CONSTRAINT sys_params_pkey PRIMARY KEY (id);


--
-- Name: sys_user_authority sys_user_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_user_authority
    ADD CONSTRAINT sys_user_authority_pkey PRIMARY KEY (sys_user_id, sys_authority_authority_id);


--
-- Name: sys_users sys_users_pkey; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_pkey PRIMARY KEY (id);


--
-- Name: sys_authorities uni_sys_authorities_authority_id; Type: CONSTRAINT; Schema: public; Owner: gva
--

ALTER TABLE ONLY public.sys_authorities
    ADD CONSTRAINT uni_sys_authorities_authority_id PRIMARY KEY (authority_id);


--
-- Name: idx_User_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX "idx_User_deleted_at" ON public."User" USING btree (deleted_at);


--
-- Name: idx_casbin_rule; Type: INDEX; Schema: public; Owner: gva
--

CREATE UNIQUE INDEX idx_casbin_rule ON public.casbin_rule USING btree (ptype, v0, v1, v2, v3, v4, v5);


--
-- Name: idx_core_activities_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_core_activities_deleted_at ON public.core_activities USING btree (deleted_at);


--
-- Name: idx_core_courses_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_core_courses_deleted_at ON public.core_courses USING btree (deleted_at);


--
-- Name: idx_exa_attachment_category_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_exa_attachment_category_deleted_at ON public.exa_attachment_category USING btree (deleted_at);


--
-- Name: idx_exa_customers_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_exa_customers_deleted_at ON public.exa_customers USING btree (deleted_at);


--
-- Name: idx_exa_file_chunks_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_exa_file_chunks_deleted_at ON public.exa_file_chunks USING btree (deleted_at);


--
-- Name: idx_exa_file_upload_and_downloads_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_exa_file_upload_and_downloads_deleted_at ON public.exa_file_upload_and_downloads USING btree (deleted_at);


--
-- Name: idx_exa_files_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_exa_files_deleted_at ON public.exa_files USING btree (deleted_at);


--
-- Name: idx_finance_code_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_finance_code_deleted_at ON public.finance_code USING btree (deleted_at);


--
-- Name: idx_gva_announcements_info_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_gva_announcements_info_deleted_at ON public.gva_announcements_info USING btree (deleted_at);


--
-- Name: idx_jwt_blacklists_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_jwt_blacklists_deleted_at ON public.jwt_blacklists USING btree (deleted_at);


--
-- Name: idx_program_banner_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_program_banner_deleted_at ON public.program_banner USING btree (deleted_at);


--
-- Name: idx_program_benefit_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_program_benefit_deleted_at ON public.program_benefit USING btree (deleted_at);


--
-- Name: idx_program_categories_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_program_categories_deleted_at ON public.program_categories USING btree (deleted_at);


--
-- Name: idx_program_poster_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_program_poster_deleted_at ON public.program_poster USING btree (deleted_at);


--
-- Name: idx_program_teacher_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_program_teacher_deleted_at ON public.program_teacher USING btree (deleted_at);


--
-- Name: idx_sys_apis_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_apis_deleted_at ON public.sys_apis USING btree (deleted_at);


--
-- Name: idx_sys_auto_code_histories_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_auto_code_histories_deleted_at ON public.sys_auto_code_histories USING btree (deleted_at);


--
-- Name: idx_sys_auto_code_packages_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_auto_code_packages_deleted_at ON public.sys_auto_code_packages USING btree (deleted_at);


--
-- Name: idx_sys_base_menu_btns_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_base_menu_btns_deleted_at ON public.sys_base_menu_btns USING btree (deleted_at);


--
-- Name: idx_sys_base_menu_parameters_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_base_menu_parameters_deleted_at ON public.sys_base_menu_parameters USING btree (deleted_at);


--
-- Name: idx_sys_base_menus_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_base_menus_deleted_at ON public.sys_base_menus USING btree (deleted_at);


--
-- Name: idx_sys_dictionaries_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_dictionaries_deleted_at ON public.sys_dictionaries USING btree (deleted_at);


--
-- Name: idx_sys_dictionary_details_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_dictionary_details_deleted_at ON public.sys_dictionary_details USING btree (deleted_at);


--
-- Name: idx_sys_export_template_condition_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_export_template_condition_deleted_at ON public.sys_export_template_condition USING btree (deleted_at);


--
-- Name: idx_sys_export_template_join_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_export_template_join_deleted_at ON public.sys_export_template_join USING btree (deleted_at);


--
-- Name: idx_sys_export_templates_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_export_templates_deleted_at ON public.sys_export_templates USING btree (deleted_at);


--
-- Name: idx_sys_ignore_apis_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_ignore_apis_deleted_at ON public.sys_ignore_apis USING btree (deleted_at);


--
-- Name: idx_sys_operation_records_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_operation_records_deleted_at ON public.sys_operation_records USING btree (deleted_at);


--
-- Name: idx_sys_params_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_params_deleted_at ON public.sys_params USING btree (deleted_at);


--
-- Name: idx_sys_users_deleted_at; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_users_deleted_at ON public.sys_users USING btree (deleted_at);


--
-- Name: idx_sys_users_username; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_users_username ON public.sys_users USING btree (username);


--
-- Name: idx_sys_users_uuid; Type: INDEX; Schema: public; Owner: gva
--

CREATE INDEX idx_sys_users_uuid ON public.sys_users USING btree (uuid);


--
-- PostgreSQL database dump complete
--

