PGDMP     7            	        w            sambil    10.7    10.7 W    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16688    sambil    DATABASE     �   CREATE DATABASE sambil WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE sambil;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    17209 %   comprar_no(numeric, numeric, numeric)    FUNCTION     �   CREATE FUNCTION public.comprar_no(tienda numeric, persona numeric, mont numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO comprano(idtienda, idpersona, monto) VALUES (tienda, persona, mont);

END;
$$;
 P   DROP FUNCTION public.comprar_no(tienda numeric, persona numeric, mont numeric);
       public       postgres    false    1    3            �            1255    17208 %   comprar_si(numeric, numeric, numeric)    FUNCTION     �   CREATE FUNCTION public.comprar_si(tienda numeric, persona numeric, mont numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO compratl(idtienda, idpersona, monto) VALUES (tienda, persona, mont);

END;
$$;
 P   DROP FUNCTION public.comprar_si(tienda numeric, persona numeric, mont numeric);
       public       postgres    false    1    3            �            1255    17220    descu()    FUNCTION       CREATE FUNCTION public.descu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
montoD numeric(9);
idcom numeric(9);
cant numeric(9);
begin
select count(idcomprano) into cant from comprano;
if(cant%5=0) then
montoD=new.monto*0.9;
new.monto=montod;
end if;
return new;
end;
$$;
    DROP FUNCTION public.descu();
       public       postgres    false    1    3            �            1255    17100    mesavacia()    FUNCTION     �  CREATE FUNCTION public.mesavacia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
cant numeric(2);
elegido numeric(2);
BEGIN
 select count(idmesa) into cant from mesa where estado=0;

IF cant<1 THEN
RAISE EXCEPTION 'NO HAY MESAS DISPONIBLES';
ELSE
select idmesa INTO elegido from mesa where estado=0 limit 1;
update mesa set estado=1 where idmesa=elegido;
RAISE NOTICE 'EL CLIENTE SE HA SENTADO SATISFACTORIAMENTE';
END IF;
Return new;
END
$$;
 "   DROP FUNCTION public.mesavacia();
       public       postgres    false    1    3            �            1255    17181    ocupacion_mesa()    FUNCTION     6  CREATE FUNCTION public.ocupacion_mesa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
declare 
cant numeric (2);
elegido numeric (2);
begin
if estado.new = 1 then
select count(idmesa) into cant from mesa where estado = 0;
if cant < 1 then 
RAISE exception 'No hay mesas disponibles';
else 
select idmesa into elegido from mesa where estado = 0 limit 1;
update mesa set estado = 1 where idmesa = elegido;
new.idmesa = elegido;
raise notice 'El usuario se ha sentado';
end if;
else
update mesa set estado = 0 where idmesa = idmesa.new;
end if;
return new; 
end 
$$;
 '   DROP FUNCTION public.ocupacion_mesa();
       public       postgres    false    3    1            �            1255    17213 #   ocupacion_sentado(numeric, numeric)    FUNCTION     �   CREATE FUNCTION public.ocupacion_sentado(personao numeric, mesa numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO ocupacion(idpersona, estado, idmesa) values(personaO,1,mesa);

END;
$$;
 H   DROP FUNCTION public.ocupacion_sentado(personao numeric, mesa numeric);
       public       postgres    false    3    1            �            1259    16990    comprano    TABLE     �   CREATE TABLE public.comprano (
    idcomprano integer NOT NULL,
    idtienda numeric,
    idpersona numeric,
    monto numeric
);
    DROP TABLE public.comprano;
       public         postgres    false    3            �            1259    16988    comprano_idcomprano_seq    SEQUENCE     �   CREATE SEQUENCE public.comprano_idcomprano_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.comprano_idcomprano_seq;
       public       postgres    false    3    202            �           0    0    comprano_idcomprano_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.comprano_idcomprano_seq OWNED BY public.comprano.idcomprano;
            public       postgres    false    201            �            1259    17041    compratl    TABLE     �   CREATE TABLE public.compratl (
    idcompra integer NOT NULL,
    idtienda numeric,
    idpersona numeric,
    monto numeric
);
    DROP TABLE public.compratl;
       public         postgres    false    3            �            1259    17039    compratl_idcompra_seq    SEQUENCE     �   CREATE SEQUENCE public.compratl_idcompra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.compratl_idcompra_seq;
       public       postgres    false    206    3            �           0    0    compratl_idcompra_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.compratl_idcompra_seq OWNED BY public.compratl.idcompra;
            public       postgres    false    205            �            1259    17227    persona    TABLE     �   CREATE TABLE public.persona (
    idpersona integer NOT NULL,
    edad numeric,
    estado numeric,
    sexo character varying
);
    DROP TABLE public.persona;
       public         postgres    false    3            �            1259    17294    edadpromedio    VIEW     �   CREATE VIEW public.edadpromedio AS
 SELECT trunc(avg(persona.edad), 0) AS "edad promedio de las personas"
   FROM public.persona;
    DROP VIEW public.edadpromedio;
       public       postgres    false    214    3            �            1259    17131    entrada    TABLE     �   CREATE TABLE public.entrada (
    identrada integer NOT NULL,
    idpersona numeric,
    acceso numeric,
    hora timestamp without time zone DEFAULT now()
);
    DROP TABLE public.entrada;
       public         postgres    false    3            �            1259    17129    entrada_identrada_seq    SEQUENCE     �   CREATE SEQUENCE public.entrada_identrada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.entrada_identrada_seq;
       public       postgres    false    3    212            �           0    0    entrada_identrada_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.entrada_identrada_seq OWNED BY public.entrada.identrada;
            public       postgres    false    211            �            1259    17065    estadopersonamesa    TABLE     �   CREATE TABLE public.estadopersonamesa (
    idepm integer NOT NULL,
    idpersona numeric,
    idmesa numeric,
    estado numeric
);
 %   DROP TABLE public.estadopersonamesa;
       public         postgres    false    3            �            1259    17063    estadopersonamesa_idepm_seq    SEQUENCE     �   CREATE SEQUENCE public.estadopersonamesa_idepm_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.estadopersonamesa_idepm_seq;
       public       postgres    false    3    208            �           0    0    estadopersonamesa_idepm_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.estadopersonamesa_idepm_seq OWNED BY public.estadopersonamesa.idepm;
            public       postgres    false    207            �            1259    16770    mesa    TABLE     N   CREATE TABLE public.mesa (
    idmesa numeric NOT NULL,
    estado numeric
);
    DROP TABLE public.mesa;
       public         postgres    false    3            �            1259    17011 	   ocupacion    TABLE     �   CREATE TABLE public.ocupacion (
    idocupacion integer NOT NULL,
    idpersona numeric,
    estado numeric,
    idmesa numeric,
    hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.ocupacion;
       public         postgres    false    3            �            1259    17009    ocupacion_idocupacion_seq    SEQUENCE     �   CREATE SEQUENCE public.ocupacion_idocupacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ocupacion_idocupacion_seq;
       public       postgres    false    204    3            �           0    0    ocupacion_idocupacion_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.ocupacion_idocupacion_seq OWNED BY public.ocupacion.idocupacion;
            public       postgres    false    203            �            1259    17290    perfilpersona    VIEW     �   CREATE VIEW public.perfilpersona AS
 SELECT persona.idpersona AS "id persona",
    persona.sexo AS genero,
    persona.edad
   FROM public.persona;
     DROP VIEW public.perfilpersona;
       public       postgres    false    214    214    214    3            �            1259    17225    persona_idpersona_seq    SEQUENCE     �   CREATE SEQUENCE public.persona_idpersona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.persona_idpersona_seq;
       public       postgres    false    214    3            �           0    0    persona_idpersona_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.persona_idpersona_seq OWNED BY public.persona.idpersona;
            public       postgres    false    213            �            1259    17102    porcentajeventas    VIEW     �  CREATE VIEW public.porcentajeventas AS
 SELECT ((( SELECT count(compratl.idcompra) AS count
           FROM public.compratl) * 100) / ( SELECT (( SELECT count(compratl.idcompra) AS count
                   FROM public.compratl) + ( SELECT count(comprano.idcomprano) AS count
                   FROM public.comprano)))) AS "% de ventas con telefono",
    ((( SELECT count(comprano.idcomprano) AS count
           FROM public.comprano) * 100) / ( SELECT (( SELECT count(compratl.idcompra) AS count
                   FROM public.compratl) + ( SELECT count(comprano.idcomprano) AS count
                   FROM public.comprano)))) AS "% de ventas sin telefono";
 #   DROP VIEW public.porcentajeventas;
       public       postgres    false    202    206    3            �            1259    16710    puerta    TABLE     Z   CREATE TABLE public.puerta (
    idpuerta numeric NOT NULL,
    tipo character varying
);
    DROP TABLE public.puerta;
       public         postgres    false    3            �            1259    17273    telefono    TABLE     X   CREATE TABLE public.telefono (
    macadress numeric NOT NULL,
    idpersona integer
);
    DROP TABLE public.telefono;
       public         postgres    false    3            �            1259    16718    tienda    TABLE     e   CREATE TABLE public.tienda (
    idtienda numeric NOT NULL,
    nombre character varying NOT NULL
);
    DROP TABLE public.tienda;
       public         postgres    false    3            �            1259    17286    top5    VIEW     H  CREATE VIEW public.top5 AS
 SELECT a.idpersona,
    count(a.idpersona) AS "Cantidad Visitas"
   FROM (public.persona a
     JOIN public.entrada b ON (((a.idpersona)::numeric = b.idpersona)))
  WHERE (date_part('month'::text, b.hora) = (6)::double precision)
  GROUP BY a.idpersona
  ORDER BY (count(a.idpersona)) DESC
 LIMIT 5;
    DROP VIEW public.top5;
       public       postgres    false    214    212    212    3            �            1259    16744 	   ubicacion    TABLE     e   CREATE TABLE public.ubicacion (
    idubicacion numeric NOT NULL,
    lugar character(1) NOT NULL
);
    DROP TABLE public.ubicacion;
       public         postgres    false    3            �            1259    16752    ubicacionespecifica    TABLE     �   CREATE TABLE public.ubicacionespecifica (
    idubicacionespecifica numeric NOT NULL,
    idubicacion numeric NOT NULL,
    hora timestamp without time zone NOT NULL,
    macaddress numeric NOT NULL
);
 '   DROP TABLE public.ubicacionespecifica;
       public         postgres    false    3            �            1259    17106    vecesquesento    VIEW     �   CREATE VIEW public.vecesquesento AS
 SELECT ocupacion.idpersona AS "id persona",
    count(ocupacion.idocupacion) AS "veces que se sento"
   FROM public.ocupacion
  GROUP BY ocupacion.idpersona;
     DROP VIEW public.vecesquesento;
       public       postgres    false    204    204    3            �
           2604    16993    comprano idcomprano    DEFAULT     z   ALTER TABLE ONLY public.comprano ALTER COLUMN idcomprano SET DEFAULT nextval('public.comprano_idcomprano_seq'::regclass);
 B   ALTER TABLE public.comprano ALTER COLUMN idcomprano DROP DEFAULT;
       public       postgres    false    202    201    202            �
           2604    17044    compratl idcompra    DEFAULT     v   ALTER TABLE ONLY public.compratl ALTER COLUMN idcompra SET DEFAULT nextval('public.compratl_idcompra_seq'::regclass);
 @   ALTER TABLE public.compratl ALTER COLUMN idcompra DROP DEFAULT;
       public       postgres    false    205    206    206            �
           2604    17134    entrada identrada    DEFAULT     v   ALTER TABLE ONLY public.entrada ALTER COLUMN identrada SET DEFAULT nextval('public.entrada_identrada_seq'::regclass);
 @   ALTER TABLE public.entrada ALTER COLUMN identrada DROP DEFAULT;
       public       postgres    false    211    212    212            �
           2604    17068    estadopersonamesa idepm    DEFAULT     �   ALTER TABLE ONLY public.estadopersonamesa ALTER COLUMN idepm SET DEFAULT nextval('public.estadopersonamesa_idepm_seq'::regclass);
 F   ALTER TABLE public.estadopersonamesa ALTER COLUMN idepm DROP DEFAULT;
       public       postgres    false    207    208    208            �
           2604    17014    ocupacion idocupacion    DEFAULT     ~   ALTER TABLE ONLY public.ocupacion ALTER COLUMN idocupacion SET DEFAULT nextval('public.ocupacion_idocupacion_seq'::regclass);
 D   ALTER TABLE public.ocupacion ALTER COLUMN idocupacion DROP DEFAULT;
       public       postgres    false    204    203    204            �
           2604    17230    persona idpersona    DEFAULT     v   ALTER TABLE ONLY public.persona ALTER COLUMN idpersona SET DEFAULT nextval('public.persona_idpersona_seq'::regclass);
 @   ALTER TABLE public.persona ALTER COLUMN idpersona DROP DEFAULT;
       public       postgres    false    214    213    214            v          0    16990    comprano 
   TABLE DATA               J   COPY public.comprano (idcomprano, idtienda, idpersona, monto) FROM stdin;
    public       postgres    false    202   �g       z          0    17041    compratl 
   TABLE DATA               H   COPY public.compratl (idcompra, idtienda, idpersona, monto) FROM stdin;
    public       postgres    false    206   Ph       ~          0    17131    entrada 
   TABLE DATA               E   COPY public.entrada (identrada, idpersona, acceso, hora) FROM stdin;
    public       postgres    false    212    i       |          0    17065    estadopersonamesa 
   TABLE DATA               M   COPY public.estadopersonamesa (idepm, idpersona, idmesa, estado) FROM stdin;
    public       postgres    false    208   �l       t          0    16770    mesa 
   TABLE DATA               .   COPY public.mesa (idmesa, estado) FROM stdin;
    public       postgres    false    200   m       x          0    17011 	   ocupacion 
   TABLE DATA               Q   COPY public.ocupacion (idocupacion, idpersona, estado, idmesa, hora) FROM stdin;
    public       postgres    false    204   6m       �          0    17227    persona 
   TABLE DATA               @   COPY public.persona (idpersona, edad, estado, sexo) FROM stdin;
    public       postgres    false    214   Co       p          0    16710    puerta 
   TABLE DATA               0   COPY public.puerta (idpuerta, tipo) FROM stdin;
    public       postgres    false    196   �o       �          0    17273    telefono 
   TABLE DATA               8   COPY public.telefono (macadress, idpersona) FROM stdin;
    public       postgres    false    215   �o       q          0    16718    tienda 
   TABLE DATA               2   COPY public.tienda (idtienda, nombre) FROM stdin;
    public       postgres    false    197   �o       r          0    16744 	   ubicacion 
   TABLE DATA               7   COPY public.ubicacion (idubicacion, lugar) FROM stdin;
    public       postgres    false    198   p       s          0    16752    ubicacionespecifica 
   TABLE DATA               c   COPY public.ubicacionespecifica (idubicacionespecifica, idubicacion, hora, macaddress) FROM stdin;
    public       postgres    false    199   (p       �           0    0    comprano_idcomprano_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.comprano_idcomprano_seq', 1830, true);
            public       postgres    false    201            �           0    0    compratl_idcompra_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.compratl_idcompra_seq', 1113, true);
            public       postgres    false    205            �           0    0    entrada_identrada_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.entrada_identrada_seq', 291, true);
            public       postgres    false    211            �           0    0    estadopersonamesa_idepm_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.estadopersonamesa_idepm_seq', 1, false);
            public       postgres    false    207            �           0    0    ocupacion_idocupacion_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.ocupacion_idocupacion_seq', 2939, true);
            public       postgres    false    203            �           0    0    persona_idpersona_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.persona_idpersona_seq', 1, true);
            public       postgres    false    213            �
           2606    16998    comprano comprano_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.comprano
    ADD CONSTRAINT comprano_pkey PRIMARY KEY (idcomprano);
 @   ALTER TABLE ONLY public.comprano DROP CONSTRAINT comprano_pkey;
       public         postgres    false    202            �
           2606    17049    compratl compratl_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.compratl
    ADD CONSTRAINT compratl_pkey PRIMARY KEY (idcompra);
 @   ALTER TABLE ONLY public.compratl DROP CONSTRAINT compratl_pkey;
       public         postgres    false    206            �
           2606    17139    entrada entrada_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.entrada
    ADD CONSTRAINT entrada_pkey PRIMARY KEY (identrada);
 >   ALTER TABLE ONLY public.entrada DROP CONSTRAINT entrada_pkey;
       public         postgres    false    212            �
           2606    17073 (   estadopersonamesa estadopersonamesa_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.estadopersonamesa
    ADD CONSTRAINT estadopersonamesa_pkey PRIMARY KEY (idepm);
 R   ALTER TABLE ONLY public.estadopersonamesa DROP CONSTRAINT estadopersonamesa_pkey;
       public         postgres    false    208            �
           2606    16777    mesa mesa_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.mesa
    ADD CONSTRAINT mesa_pkey PRIMARY KEY (idmesa);
 8   ALTER TABLE ONLY public.mesa DROP CONSTRAINT mesa_pkey;
       public         postgres    false    200            �
           2606    17019    ocupacion ocupacion_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.ocupacion
    ADD CONSTRAINT ocupacion_pkey PRIMARY KEY (idocupacion);
 B   ALTER TABLE ONLY public.ocupacion DROP CONSTRAINT ocupacion_pkey;
       public         postgres    false    204            �
           2606    17235    persona persona_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (idpersona);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public         postgres    false    214            �
           2606    16717    puerta puerta_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.puerta
    ADD CONSTRAINT puerta_pkey PRIMARY KEY (idpuerta);
 <   ALTER TABLE ONLY public.puerta DROP CONSTRAINT puerta_pkey;
       public         postgres    false    196            �
           2606    17280    telefono telefono_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_pkey PRIMARY KEY (macadress);
 @   ALTER TABLE ONLY public.telefono DROP CONSTRAINT telefono_pkey;
       public         postgres    false    215            �
           2606    16725    tienda tienda_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_pkey PRIMARY KEY (idtienda);
 <   ALTER TABLE ONLY public.tienda DROP CONSTRAINT tienda_pkey;
       public         postgres    false    197            �
           2606    16751    ubicacion ubicacion_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.ubicacion
    ADD CONSTRAINT ubicacion_pkey PRIMARY KEY (idubicacion);
 B   ALTER TABLE ONLY public.ubicacion DROP CONSTRAINT ubicacion_pkey;
       public         postgres    false    198            �
           2606    16759 ,   ubicacionespecifica ubicacionespecifica_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.ubicacionespecifica
    ADD CONSTRAINT ubicacionespecifica_pkey PRIMARY KEY (idubicacionespecifica);
 V   ALTER TABLE ONLY public.ubicacionespecifica DROP CONSTRAINT ubicacionespecifica_pkey;
       public         postgres    false    199            �
           2620    17224    comprano descu    TRIGGER     e   CREATE TRIGGER descu BEFORE INSERT ON public.comprano FOR EACH ROW EXECUTE PROCEDURE public.descu();
 '   DROP TRIGGER descu ON public.comprano;
       public       postgres    false    236    202            �
           2620    17186    ocupacion sentar    TRIGGER     �   CREATE TRIGGER sentar BEFORE INSERT ON public.ocupacion FOR EACH ROW EXECUTE PROCEDURE public.mesavacia();

ALTER TABLE public.ocupacion DISABLE TRIGGER sentar;
 )   DROP TRIGGER sentar ON public.ocupacion;
       public       postgres    false    204    232            �
           2606    17025    ocupacion idmesa    FK CONSTRAINT     q   ALTER TABLE ONLY public.ocupacion
    ADD CONSTRAINT idmesa FOREIGN KEY (idmesa) REFERENCES public.mesa(idmesa);
 :   ALTER TABLE ONLY public.ocupacion DROP CONSTRAINT idmesa;
       public       postgres    false    200    2779    204            �
           2606    17079    estadopersonamesa idmesaepm    FK CONSTRAINT     |   ALTER TABLE ONLY public.estadopersonamesa
    ADD CONSTRAINT idmesaepm FOREIGN KEY (idmesa) REFERENCES public.mesa(idmesa);
 E   ALTER TABLE ONLY public.estadopersonamesa DROP CONSTRAINT idmesaepm;
       public       postgres    false    200    2779    208            �
           2606    17281    telefono idpersona    FK CONSTRAINT     |   ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT idpersona FOREIGN KEY (idpersona) REFERENCES public.persona(idpersona);
 <   ALTER TABLE ONLY public.telefono DROP CONSTRAINT idpersona;
       public       postgres    false    2791    215    214            �
           2606    16999    comprano idtiendano    FK CONSTRAINT     z   ALTER TABLE ONLY public.comprano
    ADD CONSTRAINT idtiendano FOREIGN KEY (idtienda) REFERENCES public.tienda(idtienda);
 =   ALTER TABLE ONLY public.comprano DROP CONSTRAINT idtiendano;
       public       postgres    false    2773    197    202            �
           2606    17050    compratl idtiendatl    FK CONSTRAINT     z   ALTER TABLE ONLY public.compratl
    ADD CONSTRAINT idtiendatl FOREIGN KEY (idtienda) REFERENCES public.tienda(idtienda);
 =   ALTER TABLE ONLY public.compratl DROP CONSTRAINT idtiendatl;
       public       postgres    false    206    2773    197            �
           2606    16760    ubicacionespecifica idubicacion    FK CONSTRAINT     �   ALTER TABLE ONLY public.ubicacionespecifica
    ADD CONSTRAINT idubicacion FOREIGN KEY (idubicacion) REFERENCES public.ubicacion(idubicacion);
 I   ALTER TABLE ONLY public.ubicacionespecifica DROP CONSTRAINT idubicacion;
       public       postgres    false    198    2775    199            v   �   x�5�� C�Z�	��e��c�7�D� �yC�ƃӱ-.�qp��}��.�E�&Z��o�!کE']�g^��f!O �O�ܤ��ȹHn��uYG�P������r������N�!]ho#S�e]�Z�/=�c������8�J�.>"u��ôW5;]vy.�V]S�n����O����=      z   �   x�-����0г]� ����kA&��`E%k�{�[���\)N�T�(��B�t��|��q�t&"��ِ���)��T��}��K�w�m��5J�L陵��t1M�'���N������.�����H�K��E�ץSt�hv�ڴ6�>E�éؿ���?Ŝ6      ~   �  x�u�ѭ�8��*��3D����r��qK�r��E��,S_��6������ȧّ�c����R����4	 ��?�@��~#����O$5ALV�~���j����֚ IV�B\�-�X�7"�DX�����f�BT�L��B���u������F|�B�\�O�#zoZ1�q�B�܅L3hI&w!!p���CL��jT�h����.$�����]HV�'S{�u�-�څH��1Sk�?��aj/�2E�%S� ����^�h���r"8Bm�� Ԑ	-ԁ0����::�anb��&�AB�Z&w!x�k!&w̏��bs�BL��P5 L� 
�*L�Bp�	��}�8}�Od^O���@�b����	��x�o$jC��%2�P��*�������"���H�%��-d:�H3w#٫�T������U���f����-$�]Ԙ��!��	��:�͝D����͝��Dpq'�Ԯu���wbo[���ڧ�%r!�U� S<Е]�j���+�o�~��������Zgl��%c�o��A�j��)�1z��v�_�aHq���Y�����q7"�8"n!�%�"+N�o�R�x�=�o�����I��� q^�D��6y�'V�o����<�$9��(-��-�X���2X�bG�i���ۅ��<X�>D6h�m�m�SX�>H�&t��]�.�:�iv"]������A7i��ا�A��)�O�/Z�	ߧ�$jG�O�/����>�� Y���4{\$��{���G����}3����E�d��?����G��U�;�r!�˴N�^N���:�^NAYH')� 9�n�`������I��B&��2i0�ȨI4i.,�.���܍xG�M��g�8#�ndbp&�F�
D����s3:gm����>Έ����_gD�B7{f�Fj\��܍�;
�n!����3��FP
���3�n!)�|�u�����x���r)��      |      x������ � �      t      x�3�4�2�4������ ��      x   �  x�u�ˑ+1�u;���P��e��z�Pe�|J����=X_F����_�/p�1�pD�*!DS�T�H!����� %�?�(/b�JF��ʐ]���Ձc���q�?��?����:�b�pr�jξA9os��*M�ڡ�9�V�.ĭ��9	�����u�VL*�dSb��B�J7�t��޶}TJJ�k��S�]k�^X���:�	|踵Z��J���5zC�F/Es�[����\�6�����������җbЪ`�+i)�����җ�Cz�Zr/�q(���y������Xs�Vf��x����m����
�>"ϝ��JB��{�x�|��ixu목��KuG`���@��Uu^��]k��*��#�y��UU.�w�)�R�wQ��FS�/:���f��UR�<ُ(S��`��_��_�}~�-�jj�U� T괚Z�����g�Y��cf�%K��׍����赯ɴW�sUD������������/|>����]A      �   Z   x�U��� C�����x1����u'����+;��Q�'��YoZ~G.��P߳�=4�!�s�yEt����&xȐ�6I:�6��-S      p      x������ � �      �      x������ � �      q      x�3����N����� ��      r      x������ � �      s      x������ � �     