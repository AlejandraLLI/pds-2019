#! /usr/bin/env python
# -*- coding: utf-8 -*-

import psycopg2
import psycopg2.extras
import psycopg2.extensions

import sys
from datetime import timedelta

import click

import io

from dynaconf import settings

from pathlib import Path

@click.group()
@click.pass_context
def moma(ctx):
    ctx.ensure_object(dict)
    conn = psycopg2.connect(settings.get('PGCONNSTRING'))
    conn.autocommit = True
    ctx.obj['conn'] = conn

    queries = {}
    for sql_file in Path('../sql').glob('*.sql'):
        with open(sql_file,'r') as sql:
            sql_key = sql_file.stem
            query = str(sql.read())
            queries[sql_key] = query
    ctx.obj['queries'] = queries

@moma.command()
@click.pass_context
def create_schemas(ctx):
    query = ctx.obj['queries'].get('create_schemas')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)

@moma.command()
@click.pass_context
def create_raw_tables(ctx):
    query = ctx.obj['queries'].get('create_raw_tables')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)

@moma.command()
@click.pass_context
def load_moma(ctx):
    conn = ctx.obj['conn']
    with conn.cursor() as cursor:
        for data_file in Path(settings.get('MOMADIR')).glob('*.csv'):
            print(data_file)
            table = data_file.stem
            print(table)
            sql_statement = f"copy raw.{table} from stdin with csv header delimiter as ','"
            print(sql_statement)
            buffer = io.StringIO()
            with open(data_file,'r', encoding='utf-8') as data:
                buffer.write(data.read())
            buffer.seek(0)
            cursor.copy_expert(sql_statement, file=buffer)

@moma.command()
@click.pass_context
def to_cleaned():
    query = ctx.obj['queries'].get('to_cleaned')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)

if __name__ == '__main__':
    moma()
