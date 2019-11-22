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
        /// <summary>
        /// Индификатор контакта (caseid)
        /// </summary>
        [Key]
        [Column("Id")]
        public int Id { get; set; }
        /// <summary>
        /// Это ID клиента
        /// </summary> 
        [Column("ID клиента")]
        [Required]
        [Display(Description = "IdClient!!!")]        
        public String IdClient { get; set; }

        /// <summary>
        /// Телефон
        /// </summary> 
        [Column("Телефон")]
        [Required]
        [Display(Description = "Телефон",Name = "Телефон")]
        public String MOBILE { get; set; }
        /// <summary>
        /// ФИО
        /// </summary>
        [Column("ИО")]
        public String FIO { get; set; }
        /// <summary>
        /// Текущий продукт
        /// </summary>
        [Column("Текущий продукт")]
        public String ProductCurrent { get; set; }
        /// <summary>
        /// Дата открытия продукта
        /// </summary>
        [Column("Дата открытия продукта")]
        public String ProductDateOpen { get; set; }
        /// <summary>
        /// канал(куда навигируем на докупку)
        /// </summary>
        [Column("канал(куда навигируем на докупку)")]
        public String Channel { get; set; }
        /// <summary>
        /// Доходность текущая
        /// </summary>
        [Column("Доходность текущая")]
        public String ProfitabilityCurrent { get; set; }
        /// <summary>
        /// Новое предложени
        /// </summary>
        [Column("Новое предложени")]
        public String NewOffer { get; set; }
        /// <summary>
        /// Фонд предлагаемый
        /// </summary>
        [Column("Фонд предлагаемый")]
        public String FondOffer { get; set; }
        /// <summary>
        /// Горизонт временной
        /// </summary>
        [Column("Горизонт временной")]
        public String TimeHorizon { get; set; }
        /// <summary>
        /// Задача(проект)
        /// </summary>
        [Column("Задача")]
        public String Task { get; set; }
        /// <summary>
        /// Тип реакции
        /// </summary>
        [Column("Тип реакции")]
        public String TypeReaction { get; set; }
        /// <summary>
        /// Комментарий
        /// </summary>
        [Column("Комментарий")]
        public String Comment { get; set; }
        /// <summary>
        /// Дата/время
        /// </summary>
        [Column("Дата/время")]
        public DateTime? DateTime { get; set; }
        /// <summary>
        /// Дата передачи контакта
        /// </summary>
        [Column("Дата передачи контакта")]
        public DateTime DateTransferContact { get; set; }
        /// <summary>
        /// Оператор
        /// </summary>
        [Column("Operator")]
        public String Operator { get; set; }
        /// <summary>
        /// Количество попыток дозвона
        /// </summary>
        [Column("count")]
        public String countCall { get; set; }
        /// <summary>
        /// Последний статус дозвона
        /// </summary>
        [Column("LastStatus")]
        public String LastStatus { get; set; }
        /// <summary>
        /// Часовой пояс
        /// </summary>
        [Column("TimeZona")]
        public String TimeZona { get; set; }

        /// <summary>
        /// Статус звонка (первого)
        /// </summary>
        [Column("Статус звонка (первого)")]
        public String LastCallFirst { get; set; }
        /// <summary>
        /// Количество дозвонов (клиент ответил на звонок)
        /// </summary>
        [Column("Количество дозвонов (клиент ответил на звонок)")]
        public Int32 CountTalkCall { get; set; }
        /// <summary>
        /// Статус звонка (последний дозвон)
        /// </summary>
        [Column("Статус звонка (последний дозвон)")]
        public String LastCallLast { get; set; }
        /// <summary>
        /// Время разговора (последний дозвон)
        /// </summary>
        [Column("Время разговора (последний дозвон)")]
        public Int32 TalkTimeLastCall { get; set; }
        [Column("partner")]
        public String Partner { get; set; }
        [Column("stage")]
        public String Stage { get; set; }
        [Column("timestamp")]
        [Required]
        public DateTime? Timestamp { get; set; }
        [Column("state")]
        public String State { get; set; }
        [Column("scheduledTime")]
        [Required]
        public DateTime? ScheduledTime { get; set; }
        [Column("error")]
        public bool Error { get; set; } 
        /// <summary>
        /// Номер заявки
        /// </summary>
        [Column("contractnum")]
        public String contractnum { get; set; }
        /// <summary>
        /// Дата заявки
        /// </summary>
        [Column("contractdate")]
        public DateTime? contractdate { get; set; }
        /// <summary>
        /// Тип оплаты продукта(реквизиты, карта)
        /// </summary>
        [Column("sitepaymenttype")]
        public String sitepaymenttype { get; set; }
        /// <summary>
        /// Результат оплаты(успешно, ошибка)
        /// </summary>
        [Column("sitepaymentstate")]
        public String sitepaymentstate { get; set; }
        /// <summary>
        /// Дата/время первого звонка
        /// </summary>
        [Column("Дата/время первого звонка")]
        public DateTime? FirstCallDT { get; set; }
        /// <summary>
        /// Дата/время перезвона
        /// </summary>
        [Column("Дата/время перезвона")]
        public DateTime? RecallDT { get; set; }


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
        + ", Channel " + Channel
            + ", Partner " + Partner
            + ", Stage " + Stage
            + ", Timestamp " + Timestamp
            + ", State " + State
            + ", ScheduledTime " + ScheduledTime
            + ", Error " + Error;
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

        "partner": "AK_MK_2.0_Android",
    "stage": "<tr><td>1. Ввод и идентификация данных</td><td>Выбрал продукт Альфа-Капитал Баланс.<br>Авторизация СМЭВ. Заполнил ФИО, телефон, email</td></tr>",
    "timestamp": "08.10.2019 14:57:29",
    "state": "adjourned",
    "scheduledTime": "2019-10-08T15:19:51",
    "error": false

PRIMARY KEY CLUSTERED
(
    [Id] ASC
)WITH(PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON[PRIMARY]
) ON[PRIMARY]

GO

*/
}