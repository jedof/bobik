import logging
import asyncio

# from exceptions import MissingEnvVaribleError
# psql -h localhost -d bobikdb -U bobik -p 5432
from aiogram import Bot, Dispatcher
from routers.start_router.start_router import router as start_router
from config import settings
from db.initdb import initdb


logging.basicConfig(level=logging.INFO)


async def main():
    await initdb()
    bot = Bot(token=settings.TGTOKEN.get_secret_value(), parse_mode='HTML')
    dp = Dispatcher()
    dp.include_router(start_router)
    await bot.delete_webhook(drop_pending_updates=True)
    await dp.start_polling(bot)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.run(main())    
