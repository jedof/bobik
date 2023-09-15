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