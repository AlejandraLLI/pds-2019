#! /usr/bin /env python
# -*- coding: utf-8 -*-

""" A command line interface to manage the moma database"""

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
    """  Create the conection to the moma database in postgres using the
    given default configuration.
    :param module ctx: subclass of the dict object.
    :return: 
    :rtype:
    """ 
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
    """  Execute the SQL commands to create the schemas raw, cleaned,
    semantic and features. 
    :param module ctx: subclass of the dict object.
    :return: 
    :rtype:
    """ 
    query = ctx.obj['queries'].get('create_schemas')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)

@moma.command()
@click.pass_context
def create_raw_tables(ctx):
    """  Execute the SQL commands to create tables in the raw schema.
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
    query = ctx.obj['queries'].get('create_raw_tables')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)


@moma.command()
@click.pass_context
def load_moma(ctx):
    """  Execute the SQL commands to load the moma data in the raw schema.
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
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
def to_cleaned(ctx):
    """  Execute the SQL commands to pass tables from raw schema to cleaned schema.
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
    query = ctx.obj['queries'].get('to_cleaned')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)


@moma.command()
@click.pass_context
def to_semantic(ctx):
    """  Execute the SQL commands to pass tables from cleaned schema to semantic schema.
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
    query = ctx.obj['queries'].get('to_semantic')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)


@moma.command()
@click.pass_context
def create_cohorts(ctx):
    """  Execute the SQL commands to create the cohort tables from tables in the semantic schema.
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
    query = ctx.obj['queries'].get('create_cohorts')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)


@moma.command()
@click.pass_context
def create_labels(ctx):
    """  Execute the SQL commands to create tables in the labels schema.
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
    query = ctx.obj['queries'].get('create_labels')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)


@moma.command()
@click.pass_context
def create_features(ctx):
    """  Execute the SQL commands to create tables of new features. 
    :param module ctx: subclass of the dict object.
    :return: 
    :rty
    """
    query = ctx.obj['queries'].get('create_features')
    print(query)
    conn = ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)


if __name__ == '__main__':
    moma()
