import os
import psycopg2
from psycopg2 import sql

DATABASE_URL = os.getenv("DATABASE_URL", "postgres://assignment_user:S3cret@db:5432/assignment_db")

def get_db_connection():
    return psycopg2.connect(DATABASE_URL)
