import config
import random

from helpers.db import get_user_info, get_level_and_jobs, get_restaurants
from helpers.games import get_tree_for_lumberjack_job
from aiogram.types import InlineKeyboardMarkup, KeyboardButton, InlineKeyboardButton 

from aiogram.utils.keyboard import InlineKeyboardBuilder, ReplyKeyboardBuilder
from aiogram import types
from helpers.callback_factories import LumberjackJobCallbackFactory, JobsCallbackFactory, RestrantsCallbackFactory
from routers.start_router import start_router_db as srd


async def get_job_kb(user_id, job_name):
    user_info = await get_user_info(user_id)
    msg = f"<b>Ты устроился на работу</b>\n\nНазвание работы: {user_info[-7]}\nописание работы: {user_info[-5]}\nЗарплата: {user_info[-6]}\nБаланс: {user_info[-4]}\nОпыт: {user_info[-2]}\nУровень: {user_info[7]}"
    job_name = job_name.lower()
    if job_name == "дворник":
        job_kb = await get_cleaner_kb()
        return msg, job_kb    
    elif job_name == "лесоруб":
        job_kb = await get_lumberjack_kb()
        tree = await get_tree_for_lumberjack_job()
        tree = "\n".join(tree)
        return f"{msg}\n\n{tree}", job_kb
    

async def get_lumberjack_kb():
    builder = InlineKeyboardBuilder()
    builder.button(
        text="⬅", 
        callback_data=LumberjackJobCallbackFactory(action="left")
    )
    builder.button(
        text="➡", 
        callback_data=LumberjackJobCallbackFactory(action="right")
    )
    builder.adjust(2)
    return builder.as_markup()


async def get_cleaner_kb():
    row = random.randint(0, 3)
    column = random.randint(0, 4)
    builder = InlineKeyboardBuilder()
    for i in range(4):
        for j in range(5):
            text = " "
            call_back = "дворник"
            if row == i and column == j:
                text = "1"
                call_back = "special дворник"
            builder.button(
                text=text, 
                callback_data=call_back
            )
    builder.adjust(5)
    return builder.as_markup()


async def show_main_menu(session, message) -> bool:
    global state
    state = "main_menu"
    nicksql = await srd.db_get_user_data(session, message.from_user.id)
    if not nicksql:
        return False
    await message.answer(f"Добро пожаловоть в меню {nicksql[1]}", reply_markup=config.main_menu)
    return True
        

async def generate_jobbuttons(jobs: list[tuple[str, int]], level: int):
    builder = InlineKeyboardBuilder()
    for job in jobs:
        if job[1] <= level:
            builder.button(text=job[0], callback_data=JobsCallbackFactory(job=job[0]))
        else:
            break
    builder.adjust(1)
    return builder.as_markup()


async def get_jobs_kb(available_jobs, levelnum, next_level_entry_score):
    jobs_kb = None
    if available_jobs[0][1] <= levelnum:
        jobs_kb = await generate_jobbuttons(jobs=available_jobs, level=levelnum)
    msg = f"<b>Выбери работу:</b>\n<b><i>Твой уровень: {levelnum}</i></b>\n<b><i>До следующего уровеня: {next_level_entry_score}</i></b>\n\n"
    for job in available_jobs:
        if job[1] <= levelnum:
            msg += f"<b>{job[0]}</b> <i>- доступно с {job[1]} уровня</i>\n"
        else:
            msg += f"<b>{job[0]}</b> <i>- доступно с {job[1]} уровня (недоступно)</i>\n"
    return msg, jobs_kb


async def send_jobs(message):
    available_jobs, levelnum, next_level_entry_score = await get_level_and_jobs(message.from_user.id)
    msg, jobs_kb = await get_jobs_kb(available_jobs, levelnum, next_level_entry_score)
    await message.answer(msg, reply_markup=jobs_kb)


async def get_shops_kb():
    builder = ReplyKeyboardBuilder()
    builder.add(KeyboardButton(text="Продуктовый магазин"))
    builder.add(KeyboardButton(text="Ресторан"))
    builder.add(KeyboardButton(text="Назад"))
    builder.adjust(2)
    return builder.as_markup(resize_keyboard=True)


async def get_restaurants_kb():
    builder = InlineKeyboardBuilder()
    restaurants = await get_restaurants()
    for restaurant in restaurants:
        print(restaurant)
        builder.button(callback_data=RestrantsCallbackFactory(rest_name=restaurant[0]), text=restaurant[0])
    builder.adjust(1)
    return builder.as_markup(resize_keyboard=True)


async def get_food_shop_kb():
    builder = ReplyKeyboardBuilder()
    builder.add(KeyboardButton(text="Назад"))
    return builder.as_markup(resize_keyboard=True)