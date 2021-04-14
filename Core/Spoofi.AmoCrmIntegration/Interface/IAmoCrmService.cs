using System.Collections.Generic;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.Dtos.Response;

namespace Spoofi.AmoCrmIntegration.Interface
{
    public interface IAmoCrmService
    {
        /// <summary>
        ///     Получение информации об аккаунте в CRM
        /// </summary>
        /// <returns>Информация об аккаунте - <see cref="CrmAccountInfo" /></returns>
        CrmAccountInfo GetAccountInfo();

        /// <summary>
        ///     Получение пользователей из CRM
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmUser> GetCrmUsers();


        /// <summary>
        ///     Получить компании по Id
        /// </summary>
        /// <returns></returns>
        CrmCompany GetCompany(long CompanyId);
        /// <summary>
        ///     Получить все компании из CRM  
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmCompany> GetCompanies();
        /// <summary>
        ///     Получить все компании из CRM по запросу
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmCompany> GetCompanies(string query);


        /// <summary>
        ///     Получить все контакты из CRM
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmContact> GetContacts();



        /// <summary>
        ///     Получить все контакты из CRM по запросу
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmContact> GetContacts(string query);
        
        /// <summary>
        ///     Получить все лиды из CRM  
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmLead> GetLeads();
        
        /// <summary>
        ///     Получить все воронки из CRM  
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmPipeline> GetPipelines();
        // <summary>
        ///     Получить все лиды из CRM по запросу
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmLead> GetLeads(string query);
        IEnumerable<CrmLead> GetLeads(int status);

        /// <summary>
        ///     Получить сделку по id
        /// </summary>
        /// <param name="leadId">id сделки</param>
        /// <returns>
        ///     <see cref="CrmLead" />
        /// </returns>
        CrmLead GetLead(long leadId);

        /// <summary>
        ///     Получить все контакты из CRM по id ответственного пользователя
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmContact> GetContacts(long responsibleUserId);

        /// <summary>
        ///     Получить все примечания из CRM по id элемента
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmNote> GetNotes(long elementId);


        /// <summary>
        ///     Получить все примечания из CRM по содержимому
        /// </summary>
        /// <returns></returns>
        IEnumerable<CrmNote> GetNotes(string query);

        /// <summary>
        ///     Получить контакт по id
        /// </summary>
        /// <param name="contactId">id контакта</param>
        /// <returns>
        ///     <see cref="CrmContact" />
        /// </returns>
        CrmContact GetContact(long contactId);

        /// <summary>
        ///     Добавление или обновление контактов
        /// </summary>
        /// <param name="addOrUpdateContacts">Объект с обновляемыми/добавляемыми контактами</param>
        /// <returns></returns>
        List<AddedOrUpdatedContact> AddOrUpdateContact(AddOrUpdateContactRequest addOrUpdateContactRequest);


        /// <summary>
        ///     Добавление или обновление задач
        /// </summary>
        /// <param name="addOrUpdateTasks">Объект с обновляемыми/добавляемыми задачами</param>
        /// <returns></returns>
        List<AddedOrUpdatedTask> AddOrUpdateTask(AddOrUpdateTaskRequest addOrUpdateTaskRequest);

        /// <summary>
        ///     Добавление или обновление примечания
        /// </summary>
        /// <param name="addOrUpdateNotes">Объект с обновляемыми/добавляемыми примечание</param>
        /// <returns></returns>
        List<AddedOrUpdatedNote> AddOrUpdateNote(AddOrUpdateNoteRequest addOrUpdateNoteRequest);

        /// <summary>
        ///     Добавление или обновление лида
        /// </summary>
        /// <param name="addOrUpdateLeads">Объект с обновляемыми/добавляемыми лидами</param>
        /// <returns></returns>
        List<AddedOrUpdatedLead> AddOrUpdateLead(AddOrUpdateLeadRequest addOrUpdateLeads);

        /// <summary>
        ///     Добавление или обновление лида
        /// </summary>
        /// <param name="addOrUpdateLeads">Объект с обновляемыми/добавляемыми лидами</param>
        /// <returns></returns>
        List<AddedOrUpdatedLead> AddOrUpdateLeadV2(AddOrUpdateLeadRequest addOrUpdateLeads);

        /// <summary>
        ///     Добавление или обновление кампании
        /// </summary>
        /// <param name="addOrUpdateCompanies">Объект с обновляемыми/добавляемыми кампаиями</param>
        /// <returns></returns>
        List<AddedOrUpdatedCompany> AddOrUpdateCompany(AddOrUpdateCompanyRequest addOrUpdateCompanyRequest);
    }
}