import config

from aiogram import Router, F, types
from aiogram.filters import Command
from helpers.db import (
    level_up, increment_balance, update_user_job,
    increment_score, deincrement_score, con, cur
)
from helpers.keyboard_helpers import (
    get_job_kb, send_jobs, get_restaurants_kb, 
    get_food_shop_kb, show_main_menu, get_shops_kb
)
from helpers.callback_factories import LumberjackJobCallbackFactory, JobsCallbackFactory, RestrantsCallbackFactory


router = Router()

@router.callback_query(F.data == "дворник")
async def cleaner_callback(call):
    await call.answer("Ты промазал")
    await deincrement_score(call.from_user.id)
    message, job_kb = await get_job_kb(call.from_user.id, "дворник")
    await call.message.edit_text(message, reply_markup=job_kb)


@router.callback_query(F.data.startswith("special"))
async def cleaner_true_callback(call):
    await call.answer()
    job = call.data.split()[-1]
    await increment_balance(call.from_user.id)
    await increment_score(call.from_user.id)
    message, job_kb = await get_job_kb(call.from_user.id, job)
    await call.message.edit_text(message, reply_markup=job_kb)
    msg, level = await level_up(call.from_user.id)
    if level:
        await call.message.answer(msg)
        await show_main_menu(call.message)


@router.callback_query(RestrantsCallbackFactory.filter())
async def select_restaurant(
    call: types.CallbackQuery,
    callback_data: RestrantsCallbackFactory
):
    await call.answer()
    print(callback_data)


@router.callback_query(JobsCallbackFactory.filter())
async def jobs_callback_handler(
    call: types.CallbackQuery,
    callback_data: JobsCallbackFactory
):
    await call.answer()
    await update_user_job(call.from_user.id, callback_data.job)
    message, job_kb = await get_job_kb(call.from_user.id, callback_data.job)
    await call.message.answer(message, reply_markup=job_kb)


@router.callback_query(LumberjackJobCallbackFactory.filter())
async def lumberjack_job(
        callback: types.CallbackQuery, 
        callback_data: LumberjackJobCallbackFactory
    ):
    is_lumber_on_left = False
    first_layer = callback.message.text[-13:]
    second_layer = callback.message.text[-27:-14]
    if first_layer[5] == "-":
        is_lumber_on_left = True
    print(callback_data.action)
    print(is_lumber_on_left)
    print(callback.message.text[-27:])
    print("first", first_layer)
    print("first", first_layer[6])
    print("first", first_layer[5])
    print("second", second_layer)


@router.message(Command("deluser"))
async def deluser_command(message):
    global con, cur, state
    deleteusersql = f"delete from users where user_id = {message.from_user.id}"
    cur.execute(deleteusersql)
    con.commit()
    state = None

@router.message(Command("start"))
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
        sql = f"insert into player_attributes (user_id, balance, score, food, stamina) \
                values ({message.from_user.id}, 0, 0, 1200, 100)"
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
        state = "main_menu"
        await show_main_menu(message)


@router.message()
async def all_messages(message):
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
        state = "main_menu"
    elif state == "main_menu":
        cur.execute(f"SELECT u.user_name, j.job_name, j.job_salary, pa.balance, pa.score, l.level_number from users u LEFT JOIN jobs j ON j.job_id = u.job_id LEFT JOIN levels l ON l.level_id = u.level_id left join player_attributes pa on pa.user_id = u.user_id WHERE u.user_id = {message.from_user.id};")
        usersql = cur.fetchone()
        if message.text == "Профиль":
            await message.answer("<b>Твой профиль</b>\n\n"
                                 f"<b>Имя:</b> <i>{usersql[0]}</i>\n"
                                 f"<b>Паспорт:</b> <i>{message.from_user.id}</i>\n"
                                 f"<b>Работа:</b> <i>{usersql[1]}</i>\n"
                                 f"<b>Зарплата:</b> <i>{usersql[2]}</i>\n"
                                 f"<b>Баланс:</b> <i>{usersql[3]}</i>\n"
                                 f"<b>Опыт:</b> <i>{usersql[4]}</i>\n"
                                 f"<b>Уровень:</b> <i>{usersql[5]}</i>\n"
                                 "<b>Доход:</b>\n")
        elif message.text == "Работы":
            await send_jobs(message)
        elif message.text == "Магазин":
            kb = await get_shops_kb()
            await message.answer("<b>Магазин</b>", reply_markup=kb)
            state = "choice"
    elif state == "choice":
        if message.text == ("Продуктовый магазин"):
            food_shop_kb = await get_food_shop_kb()
            await message.answer("<b>Выбери продукт</b>", reply_markup=food_shop_kb)
            # TODO: заполнить таблицу products и написать функцию для получения продуктов и генерации клавиатуры с выбором продуктов   
        elif message.text == ("Ресторан"):
            restaurants_kb = await get_restaurants_kb()
            await message.answer("<b>Выбери ресторан</b>", reply_markup=restaurants_kb)
        elif message.text == ("Назад"):
            await show_main_menu(message)
            state = "main_menu"
