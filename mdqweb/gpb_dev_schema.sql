--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: gtsq; Type: DOMAIN; Schema: public; Owner: gpb
--

CREATE DOMAIN gtsq AS text;


ALTER DOMAIN public.gtsq OWNER TO gpb;

--
-- Name: gtsvector; Type: DOMAIN; Schema: public; Owner: gpb
--

CREATE DOMAIN gtsvector AS pg_catalog.gtsvector;


ALTER DOMAIN public.gtsvector OWNER TO gpb;

--
-- Name: statinfo; Type: TYPE; Schema: public; Owner: gpb
--

CREATE TYPE statinfo AS (
	word text,
	ndoc integer,
	nentry integer
);


ALTER TYPE public.statinfo OWNER TO gpb;

--
-- Name: tokenout; Type: TYPE; Schema: public; Owner: gpb
--

CREATE TYPE tokenout AS (
	tokid integer,
	token text
);


ALTER TYPE public.tokenout OWNER TO gpb;

--
-- Name: tokentype; Type: TYPE; Schema: public; Owner: gpb
--

CREATE TYPE tokentype AS (
	tokid integer,
	alias text,
	descr text
);


ALTER TYPE public.tokentype OWNER TO gpb;

--
-- Name: tsdebug; Type: TYPE; Schema: public; Owner: gpb
--

CREATE TYPE tsdebug AS (
	ts_name text,
	tok_type text,
	description text,
	token text,
	dict_name text[],
	tsvector pg_catalog.tsvector
);


ALTER TYPE public.tsdebug OWNER TO gpb;

--
-- Name: tsquery; Type: DOMAIN; Schema: public; Owner: gpb
--

CREATE DOMAIN tsquery AS pg_catalog.tsquery;


ALTER DOMAIN public.tsquery OWNER TO gpb;

--
-- Name: tsvector; Type: DOMAIN; Schema: public; Owner: gpb
--

CREATE DOMAIN tsvector AS pg_catalog.tsvector;


ALTER DOMAIN public.tsvector OWNER TO gpb;

--
-- Name: _get_parser_from_curcfg(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _get_parser_from_curcfg() RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$select prsname::text from pg_catalog.pg_ts_parser p join pg_ts_config c on cfgparser = p.oid where c.oid = show_curcfg();$$;


ALTER FUNCTION public._get_parser_from_curcfg() OWNER TO postgres;

--
-- Name: concat(pg_catalog.tsvector, pg_catalog.tsvector); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION concat(pg_catalog.tsvector, pg_catalog.tsvector) RETURNS pg_catalog.tsvector
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsvector_concat$$;


ALTER FUNCTION public.concat(pg_catalog.tsvector, pg_catalog.tsvector) OWNER TO postgres;

--
-- Name: dex_init(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dex_init(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_dex_init';


ALTER FUNCTION public.dex_init(internal) OWNER TO postgres;

--
-- Name: dex_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dex_lexize(internal, internal, integer) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_dex_lexize';


ALTER FUNCTION public.dex_lexize(internal, internal, integer) OWNER TO postgres;

--
-- Name: get_covers(pg_catalog.tsvector, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_covers(pg_catalog.tsvector, pg_catalog.tsquery) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_get_covers';


ALTER FUNCTION public.get_covers(pg_catalog.tsvector, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: headline(text, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION headline(text, pg_catalog.tsquery) RETURNS text
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_headline$$;


ALTER FUNCTION public.headline(text, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: headline(oid, text, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION headline(oid, text, pg_catalog.tsquery) RETURNS text
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_headline_byid$$;


ALTER FUNCTION public.headline(oid, text, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: headline(text, text, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION headline(text, text, pg_catalog.tsquery) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/tsearch2', 'tsa_headline_byname';


ALTER FUNCTION public.headline(text, text, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: headline(text, pg_catalog.tsquery, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION headline(text, pg_catalog.tsquery, text) RETURNS text
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_headline_opt$$;


ALTER FUNCTION public.headline(text, pg_catalog.tsquery, text) OWNER TO postgres;

--
-- Name: headline(oid, text, pg_catalog.tsquery, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION headline(oid, text, pg_catalog.tsquery, text) RETURNS text
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_headline_byid_opt$$;


ALTER FUNCTION public.headline(oid, text, pg_catalog.tsquery, text) OWNER TO postgres;

--
-- Name: headline(text, text, pg_catalog.tsquery, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION headline(text, text, pg_catalog.tsquery, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/tsearch2', 'tsa_headline_byname';


ALTER FUNCTION public.headline(text, text, pg_catalog.tsquery, text) OWNER TO postgres;

--
-- Name: length(pg_catalog.tsvector); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length(pg_catalog.tsvector) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsvector_length$$;


ALTER FUNCTION public.length(pg_catalog.tsvector) OWNER TO postgres;

--
-- Name: lexize(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lexize(text) RETURNS text[]
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_lexize_bycurrent';


ALTER FUNCTION public.lexize(text) OWNER TO postgres;

--
-- Name: lexize(oid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lexize(oid, text) RETURNS text[]
    LANGUAGE internal STRICT
    AS $$ts_lexize$$;


ALTER FUNCTION public.lexize(oid, text) OWNER TO postgres;

--
-- Name: lexize(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lexize(text, text) RETURNS text[]
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_lexize_byname';


ALTER FUNCTION public.lexize(text, text) OWNER TO postgres;

--
-- Name: numnode(pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numnode(pg_catalog.tsquery) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsquery_numnode$$;


ALTER FUNCTION public.numnode(pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: parse(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION parse(text) RETURNS SETOF tokenout
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_parse_current';


ALTER FUNCTION public.parse(text) OWNER TO postgres;

--
-- Name: parse(oid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION parse(oid, text) RETURNS SETOF tokenout
    LANGUAGE internal STRICT
    AS $$ts_parse_byid$$;


ALTER FUNCTION public.parse(oid, text) OWNER TO postgres;

--
-- Name: parse(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION parse(text, text) RETURNS SETOF tokenout
    LANGUAGE internal STRICT
    AS $$ts_parse_byname$$;


ALTER FUNCTION public.parse(text, text) OWNER TO postgres;

--
-- Name: plainto_tsquery(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plainto_tsquery(text) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$plainto_tsquery$$;


ALTER FUNCTION public.plainto_tsquery(text) OWNER TO postgres;

--
-- Name: plainto_tsquery(oid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plainto_tsquery(oid, text) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$plainto_tsquery_byid$$;


ALTER FUNCTION public.plainto_tsquery(oid, text) OWNER TO postgres;

--
-- Name: plainto_tsquery(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plainto_tsquery(text, text) RETURNS pg_catalog.tsquery
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/tsearch2', 'tsa_plainto_tsquery_name';


ALTER FUNCTION public.plainto_tsquery(text, text) OWNER TO postgres;

--
-- Name: prsd_end(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prsd_end(internal) RETURNS void
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_prsd_end';


ALTER FUNCTION public.prsd_end(internal) OWNER TO postgres;

--
-- Name: prsd_getlexeme(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prsd_getlexeme(internal, internal, internal) RETURNS integer
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_prsd_getlexeme';


ALTER FUNCTION public.prsd_getlexeme(internal, internal, internal) OWNER TO postgres;

--
-- Name: prsd_headline(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prsd_headline(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_prsd_headline';


ALTER FUNCTION public.prsd_headline(internal, internal, internal) OWNER TO postgres;

--
-- Name: prsd_lextype(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prsd_lextype(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_prsd_lextype';


ALTER FUNCTION public.prsd_lextype(internal) OWNER TO postgres;

--
-- Name: prsd_start(internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prsd_start(internal, integer) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_prsd_start';


ALTER FUNCTION public.prsd_start(internal, integer) OWNER TO postgres;

--
-- Name: querytree(pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION querytree(pg_catalog.tsquery) RETURNS text
    LANGUAGE internal STRICT
    AS $$tsquerytree$$;


ALTER FUNCTION public.querytree(pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rank(pg_catalog.tsvector, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank(pg_catalog.tsvector, pg_catalog.tsquery) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rank_tt$$;


ALTER FUNCTION public.rank(pg_catalog.tsvector, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rank(real[], pg_catalog.tsvector, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank(real[], pg_catalog.tsvector, pg_catalog.tsquery) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rank_wtt$$;


ALTER FUNCTION public.rank(real[], pg_catalog.tsvector, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rank(pg_catalog.tsvector, pg_catalog.tsquery, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank(pg_catalog.tsvector, pg_catalog.tsquery, integer) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rank_ttf$$;


ALTER FUNCTION public.rank(pg_catalog.tsvector, pg_catalog.tsquery, integer) OWNER TO postgres;

--
-- Name: rank(real[], pg_catalog.tsvector, pg_catalog.tsquery, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank(real[], pg_catalog.tsvector, pg_catalog.tsquery, integer) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rank_wttf$$;


ALTER FUNCTION public.rank(real[], pg_catalog.tsvector, pg_catalog.tsquery, integer) OWNER TO postgres;

--
-- Name: rank_cd(pg_catalog.tsvector, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank_cd(pg_catalog.tsvector, pg_catalog.tsquery) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rankcd_tt$$;


ALTER FUNCTION public.rank_cd(pg_catalog.tsvector, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rank_cd(real[], pg_catalog.tsvector, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank_cd(real[], pg_catalog.tsvector, pg_catalog.tsquery) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rankcd_wtt$$;


ALTER FUNCTION public.rank_cd(real[], pg_catalog.tsvector, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rank_cd(pg_catalog.tsvector, pg_catalog.tsquery, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank_cd(pg_catalog.tsvector, pg_catalog.tsquery, integer) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rankcd_ttf$$;


ALTER FUNCTION public.rank_cd(pg_catalog.tsvector, pg_catalog.tsquery, integer) OWNER TO postgres;

--
-- Name: rank_cd(real[], pg_catalog.tsvector, pg_catalog.tsquery, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rank_cd(real[], pg_catalog.tsvector, pg_catalog.tsquery, integer) RETURNS real
    LANGUAGE internal IMMUTABLE STRICT
    AS $$ts_rankcd_wttf$$;


ALTER FUNCTION public.rank_cd(real[], pg_catalog.tsvector, pg_catalog.tsquery, integer) OWNER TO postgres;

--
-- Name: reset_tsearch(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reset_tsearch() RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_reset_tsearch';


ALTER FUNCTION public.reset_tsearch() OWNER TO postgres;

--
-- Name: rewrite(pg_catalog.tsquery, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rewrite(pg_catalog.tsquery, text) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsquery_rewrite_query$$;


ALTER FUNCTION public.rewrite(pg_catalog.tsquery, text) OWNER TO postgres;

--
-- Name: rewrite(pg_catalog.tsquery, pg_catalog.tsquery, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rewrite(pg_catalog.tsquery, pg_catalog.tsquery, pg_catalog.tsquery) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsquery_rewrite$$;


ALTER FUNCTION public.rewrite(pg_catalog.tsquery, pg_catalog.tsquery, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rewrite_accum(pg_catalog.tsquery, pg_catalog.tsquery[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rewrite_accum(pg_catalog.tsquery, pg_catalog.tsquery[]) RETURNS pg_catalog.tsquery
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_rewrite_accum';


ALTER FUNCTION public.rewrite_accum(pg_catalog.tsquery, pg_catalog.tsquery[]) OWNER TO postgres;

--
-- Name: rewrite_finish(pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rewrite_finish(pg_catalog.tsquery) RETURNS pg_catalog.tsquery
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_rewrite_finish';


ALTER FUNCTION public.rewrite_finish(pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: set_curcfg(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_curcfg(integer) RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_set_curcfg';


ALTER FUNCTION public.set_curcfg(integer) OWNER TO postgres;

--
-- Name: set_curcfg(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_curcfg(text) RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_set_curcfg_byname';


ALTER FUNCTION public.set_curcfg(text) OWNER TO postgres;

--
-- Name: set_curdict(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_curdict(integer) RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_set_curdict';


ALTER FUNCTION public.set_curdict(integer) OWNER TO postgres;

--
-- Name: set_curdict(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_curdict(text) RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_set_curdict_byname';


ALTER FUNCTION public.set_curdict(text) OWNER TO postgres;

--
-- Name: set_curprs(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_curprs(integer) RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_set_curprs';


ALTER FUNCTION public.set_curprs(integer) OWNER TO postgres;

--
-- Name: set_curprs(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_curprs(text) RETURNS void
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_set_curprs_byname';


ALTER FUNCTION public.set_curprs(text) OWNER TO postgres;

--
-- Name: setweight(pg_catalog.tsvector, "char"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setweight(pg_catalog.tsvector, "char") RETURNS pg_catalog.tsvector
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsvector_setweight$$;


ALTER FUNCTION public.setweight(pg_catalog.tsvector, "char") OWNER TO postgres;

--
-- Name: show_curcfg(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_curcfg() RETURNS oid
    LANGUAGE internal STABLE STRICT
    AS $$get_current_ts_config$$;


ALTER FUNCTION public.show_curcfg() OWNER TO postgres;

--
-- Name: snb_en_init(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snb_en_init(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_snb_en_init';


ALTER FUNCTION public.snb_en_init(internal) OWNER TO postgres;

--
-- Name: snb_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snb_lexize(internal, internal, integer) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_snb_lexize';


ALTER FUNCTION public.snb_lexize(internal, internal, integer) OWNER TO postgres;

--
-- Name: snb_ru_init(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snb_ru_init(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_snb_ru_init';


ALTER FUNCTION public.snb_ru_init(internal) OWNER TO postgres;

--
-- Name: snb_ru_init_koi8(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snb_ru_init_koi8(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_snb_ru_init_koi8';


ALTER FUNCTION public.snb_ru_init_koi8(internal) OWNER TO postgres;

--
-- Name: snb_ru_init_utf8(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snb_ru_init_utf8(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_snb_ru_init_utf8';


ALTER FUNCTION public.snb_ru_init_utf8(internal) OWNER TO postgres;

--
-- Name: spell_init(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spell_init(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_spell_init';


ALTER FUNCTION public.spell_init(internal) OWNER TO postgres;

--
-- Name: spell_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spell_lexize(internal, internal, integer) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_spell_lexize';


ALTER FUNCTION public.spell_lexize(internal, internal, integer) OWNER TO postgres;

--
-- Name: stat(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION stat(text) RETURNS SETOF statinfo
    LANGUAGE internal STRICT
    AS $$ts_stat1$$;


ALTER FUNCTION public.stat(text) OWNER TO postgres;

--
-- Name: stat(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION stat(text, text) RETURNS SETOF statinfo
    LANGUAGE internal STRICT
    AS $$ts_stat2$$;


ALTER FUNCTION public.stat(text, text) OWNER TO postgres;

--
-- Name: strip(pg_catalog.tsvector); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION strip(pg_catalog.tsvector) RETURNS pg_catalog.tsvector
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsvector_strip$$;


ALTER FUNCTION public.strip(pg_catalog.tsvector) OWNER TO postgres;

--
-- Name: syn_init(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION syn_init(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_syn_init';


ALTER FUNCTION public.syn_init(internal) OWNER TO postgres;

--
-- Name: syn_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION syn_lexize(internal, internal, integer) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_syn_lexize';


ALTER FUNCTION public.syn_lexize(internal, internal, integer) OWNER TO postgres;

--
-- Name: thesaurus_init(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION thesaurus_init(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_thesaurus_init';


ALTER FUNCTION public.thesaurus_init(internal) OWNER TO postgres;

--
-- Name: thesaurus_lexize(internal, internal, integer, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION thesaurus_lexize(internal, internal, integer, internal) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/tsearch2', 'tsa_thesaurus_lexize';


ALTER FUNCTION public.thesaurus_lexize(internal, internal, integer, internal) OWNER TO postgres;

--
-- Name: to_tsquery(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION to_tsquery(text) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$to_tsquery$$;


ALTER FUNCTION public.to_tsquery(text) OWNER TO postgres;

--
-- Name: to_tsquery(oid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION to_tsquery(oid, text) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$to_tsquery_byid$$;


ALTER FUNCTION public.to_tsquery(oid, text) OWNER TO postgres;

--
-- Name: to_tsquery(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION to_tsquery(text, text) RETURNS pg_catalog.tsquery
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/tsearch2', 'tsa_to_tsquery_name';


ALTER FUNCTION public.to_tsquery(text, text) OWNER TO postgres;

--
-- Name: to_tsvector(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION to_tsvector(text) RETURNS pg_catalog.tsvector
    LANGUAGE internal IMMUTABLE STRICT
    AS $$to_tsvector$$;


ALTER FUNCTION public.to_tsvector(text) OWNER TO postgres;

--
-- Name: to_tsvector(oid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION to_tsvector(oid, text) RETURNS pg_catalog.tsvector
    LANGUAGE internal IMMUTABLE STRICT
    AS $$to_tsvector_byid$$;


ALTER FUNCTION public.to_tsvector(oid, text) OWNER TO postgres;

--
-- Name: to_tsvector(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION to_tsvector(text, text) RETURNS pg_catalog.tsvector
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/tsearch2', 'tsa_to_tsvector_name';


ALTER FUNCTION public.to_tsvector(text, text) OWNER TO postgres;

--
-- Name: token_type(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION token_type() RETURNS SETOF tokentype
    LANGUAGE c STRICT ROWS 16
    AS '$libdir/tsearch2', 'tsa_token_type_current';


ALTER FUNCTION public.token_type() OWNER TO postgres;

--
-- Name: token_type(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION token_type(integer) RETURNS SETOF tokentype
    LANGUAGE internal STRICT ROWS 16
    AS $$ts_token_type_byid$$;


ALTER FUNCTION public.token_type(integer) OWNER TO postgres;

--
-- Name: token_type(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION token_type(text) RETURNS SETOF tokentype
    LANGUAGE internal STRICT ROWS 16
    AS $$ts_token_type_byname$$;


ALTER FUNCTION public.token_type(text) OWNER TO postgres;

--
-- Name: ts_debug(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ts_debug(text) RETURNS SETOF tsdebug
    LANGUAGE sql STRICT
    AS $_$
select
        (select c.cfgname::text from pg_catalog.pg_ts_config as c
         where c.oid = show_curcfg()),
        t.alias as tok_type,
        t.descr as description,
        p.token,
        ARRAY ( SELECT m.mapdict::pg_catalog.regdictionary::pg_catalog.text
                FROM pg_catalog.pg_ts_config_map AS m
                WHERE m.mapcfg = show_curcfg() AND m.maptokentype = p.tokid
                ORDER BY m.mapseqno )
        AS dict_name,
        strip(to_tsvector(p.token)) as tsvector
from
        parse( _get_parser_from_curcfg(), $1 ) as p,
        token_type() as t
where
        t.tokid = p.tokid
$_$;


ALTER FUNCTION public.ts_debug(text) OWNER TO postgres;

--
-- Name: tsearch2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tsearch2() RETURNS trigger
    LANGUAGE c
    AS '$libdir/tsearch2', 'tsa_tsearch2';


ALTER FUNCTION public.tsearch2() OWNER TO postgres;

--
-- Name: tsq_mcontained(pg_catalog.tsquery, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tsq_mcontained(pg_catalog.tsquery, pg_catalog.tsquery) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsq_mcontained$$;


ALTER FUNCTION public.tsq_mcontained(pg_catalog.tsquery, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: tsq_mcontains(pg_catalog.tsquery, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tsq_mcontains(pg_catalog.tsquery, pg_catalog.tsquery) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsq_mcontains$$;


ALTER FUNCTION public.tsq_mcontains(pg_catalog.tsquery, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: tsquery_and(pg_catalog.tsquery, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tsquery_and(pg_catalog.tsquery, pg_catalog.tsquery) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsquery_and$$;


ALTER FUNCTION public.tsquery_and(pg_catalog.tsquery, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: tsquery_not(pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tsquery_not(pg_catalog.tsquery) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsquery_not$$;


ALTER FUNCTION public.tsquery_not(pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: tsquery_or(pg_catalog.tsquery, pg_catalog.tsquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tsquery_or(pg_catalog.tsquery, pg_catalog.tsquery) RETURNS pg_catalog.tsquery
    LANGUAGE internal IMMUTABLE STRICT
    AS $$tsquery_or$$;


ALTER FUNCTION public.tsquery_or(pg_catalog.tsquery, pg_catalog.tsquery) OWNER TO postgres;

--
-- Name: rewrite(pg_catalog.tsquery[]); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE rewrite(pg_catalog.tsquery[]) (
    SFUNC = rewrite_accum,
    STYPE = pg_catalog.tsquery,
    FINALFUNC = rewrite_finish
);


ALTER AGGREGATE public.rewrite(pg_catalog.tsquery[]) OWNER TO postgres;

--
-- Name: gin_tsvector_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin_tsvector_ops
    FOR TYPE pg_catalog.tsvector USING gin AS
    STORAGE text ,
    OPERATOR 1 @@(pg_catalog.tsvector,pg_catalog.tsquery) ,
    OPERATOR 2 @@@(pg_catalog.tsvector,pg_catalog.tsquery) ,
    FUNCTION 1 bttextcmp(text,text) ,
    FUNCTION 2 gin_extract_tsvector(pg_catalog.tsvector,internal) ,
    FUNCTION 3 gin_extract_tsquery(pg_catalog.tsquery,internal,smallint,internal,internal) ,
    FUNCTION 4 gin_tsquery_consistent(internal,smallint,pg_catalog.tsquery,integer,internal,internal) ,
    FUNCTION 5 gin_cmp_prefix(text,text,smallint,internal);


ALTER OPERATOR CLASS public.gin_tsvector_ops USING gin OWNER TO postgres;

--
-- Name: gist_tp_tsquery_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_tp_tsquery_ops
    FOR TYPE pg_catalog.tsquery USING gist AS
    STORAGE bigint ,
    OPERATOR 7 @>(pg_catalog.tsquery,pg_catalog.tsquery) ,
    OPERATOR 8 <@(pg_catalog.tsquery,pg_catalog.tsquery) ,
    FUNCTION 1 gtsquery_consistent(internal,internal,integer,oid,internal) ,
    FUNCTION 2 gtsquery_union(internal,internal) ,
    FUNCTION 3 gtsquery_compress(internal) ,
    FUNCTION 4 gtsquery_decompress(internal) ,
    FUNCTION 5 gtsquery_penalty(internal,internal,internal) ,
    FUNCTION 6 gtsquery_picksplit(internal,internal) ,
    FUNCTION 7 gtsquery_same(bigint,bigint,internal);


ALTER OPERATOR CLASS public.gist_tp_tsquery_ops USING gist OWNER TO postgres;

--
-- Name: gist_tsvector_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_tsvector_ops
    FOR TYPE pg_catalog.tsvector USING gist AS
    STORAGE pg_catalog.gtsvector ,
    OPERATOR 1 @@(pg_catalog.tsvector,pg_catalog.tsquery) ,
    FUNCTION 1 gtsvector_consistent(internal,pg_catalog.gtsvector,integer,oid,internal) ,
    FUNCTION 2 gtsvector_union(internal,internal) ,
    FUNCTION 3 gtsvector_compress(internal) ,
    FUNCTION 4 gtsvector_decompress(internal) ,
    FUNCTION 5 gtsvector_penalty(internal,internal,internal) ,
    FUNCTION 6 gtsvector_picksplit(internal,internal) ,
    FUNCTION 7 gtsvector_same(pg_catalog.gtsvector,pg_catalog.gtsvector,internal);


ALTER OPERATOR CLASS public.gist_tsvector_ops USING gist OWNER TO postgres;

--
-- Name: tsquery_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS tsquery_ops
    FOR TYPE pg_catalog.tsquery USING btree AS
    OPERATOR 1 <(pg_catalog.tsquery,pg_catalog.tsquery) ,
    OPERATOR 2 <=(pg_catalog.tsquery,pg_catalog.tsquery) ,
    OPERATOR 3 =(pg_catalog.tsquery,pg_catalog.tsquery) ,
    OPERATOR 4 >=(pg_catalog.tsquery,pg_catalog.tsquery) ,
    OPERATOR 5 >(pg_catalog.tsquery,pg_catalog.tsquery) ,
    FUNCTION 1 tsquery_cmp(pg_catalog.tsquery,pg_catalog.tsquery);


ALTER OPERATOR CLASS public.tsquery_ops USING btree OWNER TO postgres;

--
-- Name: tsvector_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS tsvector_ops
    FOR TYPE pg_catalog.tsvector USING btree AS
    OPERATOR 1 <(pg_catalog.tsvector,pg_catalog.tsvector) ,
    OPERATOR 2 <=(pg_catalog.tsvector,pg_catalog.tsvector) ,
    OPERATOR 3 =(pg_catalog.tsvector,pg_catalog.tsvector) ,
    OPERATOR 4 >=(pg_catalog.tsvector,pg_catalog.tsvector) ,
    OPERATOR 5 >(pg_catalog.tsvector,pg_catalog.tsvector) ,
    FUNCTION 1 tsvector_cmp(pg_catalog.tsvector,pg_catalog.tsvector);


ALTER OPERATOR CLASS public.tsvector_ops USING btree OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO gpb;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO gpb;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO gpb;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO gpb;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_message; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_message (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL
);


ALTER TABLE public.auth_message OWNER TO gpb;

--
-- Name: auth_message_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_message_id_seq OWNER TO gpb;

--
-- Name: auth_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_message_id_seq OWNED BY auth_message.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO gpb;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO gpb;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO gpb;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO gpb;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO gpb;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO gpb;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO gpb;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO gpb;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: core_compra; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE core_compra (
    proveedor_id integer NOT NULL,
    fecha date,
    destino_id integer NOT NULL,
    orden_compra integer,
    importe numeric(19,2) NOT NULL,
    id integer NOT NULL,
    suministro character varying(32),
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.core_compra OWNER TO gpb;

--
-- Name: core_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE core_compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_compra_id_seq OWNER TO gpb;

--
-- Name: core_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE core_compra_id_seq OWNED BY core_compra.id;


--
-- Name: core_compralineaitem; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE core_compralineaitem (
    compra_id integer NOT NULL,
    importe_unitario numeric(19,2) NOT NULL,
    id integer NOT NULL,
    cantidad character varying(128),
    detalle text,
    search_index pg_catalog.tsvector,
    unidad_medida character varying(64)
);


ALTER TABLE public.core_compralineaitem OWNER TO gpb;

--
-- Name: core_compralineaitem_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE core_compralineaitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_compralineaitem_id_seq OWNER TO gpb;

--
-- Name: core_compralineaitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE core_compralineaitem_id_seq OWNED BY core_compralineaitem.id;


--
-- Name: core_proveedor; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE core_proveedor (
    localidad character varying(128),
    nombre text NOT NULL,
    id integer NOT NULL,
    domicilio character varying(128),
    cuit character varying(32),
    slug character varying(50) NOT NULL,
    search_index pg_catalog.tsvector,
    created_at timestamp with time zone NOT NULL,
    nombre_fantasia text
);


ALTER TABLE public.core_proveedor OWNER TO gpb;

--
-- Name: core_proveedor_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE core_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_proveedor_id_seq OWNER TO gpb;

--
-- Name: core_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE core_proveedor_id_seq OWNED BY core_proveedor.id;


--
-- Name: core_reparticion; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE core_reparticion (
    nombre character varying(128) NOT NULL,
    id integer NOT NULL,
    slug character varying(50) NOT NULL,
    search_index pg_catalog.tsvector,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.core_reparticion OWNER TO gpb;

--
-- Name: core_reparticion_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE core_reparticion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_reparticion_id_seq OWNER TO gpb;

--
-- Name: core_reparticion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE core_reparticion_id_seq OWNED BY core_reparticion.id;


--
-- Name: core_reparticionsinonimo; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE core_reparticionsinonimo (
    canonico_id integer NOT NULL,
    nombre text NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.core_reparticionsinonimo OWNER TO gpb;

--
-- Name: core_reparticionsinonimo_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE core_reparticionsinonimo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_reparticionsinonimo_id_seq OWNER TO gpb;

--
-- Name: core_reparticionsinonimo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE core_reparticionsinonimo_id_seq OWNED BY core_reparticionsinonimo.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO gpb;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO gpb;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO gpb;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO gpb;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_flatpage; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE django_flatpage (
    id integer NOT NULL,
    url character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    enable_comments boolean NOT NULL,
    template_name character varying(70) NOT NULL,
    registration_required boolean NOT NULL
);


ALTER TABLE public.django_flatpage OWNER TO gpb;

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE django_flatpage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_id_seq OWNER TO gpb;

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE django_flatpage_id_seq OWNED BY django_flatpage.id;


--
-- Name: django_flatpage_sites; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE django_flatpage_sites (
    id integer NOT NULL,
    flatpage_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.django_flatpage_sites OWNER TO gpb;

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE django_flatpage_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_sites_id_seq OWNER TO gpb;

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE django_flatpage_sites_id_seq OWNED BY django_flatpage_sites.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO gpb;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO gpb;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO gpb;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: south_migrationhistory; Type: TABLE; Schema: public; Owner: gpb; Tablespace: 
--

CREATE TABLE south_migrationhistory (
    id integer NOT NULL,
    app_name character varying(255) NOT NULL,
    migration character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.south_migrationhistory OWNER TO gpb;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: gpb
--

CREATE SEQUENCE south_migrationhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.south_migrationhistory_id_seq OWNER TO gpb;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpb
--

ALTER SEQUENCE south_migrationhistory_id_seq OWNED BY south_migrationhistory.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_message ALTER COLUMN id SET DEFAULT nextval('auth_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE core_compra ALTER COLUMN id SET DEFAULT nextval('core_compra_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE core_compralineaitem ALTER COLUMN id SET DEFAULT nextval('core_compralineaitem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE core_proveedor ALTER COLUMN id SET DEFAULT nextval('core_proveedor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE core_reparticion ALTER COLUMN id SET DEFAULT nextval('core_reparticion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE core_reparticionsinonimo ALTER COLUMN id SET DEFAULT nextval('core_reparticionsinonimo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE django_flatpage ALTER COLUMN id SET DEFAULT nextval('django_flatpage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE django_flatpage_sites ALTER COLUMN id SET DEFAULT nextval('django_flatpage_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gpb
--

ALTER TABLE south_migrationhistory ALTER COLUMN id SET DEFAULT nextval('south_migrationhistory_id_seq'::regclass);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_message_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_message
    ADD CONSTRAINT auth_message_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: core_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_compra
    ADD CONSTRAINT core_compra_pkey PRIMARY KEY (id);


--
-- Name: core_compralineaitem_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_compralineaitem
    ADD CONSTRAINT core_compralineaitem_pkey PRIMARY KEY (id);


--
-- Name: core_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_proveedor
    ADD CONSTRAINT core_proveedor_pkey PRIMARY KEY (id);


--
-- Name: core_reparticion_nombre_uniq; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_reparticion
    ADD CONSTRAINT core_reparticion_nombre_uniq UNIQUE (nombre);


--
-- Name: core_reparticion_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_reparticion
    ADD CONSTRAINT core_reparticion_pkey PRIMARY KEY (id);


--
-- Name: core_reparticionsinonimo_nombre_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_reparticionsinonimo
    ADD CONSTRAINT core_reparticionsinonimo_nombre_key UNIQUE (nombre);


--
-- Name: core_reparticionsinonimo_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY core_reparticionsinonimo
    ADD CONSTRAINT core_reparticionsinonimo_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_flatpage
    ADD CONSTRAINT django_flatpage_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_sites_flatpage_id_key; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_flatpage_id_key UNIQUE (flatpage_id, site_id);


--
-- Name: django_flatpage_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: south_migrationhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: gpb; Tablespace: 
--

ALTER TABLE ONLY south_migrationhistory
    ADD CONSTRAINT south_migrationhistory_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_message_user_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_message_user_id ON auth_message USING btree (user_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: core_compra_destino_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_compra_destino_id ON core_compra USING btree (destino_id);


--
-- Name: core_compra_fecha; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_compra_fecha ON core_compra USING btree (fecha);


--
-- Name: core_compra_proveedor_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_compra_proveedor_id ON core_compra USING btree (proveedor_id);


--
-- Name: core_compralineaitem_compra_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_compralineaitem_compra_id ON core_compralineaitem USING btree (compra_id);


--
-- Name: core_proveedor_slug; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_proveedor_slug ON core_proveedor USING btree (slug);


--
-- Name: core_proveedor_slug_like; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_proveedor_slug_like ON core_proveedor USING btree (slug varchar_pattern_ops);


--
-- Name: core_reparticion_slug; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_reparticion_slug ON core_reparticion USING btree (slug);


--
-- Name: core_reparticion_slug_like; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_reparticion_slug_like ON core_reparticion USING btree (slug varchar_pattern_ops);


--
-- Name: core_reparticionsinonimo_canonico_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX core_reparticionsinonimo_canonico_id ON core_reparticionsinonimo USING btree (canonico_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_flatpage_sites_flatpage_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX django_flatpage_sites_flatpage_id ON django_flatpage_sites USING btree (flatpage_id);


--
-- Name: django_flatpage_sites_site_id; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX django_flatpage_sites_site_id ON django_flatpage_sites USING btree (site_id);


--
-- Name: django_flatpage_url; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX django_flatpage_url ON django_flatpage USING btree (url);


--
-- Name: django_flatpage_url_like; Type: INDEX; Schema: public; Owner: gpb; Tablespace: 
--

CREATE INDEX django_flatpage_url_like ON django_flatpage USING btree (url varchar_pattern_ops);


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_message_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_message
    ADD CONSTRAINT auth_message_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: canonico_id_refs_id_6df7cc837e54fde7; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY core_reparticionsinonimo
    ADD CONSTRAINT canonico_id_refs_id_6df7cc837e54fde7 FOREIGN KEY (canonico_id) REFERENCES core_reparticion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: compra_id_refs_id_60b4bdbc; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY core_compralineaitem
    ADD CONSTRAINT compra_id_refs_id_60b4bdbc FOREIGN KEY (compra_id) REFERENCES core_compra(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: destino_id_refs_id_26ed92a4; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY core_compra
    ADD CONSTRAINT destino_id_refs_id_26ed92a4 FOREIGN KEY (destino_id) REFERENCES core_reparticion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_flatpage_sites_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_site_id_fkey FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: flatpage_id_refs_id_c0e84f5a; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT flatpage_id_refs_id_c0e84f5a FOREIGN KEY (flatpage_id) REFERENCES django_flatpage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: proveedor_id_refs_id_af03eb2; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY core_compra
    ADD CONSTRAINT proveedor_id_refs_id_af03eb2 FOREIGN KEY (proveedor_id) REFERENCES core_proveedor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_7ceef80f; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_7ceef80f FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_dfbab7d; Type: FK CONSTRAINT; Schema: public; Owner: gpb
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_dfbab7d FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

