--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

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
-- Name: categories; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.categories (
    category_id bigint NOT NULL,
    category_name character varying(255),
    category_path character varying(255)
);


ALTER TABLE public.categories OWNER TO bobik;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO bobik;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: compositions; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.compositions (
    composition_id bigint NOT NULL,
    position_id bigint NOT NULL,
    ingredient_id bigint NOT NULL
);


ALTER TABLE public.compositions OWNER TO bobik;

--
-- Name: compositions_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.compositions_composition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compositions_composition_id_seq OWNER TO bobik;

--
-- Name: compositions_composition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.compositions_composition_id_seq OWNED BY public.compositions.composition_id;


--
-- Name: compositions_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.compositions_ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compositions_ingredient_id_seq OWNER TO bobik;

--
-- Name: compositions_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.compositions_ingredient_id_seq OWNED BY public.compositions.ingredient_id;


--
-- Name: compositions_position_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.compositions_position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compositions_position_id_seq OWNER TO bobik;

--
-- Name: compositions_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.compositions_position_id_seq OWNED BY public.compositions.position_id;


--
-- Name: food_categories; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.food_categories (
    category_id bigint NOT NULL,
    category_name character varying(255)
);


ALTER TABLE public.food_categories OWNER TO bobik;

--
-- Name: food_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.food_categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.food_categories_category_id_seq OWNER TO bobik;

--
-- Name: food_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.food_categories_category_id_seq OWNED BY public.food_categories.category_id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.ingredients (
    ingredient_id bigint NOT NULL,
    ingredient_name character varying(255)
);


ALTER TABLE public.ingredients OWNER TO bobik;

--
-- Name: ingredients_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.ingredients_ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredients_ingredient_id_seq OWNER TO bobik;

--
-- Name: ingredients_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.ingredients_ingredient_id_seq OWNED BY public.ingredients.ingredient_id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.jobs (
    job_id bigint NOT NULL,
    job_name character varying(255),
    job_description character varying(255),
    job_salary integer,
    score_step integer
);


ALTER TABLE public.jobs OWNER TO bobik;

--
-- Name: jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_job_id_seq OWNER TO bobik;

--
-- Name: jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.jobs_job_id_seq OWNED BY public.jobs.job_id;


--
-- Name: jobs_levels; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.jobs_levels (
    id bigint NOT NULL,
    level_id bigint NOT NULL,
    job_id bigint NOT NULL
);


ALTER TABLE public.jobs_levels OWNER TO bobik;

--
-- Name: jobs_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.jobs_levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_levels_id_seq OWNER TO bobik;

--
-- Name: jobs_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.jobs_levels_id_seq OWNED BY public.jobs_levels.id;


--
-- Name: jobs_levels_job_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.jobs_levels_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_levels_job_id_seq OWNER TO bobik;

--
-- Name: jobs_levels_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.jobs_levels_job_id_seq OWNED BY public.jobs_levels.job_id;


--
-- Name: jobs_levels_level_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.jobs_levels_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_levels_level_id_seq OWNER TO bobik;

--
-- Name: jobs_levels_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.jobs_levels_level_id_seq OWNED BY public.jobs_levels.level_id;


--
-- Name: levels; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.levels (
    level_id bigint NOT NULL,
    level_number integer,
    next_level_entry_score integer
);


ALTER TABLE public.levels OWNER TO bobik;

--
-- Name: levels_level_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.levels_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.levels_level_id_seq OWNER TO bobik;

--
-- Name: levels_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.levels_level_id_seq OWNED BY public.levels.level_id;


--
-- Name: player_attributes; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.player_attributes (
    attribute_id bigint NOT NULL,
    user_id bigint NOT NULL,
    balance integer DEFAULT 0,
    score integer DEFAULT 0,
    food integer DEFAULT 2100,
    stamina integer DEFAULT 100
);


ALTER TABLE public.player_attributes OWNER TO bobik;

--
-- Name: player_attributes_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.player_attributes_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_attributes_attribute_id_seq OWNER TO bobik;

--
-- Name: player_attributes_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.player_attributes_attribute_id_seq OWNED BY public.player_attributes.attribute_id;


--
-- Name: player_attributes_user_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.player_attributes_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_attributes_user_id_seq OWNER TO bobik;

--
-- Name: player_attributes_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.player_attributes_user_id_seq OWNED BY public.player_attributes.user_id;


--
-- Name: product_attributes; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.product_attributes (
    attribute_id bigint NOT NULL,
    attribute_name character varying(255),
    product_id bigint NOT NULL,
    attribute_value character varying(255)
);


ALTER TABLE public.product_attributes OWNER TO bobik;

--
-- Name: product_attributes_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.product_attributes_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_attributes_attribute_id_seq OWNER TO bobik;

--
-- Name: product_attributes_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.product_attributes_attribute_id_seq OWNED BY public.product_attributes.attribute_id;


--
-- Name: product_attributes_product_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.product_attributes_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_attributes_product_id_seq OWNER TO bobik;

--
-- Name: product_attributes_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.product_attributes_product_id_seq OWNED BY public.product_attributes.product_id;


--
-- Name: product_sizes; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.product_sizes (
    size_id bigint NOT NULL,
    size_name character varying(255),
    product_id bigint NOT NULL,
    price integer
);


ALTER TABLE public.product_sizes OWNER TO bobik;

--
-- Name: product_sizes_product_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.product_sizes_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_sizes_product_id_seq OWNER TO bobik;

--
-- Name: product_sizes_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.product_sizes_product_id_seq OWNED BY public.product_sizes.product_id;


--
-- Name: product_sizes_size_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.product_sizes_size_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_sizes_size_id_seq OWNER TO bobik;

--
-- Name: product_sizes_size_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.product_sizes_size_id_seq OWNED BY public.product_sizes.size_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.products (
    product_id bigint NOT NULL,
    product_name character varying(255),
    category_id bigint NOT NULL
);


ALTER TABLE public.products OWNER TO bobik;

--
-- Name: products_category_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.products_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_category_id_seq OWNER TO bobik;

--
-- Name: products_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.products_category_id_seq OWNED BY public.products.category_id;


--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO bobik;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: restaurant_menu; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.restaurant_menu (
    position_id bigint NOT NULL,
    restaurant_id bigint NOT NULL,
    food_category_id bigint NOT NULL,
    position_name character varying(255),
    position_size character varying(255),
    position_calories integer,
    position_price integer
);


ALTER TABLE public.restaurant_menu OWNER TO bobik;

--
-- Name: restaurant_menu_food_category_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.restaurant_menu_food_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restaurant_menu_food_category_id_seq OWNER TO bobik;

--
-- Name: restaurant_menu_food_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.restaurant_menu_food_category_id_seq OWNED BY public.restaurant_menu.food_category_id;


--
-- Name: restaurant_menu_position_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.restaurant_menu_position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restaurant_menu_position_id_seq OWNER TO bobik;

--
-- Name: restaurant_menu_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.restaurant_menu_position_id_seq OWNED BY public.restaurant_menu.position_id;


--
-- Name: restaurant_menu_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.restaurant_menu_restaurant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restaurant_menu_restaurant_id_seq OWNER TO bobik;

--
-- Name: restaurant_menu_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.restaurant_menu_restaurant_id_seq OWNED BY public.restaurant_menu.restaurant_id;


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.restaurants (
    restaurant_id bigint NOT NULL,
    restaurant_name character varying(255)
);


ALTER TABLE public.restaurants OWNER TO bobik;

--
-- Name: restaurants_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.restaurants_restaurant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restaurants_restaurant_id_seq OWNER TO bobik;

--
-- Name: restaurants_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.restaurants_restaurant_id_seq OWNED BY public.restaurants.restaurant_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: bobik
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    first_name text NOT NULL,
    last_name text,
    user_name text,
    level_id bigint NOT NULL,
    job_id bigint NOT NULL,
    gender character varying(255),
    skin_color character varying(255)
);


ALTER TABLE public.users OWNER TO bobik;

--
-- Name: users_job_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.users_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_job_id_seq OWNER TO bobik;

--
-- Name: users_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.users_job_id_seq OWNED BY public.users.job_id;


--
-- Name: users_level_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.users_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_level_id_seq OWNER TO bobik;

--
-- Name: users_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.users_level_id_seq OWNED BY public.users.level_id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: bobik
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO bobik;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bobik
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: compositions composition_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.compositions ALTER COLUMN composition_id SET DEFAULT nextval('public.compositions_composition_id_seq'::regclass);


--
-- Name: compositions position_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.compositions ALTER COLUMN position_id SET DEFAULT nextval('public.compositions_position_id_seq'::regclass);


--
-- Name: compositions ingredient_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.compositions ALTER COLUMN ingredient_id SET DEFAULT nextval('public.compositions_ingredient_id_seq'::regclass);


--
-- Name: food_categories category_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.food_categories ALTER COLUMN category_id SET DEFAULT nextval('public.food_categories_category_id_seq'::regclass);


--
-- Name: ingredients ingredient_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN ingredient_id SET DEFAULT nextval('public.ingredients_ingredient_id_seq'::regclass);


--
-- Name: jobs job_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs ALTER COLUMN job_id SET DEFAULT nextval('public.jobs_job_id_seq'::regclass);


--
-- Name: jobs_levels id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs_levels ALTER COLUMN id SET DEFAULT nextval('public.jobs_levels_id_seq'::regclass);


--
-- Name: jobs_levels level_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs_levels ALTER COLUMN level_id SET DEFAULT nextval('public.jobs_levels_level_id_seq'::regclass);


--
-- Name: jobs_levels job_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs_levels ALTER COLUMN job_id SET DEFAULT nextval('public.jobs_levels_job_id_seq'::regclass);


--
-- Name: levels level_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.levels ALTER COLUMN level_id SET DEFAULT nextval('public.levels_level_id_seq'::regclass);


--
-- Name: player_attributes attribute_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.player_attributes ALTER COLUMN attribute_id SET DEFAULT nextval('public.player_attributes_attribute_id_seq'::regclass);


--
-- Name: player_attributes user_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.player_attributes ALTER COLUMN user_id SET DEFAULT nextval('public.player_attributes_user_id_seq'::regclass);


--
-- Name: product_attributes attribute_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_attributes ALTER COLUMN attribute_id SET DEFAULT nextval('public.product_attributes_attribute_id_seq'::regclass);


--
-- Name: product_attributes product_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_attributes ALTER COLUMN product_id SET DEFAULT nextval('public.product_attributes_product_id_seq'::regclass);


--
-- Name: product_sizes size_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_sizes ALTER COLUMN size_id SET DEFAULT nextval('public.product_sizes_size_id_seq'::regclass);


--
-- Name: product_sizes product_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_sizes ALTER COLUMN product_id SET DEFAULT nextval('public.product_sizes_product_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: products category_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.products ALTER COLUMN category_id SET DEFAULT nextval('public.products_category_id_seq'::regclass);


--
-- Name: restaurant_menu position_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurant_menu ALTER COLUMN position_id SET DEFAULT nextval('public.restaurant_menu_position_id_seq'::regclass);


--
-- Name: restaurant_menu restaurant_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurant_menu ALTER COLUMN restaurant_id SET DEFAULT nextval('public.restaurant_menu_restaurant_id_seq'::regclass);


--
-- Name: restaurant_menu food_category_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurant_menu ALTER COLUMN food_category_id SET DEFAULT nextval('public.restaurant_menu_food_category_id_seq'::regclass);


--
-- Name: restaurants restaurant_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN restaurant_id SET DEFAULT nextval('public.restaurants_restaurant_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: users level_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.users ALTER COLUMN level_id SET DEFAULT nextval('public.users_level_id_seq'::regclass);


--
-- Name: users job_id; Type: DEFAULT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.users ALTER COLUMN job_id SET DEFAULT nextval('public.users_job_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.categories (category_id, category_name, category_path) FROM stdin;
\.


--
-- Data for Name: compositions; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.compositions (composition_id, position_id, ingredient_id) FROM stdin;
\.


--
-- Data for Name: food_categories; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.food_categories (category_id, category_name) FROM stdin;
1	Популярное
2	Бургеры и Роллы
3	Картофель, стартеры и салаты
4	Кафе
5	Напитки
6	Завтрак
7	Десерты
8	Соусы
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.ingredients (ingredient_id, ingredient_name) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.jobs (job_id, job_name, job_description, job_salary, score_step) FROM stdin;
1	Безработный	Безработный	0	0
3	Лесоруб	Руби деревья	100	5
4	Шахтер	Копай руду	100	5
5	Дальнобойщик	Достfвляй	500	30
6	Каменотес	Обрабатывай камень	150	10
7	Лесопилка	Обрабатывай дерево	150	10
8	Плавильня	Плавь металл	200	15
10	Стройка	Строй здания	1000	50
9	Металлозавод	Обрабытывай металл	400	20
2	Дворник	Мети дворы	5	1
\.


--
-- Data for Name: jobs_levels; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.jobs_levels (id, level_id, job_id) FROM stdin;
1	1	2
2	2	3
3	3	4
4	4	5
5	5	6
6	6	7
7	7	8
8	8	9
9	9	10
\.


--
-- Data for Name: levels; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.levels (level_id, level_number, next_level_entry_score) FROM stdin;
1	1	50
2	2	100
3	3	200
4	4	300
5	5	400
6	6	500
7	7	600
8	8	700
9	9	850
10	10	1000
\.


--
-- Data for Name: player_attributes; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.player_attributes (attribute_id, user_id, balance, score, food, stamina) FROM stdin;
2	1319656277	615	392	1200	100
\.


--
-- Data for Name: product_attributes; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.product_attributes (attribute_id, attribute_name, product_id, attribute_value) FROM stdin;
\.


--
-- Data for Name: product_sizes; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.product_sizes (size_id, size_name, product_id, price) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.products (product_id, product_name, category_id) FROM stdin;
\.


--
-- Data for Name: restaurant_menu; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.restaurant_menu (position_id, restaurant_id, food_category_id, position_name, position_size, position_calories, position_price) FROM stdin;
1	1	1	Биг Хит	\N	524	165
2	1	1	Гранд Де Люкс	\N	570	199
3	1	1	Биг Спешиал	\N	800	275
4	1	1	Двойной Чизбургер	\N	441	145
5	1	1	Чикен Премьер	\N	525	165
6	1	1	Наггетсы	4 шт	179	59
7	1	1	Наггетсы	6 шт	268	69
8	1	1	Наггетсы	9 шт	402	99
9	1	1	Наггетсы	18 шт	804	197
10	1	1	Пирожок Вишневый	\N	249	65
11	1	2	Барселона Бургер	\N	568	239
12	1	2	Барселона Бургер с курицей	\N	554	215
13	1	2	Биг Спешиал Ростбиф	\N	795	325
14	1	2	Биг Хит	\N	524	165
15	1	2	Двойной Биг Хит	\N	711	225
16	1	2	Гранд	\N	514	175
17	1	2	Гранд Де Люкс	\N	570	199
18	1	2	Двойной Гранд	\N	732	259
19	1	2	Двойной Биг Спешиал	\N	1098	361
20	1	2	Биг Спешиал	\N	800	275
21	1	2	Биг Спешиал Джуниор	\N	573	235
22	1	2	Двойной Чизбургер	\N	441	145
23	1	2	Чизбургер	\N	299	69
24	1	2	Гамбургер	\N	251	57
25	1	2	Чикен Премьер	\N	525	165
26	1	2	Чикен Хит	\N	484	109
27	1	2	Чикен Бургер	\N	337	59
28	1	2	Фиш Бургер	\N	331	171
29	1	2	Двойной Фиш Бургер	\N	475	235
30	1	2	Цезарь Ролл	\N	472	179
31	1	2	Шримп Ролл	\N	412	239
32	1	2	Биг Спешиал Ролл	\N	525	199
33	1	2	Пара Барселона Бургер	\N	1136	429
34	1	2	Пара Барселона Бургер с курицей	\N	1108	389
35	1	3	Сырные треугольники Чоризо	\N	232	109
36	1	3	Большой Снэк Бокс со стрипсами	\N	1537	445
37	1	3	Большой Снэк Бокс с крыльями	\N	1733	469
38	1	3	Гранд Фри	Маленький	284	65
39	1	3	Гранд Фри	Средний	383	89
40	1	3	Гранд Фри	Большой	482	105
41	1	3	Картофельные Дольки	Средние	499	103
42	1	3	Картофельные Дольки	Большие	664	131
43	1	3	Снэк Бокс	\N	535	169
44	1	3	Снэк Бокс с крыльями	\N	866	239
45	1	3	Куриные Крылышки	3 шт	417	145
46	1	3	Куриные Крылышки	5 шт	695	215
47	1	3	Куриные Крылышки	7 шт	973	289
48	1	3	Наггетсы	4 шт	179	59
49	1	3	Наггетсы	6 шт	268	69
50	1	3	Наггетсы	9 шт	402	99
51	1	3	Наггетсы	18 шт	804	197
52	1	3	Стрипсы	3 шт	270	115
53	1	3	Стрипсы	5 шт	450	189
54	1	3	Стрипсы	7 шт	630	249
55	1	3	Большие Креветки	4 шт	180	189
56	1	3	Большие Креветки	6 шт	271	259
57	1	3	Большие Креветки	9 шт	406	365
58	1	3	Салат цезарь	\N	231	179
59	1	3	Салат Цезарь с креветками	\N	186	249
60	1	3	Овощной салат	\N	31	109
61	1	3	Морковные палочки	\N	28	71
62	1	3	Яблочные дольки	\N	38	71
63	1	4	Розан с ванильным кремом	\N	334	119
64	1	4	Морковный торт	\N	567	185
65	1	4	Лимонный тарт	\N	432	175
66	1	4	Творожник	\N	197	79
67	1	4	Торт Шоколадный	\N	449	175
68	1	4	Клубничный Чизкейк	\N	291	175
69	1	4	Тирамису	\N	260	165
70	1	4	Торт Миндальный	\N	347	175
71	1	4	Чизкейк Классический	\N	425	175
72	1	4	Торт Рикотта с грушей	\N	335	175
73	1	4	Макарони	\N	84	75
74	1	4	Печенье Клюква-кокос	\N	368	79
75	1	4	Печенье Шоколадное с кусочками шоколада	\N	324	79
76	1	4	Чиабатта с тунцом	\N	371	185
77	1	4	Чиабатта с ветчиной и сыром	\N	432	175
78	1	4	Круассан с ветчиной и сыром	\N	306	139
79	1	4	Круассан	\N	169	99
80	1	4	Айс Кофе Карамель	\N	155	149
81	1	4	Айс Кофе Карамель Миндальный	\N	106	209
82	1	4	Айс Кофе Карамель Кокосовый	\N	114	209
83	1	4	Апельсиновый Раф	\N	326	189
84	1	4	Миндальный Капучино	Маленький	31	129
85	1	4	Миндальный Капучино	Средний	44	169
86	1	4	Миндальный Капучино	Средний	57	189
87	1	4	Кокосовый Капучино	Маленький	42	129
88	1	4	Кокосовый Капучино	Средний	59	169
89	1	4	Кокосовый Капучино	Большой	76	189
90	1	4	Капучино	Маленький	70	69
91	1	4	Капучино	Средний	110	109
92	1	4	Капучино	Большой	130	129
93	1	4	Миндальный Латте	Средний	50	169
94	1	4	Миндальный Латте	Большой	54	189
95	1	4	Кокосовый Латте	Средний	67	169
96	1	4	Кокосовый Латте	Большой	72	189
97	1	4	Латте	Средний	120	109
98	1	4	Латте	Большой	130	129
99	1	4	Миндальный Флэт Уайт	Средний	44	215
100	1	4	Миндальный Флэт Уайт	Большой	63	270
101	1	4	Кокосовый Флэт Уайт	Средний	59	215
102	1	4	Кокосовый Флэт Уайт	Большой	84	270
103	1	4	Флэт Уайт	Средний	113	155
104	1	4	Флэт Уайт	Большой	156	210
105	1	4	Миндальный Пряный Чай Латте	\N	135	215
106	1	4	Кокосовый Пряный Чай Латте	\N	156	215
107	1	4	Пряный Чай Латте	\N	229	155
108	1	4	Американо	Маленький	7	59
109	1	4	Американо	Средний	10	85
110	1	4	Американо	Большой	14	99
111	1	4	Венский кофе	Средний	174	155
112	1	4	Венский кофе	Большой	177	210
113	1	4	Горячий Шоколад	\N	319	185
114	1	4	Раф	Средний	285	155
115	1	4	Раф	Большой	316	210
116	1	4	Чай черный Эрл Грей	\N	40	99
117	1	4	Чай Черный с чабрецом	\N	40	99
118	1	4	Чай Хуго Коктейль	\N	40	99
119	1	4	Двойной Эспрессо	\N	2	69
120	1	4	Артезианская вода Белоголовка негазированная 0,4 л. - артезианская вода без газа	\N	50	99
\.


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.restaurants (restaurant_id, restaurant_name) FROM stdin;
1	Бургер и запятая
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: bobik
--

COPY public.users (user_id, first_name, last_name, user_name, level_id, job_id, gender, skin_color) FROM stdin;
123456	sadas	sadas	asdas	3	3	Женский	Белый
1319656277	Иван	Каринский	Иван	5	2	Мужской	Белый
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);


--
-- Name: compositions_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.compositions_composition_id_seq', 1, false);


--
-- Name: compositions_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.compositions_ingredient_id_seq', 1, false);


--
-- Name: compositions_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.compositions_position_id_seq', 1, false);


--
-- Name: food_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.food_categories_category_id_seq', 1, false);


--
-- Name: ingredients_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.ingredients_ingredient_id_seq', 1, false);


--
-- Name: jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.jobs_job_id_seq', 1, false);


--
-- Name: jobs_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.jobs_levels_id_seq', 2, true);


--
-- Name: jobs_levels_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.jobs_levels_job_id_seq', 1, false);


--
-- Name: jobs_levels_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.jobs_levels_level_id_seq', 1, false);


--
-- Name: levels_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.levels_level_id_seq', 1, false);


--
-- Name: player_attributes_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.player_attributes_attribute_id_seq', 2, true);


--
-- Name: player_attributes_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.player_attributes_user_id_seq', 1, false);


--
-- Name: product_attributes_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.product_attributes_attribute_id_seq', 1, false);


--
-- Name: product_attributes_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.product_attributes_product_id_seq', 1, false);


--
-- Name: product_sizes_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.product_sizes_product_id_seq', 1, false);


--
-- Name: product_sizes_size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.product_sizes_size_id_seq', 1, false);


--
-- Name: products_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.products_category_id_seq', 2, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.products_product_id_seq', 5, true);


--
-- Name: restaurant_menu_food_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.restaurant_menu_food_category_id_seq', 1, false);


--
-- Name: restaurant_menu_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.restaurant_menu_position_id_seq', 1, false);


--
-- Name: restaurant_menu_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.restaurant_menu_restaurant_id_seq', 1, false);


--
-- Name: restaurants_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.restaurants_restaurant_id_seq', 1, false);


--
-- Name: users_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.users_job_id_seq', 1, false);


--
-- Name: users_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.users_level_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bobik
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: compositions compositions_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.compositions
    ADD CONSTRAINT compositions_pkey PRIMARY KEY (composition_id);


--
-- Name: food_categories food_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.food_categories
    ADD CONSTRAINT food_categories_pkey PRIMARY KEY (category_id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (ingredient_id);


--
-- Name: jobs_levels jobs_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs_levels
    ADD CONSTRAINT jobs_levels_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);


--
-- Name: levels levels_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.levels
    ADD CONSTRAINT levels_pkey PRIMARY KEY (level_id);


--
-- Name: player_attributes player_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.player_attributes
    ADD CONSTRAINT player_attributes_pkey PRIMARY KEY (attribute_id);


--
-- Name: product_attributes product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_pkey PRIMARY KEY (attribute_id);


--
-- Name: product_sizes product_sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_sizes_pkey PRIMARY KEY (size_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: restaurant_menu restaurant_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurant_menu
    ADD CONSTRAINT restaurant_menu_pkey PRIMARY KEY (position_id);


--
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (restaurant_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: compositions compositions_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.compositions
    ADD CONSTRAINT compositions_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(ingredient_id) ON DELETE CASCADE;


--
-- Name: compositions compositions_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.compositions
    ADD CONSTRAINT compositions_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.restaurant_menu(position_id) ON DELETE CASCADE;


--
-- Name: jobs_levels jobs_levels_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs_levels
    ADD CONSTRAINT jobs_levels_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id) ON DELETE CASCADE;


--
-- Name: jobs_levels jobs_levels_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.jobs_levels
    ADD CONSTRAINT jobs_levels_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.levels(level_id) ON DELETE CASCADE;


--
-- Name: player_attributes player_attributes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.player_attributes
    ADD CONSTRAINT player_attributes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: product_attributes product_attributes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: product_sizes product_sizes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_sizes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE SET NULL;


--
-- Name: restaurant_menu restaurant_menu_food_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurant_menu
    ADD CONSTRAINT restaurant_menu_food_category_id_fkey FOREIGN KEY (food_category_id) REFERENCES public.food_categories(category_id) ON DELETE SET NULL;


--
-- Name: restaurant_menu restaurant_menu_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.restaurant_menu
    ADD CONSTRAINT restaurant_menu_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(restaurant_id) ON DELETE CASCADE;


--
-- Name: users users_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id) ON DELETE CASCADE;


--
-- Name: users users_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bobik
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.levels(level_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

