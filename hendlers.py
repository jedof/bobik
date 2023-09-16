import config

from aiogram import Router, F
from helpers.keyboard_helpers import show_main_menu
from helpers.db import increment_balance, update_user_job, get_restaurants_kb
from helpers.keyboard_helpers import get_job_kb, send_jobs


router = Router()


@router.callback_query(F.data == " ")
async def cleaner_callback(call):
    await call.answer("Ты промазал")


@router.callback_query(F.data.startswith("special"))
async def cleaner_true_callback(call):
    await call.answer()
    job = call.data.split()[-1]
    balance = await increment_balance(call.from_user.id)
    print("!!!!!", balance)
    message, job_kb = await get_job_kb(call.from_user.id, job)
    await call.message.edit_text(message, reply_markup=job_kb)


@router.callback_query(F.data in config.jobs_callback)
async def jobs_callback_handler(call):
    await call.answer()
    await update_user_job(call.from_user.id, call.data)
    message, job_kb = await get_job_kb(call.from_user.id, call.data)
    print("!!!!!!!", job_kb, message)
    await call.message.answer(message, reply_markup=job_kb)


@router.callback_query(F.data in ("left", "right"))
async def lumberjack_job(call):
    is_lumber_on_left = False
    first_layer = call.message.text[-14:]
    second_layer = call.message.text[-27:-14]
    if first_layer[5] == "-":
        is_lumber_on_left = True
    print(is_lumber_on_left)
    print(call.message.text[-27:])


@router.message_handler(commands=["deluser"])
async def deluser_command(message):
    global con, cur, state
    deleteusersql = f"delete from users where user_id = {message.from_user.id}"
    cur.execute(deleteusersql)
    con.commit()
    state = None

@router.message_handler(commands=["start"])
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
        await message.answer("Какого ты пола", reply_markup=config.gender_keyboard)
    elif not user_info[2]:
        state = "skin_color"
        await message.answer("выбери цвет кожи", reply_markup=config.skincolor_keyboard)
    else:
        await show_main_menu(message)


@router.message_handler()
async def message_handler(message):
    global con, cur, state
    if state == "nick":
        sql = f"update users set user_name = '{message.text}' where user_id = {message.from_user.id}"
        name = cur.execute(sql)
        con.commit()
        await message.answer("Какого ты пола", reply_markup=config.gender_keyboard)
        state = "gender"
    elif state == "gender":
        sql = f"update users set gender = '{message.text}' where user_id = {message.from_user.id}"
        gender = cur.execute(sql)
        con.commit()
        await message.answer("выбери цвет кожи", reply_markup=config.skincolor_keyboard)
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
                
