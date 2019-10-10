using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    [Table("WS_AlfaCapital")]
    public class AlfaCapital
    {
        [Key]
        [Column("Id")]
        public int Id { get; set; }
        [Column("ID клиента")]
        [Display(Description = "IdClient!!!")]
        public String IdClient { get; set; }
        [Column("Телефон")]
        [Display(Description = "Телефон",Name = "Телефон")]
        public String MOBILE { get; set; }
        [Column("ИО")]
        public String FIO { get; set; }
        [Column("Текущий продукт")]
        public String ProductCurrent { get; set; }
        [Column("Дата открытия продукта")]
        public String ProductDateOpen { get; set; }
        [Column("канал(куда навигируем на докупку)")]
        public String Channel { get; set; }
        [Column("Доходность текущая")]
        public String ProfitabilityCurrent { get; set; }
        [Column("Новое предложени")]
        public String NewOffer { get; set; }
        [Column("Фонд предлагаемый")]
        public String FondOffer { get; set; }
        [Column("Горизонт временной")]
        public String TimeHorizon { get; set; }
        [Column("Задача")]
        public String Task { get; set; }
        [Column("Тип реакции")]
        public String TypeReaction { get; set; }
        [Column("Комментарий")]
        public String Comment { get; set; }
        [Column("Дата/время")]
        public String DateTime { get; set; }
        [Column("Дата передачи контакта")]
        public String DateTransferContact { get; set; }
        [Column("Operator")]
        public String Operator { get; set; }
        [Column("count")]
        public String countCall { get; set; }
        [Column("LastStatus")]
        public String LastStatus { get; set; }
        [Column("TimeZona")]
        public String TimeZona { get; set; }


        [Column("Статус звонка (первого)")]
        public String LastCallFirst { get; set; }
        [Column("Количество дозвонов (клиент ответил на звонок)")]
        public Int32 CountTalkCall { get; set; }
        [Column("Статус звонка (последний дозвон)")]
        public String LastCallLast { get; set; }
        [Column("Время разговора (последний дозвон)")]
        public Int32 TalkTimeLastCall { get; set; }

        public override string ToString()
        {
            return " IdClient " + IdClient
        + ", MOBILE " + MOBILE
        + ", FIO " + FIO
        + ", ProductCurrent " + ProductCurrent
        + ", ProductDateOpen " + ProductDateOpen
        + ", Channel " + Channel
        + ", ProfitabilityCurrent " + ProfitabilityCurrent
        + ", NewOffer " + NewOffer
        + ", FondOffer " + FondOffer
        + ", TimeHorizon " + TimeHorizon
        + ", Task " + Task
        + ", TypeReaction " + TypeReaction
        + ", Comment " + Comment
        + ", DateTime " + DateTime
        + ", DateTransferContact " + DateTransferContact
        + ", Operator " + Operator
        + ", countCall " + countCall
        + ", LastStatus " + LastStatus
        + ", TimeZona " + TimeZona
        + ", LastCallFirst " + LastCallFirst
        + ", CountTalkCall " + CountTalkCall
        + ", LastCallLast " + LastCallLast
        + ", TalkTimeLastCall " + TalkTimeLastCall
        + ", Channel " + Channel;
        }
    }  

    /*
    { 
    "id": "9d7e0048-5f33-42ba-a579-19d9dbefd367", 
    "MOBILE": "+79267216924", 
    "partner": "default", 
    "stage": "<table><tr><td>0. Заказ звонка</td><td></td></tr></table>", 
    "scheduledTime": "2019-09-04T09:14:45", 
    "error": false 
} 

CREATE TABLE[dbo].[A_TaskManager_LocalList_ae2d045c-f519-4abb-8809-d5374aa275e8_0]
(

   [Id][int] IDENTITY(1,1) NOT NULL,

  [ID клиента] [nvarchar] (2000) NULL,
	[Телефон] [nvarchar] (2000) NULL,
	[ИО] [nvarchar] (2000) NULL,
	[Текущий продукт] [nvarchar] (2000) NULL,
	[Дата открытия продукта] [nvarchar] (2000) NULL,
	[канал(куда навигируем на докупку)] [nvarchar] (2000) NULL,
	[Доходность текущая] [nvarchar] (2000) NULL,
	[Новое предложени] [nvarchar] (2000) NULL,
	[Фонд предлагаемый] [nvarchar] (2000) NULL,
	[Доходность предлагаемого фонда] [nvarchar] (2000) NULL,
	[Горизонт временной] [nvarchar] (2000) NULL,
	[Задача] [nvarchar] (2000) NULL,
	[Тип реакции] [nvarchar] (2000) NULL,
	[Комментарий] [nvarchar] (2000) NULL,
	[Дата/время] [nvarchar] (2000) NULL,
	[Дата передачи контакта] [nvarchar] (2000) NULL,
	[Operator] [nvarchar] (2000) NULL,
	[count] [nvarchar] (2000) NULL,
	[LastStatus] [nvarchar] (2000) NULL,
	[TimeZona] [nvarchar] (2000) NULL,
PRIMARY KEY CLUSTERED
(
    [Id] ASC
)WITH(PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON[PRIMARY]
) ON[PRIMARY]

GO

*/
}