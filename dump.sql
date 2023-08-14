-- Active: 1691916540923@@127.0.0.1@5432@bobikdb
-- PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE categories (
  category_id BIGSERIAL PRIMARY key, 
  category_name VARCHAR(255), 
  category_path VARCHAR(255)
);
CREATE TABLE products (
  product_id BIGSERIAL PRIMARY key, 
  product_name VARCHAR(255), 
  category_id BIGSERIAL REFERENCES categories (category_id) ON DELETE 
  SET 
    NULL
);
CREATE TABLE product_attributes (
  attribute_id BIGSERIAL PRIMARY KEY, 
  attribute_name VARCHAR(255), 
  product_id BIGSERIAL REFERENCES products (product_id) ON DELETE CASCADE, 
  attribute_value VARCHAR(255)
);
CREATE TABLE product_sizes (
  size_id BIGSERIAL PRIMARY KEY, 
  size_name VARCHAR(255), 
  product_id BIGSERIAL REFERENCES products (product_id) ON DELETE CASCADE, 
  price INTEGER
);
CREATE TABLE restaurants (
  restaurant_id BIGSERIAL PRIMARY KEY, 
  restaurant_name VARCHAR(255)
);
INSERT INTO restaurants VALUES(1,'Бургер и запятая');
CREATE TABLE food_categories(
  category_id BIGSERIAL PRIMARY KEY, 
  category_name VARCHAR(255)
);
INSERT INTO food_categories VALUES(1,'Популярное');
INSERT INTO food_categories VALUES(2,'Бургеры и Роллы');
INSERT INTO food_categories VALUES(3,'Картофель, стартеры и салаты');
INSERT INTO food_categories VALUES(4,'Кафе');
INSERT INTO food_categories VALUES(5,'Напитки');
INSERT INTO food_categories VALUES(6,'Завтрак');
INSERT INTO food_categories VALUES(7,'Десерты');
INSERT INTO food_categories VALUES(8,'Соусы');
CREATE TABLE restaurant_menu (
  position_id BIGSERIAL PRIMARY KEY, 
  restaurant_id BIGSERIAL REFERENCES restaurants (restaurant_id) ON DELETE CASCADE, 
  food_category_id BIGSERIAL REFERENCES food_categories (category_id) ON DELETE 
  SET 
    NULL, 
    position_name VARCHAR(255), 
    position_size VARCHAR(255), 
    position_calories INTEGER, 
    position_price INTEGER
);
INSERT INTO restaurant_menu VALUES(1,1,1,'Биг Хит',NULL,524,165);
INSERT INTO restaurant_menu VALUES(2,1,1,'Гранд Де Люкс',NULL,570,199);
INSERT INTO restaurant_menu VALUES(3,1,1,'Биг Спешиал',NULL,800,275);
INSERT INTO restaurant_menu VALUES(4,1,1,'Двойной Чизбургер',NULL,441,145);
INSERT INTO restaurant_menu VALUES(5,1,1,'Чикен Премьер',NULL,525,165);
INSERT INTO restaurant_menu VALUES(6,1,1,'Наггетсы','4 шт',179,59);
INSERT INTO restaurant_menu VALUES(7,1,1,'Наггетсы','6 шт',268,69);
INSERT INTO restaurant_menu VALUES(8,1,1,'Наггетсы','9 шт',402,99);
INSERT INTO restaurant_menu VALUES(9,1,1,'Наггетсы','18 шт',804,197);
INSERT INTO restaurant_menu VALUES(10,1,1,'Пирожок Вишневый',NULL,249,65);
INSERT INTO restaurant_menu VALUES(11,1,2,'Барселона Бургер',NULL,568,239);
INSERT INTO restaurant_menu VALUES(12,1,2,'Барселона Бургер с курицей',NULL,554,215);
INSERT INTO restaurant_menu VALUES(13,1,2,'Биг Спешиал Ростбиф',NULL,795,325);
INSERT INTO restaurant_menu VALUES(14,1,2,'Биг Хит',NULL,524,165);
INSERT INTO restaurant_menu VALUES(15,1,2,'Двойной Биг Хит',NULL,711,225);
INSERT INTO restaurant_menu VALUES(16,1,2,'Гранд',NULL,514,175);
INSERT INTO restaurant_menu VALUES(17,1,2,'Гранд Де Люкс',NULL,570,199);
INSERT INTO restaurant_menu VALUES(18,1,2,'Двойной Гранд',NULL,732,259);
INSERT INTO restaurant_menu VALUES(19,1,2,'Двойной Биг Спешиал',NULL,1098,361);
INSERT INTO restaurant_menu VALUES(20,1,2,'Биг Спешиал',NULL,800,275);
INSERT INTO restaurant_menu VALUES(21,1,2,'Биг Спешиал Джуниор',NULL,573,235);
INSERT INTO restaurant_menu VALUES(22,1,2,'Двойной Чизбургер',NULL,441,145);
INSERT INTO restaurant_menu VALUES(23,1,2,'Чизбургер',NULL,299,69);
INSERT INTO restaurant_menu VALUES(24,1,2,'Гамбургер',NULL,251,57);
INSERT INTO restaurant_menu VALUES(25,1,2,'Чикен Премьер',NULL,525,165);
INSERT INTO restaurant_menu VALUES(26,1,2,'Чикен Хит',NULL,484,109);
INSERT INTO restaurant_menu VALUES(27,1,2,'Чикен Бургер',NULL,337,59);
INSERT INTO restaurant_menu VALUES(28,1,2,'Фиш Бургер',NULL,331,171);
INSERT INTO restaurant_menu VALUES(29,1,2,'Двойной Фиш Бургер',NULL,475,235);
INSERT INTO restaurant_menu VALUES(30,1,2,'Цезарь Ролл',NULL,472,179);
INSERT INTO restaurant_menu VALUES(31,1,2,'Шримп Ролл',NULL,412,239);
INSERT INTO restaurant_menu VALUES(32,1,2,'Биг Спешиал Ролл',NULL,525,199);
INSERT INTO restaurant_menu VALUES(33,1,2,'Пара Барселона Бургер',NULL,1136,429);
INSERT INTO restaurant_menu VALUES(34,1,2,'Пара Барселона Бургер с курицей',NULL,1108,389);
INSERT INTO restaurant_menu VALUES(35,1,3,'Сырные треугольники Чоризо',NULL,232,109);
INSERT INTO restaurant_menu VALUES(36,1,3,'Большой Снэк Бокс со стрипсами',NULL,1537,445);
INSERT INTO restaurant_menu VALUES(37,1,3,'Большой Снэк Бокс с крыльями',NULL,1733,469);
INSERT INTO restaurant_menu VALUES(38,1,3,'Гранд Фри','Маленький',284,65);
INSERT INTO restaurant_menu VALUES(39,1,3,'Гранд Фри','Средний',383,89);
INSERT INTO restaurant_menu VALUES(40,1,3,'Гранд Фри','Большой',482,105);
INSERT INTO restaurant_menu VALUES(41,1,3,'Картофельные Дольки','Средние',499,103);
INSERT INTO restaurant_menu VALUES(42,1,3,'Картофельные Дольки','Большие',664,131);
INSERT INTO restaurant_menu VALUES(43,1,3,'Снэк Бокс',NULL,535,169);
INSERT INTO restaurant_menu VALUES(44,1,3,'Снэк Бокс с крыльями',NULL,866,239);
INSERT INTO restaurant_menu VALUES(45,1,3,'Куриные Крылышки','3 шт',417,145);
INSERT INTO restaurant_menu VALUES(46,1,3,'Куриные Крылышки','5 шт',695,215);
INSERT INTO restaurant_menu VALUES(47,1,3,'Куриные Крылышки','7 шт',973,289);
INSERT INTO restaurant_menu VALUES(48,1,3,'Наггетсы','4 шт',179,59);
INSERT INTO restaurant_menu VALUES(49,1,3,'Наггетсы','6 шт',268,69);
INSERT INTO restaurant_menu VALUES(50,1,3,'Наггетсы','9 шт',402,99);
INSERT INTO restaurant_menu VALUES(51,1,3,'Наггетсы','18 шт',804,197);
INSERT INTO restaurant_menu VALUES(52,1,3,'Стрипсы','3 шт',270,115);
INSERT INTO restaurant_menu VALUES(53,1,3,'Стрипсы','5 шт',450,189);
INSERT INTO restaurant_menu VALUES(54,1,3,'Стрипсы','7 шт',630,249);
INSERT INTO restaurant_menu VALUES(55,1,3,'Большие Креветки','4 шт',180,189);
INSERT INTO restaurant_menu VALUES(56,1,3,'Большие Креветки','6 шт',271,259);
INSERT INTO restaurant_menu VALUES(57,1,3,'Большие Креветки','9 шт',406,365);
INSERT INTO restaurant_menu VALUES(58,1,3,'Салат цезарь',NULL,231,179);
INSERT INTO restaurant_menu VALUES(59,1,3,'Салат Цезарь с креветками',NULL,186,249);
INSERT INTO restaurant_menu VALUES(60,1,3,'Овощной салат',NULL,31,109);
INSERT INTO restaurant_menu VALUES(61,1,3,'Морковные палочки',NULL,28,71);
INSERT INTO restaurant_menu VALUES(62,1,3,'Яблочные дольки',NULL,38,71);
INSERT INTO restaurant_menu VALUES(63,1,4,'Розан с ванильным кремом',NULL,334,119);
INSERT INTO restaurant_menu VALUES(64,1,4,'Морковный торт',NULL,567,185);
INSERT INTO restaurant_menu VALUES(65,1,4,'Лимонный тарт',NULL,432,175);
INSERT INTO restaurant_menu VALUES(66,1,4,'Творожник',NULL,197,79);
INSERT INTO restaurant_menu VALUES(67,1,4,'Торт Шоколадный',NULL,449,175);
INSERT INTO restaurant_menu VALUES(68,1,4,'Клубничный Чизкейк',NULL,291,175);
INSERT INTO restaurant_menu VALUES(69,1,4,'Тирамису',NULL,260,165);
INSERT INTO restaurant_menu VALUES(70,1,4,'Торт Миндальный',NULL,347,175);
INSERT INTO restaurant_menu VALUES(71,1,4,'Чизкейк Классический',NULL,425,175);
INSERT INTO restaurant_menu VALUES(72,1,4,'Торт Рикотта с грушей',NULL,335,175);
INSERT INTO restaurant_menu VALUES(73,1,4,'Макарони',NULL,84,75);
INSERT INTO restaurant_menu VALUES(74,1,4,'Печенье Клюква-кокос',NULL,368,79);
INSERT INTO restaurant_menu VALUES(75,1,4,'Печенье Шоколадное с кусочками шоколада',NULL,324,79);
INSERT INTO restaurant_menu VALUES(76,1,4,'Чиабатта с тунцом',NULL,371,185);
INSERT INTO restaurant_menu VALUES(77,1,4,'Чиабатта с ветчиной и сыром',NULL,432,175);
INSERT INTO restaurant_menu VALUES(78,1,4,'Круассан с ветчиной и сыром',NULL,306,139);
INSERT INTO restaurant_menu VALUES(79,1,4,'Круассан',NULL,169,99);
INSERT INTO restaurant_menu VALUES(80,1,4,'Айс Кофе Карамель',NULL,155,149);
INSERT INTO restaurant_menu VALUES(81,1,4,'Айс Кофе Карамель Миндальный',NULL,106,209);
INSERT INTO restaurant_menu VALUES(82,1,4,'Айс Кофе Карамель Кокосовый',NULL,114,209);
INSERT INTO restaurant_menu VALUES(83,1,4,'Апельсиновый Раф',NULL,326,189);
INSERT INTO restaurant_menu VALUES(84,1,4,'Миндальный Капучино','Маленький',31,129);
INSERT INTO restaurant_menu VALUES(85,1,4,'Миндальный Капучино','Средний',44,169);
INSERT INTO restaurant_menu VALUES(86,1,4,'Миндальный Капучино','Средний',57,189);
INSERT INTO restaurant_menu VALUES(87,1,4,'Кокосовый Капучино','Маленький',42,129);
INSERT INTO restaurant_menu VALUES(88,1,4,'Кокосовый Капучино','Средний',59,169);
INSERT INTO restaurant_menu VALUES(89,1,4,'Кокосовый Капучино','Большой',76,189);
INSERT INTO restaurant_menu VALUES(90,1,4,'Капучино','Маленький',70,69);
INSERT INTO restaurant_menu VALUES(91,1,4,'Капучино','Средний',110,109);
INSERT INTO restaurant_menu VALUES(92,1,4,'Капучино','Большой',130,129);
INSERT INTO restaurant_menu VALUES(93,1,4,'Миндальный Латте','Средний',50,169);
INSERT INTO restaurant_menu VALUES(94,1,4,'Миндальный Латте','Большой',54,189);
INSERT INTO restaurant_menu VALUES(95,1,4,'Кокосовый Латте','Средний',67,169);
INSERT INTO restaurant_menu VALUES(96,1,4,'Кокосовый Латте','Большой',72,189);
INSERT INTO restaurant_menu VALUES(97,1,4,'Латте','Средний',120,109);
INSERT INTO restaurant_menu VALUES(98,1,4,'Латте','Большой',130,129);
INSERT INTO restaurant_menu VALUES(99,1,4,'Миндальный Флэт Уайт','Средний',44,215);
INSERT INTO restaurant_menu VALUES(100,1,4,'Миндальный Флэт Уайт','Большой',63,270);
INSERT INTO restaurant_menu VALUES(101,1,4,'Кокосовый Флэт Уайт','Средний',59,215);
INSERT INTO restaurant_menu VALUES(102,1,4,'Кокосовый Флэт Уайт','Большой',84,270);
INSERT INTO restaurant_menu VALUES(103,1,4,'Флэт Уайт','Средний',113,155);
INSERT INTO restaurant_menu VALUES(104,1,4,'Флэт Уайт','Большой',156,210);
INSERT INTO restaurant_menu VALUES(105,1,4,'Миндальный Пряный Чай Латте',NULL,135,215);
INSERT INTO restaurant_menu VALUES(106,1,4,'Кокосовый Пряный Чай Латте',NULL,156,215);
INSERT INTO restaurant_menu VALUES(107,1,4,'Пряный Чай Латте',NULL,229,155);
INSERT INTO restaurant_menu VALUES(108,1,4,'Американо','Маленький',7,59);
INSERT INTO restaurant_menu VALUES(109,1,4,'Американо','Средний',10,85);
INSERT INTO restaurant_menu VALUES(110,1,4,'Американо','Большой',14,99);
INSERT INTO restaurant_menu VALUES(111,1,4,'Венский кофе','Средний',174,155);
INSERT INTO restaurant_menu VALUES(112,1,4,'Венский кофе','Большой',177,210);
INSERT INTO restaurant_menu VALUES(113,1,4,'Горячий Шоколад',NULL,319,185);
INSERT INTO restaurant_menu VALUES(114,1,4,'Раф','Средний',285,155);
INSERT INTO restaurant_menu VALUES(115,1,4,'Раф','Большой',316,210);
INSERT INTO restaurant_menu VALUES(116,1,4,'Чай черный Эрл Грей',NULL,40,99);
INSERT INTO restaurant_menu VALUES(117,1,4,'Чай Черный с чабрецом',NULL,40,99);
INSERT INTO restaurant_menu VALUES(118,1,4,'Чай Хуго Коктейль',NULL,40,99);
INSERT INTO restaurant_menu VALUES(119,1,4,'Двойной Эспрессо',NULL,2,69);
INSERT INTO restaurant_menu VALUES(120,1,4,'Артезианская вода Белоголовка негазированная 0,4 л. - артезианская вода без газа',NULL,50,99);
CREATE TABLE ingredients (
  ingredient_id BIGSERIAL PRIMARY KEY, 
  ingredient_name VARCHAR(255)
);
CREATE TABLE compositions (
  composition_id BIGSERIAL PRIMARY KEY, 
  position_id BIGSERIAL REFERENCES restaurant_menu (position_id) ON DELETE CASCADE, 
  ingredient_id BIGSERIAL REFERENCES ingredients (ingredient_id) ON DELETE CASCADE
);
CREATE TABLE levels (
  level_id BIGSERIAL PRIMARY KEY, level_number INTEGER, 
  next_level_entry_score INTEGER
);
INSERT INTO levels VALUES(1,1,50);
INSERT INTO levels VALUES(2,2,100);
INSERT INTO levels VALUES(3,3,200);
INSERT INTO levels VALUES(4,4,300);
INSERT INTO levels VALUES(5,5,400);
INSERT INTO levels VALUES(6,6,500);
INSERT INTO levels VALUES(7,7,600);
INSERT INTO levels VALUES(8,8,700);
INSERT INTO levels VALUES(9,9,850);
INSERT INTO levels VALUES(10,10,1000);
CREATE TABLE jobs (
  job_id BIGSERIAL PRIMARY KEY, 
  job_name VARCHAR(255), 
  job_description VARCHAR(255), 
  job_salary INTEGER
);
INSERT INTO jobs VALUES(1,'Безработный','Безработный',0);
INSERT INTO jobs VALUES(2,'Дворник','Мети дворы',5);
INSERT INTO jobs VALUES(3,'Лесоруб','Руби деревья',25);
INSERT INTO jobs VALUES(4,'Шахтер','Копай руду',35);
INSERT INTO jobs VALUES(5,'Дальнобойщик','Достовляй',100);
INSERT INTO jobs VALUES(6,'Каменотес','Обрабатывай камень',50);
INSERT INTO jobs VALUES(7,'Лесопилка','Обрабатывай дерево',60);
INSERT INTO jobs VALUES(8,'Плавильня','Плавь металл',55);
INSERT INTO jobs VALUES(9,'Металлозавод','Обрабытывай металл',75);
INSERT INTO jobs VALUES(10,'Стройка','Строй здания',100);
INSERT INTO jobs VALUES(11,'Завод автозапчастей','Делай автозапчасти',150);
CREATE TABLE jobs_levels (
  id BIGSERIAL PRIMARY KEY, 
  level_id BIGSERIAL REFERENCES levels (level_id) ON DELETE CASCADE, 
  job_id BIGSERIAL REFERENCES jobs (job_id) ON DELETE CASCADE
);
INSERT INTO jobs_levels VALUES(1,1,2);
INSERT INTO jobs_levels VALUES(2,2,3);
INSERT INTO jobs_levels VALUES(3,3,4);
INSERT INTO jobs_levels VALUES(4,4,5);
INSERT INTO jobs_levels VALUES(5,5,6);
INSERT INTO jobs_levels VALUES(6,6,7);
INSERT INTO jobs_levels VALUES(7,7,8);
INSERT INTO jobs_levels VALUES(8,8,9);
INSERT INTO jobs_levels VALUES(9,9,10);
INSERT INTO jobs_levels VALUES(10,10,11);
CREATE TABLE users (
  user_id BIGSERIAL PRIMARY KEY, 
  first_name text NOT NULL, 
  last_name TEXT, 
  user_name TEXT, 
  level_id BIGSERIAL REFERENCES levels (level_id) ON DELETE CASCADE, 
  job_id BIGSERIAL REFERENCES jobs (job_id) ON DELETE CASCADE,
  gender VARCHAR(255), skin_color VARCHAR(255));
INSERT INTO users VALUES(1319656277,'Иван','Каринский','Иван',3,1,'Мужской','Белый');
INSERT INTO users VALUES(123456,'sadas','sadas','asdas',3,3,'Женский','Белый');
CREATE TABLE player_attributes (
  attribute_id BIGSERIAL PRIMARY KEY,
  user_id BIGSERIAL REFERENCES users (user_id) ON DELETE CASCADE,
  balance INTEGER DEFAULT 0,
  score INTEGER DEFAULT 0,
  food INTEGER DEFAULT 2100,
  stamina INTEGER DEFAULT 100
);
INSERT INTO player_attributes VALUES(1,1319656277,0,0,2100,100);
-- ALTER TABLE users alter COLUMN user_id 
COMMIT;

-- DROP TABLE users CASCADE;
