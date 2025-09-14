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
    user_type text DEFAULT 'normal'::text,
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
    registration_type text DEFAULT 'paid'::text,
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
    deleted_by bigint,
    hot boolean DEFAULT false,
    exquisite boolean DEFAULT false
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
-- Name: activity_registrations; Type: TABLE; Schema: public; Owner: gva
--

CREATE TABLE public.activity_registrations (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    user_id bigint NOT NULL,
    activity_id bigint NOT NULL,
    registration_type text DEFAULT 'paid'::text,
    verification_code character varying(50),
    participant_name character varying(100),
    participant_phone character varying(20),
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    payment_time timestamp with time zone,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint
);


ALTER TABLE public.activity_registrations OWNER TO gva;

--
-- Name: COLUMN activity_registrations.created_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.activity_registrations.created_by IS '创建者';


--
-- Name: COLUMN activity_registrations.updated_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.activity_registrations.updated_by IS '更新者';


--
-- Name: COLUMN activity_registrations.deleted_by; Type: COMMENT; Schema: public; Owner: gva
--

COMMENT ON COLUMN public.activity_registrations.deleted_by IS '删除者';


--
-- Name: activity_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: gva
--

CREATE SEQUENCE public.activity_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_registrations_id_seq OWNER TO gva;

--
-- Name: activity_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gva
--

ALTER SEQUENCE public.activity_registrations_id_seq OWNED BY public.activity_registrations.id;


--
-- PostgreSQL database dump complete
--

