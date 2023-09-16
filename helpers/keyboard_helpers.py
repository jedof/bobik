import config
import random

from helpers.db import get_user_info, get_level_and_jobs
from helpers.games import get_tree_for_lumberjack_job
from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton


async def get_job_kb(user_id, job_name):
    user_info = await get_user_info(user_id)
    msg = f"<b>Ты устроился на работу</b>\n\nНазвание работы: {user_info[-7]}\nописание работы: {user_info[-5]}\nЗарплата: {user_info[-6]}\nБаланс: {user_info[-4]}\nУровень: {user_info[7]}"
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
    job_kb = InlineKeyboardMarkup()
    job_kb.row(InlineKeyboardButton("⬅", callback_data="left"), InlineKeyboardButton("➡", callback_data="right"))
    return job_kb


async def get_cleaner_kb():
    row = random.randint(0, 3)
    column = random.randint(0, 4)
    job_kb = InlineKeyboardMarkup(row_width=5)
    for i in range(4):
        for j in range(5):
            text = " "
            call_back = " "
            if row == i and column == j:
                text = "1"
                call_back = "special дворник"
            job_kb.insert(InlineKeyboardButton(text, callback_data=call_back))
    return job_kb


async def show_main_menu(message) -> bool:
    global state
    state = "main_menu"
    nicksql = await get_user_info(message.from_user.id)
    if not nicksql:
        return False
    await message.answer(f"Добро пожаловоть в меню {nicksql[1]}", reply_markup=config.main_menu)
    return True
        

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


async def get_jobs_kb(available_jobs, levelnum):
    jobs_kb = None
    if available_jobs[0][1] <= levelnum:
        jobs_kb = await generate_jobbuttons(jobs=available_jobs, level=levelnum)
    msg = f"<b>Выбери работу:</b>\n<b><i>Твой уровень: {levelnum}</i></b>\n\n"
    for job in available_jobs:
        if job[1] <= levelnum:
            msg += f"<b>{job[0]}</b> <i>- доступно с {job[1]} уровня</i>\n"
        else:
            msg += f"<b>{job[0]}</b> <i>- доступно с {job[1]} уровня (недоступно)</i>\n"
    return msg, jobs_kb


async def send_jobs(message):
    available_jobs, levelnum = await get_level_and_jobs(message.from_user.id)
    msg, jobs_kb = await get_jobs_kb(available_jobs, levelnum)
    await message.answer(msg, reply_markup=jobs_kb)
