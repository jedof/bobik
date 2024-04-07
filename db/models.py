from sqlalchemy import (
    orm,
    Integer,
    String,
    ForeignKey,
)


class Base(orm.DeclarativeBase):
    pass


class Jobs(Base):
    __tablename__ = "jobs"

    job_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    job_name: orm.Mapped[str] = orm.mapped_column(String)
    job_description: orm.Mapped[str] = orm.mapped_column(String)
    jod_salary: orm.Mapped[int] = orm.mapped_column(Integer)
    score_step: orm.Mapped[int] = orm.mapped_column(Integer)


class Levels(Base):
    __tablename__ = "levels"

    level_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    level_number: orm.Mapped[int] = orm.mapped_column(Integer)
    level_entry_score: orm.Mapped[int] = orm.mapped_column(Integer)


class Users(Base):
    __tablename__ = "users"

    user_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    first_name: orm.Mapped[str] = orm.mapped_column(String)
    last_name: orm.Mapped[str] = orm.mapped_column(String)
    user_name: orm.Mapped[str] = orm.mapped_column(String, nullable=True)
    level = orm.relationship("Levels")
    level_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("levels.level_id"))
    job = orm.relationship("Jobs")
    job_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("jobs.job_id"))
    gender: orm.Mapped[str] = orm.mapped_column(String, nullable=True)
    skin_color: orm.Mapped[str] = orm.mapped_column(String, nullable=True)


class Categories(Base):
    __tablename__ = "categories"

    category_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    category_name: orm.Mapped[str] = orm.mapped_column(String)
    category_path: orm.Mapped[str] = orm.mapped_column(String)


class Compositions(Base):
    __tablename__ = "compositions"
    
    composition_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    position = orm.relationship("Restaurant_menu")
    position_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("restaurant_menu.position_id"))
    ingredients = orm.relationship("Ingredients")
    ingredients_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("ingredients.ingredient_id"))


class Food_categories(Base):
    __tablename__ = "food_categories"

    food_category_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    category_name: orm.Mapped[str] = orm.mapped_column(String)


class Ingredients(Base):
    __tablename__ = "ingredients"

    ingredient_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    ingredients_name: orm.Mapped[str] = orm.mapped_column(String)


class Jobs_levels(Base):
    __tablename__ = "jobs_levels"

    id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    level = orm.relationship("Levels")
    level_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("levels.level_id"))
    job = orm.relationship("Jobs")
    job_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("jobs.job_id"))


class Player_attributes(Base):
    __tablename__ = "player_attributes"

    attribute_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    user = orm.relationship("Users")
    user_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("users.user_id"))
    balance: orm.Mapped[int] = orm.mapped_column(Integer)
    score: orm.Mapped[int] = orm.mapped_column(Integer)
    food: orm.Mapped[int] = orm.mapped_column(Integer)
    stamina: orm.Mapped[int] = orm.mapped_column(Integer)


class Product_attributes(Base):
    __tablename__ = "product_attributes"

    attridute_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    attridute_name: orm.Mapped[str] = orm.mapped_column(String)
    product = orm.relationship("Products")
    product_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("products.product_id"))
    attridute_value: orm.Mapped[str] = orm.mapped_column(String)

class Products(Base):
    __tablename__ = "products"

    product_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    product_name: orm.Mapped[str] = orm.mapped_column(String)
    category = orm.relationship("Food_categories")
    category_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("food_categories.food_category_id"))


class Product_sizes(Base):
    __tablename__ = "product_sizes"

    size_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    size_name: orm.Mapped[str] = orm.mapped_column(String)
    product = orm.relationship("Products")
    product_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("products.product_id"))
    price: orm.Mapped[int] = orm.mapped_column(Integer)


class Restaurant_menu(Base):
    __tablename__ = "restaurant_menu"

    position_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    restaurant = orm.relationship("Restaurants")
    restaurant_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("restaurants.restaurant_id"))
    food_category = orm.relationship("Food_categories")
    food_category_id: orm.Mapped[int] = orm.mapped_column(ForeignKey("food_categories.food_category_id"))
    position_name: orm.Mapped[str] = orm.mapped_column(String)
    position_size: orm.Mapped[str] = orm.mapped_column(String)
    position_categories: orm.Mapped[str] = orm.mapped_column(String)
    position_price: orm.Mapped[int] = orm.mapped_column(Integer)


class Restaurants(Base):
    __tablename__ = "restaurants"

    restaurant_id: orm.Mapped[int] = orm.mapped_column(Integer, primary_key=True)
    restaurant_name: orm.Mapped[str] = orm.mapped_column(String)
