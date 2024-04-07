from aiogram import types, Router
from aiogram.filters import Command
from routers.start_router import start_router_db as srd
from db.session import get_db_session
from config import settings
from helpers.keyboard_helpers import show_main_menu


router = Router()

@router.message(Command("start"))
async def start_command(message):
    global state
    state = None
    async with get_db_session() as session:
        user_info = await srd.db_get_user_data(session, message.from_user.id)
        print(user_info)
        if not user_info:
            await srd.db_add_user(session, message)
            await srd.db_add_player_attributes(session, message)
            await session.commit()
            state = "nick"
            await message.answer("Напиши свое имя")
            return
        if not user_info[0]:
            state = "nick"
            await message.answer("Напиши свое имя")
        elif not user_info[1]:
            state = "gender"
            await message.answer("Какого ты пола", reply_markup=settings.gender_keyboard)
        elif not user_info[2]:
            state = "skin_color"
            await message.answer("выбери цвет кожи", reply_markup=settings.skincolor_keyboard)
        else:
            state = "main_menu"
            await show_main_menu(session, message)


@router.message()
async def all_messages(message):
    global con, cur, state
    if state == "nick":
        await srd.db_update(session, message)
        await message.answer("Какого ты пола", reply_markup=settings.gender_keyboard)
        state = "gender"
    elif state == "gender":
        sql = f"update users set gender = '{message.text}' where user_id = {message.from_user.id}"
        gender = cur.execute(sql)
        con.commit()
        await message.answer("выбери цвет кожи", reply_markup=settings.skincolor_keyboard)
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