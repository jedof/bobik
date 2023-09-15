async def get_job_info_message(job: tuple):
    msg = f"Название: {job[0]}\nОписание: {job[1]}\nЗарплата: {job[2]}"
    return msg