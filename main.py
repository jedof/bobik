import os
import logging
import psycopg2
import random

# from exceptions import MissingEnvVaribleError
# psql -h localhost -d bobikdb -U bobik -p 5432
from dotenv import load_dotenv
from aiogram import Bot, Dispatcher
from aiogram.types import ParseMode, ReplyKeyboardMarkup, KeyboardButton, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.contrib.middlewares.logging import LoggingMiddleware

load_dotenv()
TGTOKEN = os.getenv('TGTOKEN')
DATABASE = os.getenv('DATABASE')
USERDB = os.getenv('USERDB')
PASSWORD = os.getenv('PASSWORD')
PORT = os.getenv('PORT')
HOST = os.getenv('HOST')
logging.basicConfig(level=logging.INFO)
# if not TGTOKEN:
    # raise MissingEnvVaribleError('не указана переменная окружения')
bot = Bot(token=TGTOKEN, parse_mode=ParseMode.HTML)
dp = Dispatcher(bot)
dp.middleware.setup(LoggingMiddleware())

gender_keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
male = KeyboardButton("Мужской")
female = KeyboardButton("Женский")
gender_keyboard.add(male)
gender_keyboard.add(female)
skincolor_keyboard = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
skincolor_keyboard.add(KeyboardButton( "Белый"))
skincolor_keyboard.add(KeyboardButton("Черный"))
main_menu = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=False)
main_menu.row(KeyboardButton("Профиль"), KeyboardButton("Работы"))
main_menu.add(KeyboardButton("Магазин"))
state = None
jobs_callback = []


async def get_restaurant_food_categories_kb(restaurant_name):
    global cur
    sql = "SELECT DISTINCT fc.category_name"\
          "FROM restaurant_menu rm"\
          "LEFT JOIN food_categories fc ON rm.food_category_id = fc.category_id"\
          "LEFT JOIN restaurants r ON rm.restaurant_id = r.restaurant_id"\
          f"WHERE r.restaurant_name = {restaurant_name};"
    cur.execute(sql)
    restaurants = cur.fetchall()


async def get_restaurants_kb():
    global cur
    restaurants = cur.execute("select restaurant_name from restaurants")
    restaurants = cur.fetchall()
    restaurants_kb = ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)
    for restaurant in restaurants:
        restaurants_kb.add(KeyboardButton(restaurant[0]))
    restaurants_kb.add(KeyboardButton("Назад"))
    return restaurants_kb
    

async def generate_jobbuttons(jobs: list[tuple[str, int]], level: int):
    global jobs_callback
    jobs_kb = InlineKeyboardMarkup()
    for job in jobs:
        if job[1] <= level:
            jobs_kb.add(InlineKeyboardButton(text=job[0], callback_data=job[0]))
            jobs_callback.append(job[0])
        else:
            break
    return jobs_kb


async def get_user_info(user_id: int) -> str | None:
    sql = "SELECT u.user_id,"\
                "u.user_name,"\
                "u.first_name,"\
                "u.last_name,"\
                "u.gender,"\
                "u.skin_color,"\
                "l.level_id,"\
                "l.level_number,"\
                "l.next_level_entry_score,"\
                "j.job_id,"\
                "j.job_name,"\
                "j.job_salary,"\
                "j.job_description,"\
                "pa.balance,"\
                "pa.food,"\
                "pa.score,"\
                "pa.stamina "\
        "FROM users u "\
        "LEFT JOIN levels l ON u.level_id = l.level_id "\
        "LEFT JOIN jobs j ON u.job_id = j.job_id "\
        "LEFT JOIN player_attributes pa ON u.user_id = pa.user_id "\
        f"WHERE u.user_id = {user_id};"
    cur.execute(sql)
    user_info = cur.fetchone()
    return user_info if user_info else None


async def show_main_menu(message) -> bool:
    global state
    state = "main_menu"
    nicksql = await get_user_info(message.from_user.id)
    if not nicksql:
        return False
    await message.answer(f"Добро пожаловоть в меню {nicksql[1]}", reply_markup=main_menu)
    return True
    

async def get_jobs(user_id):
    cur.execute(f"select l.level_number from users u left join levels l on u.level_id = l.level_id where user_id = {user_id}")
    levelnum = cur.fetchone()
    available_jobs = cur.execute(f"SELECT j.job_name, l.level_number from jobs_levels jl LEFT JOIN jobs j on j.job_id = jl.job_id left join levels l on jl.level_id = l.level_id;")
    available_jobs = cur.fetchall()
    jobs_kb = None
    if available_jobs[0][1] <= levelnum[0]:
        jobs_kb = await generate_jobbuttons(jobs=available_jobs, level=levelnum[0])
    msg = f"<b>Выбери работу:</b>\n<b><i>Твой уровень: {levelnum[0]}</i></b>\n\n"
    for job in available_jobs:
        if job[1] <= levelnum[0]:
            msg += f"<b>{job[0]}</b> <i>- доступно с {job[1]} уровня</i>\n"
        else:
            msg += f"<b>{job[0]}</b> <i>- доступно с {job[1]} уровня (недоступно)</i>\n"
    return msg, jobs_kb


async def send_jobs(message):
    msg, jobs_kb = await get_jobs(message.from_user.id)
    await message.answer(msg, reply_markup=jobs_kb)


async def get_job_by_jobname(job: str):
    job_sql = f"select job_name, job_description, job_salary from jobs where job_name = '{job}'"
    cur.execute(job_sql)
    job = cur.fetchone()
    return job


async def get_job_info_message(job: tuple):
    msg = f"Название: {job[0]}\nОписание: {job[1]}\nЗарплата: {job[2]}"
    return msg


async def get_job_kb(job_name: str):
    job_kb = []
    if job_name == "Дворник":
        row = random.randint(0, 3)
        column = random.randint(0, 4)
        job_kb = InlineKeyboardMarkup(row_width=5)
        for i in range(4):
            for j in range(5):
                text = " "
                call_back = " "
                if row == i and column == j:
                    text = "1"
                    call_back = "special"
                job_kb.insert(InlineKeyboardButton(text, callback_data=call_back))
        return job_kb
    elif job_name == "Лесоруб":
        job_kb.append(InlineKeyboardButton("⬅", "left"))
        job_kb.append(InlineKeyboardButton("➡", "right"))
    job_kb = InlineKeyboardMarkup(inline_keyboard=job_kb)
    return job_kb


async def get_tree_for_lumberjack_job():
#     |/
#    \|
#     |/
    tree = []
    for i in range(10):
        side = random.randint(0, 2)
        if side == 0:
            tree.append("*     |     *")
        elif side == 1: 
            tree.append("*    \|     *")
        elif side == 2: 
            tree.append("*     |/    *")
    return tree


@dp.callback_query_handler(lambda call: call.data == " ")
async def cleaner_callback(call):
    await call.answer("Ты промазал")


@dp.callback_query_handler(lambda call: call.data == "special")
async def cleaner_true_callback(call):
    await call.answer()


@dp.callback_query_handler(lambda call: call.data in jobs_callback)
async def jobs_callback_handler(call):
    await call.answer()
    user_info = await get_user_info(call.from_user.id)
    msg = f"<b>Ты устроился на работу</b>"
    job_kb = await get_job_kb(call.data)
    if call.data == "Дворник":
        await call.message.answer(f"{msg} \n\n{user_info}", reply_markup=job_kb)    
    elif call.data == "Лесоруб":
        tree = await get_tree_for_lumberjack_job()
        await call.message.answer(f"{tree[0]}\n"
                                  f"{tree[1]}\n"
                                  f"{tree[3]}\n"
                                  f"{tree[4]}\n"
                                  f"{tree[5]}\n"
                                  f"{tree[6]}\n"
                                  f"{tree[7]}\n"
                                  f"{tree[8]}\n"
                                  f"{tree[9]}\n")
    


@dp.message_handler(commands=["deluser"])
async def deluser_command(message):
    global con, cur, state
    deleteusersql = f"delete from users where user_id = {message.from_user.id}"
    cur.execute(deleteusersql)
    con.commit()
    state = None

@dp.message_handler(commands=["start"])
async def start_command(message):
    global con, cur, state
    state = None
    cur.execute(f"select user_name, gender, skin_color from users where user_id = {message.from_user.id}")
    user_info = cur.fetchone()
    print(user_info)
    if not user_info:
        sql = f"insert into \
                users (user_id, first_name, last_name, user_name, level_id, job_id) \
                values (\
                {message.from_user.id}, '{message.from_user.first_name}', '{message.from_user.last_name}', \
                NULL, (select level_id from levels where level_number = 1), (select job_id from jobs where job_name = 'Безработный'))"
        cur.execute(sql)
        con.commit()
        state = "nick"
        await message.answer("Напиши свое имя")
        return
    if not user_info[0]:
        state = "nick"
        await message.answer("Напиши свое имя")
    elif not user_info[1]:
        state = "gender"
        await message.answer("Какого ты пола", reply_markup=gender_keyboard)
    elif not user_info[2]:
        state = "skin_color"
        await message.answer("выбери цвет кожи", reply_markup=skincolor_keyboard)
    else:
        await show_main_menu(message)


@dp.message_handler()
async def message_handler(message):
    global con, cur, state
    if state == "nick":
        sql = f"update users set user_name = '{message.text}' where user_id = {message.from_user.id}"
        name = cur.execute(sql)
        con.commit()
        await message.answer("Какого ты пола", reply_markup=gender_keyboard)
        state = "gender"
    elif state == "gender":
        sql = f"update users set gender = '{message.text}' where user_id = {message.from_user.id}"
        gender = cur.execute(sql)
        con.commit()
        await message.answer("выбери цвет кожи", reply_markup=skincolor_keyboard)
        state = "skin_color"
    elif state == "skin_color":
        sql = f"update users set skin_color = '{message.text}' where user_id = {message.from_user.id}"
        cur.execute(sql)
        con.commit()
        await show_main_menu(message)
    elif state == "main_menu":
        cur.execute(f"SELECT u.user_name, j.job_name, j.job_salary, pa.balance, l.level_number from users u LEFT JOIN jobs j ON j.job_id = u.job_id LEFT JOIN levels l ON l.level_id = u.level_id left join player_attributes pa on pa.user_id = u.user_id WHERE u.user_id = {message.from_user.id};")
        usersql = cur.fetchone()
        if message.text == "Профиль":
            await message.answer("<b>Твой профиль</b>\n\n"
                                 f"<b>Имя:</b> <i>{usersql[0]}</i>\n"
                                 f"<b>Паспорт:</b> <i>{message.from_user.id}</i>\n"
                                 f"<b>Работа:</b> <i>{usersql[1]}</i>\n"
                                 f"<b>Зарплата:</b> <i>{usersql[2]}</i>\n"
                                 f"<b>Баланс:</b> <i>{usersql[3]}</i>\n"
                                 f"<b>Уровень:</b> <i>{usersql[4]}</i>\n"
                                 "<b>Доход:</b>\n")
        elif message.text == "Работы":
            await send_jobs(message)
        elif message.text == "Магазин":
            restaurants_kb = await get_restaurants_kb()
            await message.answer("<b>Выбери магазин</b>", reply_markup=restaurants_kb)
            state = "restaurants"
        elif message.text == ("Назад"):
            await show_main_menu(message)
    elif state == "restaurants":
        if message.text == ("Назад"):
            await show_main_menu(message)
                

if __name__ == '__main__':
    from aiogram import executor
    print(DATABASE)
    print(USERDB)
    print(PASSWORD)
    print(PORT)
    print(HOST)
    con=psycopg2.connect(database=DATABASE,
                         user=USERDB,
                         password=PASSWORD,
                         port=PORT,
                         host=HOST)
    cur = con.cursor()
    executor.start_polling(dp)
    
