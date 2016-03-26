-- MySQL dump 10.13  Distrib 5.6.28, for Linux (x86_64)
--
-- Host: localhost    Database: kml_gis
-- ------------------------------------------------------
-- Server version	5.6.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `kml_gis`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `kml_gis` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `kml_gis`;

--
-- Table structure for table `geometry_columns`
--

DROP TABLE IF EXISTS `geometry_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geometry_columns` (
  `F_TABLE_CATALOG` varchar(256) DEFAULT NULL,
  `F_TABLE_SCHEMA` varchar(256) DEFAULT NULL,
  `F_TABLE_NAME` varchar(256) NOT NULL,
  `F_GEOMETRY_COLUMN` varchar(256) NOT NULL,
  `COORD_DIMENSION` int(11) DEFAULT NULL,
  `SRID` int(11) DEFAULT NULL,
  `TYPE` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geometry_columns`
--

LOCK TABLES `geometry_columns` WRITE;
/*!40000 ALTER TABLE `geometry_columns` DISABLE KEYS */;
INSERT INTO `geometry_columns` VALUES (NULL,NULL,'tl_2015_us_state','SHAPE',2,1,'POLYGON');
/*!40000 ALTER TABLE `geometry_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spatial_ref_sys`
--

DROP TABLE IF EXISTS `spatial_ref_sys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spatial_ref_sys` (
  `SRID` int(11) NOT NULL,
  `AUTH_NAME` varchar(256) DEFAULT NULL,
  `AUTH_SRID` int(11) DEFAULT NULL,
  `SRTEXT` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spatial_ref_sys`
--

LOCK TABLES `spatial_ref_sys` WRITE;
/*!40000 ALTER TABLE `spatial_ref_sys` DISABLE KEYS */;
INSERT INTO `spatial_ref_sys` VALUES (1,NULL,NULL,'GEOGCS[\"GCS_North_American_1983\",DATUM[\"North_American_Datum_1983\",SPHEROID[\"GRS_1980\",6378137,298.257222101]],PRIMEM[\"Greenwich\",0],UNIT[\"Degree\",0.017453292519943295]]');
/*!40000 ALTER TABLE `spatial_ref_sys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` tinyint(100) NOT NULL AUTO_INCREMENT,
  `region` tinyint(10) DEFAULT NULL,
  `division` tinyint(10) DEFAULT NULL,
  `statefp` char(2) DEFAULT NULL,
  `statens` char(8) DEFAULT NULL,
  `geoid` char(2) DEFAULT NULL,
  `stusps` char(2) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `lsad` char(2) DEFAULT NULL,
  `mtfcc` char(5) DEFAULT NULL,
  `funcstat` char(1) DEFAULT NULL,
  `aland` bigint(9) DEFAULT NULL,
  `awater` bigint(10) DEFAULT NULL,
  `intptlatlon` point DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,3,6,'01','01779775','01','AL','Alabama','00','G4000','A',131173369432,4593984687,'\0\0\0\0\0\0\0ZÈmE¬^@@t@·<ûµUÀ'),(2,4,9,'02','01785533','02','AK','Alaska','00','G4000','A',1477946338495,245391672906,'\0\0\0\0\0\0\0ÖÀûO¬O@ÛoíDÉ\ZcÀ'),(3,4,8,'04','01779777','04','AZ','Arizona','00','G4000','A',294204474990,1027559124,'\0\0\0\0\0\0\0(÷Ž\Z\ZA@äM~‹Îæ[À'),(4,3,7,'05','00068085','05','AR','Arkansas','00','G4000','A',134769279101,2962525273,'\0\0\0\0\0\0\0Š]6• rA@würÁtWÀ'),(5,4,9,'06','01779778','06','CA','California','00','G4000','A',403488955894,20477992907,'\0\0\0\0\0\0\0qJŠÙÜ“B@£Œ]Çâ]À'),(6,4,8,'08','01779779','08','CO','Colorado','00','G4000','A',268428431772,1175462574,'\0\0\0\0\0\0\0+/7C@I|“Kˆ`ZÀ'),(7,1,1,'09','01779780','09','CT','Connecticut','00','G4000','A',12542452026,1814924099,'\0\0\0\0\0\0\09Ú\'6ÊD@4¡IbÉ/RÀ'),(8,3,5,'10','01779781','10','DE','Delaware','00','G4000','A',5047105127,1398742998,'\0\0\0\0\0\0\0èÚÐC@Šù/DÜRÀ'),(9,3,5,'11','01702382','11','DC','District of Columbia','00','G4000','A',158364990,18633403,'\0\0\0\0\0\0\0*[¦¹sC@½â©G\ZASÀ'),(10,3,5,'12','00294478','12','FL','Florida','00','G4000','A',138904831800,31406193924,'\0\0\0\0\0\0\0ç3E%\Zu<@¾Az/šTÀ'),(11,3,5,'13','01705317','13','GA','Georgia','00','G4000','A',149169759045,4740824950,'\0\0\0\0\0\0\06à˜\n–P@@ø?vÍ\ZÛTÀ'),(12,4,9,'15','01779782','15','HI','Hawaii','00','G4000','A',16634133472,11777724416,'\0\0\0\0\0\0\0^üÈÔ3@­öU^×ocÀ'),(13,4,8,'16','01779783','16','ID','Idaho','00','G4000','A',214042831252,2397619893,'\0\0\0\0\0\0\0¦A™,F@³ºBÄ£\\À'),(14,2,3,'17','01779784','17','IL','Illinois','00','G4000','A',143794894211,6200606440,'\0\0\0\0\0\0\0Hg+\rD@\rÁ`ÄIVÀ'),(15,2,3,'18','00448508','18','IN','Indiana','00','G4000','A',92790537698,1535887357,'\0\0\0\0\0\0\0³¹ÅW–óC@á=,’UÀ'),(16,2,4,'19','01779785','19','IA','Iowa','00','G4000','A',144667481633,1077969087,'\0\0\0\0\0\0\0p6gŽöE@yÄ\0“_WÀ'),(17,2,4,'20','00481813','20','KS','Kansas','00','G4000','A',211752682810,1346896791,'\0\0\0\0\0\0\0ïÄQ^Ð?C@õÓ$Š˜XÀ'),(18,3,6,'21','01779786','21','KY','Kentucky','00','G4000','A',102266253024,2389483091,'\0\0\0\0\0\0\0T1:ÅOÄB@>øš/ÀRUÀ'),(19,3,7,'22','01629543','22','LA','Louisiana','00','G4000','A',111903220951,23747902252,'\0\0\0\0\0\0\0³)²1\nÝ>@÷*/óVÀ'),(20,1,1,'23','01779787','23','ME','Maine','00','G4000','A',79885774936,11748561064,'\0\0\0\0\0\0\0¯8A@c´F@D=Š©*QÀ'),(21,3,5,'24','01714934','24','MD','Maryland','00','G4000','A',25147417568,6983598596,'\0\0\0\0\0\0\0é=:\Z,yC@vvè*+SÀ'),(22,1,1,'25','00606926','25','MA','Massachusetts','00','G4000','A',20205425910,7130316321,'\0\0\0\0\0\0\0m—‘ÕE@“9–wUßQÀ'),(23,2,3,'26','01779789','26','MI','Michigan','00','G4000','A',146455475554,104031185771,'\0\0\0\0\0\0\0ùÉó\rlF@*n„EjUÀ'),(24,2,4,'27','00662849','27','MN','Minnesota','00','G4000','A',206236191895,18924724649,'\0\0\0\0\0\0\0jÒ·w(G@ûl.HÄŒWÀ'),(25,3,6,'28','01779790','28','MS','Mississippi','00','G4000','A',121531969224,3928386321,'\0\0\0\0\0\0\0ÖQzKÞW@@\rËú(þiVÀ'),(26,2,4,'29','01779791','29','MO','Missouri','00','G4000','A',178052626882,2487589369,'\0\0\0\0\0\0\07‰A`å,C@pí;WÀ'),(27,4,8,'30','00767982','30','MT','Montana','00','G4000','A',376964776680,3868193267,'\0\0\0\0\0\0\0íf¡øŒ†G@¢û(Ù h[À'),(28,2,4,'31','01779792','31','NE','Nebraska','00','G4000','A',198972429772,1356294775,'\0\0\0\0\0\0\0}oxæŠÅD@58[ŠõóXÀ'),(29,4,8,'32','01779793','32','NV','Nevada','00','G4000','A',284332114099,2047841189,'\0\0\0\0\0\0\0uøµ?aªC@o\Z‘^\']À'),(30,1,1,'33','01779794','33','NH','New Hampshire','00','G4000','A',23188026108,1026190438,'\0\0\0\0\0\0\0ci–º\ZÖE@¥heåQÀ'),(31,1,2,'34','01779795','34','NJ','New Jersey','00','G4000','A',19048075783,3543447118,'\0\0\0\0\0\0\0YÙã*»\rD@£Ð\r¨’ªRÀ'),(32,4,8,'35','00897535','35','NM','New Mexico','00','G4000','A',314161426332,755674004,'\0\0\0\0\0\0\0ÖJ2¼£7A@òÃRnlˆZÀ'),(33,1,2,'36','01779796','36','NY','New York','00','G4000','A',122054140553,19242497698,'\0\0\0\0\0\0\0/ ¼4êtE@¯\0KS)æRÀ'),(34,3,5,'37','01027616','37','NC','North Carolina','00','G4000','A',125918092834,13472548815,'\0\0\0\0\0\0\0~©Ÿ7ÅA@(¸`ÈSÀ'),(35,2,4,'38','01779797','38','ND','North Dakota','00','G4000','A',178711991307,4398999691,'\0\0\0\0\0\0\0²#™¸G@®}¦~YÀ'),(36,2,3,'39','01085497','39','OH','Ohio','00','G4000','A',105831379985,10266305761,'\0\0\0\0\0\0\0ÎÑ™j5D@\\Uö]‘­TÀ'),(37,3,7,'40','01102857','40','OK','Oklahoma','00','G4000','A',177663043025,3374050771,'\0\0\0\0\0\0\0—{7Ì†ËA@\'­®ù\'_XÀ'),(38,4,9,'41','01155107','41','OR','Oregon','00','G4000','A',248608778890,6190771822,'\0\0\0\0\0\0\0¥N@aüE@prdŠÞ\'^À'),(39,1,2,'42','01779798','42','PA','Pennsylvania','00','G4000','A',115883499352,3396643587,'\0\0\0\0\0\0\0ì#¦ú„sD@ŒsŠDWuSÀ'),(40,1,1,'44','01219835','44','RI','Rhode Island','00','G4000','A',2677759613,1323474145,'\0\0\0\0\0\0\0iBI7xÌD@%QÔ¾áQÀ'),(41,3,5,'45','01779799','45','SC','South Carolina','00','G4000','A',77858297564,5074366056,'\0\0\0\0\0\0\0—5Våï@@C¨[¬6TÀ'),(42,2,4,'46','01785534','46','SD','South Dakota','00','G4000','A',196349394266,3379810671,'\0\0\0\0\0\0\0)¿û™09F@àkcG>YÀ'),(43,3,6,'47','01325873','47','TN','Tennessee','00','G4000','A',106800181941,2352826875,'\0\0\0\0\0\0\0[\0låíA@›‡¸Þ[–UÀ'),(44,3,7,'48','01779801','48','TX','Texas','00','G4000','A',676634395761,19027462392,'\0\0\0\0\0\0\0pw{µHo?@±f	ÒXÀ'),(45,4,8,'49','01455989','49','UT','Utah','00','G4000','A',212885012434,6999936465,'\0\0\0\0\0\0\0àóÃáªC@sZê[À'),(46,1,1,'50','01779802','50','VT','Vermont','00','G4000','A',23872224593,1034382802,'\0\0\0\0\0\0\0\nJÑÊ½F@ ÎË+RÀ'),(47,3,5,'51','01779803','51','VA','Virginia','00','G4000','A',102282988386,8503553482,'\0\0\0\0\0\0\0ü%˜ ÙÂB@õ˜í¯ÃªSÀ'),(48,4,9,'53','01779804','53','WA','Washington','00','G4000','A',172121026344,12540093192,'\0\0\0\0\0\0\0ôð¯/#´G@‘âÒçÙ$^À'),(49,3,5,'54','01779805','54','WV','West Virginia','00','G4000','A',62266577599,489469489,'\0\0\0\0\0\0\0Ò|?ÚRC@ N­’\'TÀ'),(50,2,3,'55','01779806','55','WI','Wisconsin','00','G4000','A',140269484183,29365442607,'\0\0\0\0\0\0\08¨XÁPF@¨ƒ¬fmVÀ'),(51,4,8,'56','01779807','56','WY','Wyoming','00','G4000','A',251465042238,1861255811,'\0\0\0\0\0\0\0Œaó~E@•×Jè®âZÀ'),(52,9,0,'60','01802701','60','AS','American Samoa','00','G4000','A',197749662,1307107436,'\0\0\0\0\0\0\0£-ÅAˆ,À¿õ¼vDUeÀ'),(53,9,0,'66','01802705','66','GU','Guam','00','G4000','A',543558314,934345914,'\0\0\0\0\0\0\0Tk]gà*@êž+\0¼b@'),(54,9,0,'69','01779809','69','MP','Commonwealth of the Northern Mariana Islands','00','G4000','A',472262566,4644320317,'\0\0\0\0\0\0\0fÝ?¢ß-@²fd;3b@'),(55,9,0,'72','01779808','72','PR','Puerto Rico','00','G4000','A',8867867645,4923406204,'\0\0\0\0\0\0\01\n‚Ç·72@ENºˆJšPÀ'),(56,9,0,'78','01802710','78','VI','United States Virgin Islands','00','G4000','A',347962916,1550265400,'\0\0\0\0\0\0\04|È¥S2@†p÷(>PÀ');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state_boundaries`
--

DROP TABLE IF EXISTS `state_boundaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_boundaries` (
  `id` tinyint(100) NOT NULL,
  `lat_long` geometry NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state_boundaries`
--

LOCK TABLES `state_boundaries` WRITE;
/*!40000 ALTER TABLE `state_boundaries` DISABLE KEYS */;
/*!40000 ALTER TABLE `state_boundaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tl_2015_us_state`
--

DROP TABLE IF EXISTS `tl_2015_us_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tl_2015_us_state` (
  `OGR_FID` int(11) NOT NULL AUTO_INCREMENT,
  `SHAPE` geometry NOT NULL,
  UNIQUE KEY `OGR_FID` (`OGR_FID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tl_2015_us_state`
--

LOCK TABLES `tl_2015_us_state` WRITE;
/*!40000 ALTER TABLE `tl_2015_us_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `tl_2015_us_state` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-26  2:30:50
