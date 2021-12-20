--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: kullaniciara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullaniciara(kullanici_id_input integer) RETURNS TABLE(kullanici_id integer, kullanici_adi character varying, kullanici_soyadi character varying, email character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

return query select "Kullanici"."kullanici_id","Kullanici"."kullanici_adi","Kullanici"."kullanici_soyadi","Kullanici"."email" from public."Kullanici" where "Kullanici"."kullanici_id" = kullanici_id_input;

end
$$;


ALTER FUNCTION public.kullaniciara(kullanici_id_input integer) OWNER TO postgres;

--
-- Name: kullaniciekle(character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullaniciekle(kullaniciadi character varying, kullanicisoyadi character varying, email character varying, dogumyili integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN

INSERT INTO public."Kullanici"("kullanici_adi","kullanici_soyadi","email","dogum_tarihi") values (kullaniciAdi,kullaniciSoyadi,email,dogumYili);

end
$$;


ALTER FUNCTION public.kullaniciekle(kullaniciadi character varying, kullanicisoyadi character varying, email character varying, dogumyili integer) OWNER TO postgres;

--
-- Name: kullaniciguncelle(integer, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullaniciguncelle(kullaniciid integer, kullaniciadi character varying, kullanicisoyadi character varying, emailinput character varying, dogumyili integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN

update public."Kullanici" set "kullanici_adi"=kullaniciAdi,"kullanici_soyadi"=kullaniciSoyadi,"email"=emailInput,"dogum_tarihi"=dogumYili where "kullanici_id"=kullaniciID;

end
$$;


ALTER FUNCTION public.kullaniciguncelle(kullaniciid integer, kullaniciadi character varying, kullanicisoyadi character varying, emailinput character varying, dogumyili integer) OWNER TO postgres;

--
-- Name: kullanicisilme(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanicisilme(kullanici_id_input integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN

DELETE from public."Kullanici" where kullanici_id=kullanici_id_input;

end
$$;


ALTER FUNCTION public.kullanicisilme(kullanici_id_input integer) OWNER TO postgres;


--
-- Name: kullanicisayisiartma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanicisayisiartma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

update "KullaniciSayisi" set "kullanici_sayisi"= "kullanici_sayisi"+ 1;
RETURN NEW;
end
$$;


ALTER FUNCTION public.kullanicisayisiartma() OWNER TO postgres;

--
-- Name: kullanicisayisiazalma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanicisayisiazalma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

update "KullaniciSayisi" set "kullanici_sayisi"= "kullanici_sayisi" -  1;
RETURN NEW;
end
$$;


ALTER FUNCTION public.kullanicisayisiazalma() OWNER TO postgres;

--
-- Name: sanatcisayisiartma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sanatcisayisiartma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

update "SanatciSayisi" set"sanatci_sayisi"="sanatci_sayisi" +  1;
RETURN NEW;
end
$$;


ALTER FUNCTION public.sanatcisayisiartma() OWNER TO postgres;

--
-- Name: sanatcisayisiazalma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sanatcisayisiazalma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

update "SanatciSayisi" set "sanatci_sayisi"= "sanatci_sayisi" -  1;

RETURN NEW;
end
$$;


ALTER FUNCTION public.sanatcisayisiazalma() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Album" (
    album_adi character varying NOT NULL,
    sure character varying NOT NULL,
    album_id integer NOT NULL,
    sanatci_id integer NOT NULL
);


ALTER TABLE public."Album" OWNER TO postgres;

--
-- Name: AlbumFotografi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AlbumFotografi" (
    fotograf character varying NOT NULL,
    album_foto_id integer NOT NULL,
    album_id integer NOT NULL
);


ALTER TABLE public."AlbumFotografi" OWNER TO postgres;

--
-- Name: Begeni; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Begeni" (
    begeni_tarihi date NOT NULL,
    begeni_id integer NOT NULL,
    album_id integer NOT NULL,
    "Kullanici_id" integer NOT NULL
);


ALTER TABLE public."Begeni" OWNER TO postgres;

--
-- Name: CalmaListesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CalmaListesi" (
    calmalistesi_adi character varying NOT NULL,
    calma_listesi_id integer NOT NULL
);


ALTER TABLE public."CalmaListesi" OWNER TO postgres;

--
-- Name: Dil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dil" (
    dil_id integer NOT NULL,
    dil character varying NOT NULL
);


ALTER TABLE public."Dil" OWNER TO postgres;

--
-- Name: EklenenAlbum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EklenenAlbum" (
    eklenen_tarih date NOT NULL,
    album_id integer NOT NULL,
    kullanici_id integer NOT NULL,
    eklenen_album_id integer NOT NULL
);


ALTER TABLE public."EklenenAlbum" OWNER TO postgres;

--
-- Name: KareFotograf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KareFotograf" (
    fotograf character varying,
    kare_fotograf_id integer NOT NULL,
    sanatci_id integer NOT NULL,
    kullanici_id integer NOT NULL
);


ALTER TABLE public."KareFotograf" OWNER TO postgres;

--
-- Name: Kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kullanici" (
    email character varying,
    kullanici_adi character varying NOT NULL,
    kullanici_soyadi character varying,
    kullanici_id integer NOT NULL,
    dogum_tarihi integer NOT NULL
);


ALTER TABLE public."Kullanici" OWNER TO postgres;

--
-- Name: KullaniciCalmaListesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KullaniciCalmaListesi" (
    kullanici_calma_listesi_id integer NOT NULL,
    kullanici_id integer NOT NULL,
    calmalistesi_id integer NOT NULL
);


ALTER TABLE public."KullaniciCalmaListesi" OWNER TO postgres;

--
-- Name: KullaniciSayisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KullaniciSayisi" (
    kullanici_sayisi integer NOT NULL
);


ALTER TABLE public."KullaniciSayisi" OWNER TO postgres;

--
-- Name: Kullanici_kullanici_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Kullanici" ALTER COLUMN kullanici_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Kullanici_kullanici_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Sanatci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sanatci" (
    sanatci_adi character varying NOT NULL,
    sanatci_soyadi character varying NOT NULL,
    sanatci_id integer NOT NULL
);


ALTER TABLE public."Sanatci" OWNER TO postgres;

--
-- Name: SanatciSayisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SanatciSayisi" (
    sanatci_sayisi integer NOT NULL
);


ALTER TABLE public."SanatciSayisi" OWNER TO postgres;

--
-- Name: Sarki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sarki" (
    sarki character varying NOT NULL,
    sarki_adi character varying NOT NULL,
    sarki_yili date,
    toplam_sure integer,
    sarki_id integer NOT NULL,
    album_id integer NOT NULL
);


ALTER TABLE public."Sarki" OWNER TO postgres;

--
-- Name: SarkiDili; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SarkiDili" (
    sarki_dili_id integer NOT NULL,
    dil character varying NOT NULL,
    sarki_id integer NOT NULL,
    dil_id integer NOT NULL
);


ALTER TABLE public."SarkiDili" OWNER TO postgres;

--
-- Name: SarkiSozu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SarkiSozu" (
    sarki_sozu_id integer NOT NULL,
    sarki_sozu character varying NOT NULL,
    sarki_id integer NOT NULL
);


ALTER TABLE public."SarkiSozu" OWNER TO postgres;

--
-- Name: SarkiTuru; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SarkiTuru" (
    sarki_turu_id integer NOT NULL,
    sarki_turu character varying NOT NULL,
    sarki_id integer NOT NULL,
    tur_id integer NOT NULL
);


ALTER TABLE public."SarkiTuru" OWNER TO postgres;

--
-- Name: Takip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Takip" (
    takip_id integer NOT NULL,
    takip_sahibi_id integer NOT NULL,
    takip_edilen_id integer NOT NULL
);


ALTER TABLE public."Takip" OWNER TO postgres;

--
-- Name: Tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tur" (
    tur_id integer NOT NULL,
    tur character varying NOT NULL
);


ALTER TABLE public."Tur" OWNER TO postgres;

--
-- Data for Name: Album; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: AlbumFotografi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Begeni; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: CalmaListesi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Dil; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: EklenenAlbum; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: KareFotograf; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kullanici" OVERRIDING SYSTEM VALUE VALUES
	('srykrksl@gmail.com', 'gencay', 'karasakal', 1, 1998),
	('srykrksl@gmail.com', 'seray', 'karasakal', 5, 2001),
	('srykrksl@gmail.com', 'seray', 'karasakal', 6, 2001),
	('ahmetgozupek@gmail.com', 'ahmet', 'gozupek', 11, 2004),
	('seraykarasakl@gmail.com', 'seray', 'karasakal', 12, 2001),
	('altinozismail@gmail.com', 'ismail', 'altin', 3, 1978);


--
-- Data for Name: KullaniciCalmaListesi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: KullaniciSayisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KullaniciSayisi" VALUES
	(6);


--
-- Data for Name: Sanatci; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SanatciSayisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."SanatciSayisi" VALUES
	(0);


--
-- Data for Name: Sarki; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SarkiDili; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SarkiSozu; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SarkiTuru; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Takip; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Tur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Kullanici_kullanici_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_kullanici_id_seq"', 13, true);


--
-- Name: AlbumFotografi AlbumFotografi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlbumFotografi"
    ADD CONSTRAINT "AlbumFotografi_pkey" PRIMARY KEY (album_foto_id);


--
-- Name: Album Album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "Album_pkey" PRIMARY KEY (album_id);


--
-- Name: Begeni Begeni_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Begeni"
    ADD CONSTRAINT "Begeni_pkey" PRIMARY KEY (begeni_id);


--
-- Name: CalmaListesi CalmaListesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CalmaListesi"
    ADD CONSTRAINT "CalmaListesi_pkey" PRIMARY KEY (calma_listesi_id);


--
-- Name: Dil Dil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dil"
    ADD CONSTRAINT "Dil_pkey" PRIMARY KEY (dil_id);


--
-- Name: EklenenAlbum EklenenSarki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EklenenAlbum"
    ADD CONSTRAINT "EklenenSarki_pkey" PRIMARY KEY (album_id);


--
-- Name: KareFotograf KareFotograf_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KareFotograf"
    ADD CONSTRAINT "KareFotograf_pkey" PRIMARY KEY (kare_fotograf_id);


--
-- Name: KullaniciCalmaListesi KullaniciCalmaListesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciCalmaListesi"
    ADD CONSTRAINT "KullaniciCalmaListesi_pkey" PRIMARY KEY (kullanici_calma_listesi_id);


--
-- Name: Kullanici Kullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "Kullanici_pkey" PRIMARY KEY (kullanici_id);


--
-- Name: Sanatci Sanatci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sanatci"
    ADD CONSTRAINT "Sanatci_pkey" PRIMARY KEY (sanatci_id);


--
-- Name: SarkiDili SarkiDili_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiDili"
    ADD CONSTRAINT "SarkiDili_pkey" PRIMARY KEY (sarki_dili_id);


--
-- Name: SarkiTuru SarkiTuru_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiTuru"
    ADD CONSTRAINT "SarkiTuru_pkey" PRIMARY KEY (sarki_turu_id);


--
-- Name: Sarki Sarki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sarki"
    ADD CONSTRAINT "Sarki_pkey" PRIMARY KEY (sarki_id);


--
-- Name: Takip Takip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Takip"
    ADD CONSTRAINT "Takip_pkey" PRIMARY KEY (takip_id);


--
-- Name: Tur Tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tur"
    ADD CONSTRAINT "Tur_pkey" PRIMARY KEY (tur_id);


--
-- Name: AlbumFotografi unique_AlbumFotografi_Album_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlbumFotografi"
    ADD CONSTRAINT "unique_AlbumFotografi_Album_id" UNIQUE (album_id);


--
-- Name: Album unique_Album_album_i; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "unique_Album_album_i" UNIQUE (album_id);


--
-- Name: KareFotograf unique_KareFotograf_Kullanici_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KareFotograf"
    ADD CONSTRAINT "unique_KareFotograf_Kullanici_id" UNIQUE (kullanici_id);


--
-- Name: KareFotograf unique_KareFotograf_Sanatci_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KareFotograf"
    ADD CONSTRAINT "unique_KareFotograf_Sanatci_id" UNIQUE (sanatci_id);


--
-- Name: SarkiSozu unique_SarkiSozu_Sarki_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiSozu"
    ADD CONSTRAINT "unique_SarkiSozu_Sarki_id" UNIQUE (sarki_id);


--
-- Name: SarkiSozu unique_SarkiSozu_sarkiSozuID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiSozu"
    ADD CONSTRAINT "unique_SarkiSozu_sarkiSozuID" PRIMARY KEY (sarki_sozu_id);


--
-- Name: index_Album_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Album_id" ON public."Sarki" USING btree (album_id);


--
-- Name: index_Album_id1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Album_id1" ON public."Begeni" USING btree (album_id);


--
-- Name: index_Album_id2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Album_id2" ON public."EklenenAlbum" USING btree (eklenen_album_id);


--
-- Name: index_CalmaListesi_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_CalmaListesi_id" ON public."KullaniciCalmaListesi" USING btree (calmalistesi_id);


--
-- Name: index_Dil_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Dil_id" ON public."SarkiDili" USING btree (dil_id);


--
-- Name: index_Kullanici_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Kullanici_id" ON public."Begeni" USING btree ("Kullanici_id");


--
-- Name: index_Kullanici_id1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Kullanici_id1" ON public."EklenenAlbum" USING btree (kullanici_id);


--
-- Name: index_Kullanici_id2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Kullanici_id2" ON public."KullaniciCalmaListesi" USING btree (kullanici_id);


--
-- Name: index_Sanatci_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Sanatci_id" ON public."Album" USING btree (sanatci_id);


--
-- Name: index_Sarki_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Sarki_id" ON public."SarkiDili" USING btree (sarki_id);


--
-- Name: index_Sarki_id1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Sarki_id1" ON public."SarkiTuru" USING btree (sarki_id);


--
-- Name: index_Tur_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_Tur_id" ON public."SarkiTuru" USING btree (tur_id);


--
-- Name: Kullanici KullaniciSayisiArtmaTrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "KullaniciSayisiArtmaTrigger" AFTER INSERT ON public."Kullanici" FOR EACH ROW EXECUTE FUNCTION public.kullanicisayisiartma();


--
-- Name: Kullanici KullaniciSayisiAzalmaTrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "KullaniciSayisiAzalmaTrigger" AFTER DELETE ON public."Kullanici" FOR EACH ROW EXECUTE FUNCTION public.kullanicisayisiazalma();


--
-- Name: Sanatci SanatciSayisiArtmaTrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "SanatciSayisiArtmaTrigger" AFTER INSERT ON public."Sanatci" FOR EACH ROW EXECUTE FUNCTION public.sanatcisayisiartma();


--
-- Name: Sanatci SanatciSayisiAzalmaTrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "SanatciSayisiAzalmaTrigger" AFTER DELETE ON public."Sanatci" FOR EACH ROW EXECUTE FUNCTION public.sanatcisayisiazalma();


--
-- Name: AlbumFotografi lnk_Album_AlbumFotografi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlbumFotografi"
    ADD CONSTRAINT "lnk_Album_AlbumFotografi" FOREIGN KEY (album_id) REFERENCES public."Album"(album_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Begeni lnk_Album_Begeni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Begeni"
    ADD CONSTRAINT "lnk_Album_Begeni" FOREIGN KEY (album_id) REFERENCES public."Album"(album_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EklenenAlbum lnk_Album_EklenenAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EklenenAlbum"
    ADD CONSTRAINT "lnk_Album_EklenenAlbum" FOREIGN KEY (eklenen_album_id) REFERENCES public."Album"(album_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Sarki lnk_Album_Sarki; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sarki"
    ADD CONSTRAINT "lnk_Album_Sarki" FOREIGN KEY (album_id) REFERENCES public."Album"(album_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KullaniciCalmaListesi lnk_CalmaListesi_KullaniciCalmaListesi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciCalmaListesi"
    ADD CONSTRAINT "lnk_CalmaListesi_KullaniciCalmaListesi" FOREIGN KEY (calmalistesi_id) REFERENCES public."CalmaListesi"(calma_listesi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SarkiDili lnk_Dil_SarkiDili; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiDili"
    ADD CONSTRAINT "lnk_Dil_SarkiDili" FOREIGN KEY (dil_id) REFERENCES public."Dil"(dil_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Begeni lnk_Kullanici_Begeni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Begeni"
    ADD CONSTRAINT "lnk_Kullanici_Begeni" FOREIGN KEY ("Kullanici_id") REFERENCES public."Kullanici"(kullanici_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EklenenAlbum lnk_Kullanici_EklenenAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EklenenAlbum"
    ADD CONSTRAINT "lnk_Kullanici_EklenenAlbum" FOREIGN KEY (kullanici_id) REFERENCES public."Kullanici"(kullanici_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KareFotograf lnk_Kullanici_KareFotograf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KareFotograf"
    ADD CONSTRAINT "lnk_Kullanici_KareFotograf" FOREIGN KEY (kullanici_id) REFERENCES public."Kullanici"(kullanici_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KullaniciCalmaListesi lnk_Kullanici_KullaniciCalmaListesi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciCalmaListesi"
    ADD CONSTRAINT "lnk_Kullanici_KullaniciCalmaListesi" FOREIGN KEY (kullanici_id) REFERENCES public."Kullanici"(kullanici_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Takip lnk_Kullanici_Takip; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Takip"
    ADD CONSTRAINT "lnk_Kullanici_Takip" FOREIGN KEY (takip_sahibi_id) REFERENCES public."Kullanici"(kullanici_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Album lnk_Sanatci_Album; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "lnk_Sanatci_Album" FOREIGN KEY (sanatci_id) REFERENCES public."Sanatci"(sanatci_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KareFotograf lnk_Sanatci_KareFotograf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KareFotograf"
    ADD CONSTRAINT "lnk_Sanatci_KareFotograf" FOREIGN KEY (sanatci_id) REFERENCES public."Sanatci"(sanatci_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Takip lnk_Sanatci_Takip; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Takip"
    ADD CONSTRAINT "lnk_Sanatci_Takip" FOREIGN KEY (takip_edilen_id) REFERENCES public."Sanatci"(sanatci_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SarkiDili lnk_Sarki_SarkiDili; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiDili"
    ADD CONSTRAINT "lnk_Sarki_SarkiDili" FOREIGN KEY (sarki_id) REFERENCES public."Sarki"(sarki_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SarkiSozu lnk_Sarki_SarkiSozu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiSozu"
    ADD CONSTRAINT "lnk_Sarki_SarkiSozu" FOREIGN KEY (sarki_id) REFERENCES public."Sarki"(sarki_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SarkiTuru lnk_Sarki_SarkiTuru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiTuru"
    ADD CONSTRAINT "lnk_Sarki_SarkiTuru" FOREIGN KEY (sarki_id) REFERENCES public."Sarki"(sarki_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SarkiTuru lnk_Tur_SarkiTuru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SarkiTuru"
    ADD CONSTRAINT "lnk_Tur_SarkiTuru" FOREIGN KEY (tur_id) REFERENCES public."Tur"(tur_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

