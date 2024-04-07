from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, insert, update
from db import models as md


async def db_get_user_data(session: AsyncSession, user_id: int):
    user_data = await session.scalars(
        select(md.Users).where(md.Users.user_id == user_id)
    )
    user_data = user_data.first()
    return user_data


async def db_add_user(session: AsyncSession, message):
    await session.execute(
        insert(md.Users).values(
            user_id=message.from_user.id, 
            first_name=message.from_user.first_name,
            last_name=message.from_user.last_name,
            user_name=None,
            level_id=0,
            job_id=0
        )
    )


async def db_add_player_attributes(session: AsyncSession, message):
    await session.execute(
        insert(md.Player_attributes).values(
            user_id=message.from_user.id,
            balance=0,
            score=0,
            food=1200, 
            stamina=100
        )
    )
    

async def db_update(session: AsyncSession, message):
    await session.execute(
        update(md.Users).where(md.Users.user_id == message.from_user.id).values(user_name=message.text)
    )