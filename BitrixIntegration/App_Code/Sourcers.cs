using System;
using System.Collections.Generic;

/// <summary>
/// Сводное описание для Sourcers
/// </summary>
public class Sourcers
{
  public Sourcers()
  {
    //
    // TODO: добавьте логику конструктора
    //
  }

  public List<DealInfo> ClosedDeals { get; set; }
  public List<ContactInfo> Contacts { get; set; }

}
  public class ContactInfo
  {
    public int Id { get; set; }
    public string Name { get; set; }
    public string SecondName { get; set; }
    public string LastName { get; set; }
    public string Phones { get; set; }
    public string Emails { get; set; }
    public string Title { get { return $"{Name} {SecondName} {LastName}"; } }   

    public DateTime DateCreate { get; set; }
  }

  public class DealInfo
  {
    public int Id { get; set; }
    public string Title { get; set; }
    public DateTime DateCreate { get; set; }
  }