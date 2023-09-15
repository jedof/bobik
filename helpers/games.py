import random

async def gen_tree_layer(lumber: bool):
    if lumber: 
        return "*    -|     *"
    side = random.randint(0, 2)
    if side == 0:
        layer = "*     |     *"
    elif side == 1: 
        layer = "*    \|     *"
    elif side == 2:
        layer = "*     |/    *"
    return layer


async def get_tree_for_lumberjack_job():
#     |/
#    \|
#     |/
    tree = []
    for i in range(10):
        tree.append(await gen_tree_layer(True if i == 9 else False))
    return tree