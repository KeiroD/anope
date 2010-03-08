
-- If you need to create your db, uncomment the following lines.
-- 
-- CREATE DATABASE anope;
-- USE anope;


-- --------------------------------------------------------

--
-- Table structure for table 'anope_extra'
--

DROP TABLE IF EXISTS anope_extra;
CREATE TABLE anope_extra (
  data text NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'anope_commands'
--

DROP TABLE IF EXISTS anope_commands;
CREATE TABLE anope_commands (
   nick varchar(255) NOT NULL default '',
   service varchar(255) NOT NULL default '',
   command text NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table 'anope_ns_core'
--

DROP TABLE IF EXISTS anope_ns_core;
CREATE TABLE anope_ns_core (
  display varchar(255) NOT NULL default '',
  pass text NOT NULL,
  email text NOT NULL default '',
  greet text NOT NULL default '',
  icq int(10) unsigned NOT NULL default '0',
  url text NOT NULL default '',
  flags text NOT NULL default '',
  language smallint(5) unsigned NOT NULL default '0',
  channelcount smallint(5) unsigned NOT NULL default '0',
  memomax smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (display)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table 'anope_ns_core_metadata'
--

DROP TABLE IF EXISTS anope_ns_core_metadata;
CREATE TABLE anope_ns_core_metadata (
  nick varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  value text NOT NULL default '',
  PRIMARY KEY  (name)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ---------------------------------------------------------
-- 
-- Table structure for table 'anope_ns_alias'
--

DROP TABLE IF EXISTS anope_ns_alias;
CREATE TABLE anope_ns_alias (
  nick varchar(255) NOT NULL default '',
  last_quit text NOT NULL,
  last_realname text NOT NULL,
  last_usermask text NOT NULL,
  time_registered int(11) unsigned NOT NULL default '0',
  last_seen int(10) unsigned NOT NULL default '0',
  flags text NOT NULL default '',
  display varchar(255) NOT NULL default '',
  PRIMARY KEY  (nick)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table 'anope_ns_alias_metadata'
--

DROP TABLE IF EXISTS anope_ns_alias_metadata;
CREATE TABLE anope_ns_alias_metadata (
  nick varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  value text NOT NULL default '',
  PRIMARY KEY  (name)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table 'anope_ns_access'
--

DROP TABLE IF EXISTS anope_ns_access;
CREATE TABLE anope_ns_access (
  display varchar(255) NOT NULL default '',
  access varchar(160) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ---------------------------------------------------------

-- 
-- Table structure for table 'anope_ns_request'
--

DROP TABLE IF EXISTS anope_ns_request;
CREATE TABLE anope_ns_request (
  nick varchar(255) NOT NULL default '',
  passcode text NOT NULL,
  password text NOT NULL,
  email text NOT NULL,
  requested int(11) NOT NULL default '0',
  PRIMARY KEY  (nick)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Table structure for table 'anope_cs_access'
-- 

DROP TABLE IF EXISTS anope_cs_access;
CREATE TABLE anope_cs_access (
  level int(11) NOT NULL default '0',
  display varchar(255) NOT NULL default '',
  channel varchar(255) NOT NULL default '',
  last_seen int(11) NOT NULL default '0',
  creator varchar(255) NOT NULL default '',
  UNIQUE KEY (channel,display)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table 'anope_cs_info'
-- 

DROP TABLE IF EXISTS anope_cs_info;
CREATE TABLE anope_cs_info (
  name varchar(255) NOT NULL default '',
  founder text NOT NULL,
  successor text NOT NULL,
  descr text NOT NULL,
  url text NOT NULL,
  email text NOT NULL,
  time_registered int(11) unsigned NOT NULL default '0',
  last_used int(10) unsigned NOT NULL default '0',
  last_topic text NOT NULL,
  last_topic_setter text NOT NULL,
  last_topic_time int(11) unsigned NOT NULL default '0',
  flags text NOT NULL default '',
  forbidby text NOT NULL,
  forbidreason text NOT NULL,
  bantype smallint(6) NOT NULL default '0',
  mlock_on text NOT NULL default '',
  mlock_off text NOT NULL default '',
  mlock_params text NOT NULL default '',
  entry_message text NOT NULL,
  memomax smallint(5) unsigned NOT NULL default '0',
  botnick varchar(255) NOT NULL default '',
  botflags text NOT NULL default '',
  capsmin smallint(6) NOT NULL default '0',
  capspercent smallint(6) NOT NULL default '0',
  floodlines smallint(6) NOT NULL default '0',
  floodsecs smallint(6) NOT NULL default '0',
  repeattimes smallint(6) NOT NULL default '0',
  PRIMARY KEY  (name)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table 'anope_cs_info_metadata'
--

DROP TABLE IF EXISTS anope_cs_info_metadata;
CREATE TABLE anope_cs_info_metadata (
  channel varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  value text NOT NULL default '',
  PRIMARY KEY  (name)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table 'anope_cs_levels'
-- 

DROP TABLE IF EXISTS anope_cs_levels;
CREATE TABLE anope_cs_levels (
  channel varchar(255) NOT NULL default '',
  position int(11) NOT NULL default '0',
  level int(11) NOT NULL default '0',
  UNIQUE KEY channel (channel,position)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'anope_bs_core'
--

DROP TABLE IF EXISTS anope_bs_core;
CREATE TABLE anope_bs_core (
  nick varchar(255) NOT NULL default '',
  user varchar(255) NOT NULL default '',
  host text NOT NULL default '',
  rname text NOT NULL default '',
  flags text NOT NULL default '',
  created int(11) NOT NULL default '0',
  chancount int(11) NOT NULL default '0',
  PRIMARY KEY (nick)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table 'anope_metadata'
--

DROP TABLE IF EXISTS anope_metadata;
CREATE TABLE anope_metadata (
  name varchar(255) NOT NULL default '',
  value text NOT NULL default '',
  PRIMARY KEY  (name)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table 'anope_info'
-- 

DROP TABLE IF EXISTS anope_info;
CREATE TABLE anope_info (
  version int(11) default NULL,
  date datetime default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
