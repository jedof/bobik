from aiogram.filters.callback_data import CallbackData


class LumberjackJobCallbackFactory(CallbackData, prefix="lumberjack"):
    action: str


class JobsCallbackFactory(CallbackData, prefix="job"):
    job: str
