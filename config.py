from aiogram.types import ReplyKeyboardMarkup, KeyboardButton
from pydantic_settings import BaseSettings
from pydantic import SecretStr


class Settings(BaseSettings):
    TGTOKEN: SecretStr
    DATABASE: str
    USERDB: str
    POSTGRES_PASSWORD: SecretStr
    PORT: str
    DB_URL: str

    gender_keyboard: ReplyKeyboardMarkup = ReplyKeyboardMarkup(
        keyboard=[
            [
                KeyboardButton(text="Мужской"),
                KeyboardButton(text="Женский")
            ]
        ],  
        resize_keyboard=True, 
        one_time_keyboard=True
    )

    skincolor_keyboard: ReplyKeyboardMarkup = ReplyKeyboardMarkup(
        keyboard=[
            [
                KeyboardButton(text="Белый"),
                KeyboardButton(text="Черный")
            ]
        ],
        resize_keyboard=True, 
        one_time_keyboard=True
    )

    main_menu: ReplyKeyboardMarkup = ReplyKeyboardMarkup(
        keyboard=[
            [
                KeyboardButton(text="Профиль"), 
                KeyboardButton(text="Работы")
            ],
            [
                KeyboardButton(text="Магазин")       
            ]
        ],
        resize_keyboard=True, 
        one_time_keyboard=False
    )
    state: str | None = None

settings = Settings()