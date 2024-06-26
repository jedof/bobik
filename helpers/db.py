import psycopg2
import config

from aiogram.types import ReplyKeyboardMarkup, KeyboardButton, InlineKeyboardButton
from aiogram.utils.keyboard import ReplyKeyboardBuilder, InlineKeyboardBuilder


con=psycopg2.connect(database=config.DATABASE,
                        user=config.USERDB,
                        POSTGRES_PASSWORD=config.POSTGRES_PASSWORD,
                        port=config.PORT,
                        host=config.HOST)
cur = con.cursor()


async def update_user_job(user_id, job_name):
    sql = f"UPDATE "\
        "users u "\
        "set "\
        f"job_id = ("\
        "SELECT "\
        "j.job_id "\
        "from "\
        "jobs j "\
        f"Where j.job_name = '{job_name}'"\
        ") "\
        "WHERE "\
        f"u.user_id = {user_id} RETURNING u.user_id"
    cur.execute(sql)
    job_name = cur.fetchone()
    con.commit()
    return job_name[0]


async def increment_balance(user_id):
    sql = f"UPDATE "\
            "player_attributes pa "\
            "set "\
            "balance = balance + ("\
            "SELECT "\
            "j.job_salary "\
            "from "\
            "users u "\
            "INNER JOIN jobs j ON u.job_id = j.job_id "\
            "where "\
            f"u.user_id = {user_id}"\
            ") "\
            "WHERE "\
            f"pa.user_id = {user_id} RETURNING pa.balance;"
    cur.execute(sql)
    balance = cur.fetchone()
    con.commit()
    return balance[0]


async def get_job_by_jobname(job: str):
    job_sql = f"select job_name, job_description, job_salary from jobs where job_name = '{job}'"
    cur.execute(job_sql)
    job = cur.fetchone()
    return job


async def get_level_and_jobs(user_id):
    cur.execute(f"select l.level_number, l.next_level_entry_score from users u left join levels l on u.level_id = l.level_id where user_id = {user_id}")
    levelnum, next_level_entry_score = cur.fetchone()
    available_jobs = cur.execute(f"SELECT j.job_name, l.level_number from jobs_levels jl LEFT JOIN jobs j on j.job_id = jl.job_id left join levels l on jl.level_id = l.level_id;")
    available_jobs = cur.fetchall()
    return available_jobs, levelnum, next_level_entry_score

async def get_user_info(user_id: int) -> str | None:
    sql = "SELECT u.user_id,"\
                "u.user_name,"\
                "u.first_name,"\
                "u.last_name,"\
                "u.gender,"\
                "u.skin_color,"\
                "l.level_id,"\
                "l.level_number,"\
                "l.next_level_entry_score,"\
                "j.job_id,"\
                "j.job_name,"\
                "j.job_salary,"\
                "j.job_description,"\
                "pa.balance,"\
                "pa.food,"\
                "pa.score,"\
                "pa.stamina "\
        "FROM users u "\
        "LEFT JOIN levels l ON u.level_id = l.level_id "\
        "LEFT JOIN jobs j ON u.job_id = j.job_id "\
        "LEFT JOIN player_attributes pa ON u.user_id = pa.user_id "\
        f"WHERE u.user_id = {user_id};"
    cur.execute(sql)
    user_info = cur.fetchone()
    return user_info if user_info else None


async def get_restaurants():
    global cur
    restaurants = cur.execute("select restaurant_name from restaurants")
    restaurants = cur.fetchall()
    return restaurants


async def get_restaurant_food_categories_kb(restaurant_name):
    global cur
    sql = "SELECT DISTINCT fc.category_name"\
          "FROM restaurant_menu rm"\
          "LEFT JOIN food_categories fc ON rm.food_category_id = fc.category_id"\
          "LEFT JOIN restaurants r ON rm.restaurant_id = r.restaurant_id"\
          f"WHERE r.restaurant_name = {restaurant_name};"
    cur.execute(sql)
    restaurants = cur.fetchall()


async def increment_score(user_id):
    sql = f"UPDATE "\
            "player_attributes pa "\
            "set "\
            "score = score + ("\
            "SELECT "\
            "j.score_step "\
            "from "\
            "users u "\
            "INNER JOIN jobs j ON u.job_id = j.job_id "\
            "where "\
            f"u.user_id = {user_id}"\
            ") "\
            "WHERE "\
            f"pa.user_id = {user_id} RETURNING pa.score;"
    cur.execute(sql)
    score = cur.fetchone()
    con.commit()
    return score[0]


async def deincrement_score(user_id):
    sql = f"SELECT "\
            "pa.score, "\
            "j.score_step "\
            "from "\
            "users u "\
            "inner join player_attributes pa on u.user_id = pa.user_id "\
            "inner join jobs j on u.job_id = j.job_id "\
            "WHERE "\
            f"u.user_id = {user_id};"
    cur.execute(sql)
    score, score_step = cur.fetchone()
    print(score)
    if score - score_step >= 0:
        sql = f"UPDATE "\
                "player_attributes pa "\
                "set "\
                f"score = score - {score_step}"\
                "WHERE "\
                f"pa.user_id = {user_id} RETURNING pa.score;"
        cur.execute(sql)
        score = cur.fetchone()
    con.commit()
    return score


async def level_up(user_id):
    sql = f"select "\
    "u.level_id, l.next_level_entry_score, pa.score "\
    "from "\
    "users u "\
    "inner join levels l on u.level_id = l.level_id "\
    "inner join player_attributes pa on u.user_id = pa.user_id "\
    f"where u.user_id = {user_id}"
    cur.execute(sql)
    level, next_level_entry_score, score = cur.fetchone()
    print(level, next_level_entry_score, score)
    if score >= next_level_entry_score:
        level_update = f"UPDATE "\
                "users u "\
                "set "\
                f"level_id = level_id + 1"\
                "WHERE "\
                f"u.user_id = {user_id};"
        cur.execute(level_update)
        cur.fetchone()
        score_update = f"UPDATE "\
                "player_attributes pa "\
                "set "\
                f"score = 0"\
                "WHERE "\
                f"pa.user_id = {user_id};"
        cur.execute(score_update)
        cur.fetchone()
        msg = f"Ты поднялся на уровень {level + 1}"
        return msg, True
    con.commit()


async def get_rest_categories(rest_name):
    sql = "SELECT DISTINCT "\
          "r.restaurant_id, fc.category_id, fc.category_name "\
          "FROM restaurant_menu rm "\
          "INNER JOIN restaurants r ON rm.restaurant_id = r.restaurant_id "\
          "INNER JOIN food_categories fc ON rm.food_category_id = fc.category_id "\
          "WHERE rm.restaurant_id = r.restaurant_id;"