from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager
from sqlalchemy import exc
from sqlalchemy.ext.asyncio import (
async_sessionmaker,
create_async_engine,
)
from config import settings

engine = create_async_engine (settings.DB_URL)
factory = async_sessionmaker (engine)
@asynccontextmanager
async def get_db_session() -> AsyncGenerator:
    async with factory() as session:
        try:
            yield session
            await session.commit()
        except exc.SQLAlchemyError as error:
            await session.rollback()
            raise error