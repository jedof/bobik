from sqlalchemy.ext.asyncio import create_async_engine
from db.models import Base
from config import settings


async def initdb():
    engine = create_async_engine(settings.DB_URL)
    async with engine.begin() as con:
        await con.run_sync(Base.metadata.create_all)
