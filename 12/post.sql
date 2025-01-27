SET default_transaction_read_only = off;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

-- ==== убирание public доступов ====

-- убираем все права для роли public
-- запрещаем кому бы то ни было создавать временные объекты для роли public
-- запрещаем кому бы то ни было подключаться к БД для роли public
select 'REVOKE ALL ON DATABASE ' || datname || '  FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public для таблиц
select 'ALTER DEFAULT PRIVILEGES REVOKE ALL PRIVILEGES ON TABLES FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public для последовательностей
select 'ALTER DEFAULT PRIVILEGES REVOKE ALL PRIVILEGES ON SEQUENCES FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public для типов
select 'ALTER DEFAULT PRIVILEGES REVOKE ALL PRIVILEGES ON TYPES FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public на функции
select 'ALTER DEFAULT PRIVILEGES REVOKE ALL PRIVILEGES ON FUNCTIONS FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public для таблиц
select 'ALTER DEFAULT PRIVILEGES FOR ROLE deploy REVOKE ALL PRIVILEGES ON TABLES FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public для последовательностей
select 'ALTER DEFAULT PRIVILEGES FOR ROLE deploy REVOKE ALL PRIVILEGES ON SEQUENCES FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public на функции
select 'ALTER DEFAULT PRIVILEGES FOR ROLE deploy REVOKE ALL PRIVILEGES ON FUNCTIONS FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- запрещаем вновь создаваемым объектам получать любое право для роли public для типов
select 'ALTER DEFAULT PRIVILEGES FOR ROLE deploy REVOKE ALL PRIVILEGES ON TYPES FROM public;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- Запрещаем кому бы то ни было читать код процедур для роли public
select 'REVOKE ALL PRIVILEGES ON pg_catalog.pg_proc, information_schema.routines FROM PUBLIC;
REVOKE ALL PRIVILEGES ON FUNCTION pg_catalog.pg_get_functiondef(oid) FROM PUBLIC;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

-- видеть код и структуру данных для роли public
select 'REVOKE ALL PRIVILEGES ON SCHEMA pg_catalog, information_schema, public FROM PUBLIC;' as list_dbs_public
from pg_database
where datname not in ('template1','template0')
\gexec

select not (setting ~ 'shared_ispell') as is_shared_ispell_notloaded  from pg_settings where name ~ 'shared_preload_libraries' \gset
\if :is_shared_ispell_notloaded
    \echo "-- ================================================================================================================ --"
    \echo "Please, after the 1st start of the container with an empty database directory, сorrect in the postgreSQL.conf file,"
    \echo "the 'shared_preload_libraries' parameter it must include the download of the 'shared_ispell' library "
    \echo "and re-run the script: update-extension.sh"
    \echo "-- ================================================================================================================ --"
\endif
