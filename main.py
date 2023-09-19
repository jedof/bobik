import logging
import asyncio
import config

# from exceptions import MissingEnvVaribleError
# psql -h localhost -d bobikdb -U bobik -p 5432
from aiogram import Bot, Dispatcher, types
from hendlers import router


logging.basicConfig(level=logging.INFO)


async def main():
    bot = Bot(token=config.TGTOKEN, parse_mode='HTML')
    dp = Dispatcher()
    dp.include_router(router)
    await bot.delete_webhook(drop_pending_updates=True)
    await dp.start_polling(bot)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.run(main())    
