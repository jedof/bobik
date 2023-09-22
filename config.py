import os

from dotenv import load_dotenv
from aiogram.types import ReplyKeyboardMarkup, KeyboardButton


load_dotenv()
TGTOKEN = os.getenv('TGTOKEN')
DATABASE = os.getenv('DATABASE')
USERDB = os.getenv('USERDB')
PASSWORD = os.getenv('PASSWORD')
PORT = os.getenv('PORT')
HOST = os.getenv('HOST')


kb = [
    [
        KeyboardButton(text="Мужской"),
        KeyboardButton(text="Женский")
    ]
]
gender_keyboard = ReplyKeyboardMarkup(
    keyboard=kb,
    resize_keyboard=True, 
    one_time_keyboard=True
)

kb = [
    [
        KeyboardButton(text="Белый"),
        KeyboardButton(text="Черный")
    ]
]
skincolor_keyboard = ReplyKeyboardMarkup(
    keyboard=kb,
    resize_keyboard=True, 
    one_time_keyboard=True
)

kb = [
    [
        KeyboardButton(text="Профиль"), 
        KeyboardButton(text="Работы")
    ],
    [
        KeyboardButton(text="Магазин")       
    ]
]
main_menu = ReplyKeyboardMarkup(
    keyboard=kb,
    resize_keyboard=True, 
    one_time_keyboard=True
)
state = None