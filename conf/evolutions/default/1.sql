# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table emessage (
  id                        bigint auto_increment not null,
  message                   varchar(255),
  subject                   varchar(255),
  sender_name               varchar(255),
  sender_email              varchar(255),
  token                     varchar(255),
  async                     tinyint(1) default 0,
  creation_date             datetime,
  valid                     tinyint(1) default 0,
  constraint pk_emessage primary key (id))
;

create table seclients (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  token                     varchar(255),
  host                      varchar(255),
  constraint pk_seclients primary key (id))
;

create table sender (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  active                    tinyint(1) default 0,
  sender_class              varchar(255),
  constraint pk_sender primary key (id))
;

create table sent_emessage (
  id                        bigint auto_increment not null,
  status                    varchar(255),
  date_sent                 datetime,
  message                   varchar(255),
  constraint pk_sent_emessage primary key (id))
;




# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table emessage;

drop table seclients;

drop table sender;

drop table sent_emessage;

SET FOREIGN_KEY_CHECKS=1;

