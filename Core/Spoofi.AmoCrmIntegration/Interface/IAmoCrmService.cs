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
        ///     Добавление или обновление лида
        /// </summary>
        /// <param name="addOrUpdateLeads">Объект с обновляемыми/добавляемыми лидами</param>
        /// <returns></returns>
        List<AddedOrUpdatedLead> AddOrUpdateLead(AddOrUpdateLeadRequest addOrUpdateLeads);
    }
}