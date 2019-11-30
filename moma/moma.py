#! /usr/bin/env python
# -*- coding: utf-8 -*-

import psycopg2
import psycopg2.extras

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
    for sql_file in Path('sql').glob('*.sql'):
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


if __name__ == '__main__':
    moma()
