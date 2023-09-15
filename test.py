import psycopg2

con=psycopg2.connect(database="bobikdb",
                     user="bobik",
                     password="12345",
                     port=5432,
                     host="localhost")
cur = con.cursor()
cur.execute("select 1+2, now();")
test = cur.fetchall()
print(test)