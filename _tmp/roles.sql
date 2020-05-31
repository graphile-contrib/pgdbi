
----------
----------  BEGIN POSTGRES ROLES SQL
----------
    

------------  DB OWNER ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = 'app_owner')
  THEN
    CREATE ROLE app_owner;
  END IF;

  ALTER ROLE app_owner with LOGIN;
  ALTER ROLE app_owner with CREATEDB;

END
$body$;
--||--
---------- END DB OWNER ROLE -----------
  

---------- DB USER ROLES -----------

    ------------ app_anonymous
      DO
      $body$
      BEGIN
        IF NOT EXISTS (
          SELECT    *
          FROM   pg_catalog.pg_roles
          WHERE  rolname = 'app_anonymous'
        ) THEN
          CREATE ROLE app_anonymous;
        END IF;

        ALTER ROLE app_anonymous with NOLOGIN;
        

      END
      $body$;
      --||--
    -------- END app_anonymous


    ------------ app_visitor
      DO
      $body$
      BEGIN
        IF NOT EXISTS (
          SELECT    *
          FROM   pg_catalog.pg_roles
          WHERE  rolname = 'app_visitor'
        ) THEN
          CREATE ROLE app_visitor;
        END IF;

        ALTER ROLE app_visitor with NOLOGIN;
        
        GRANT app_anonymous TO app_visitor;

      END
      $body$;
      --||--
    -------- END app_visitor

---------- END USER ROLES ----------



------------  DB AUTHENTICATOR ROLE ------------
DO
$body$
BEGIN
  IF NOT EXISTS (
    SELECT    *
    FROM   pg_catalog.pg_roles
    WHERE  rolname = 'app_authenticator')
  THEN
    CREATE ROLE app_authenticator;
  END IF;

ALTER ROLE app_authenticator with LOGIN;
ALTER ROLE app_authenticator with NOINHERIT;

GRANT app_anonymous TO app_authenticator;
GRANT app_visitor TO app_authenticator;

END
$body$;
--||--
---------- END DB AUTHENTICATOR ROLE -----------
  

----------
----------  END POSTGRES ROLES SQL
----------
--==
