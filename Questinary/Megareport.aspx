<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="Megareport.aspx.cs" Inherits="Megareport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1> CCWS Отчеты</h1>
	<table border="0" cellpadding="20">
	<tr>
	<td valign="top">
	 	
	 	
		<h2>Такском</h2>
     
            <asp:HyperLink ID="HyperLink24_tc" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[takscom_reports]&report=anketa_cid92">Отчет (только анкеты) </asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink25_tc" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[takscom_reports]&report=anketa_full_cid92">Отчет (все звонки) </asp:HyperLink><br/> 
            
	 	
		<h2>Такском Тест</h2>
     
            <asp:HyperLink ID="HyperLink27_tc" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[takscom_reports]&report=anketa_cid91">Отчет (только анкеты)  TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink28_tc" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[takscom_reports]&report=anketa_full_cid91">Отчет (все звонки)  TEST</asp:HyperLink><br/> 
            
            </td>
	<td valign="top">
        <h2>Veiro.    </h2>
          
        
        <br/>
            
        <asp:HyperLink ID="HyperLink25_Veiro" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[Veiro2018_1_reports]&report=anketa_cid86">Отчет по анкетам  </asp:HyperLink><br/>     
        <asp:HyperLink ID="HyperLink27_Veiro" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[Veiro2018_1_reports]&report=anketa_full_cid86">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        </td>
	<td valign="top">
        <h2>Перспектива НТЦ.    </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLink24_PerspectiveNTZ" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[PerspectiveNTZ2018_1_reports]&report=anketa_cid84">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLink25_PerspectiveNTZ" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[PerspectiveNTZ2018_1_reports]&report=anketa_cid85">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26_PerspectiveNTZ" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[PerspectiveNTZ2018_1_reports]&report=anketa_full_cid84">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLink27_PerspectiveNTZ" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[PerspectiveNTZ2018_1_reports]&report=anketa_full_cid85">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        </td>
        
	    <td valign="top">
        <h2>Рус Опрос  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLink24_RusOpros" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[RusOpros2017_1_reports]&report=anketa_cid80">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLink25_RusOpros" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[RusOpros2017_1_reports]&report=anketa_cid81">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26_RusOpros" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[RusOpros2017_1_reports]&report=anketa_full_cid80">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLink27_RusOpros" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[RusOpros2017_1_reports]&report=anketa_full_cid81">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        </td>
	 	<td valign="top">
        <h2>Джи 3  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLink24_3g" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_2_reports]&report=anketa_cid78">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLink25_3g" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_2_reports]&report=anketa_cid79">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26_3g" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_2_reports]&report=anketa_full_cid78">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLink27_3g" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_2_reports]&report=anketa_full_cid79">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        </td>
        
        </tr>
	<tr>
	
	 	<td valign="top">
        <h2>Инклюзивное образование  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkIO_24" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_1_reports]&report=anketa_cid73">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkIO_25" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_1_reports]&report=anketa_cid74">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkIO_26" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_1_reports]&report=anketa_full_cid73">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkIO_27" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[CommGroup2017_1_reports]&report=anketa_full_cid74">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        </td>
	
	 	<td valign="top">
        <h2>Omnicomm  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkOM_24" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[Omnicomm2017_1_reports]&report=anketa_cid69">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkOM_25" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[Omnicomm2017_1_reports]&report=anketa_cid70">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkOM_26" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[Omnicomm2017_1_reports]&report=anketa_full_cid69">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkOM_27" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[Omnicomm2017_1_reports]&report=anketa_full_cid70">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        </td>
		 
	 	<td valign="top">
        <h2>Маркетинг Манаева Г.С.  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkMM_24" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingManayeva2017_1_reports]&report=anketa_cid67">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkMM_25" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingManayeva2017_1_reports]&report=anketa_cid68">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkMM_26" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingManayeva2017_1_reports]&report=anketa_full_cid67">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkMM_27" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingManayeva2017_1_reports]&report=anketa_full_cid68">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
      
        </td>
	
	 	<td valign="top">
        <h2>Маркетинг консультант  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkMC_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingConsultant2017_1_reports]&report=anketa_cid65">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkMC_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingConsultant2017_1_reports]&report=anketa_cid66">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkMC_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingConsultant2017_1_reports]&report=anketa_full_cid65">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkMC_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[MarketingConsultant2017_1_reports]&report=anketa_full_cid66">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        
		 
      
        </td>
        </tr>
        
        <tr>
	
		
	
	 	<td valign="top">
        <h2> Бинбанк - 2017  </h2>
          
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkbinbank2017_1_reports27" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[binbank2017_1_reports]&report=anketa_cid62">Отчет по анкетам TEST база</asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkbinbank2017_1_reports28" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[binbank2017_1_reports]&report=anketa_cid64">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkbinbank2017_1_reports30" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[binbank2017_1_reports]&report=anketa_full_cid62">Отчет по анкетам Вся Test база  </asp:HyperLink><br/>   
        <asp:HyperLink ID="HyperLinkbinbank2017_1_reports29" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[binbank2017_1_reports]&report=anketa_full_cid64">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
          
        
		 
      
        </td>
		
	 	<td valign="top">
	 	
	 	
	 	
        <h2> Отчеты по РИД - СК - 2018 Интершарм_2018 13.10.2018 База WS без КЛ</h2>
         
        <asp:HyperLink ID="HyperLink24_1" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid96">Мониторинг база</asp:HyperLink><br/>  
        
        <br/>
          
        
        
        <asp:HyperLink ID="HyperLink25_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20181013_ws_reports]&report=anketa_cid96">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20181013_ws_reports]&report=anketa_full_cid96">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
	 	
	 	  <h3> TEST</h3>
        
        <asp:HyperLink ID="HyperLink24_7" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20181013_ws_reports]&report=anketa_cid95">Отчет по анкетам TEST </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink25_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20181013_ws_reports]&report=anketa_full_cid95">Отчет по анкетам Вся база TEST </asp:HyperLink><br/>   
        
        <br/> 
	 	
	 	
        <h2> Отчеты по РИД - СК - 2018 Интершарм_2018 27.08.2018 База WS</h2>
         
        <asp:HyperLink ID="HyperLink24man_getMakeRIDSK7_WS" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid90">Мониторинг база</asp:HyperLink><br/>  
        
        <br/>
          
        
        
        <asp:HyperLink ID="HyperLink25man_getMakeRIDSK7_WS" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180827_ws_reports]&report=anketa_cid94">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26man_getMakeRIDSK7_WS" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180827_ws_reports]&report=anketa_full_cid94">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
	 	
	 	
	 	<!--
	 	
        <h2> Отчеты по РИД - СК - 2018 Интершарм_2018 21.03.2018 Участники Москва</h2>
         
        <asp:HyperLink ID="HyperLink24_03042018" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid89">Мониторинг база</asp:HyperLink><br/>  
        
        <br/>
          
        
        
        <asp:HyperLink ID="HyperLink25_03042018" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180321_reports]&report=anketa_cid89">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26_03042018" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180321_reports]&report=anketa_full_cid89">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
	 	
	 	
        <h2> Отчеты по РИД - СК - 2018 Интершарм_2018 21.03.2018 Участники</h2>
         
        <asp:HyperLink ID="HyperLink24_21032018" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid88">Мониторинг база</asp:HyperLink><br/>  
        
        <br/>
          
        
        
        <asp:HyperLink ID="HyperLink25_21032018" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180321_reports]&report=anketa_cid88">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink26_21032018" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180321_reports]&report=anketa_full_cid88">Отчет по анкетам Вся база  </asp:HyperLink><br/>   -->
        
       <h3> TEST</h3>
        
        <asp:HyperLink ID="HyperLink27_21032018" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180827_ws_reports]&report=anketa_cid93">Отчет по анкетам TEST </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink28_21032018" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk20180827_ws_reports]&report=anketa_full_cid93">Отчет по анкетам Вся база TEST </asp:HyperLink><br/>   
        
        <br/> 
	 	
	 	
        <h2> Отчеты по РИД - СК - 2018 Интершарм_2018 10.01.2018</h2>
         
        <asp:HyperLink ID="HyperLink25_1" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid82">Мониторинг база</asp:HyperLink><br/>  
        
        <br/>
          
        
        
        <asp:HyperLink ID="HyperLink27_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_cid82">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLink28_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_full_cid82">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/> 
	 	
        <h2> Отчеты по РИД - СК - 2017 Интершарм_2017 21.08.2017</h2>
        
        <asp:HyperLink ID="HyperLinkRI_24" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid71">Мониторинг TEST база</asp:HyperLink><br/> 
        <asp:HyperLink ID="HyperLinkRI_25" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid72">Мониторинг база</asp:HyperLink><br/>  
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkRI_27" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_cid71">Отчет по анкетам TEST база</asp:HyperLink><br/> 
        
        
        <asp:HyperLink ID="HyperLinkRI_28" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_cid72">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkRI_29" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_full_cid72">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/> 
         
      
	 	
        <h2> Отчеты по РИД - СК - 2017 Интершарм_2017</h2>
        
        <asp:HyperLink ID="HyperLinkRidSk9_2_6" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid59">Мониторинг TEST база</asp:HyperLink><br/> 
        <asp:HyperLink ID="HyperLinkRidSk9_2_5" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid60">Мониторинг база</asp:HyperLink><br/> 
        <asp:HyperLink ID="HyperLinkRidSk9_2_7" runat="server" NavigateUrl="Report.aspx?Procedure=OUTBOUND.[dbo].[man_getMakeRIDSK7]&report=anketa_cid61">Мониторинг база Москва</asp:HyperLink><br/> 
        
        <br/>
         
        <asp:HyperLink ID="HyperLinkRidSk9_2_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_cid59">Отчет по анкетам TEST база</asp:HyperLink><br/> 
        
        
        <asp:HyperLink ID="HyperLinkRidSk9_2_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_cid60">Отчет по анкетам  </asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkRidSk9_2_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_full_cid60">Отчет по анкетам Вся база  </asp:HyperLink><br/>   
        
        <br/>
        
        <asp:HyperLink ID="HyperLinkRidSk9_2_8" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_cid61">Отчет по анкетам Москва</asp:HyperLink><br/>  
        <asp:HyperLink ID="HyperLinkRidSk9_2_9" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ridsk8_reports]&report=anketa_full_cid61">Отчет по анкетам Вся база Москва</asp:HyperLink><br/>   
        
		<!--	<asp:HyperLink ID="HyperLinkRidSk9_2_4" runat="server" NavigateUrl="excel/Calendar.asp?action=reportCSV.asp&repproc=CCWS.dbo.ridsk8_reports&pars=@report=anketa_full_cid60">Отчет по анкетам Вся база CSV  </asp:HyperLink><br/> 
		-->
      
      
      
      
        </td>
	
	<td>
	    <br/>
			<h2>РАТ</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkRAT" runat="server" NavigateUrl="~/reports/RAT/Default.aspx">Отчеты</asp:HyperLink><br/>
             
			 
	    </td>
	    
	    <td>
	    <br/>
			<h2>ACTION  03.10.2016</h2>
            <br/>
            <asp:HyperLink ID="HyperLink24_Action" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD2016_reports]&report=anketa1n_cid57">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink25_Action" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD2016_reports]&report=anketa1nfull_cid57">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink26_Action" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD2016_reports]&report=anketa1Svod_cid57">Отчет   Сводный</asp:HyperLink><br/>
    
			<h2>ACTION  03.10.2016  Ночь</h2>
            <br/>
            <asp:HyperLink ID="HyperLink24_Action1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD2016_reports]&report=anketa1n_cid58">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink24_Action2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD2016_reports]&report=anketa1nfull_cid58">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink24_Action3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD2016_reports]&report=anketa1Svod_cid58">Отчет   Сводный</asp:HyperLink><br/>
    
	    </td>
	</tr>
	<tr>
	
		
		<td valign="top">
			<h2>Отчеты, симпозиум</h2>
    
            <asp:HyperLink ID="HyperLink_SCCS_Calls" runat="server" NavigateUrl="reports/report_calls/">Отчет по звонкам</asp:HyperLink><br/>
	 	</td> 
	 	<td valign="top"> 
	 	<h2>Телестар </h2>
            <br/>
            <asp:HyperLink ID="HyperLinkTelestar1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[telestar_reports]&report=anketa1n_cid53">Отчет  </asp:HyperLink><br/> 
    </td> 
	 	<td valign="top"> 
	 	<h2>Анкор  2015 </h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAnkor_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ankor_reports]&report=anketa1n_cid53">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAnkor_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ankor_reports]&report=anketa1nfull_cid53">Отчет   (все попытки)</asp:HyperLink><br/>
            <h2>Анкор  2015  ТЕСТ</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAnkor_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ankor_reports]&report=anketa1n_cid52">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAnkor_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[ankor_reports]&report=anketa1nfull_cid52">Отчет   (все попытки)</asp:HyperLink><br/>
        
            <!--<asp:HyperLink ID="HyperLinkAnkor_5" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid51">Отчет   Сводный</asp:HyperLink><br/>-->
    </td> 
    
	 	<td valign="top"> 
             <h2>Дельта Кредит Исход</h2>
    <asp:HyperLink ID="HyperLinkDeltaCredit" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportQuickSilver]&report=report3">Отчет по звонкам</asp:HyperLink><br/>
</td> 
	 	
    </tr>
    <tr>
		<td valign="top">
			<h2>Прио-Внешторгбанк</h2>
    <asp:HyperLink ID="HyperLinkPrioVTB_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid32">Отчет по рег формам</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkPrioVTB_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports_2.0]&report=report_calls_pid32full">Отчет по звонкам</asp:HyperLink><br/>
    
    </td>
	
		
		<td valign="top">
			<h2>ТВ Торг Опрос Новые клиенты TEST</h2>
            <asp:HyperLink ID="HyperLinkTvTorg_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=new_cid47">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkTvTorg_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=new_full_cid47">Отчет   (все попытки)</asp:HyperLink><br/>
         
			<h2>ТВ Торг Опрос Старые клиенты TEST</h2>
            <asp:HyperLink ID="HyperLinkTvTorg_7" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=old_cid50">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkTvTorg_8" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=old_full_cid50">Отчет   (все попытки)</asp:HyperLink><br/>
         
			<h2>ТВ Торг Опрос Новые клиенты</h2>
            <asp:HyperLink ID="HyperLinkTvTorg_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=new_cid48">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkTvTorg_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=new_full_cid48">Отчет   (все попытки)</asp:HyperLink><br/>
         
			<h2>ТВ Торг Опрос Старые клиенты</h2>
            <asp:HyperLink ID="HyperLinkTvTorg_5" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=old_cid49">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkTvTorg_6" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[shopShow_reports]&report=old_full_cid49">Отчет   (все попытки)</asp:HyperLink><br/>
         
    </td>
	 	
		<td valign="top">
			<h2>Билла</h2>
    <asp:HyperLink ID="HyperLinkBilla_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid30">Отчет по рег формам</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkBilla_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports_2.0]&report=report_calls_pid30full">Отчет по звонкам</asp:HyperLink><br/>
   
    <asp:HyperLink ID="HyperLinkBilla_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportBilla]&report=report_pretenz">Отчет по претензиям</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkBilla_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportBilla]&report=report_orders">Отчет по запросам</asp:HyperLink><br/>

         <h2>Билла Персонал</h2>
    <asp:HyperLink ID="HyperLinkBillaPersonal_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid31">Отчет по рег формам</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkBillaPersonal_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports_2.0]&report=report_calls_pid31full">Отчет по звонкам</asp:HyperLink><br/>
     
	 	</td> 
	 	
	 </tr>
	 
	 <tr>
	
		
		<td valign="top">
			<h2>Отчеты, KFC Исход</h2>
    
            <asp:HyperLink ID="HyperLinkKFC_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportKFC]&report=report">Отчет по звонкам</asp:HyperLink><br/>
	 	</td> 
	 	
	 	
		
	 	
	 </tr>
	 
	 <tr>
		
		
		<td valign="top">
			<h2>Эксимбанк</h2>
    <asp:HyperLink ID="HyperLinkEximBank" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportExim]&report=report_calls_pid22">Отчет по звонкам</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkEximBankOut" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportExim]&report=report_calls_out_pid22">Отчет по звонкам Исход</asp:HyperLink><br/>
	 	</td> 
	 	<td valign="top">
	 	
	 	<h2>Boardriders Club</h2>
    <asp:HyperLink ID="HyperLink24_Boardriders" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportQuickSilver]&report=WS_BoardridersClub">Отчет по форме</asp:HyperLink><br/>
    
	 	<h2>Quiksilver Звонки с сайте</h2>
    <asp:HyperLink ID="HyperLinkreportCallFromSite" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportQuickSilver]&report=reportCallFromSite">Отчет по звонкам</asp:HyperLink><br/>
			<h2>Quiksilver и Roxy</h2>
    <asp:HyperLink ID="HyperLinkQR" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid26">Отчет по звонкам</asp:HyperLink><br/>
             <h2>Quiksilver Исход</h2>
    <asp:HyperLink ID="HyperLinkQR_Out" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportQuickSilver]&report=report">Отчет по звонкам</asp:HyperLink><br/>

             	<h2>DC Russia</h2>
    <asp:HyperLink ID="HyperLinkDCRussia" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid27">Отчет по звонкам</asp:HyperLink><br/>
 <h2>DC Russia Исход</h2>
    <asp:HyperLink ID="HyperLinkQR_Out2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportQuickSilver]&report=report2">Отчет по звонкам</asp:HyperLink><br/>

<h2>Quiksilver Исход по пропущенным</h2>
    <asp:HyperLink ID="HyperLinkQR_OutMissed" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid28">Отчет по звонкам</asp:HyperLink><br/>
    
<h2>DC Russia Исход по пропущенным</h2>
    <asp:HyperLink ID="HyperLinkDCRussia_OutMissed" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid29">Отчет по звонкам</asp:HyperLink><br/>
    
	 	</td> 
	 	
	 	
	 	
	 	
		<td valign="top">
			<h2>Центр Персонализированной Медицины</h2>
    <asp:HyperLink ID="HyperLinkCPM_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cpm_reports]&report=report_calls">Отчет по звонкам</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkCPM_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cpm_reports]&report=report_orders">Отчет по записям в клинику</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkCPM_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cpm_reports]&report=report_polis">Отчет по заявкам на полис</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkCPM_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cpm_reports]&report=report_consult">Отчет по заявкам на консультацию</asp:HyperLink><br/>
    <h3>Исход</h3>
    <asp:HyperLink ID="HyperLinkCPM_6" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cpm_reports]&report=report_orders_anketa">Отчет по анкетам</asp:HyperLink><br/>
	 	</td> 
	 	
	 	<td valign="top">
	 	
	 	
		<h2>ACTION 2016 #1</h2>
     
            <asp:HyperLink ID="HyperLinkA_1_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_1_reports]&report=anketa_cid55">Отчет (только анкеты)  TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_1_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_1_reports]&report=anketa_full_cid55">Отчет (все звонки)  TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_1_3" runat="server" NavigateUrl="reports/action2015/Report.aspx?Procedure=CCWS.[dbo].[action2016_1_reports]&report=anketa_cid55">Отчет качественный  TEST</asp:HyperLink><br/>
            
			<br/>
			
            <asp:HyperLink ID="HyperLinkA_1_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_1_reports]&report=anketa_cid56">Отчет (только анкеты)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_1_5" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_1_reports]&report=anketa_full_cid56">Отчет (все звонки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_1_6" runat="server" NavigateUrl="reports/action2015/Report.aspx?Procedure=CCWS.[dbo].[action2016_1_reports]&report=anketa_cid56">Отчет качественный</asp:HyperLink><br/>
            
			<br/>
	 	
		<h2>ACTION 2015 #1</h2>
     
            <asp:HyperLink ID="HyperLinkA_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2015_reports]&report=anketa_cid40">Отчет (только анкеты)  TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2015_reports]&report=anketa_full_cid40">Отчет (все звонки)  TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_5" runat="server" NavigateUrl="reports/action2015/Report.aspx?Procedure=CCWS.[dbo].[action2015_reports]&report=anketa_cid40">Отчет качественный  TEST</asp:HyperLink><br/>
            
			<br/>
			
		  <asp:HyperLink ID="HyperLinkA_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2015_reports]&report=anketa_cid41">Отчет (только анкеты)   </asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2015_reports]&report=anketa_full_cid41">Отчет (все звонки)   </asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkA_6" runat="server" NavigateUrl="reports/action2015/Report.aspx?Procedure=CCWS.[dbo].[action2015_reports]&report=anketa_cid41">Отчет качественный  TEST</asp:HyperLink><br/>
            
			<br/>
			<h2>ACTION  2015 #2</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_19" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid42">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_20" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid42">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_21" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid42">Отчет   Сводный</asp:HyperLink><br/>
    
			<br/>
			<h2>ACTION  2015 #3</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_22" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid43">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_23" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid43">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_24" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid43">Отчет   Сводный</asp:HyperLink><br/>
    
			<br/>
			<h2>ACTION  2015 #4</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_25" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid44">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_26" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid44">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_27" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid44">Отчет   Сводный</asp:HyperLink><br/>
    
			<br/>
			<h2>ACTION  2015 #5</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_28" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid45">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_29" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid45">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_30" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid45">Отчет   Сводный</asp:HyperLink><br/>
    
			<br/>
			<h2>ACTION  2015 #6</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_31" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid46">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_32" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid46">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_33" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid46">Отчет   Сводный</asp:HyperLink><br/>
                <br/>
			<h2>ACTION  2015 #7</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_34" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid51">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_35" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid51">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_36" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid51">Отчет   Сводный</asp:HyperLink><br/>
    
			<h2>ACTION  2016 Горячая Линия Механика</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_37" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_reports]&report=anketa1n_cid54">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_38" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_reports]&report=anketa1nfull_cid54">Отчет   (все попытки)</asp:HyperLink><br/>
          <!--  <asp:HyperLink ID="HyperLinkAction_39" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action2016_reports]&report=anketa1Svod_cid54">Отчет   Сводный</asp:HyperLink><br/>
    -->
	
	
		<!--
			<h2>ACTION 1</h2>
    
            <asp:HyperLink ID="HyperLink24" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1_cid18">Отчет TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink26" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1_cid19">Отчет (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink25" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1full_cid19">Отчет (все попытки)</asp:HyperLink><br/>
			<br/>
			
			<h2>ACTION 1 23.11.2014</h2>
    
            <asp:HyperLink ID="HyperLinkAction_8" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1n_cid32">Отчет TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1Svod_cid32">Отчет TEST Сводный</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1n_cid31">Отчет (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_7" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1nfull_cid31">Отчет (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[action_reports]&report=anketa1Svod_cid31">Отчет Сводный</asp:HyperLink><br/>
            
            <br/>
			<h2>ACTION 1 Прогрессивный 23.11.2014</h2>
     
            <asp:HyperLink ID="HyperLinkAction_5" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid32">Отчет TEST (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_9" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid32">Отчет TEST (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_6" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid32">Отчет TEST Сводный</asp:HyperLink><br/>
            
            <br/>
            <asp:HyperLink ID="HyperLinkAction_10" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid31">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_11" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid31">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_12" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid31">Отчет   Сводный</asp:HyperLink><br/>
            
            <br/>
            
			<h2>ACTION  Прогрессивный 02.12.2014</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_13" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid35">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_14" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid35">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_15" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid35">Отчет   Сводный</asp:HyperLink><br/>
          
			<h2>ACTION  Прогрессивный 12.12.2014</h2>
            <br/>
            <asp:HyperLink ID="HyperLinkAction_16" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1n_cid38">Отчет   (только конечные попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_17" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1nfull_cid38">Отчет   (все попытки)</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkAction_18" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[actionD_reports]&report=anketa1Svod_cid38">Отчет   Сводный</asp:HyperLink><br/>
          -->
    
     	 	</td> 
     	 	
    </tr>
    <tr>
	 	
		<td valign="top">
			<h2>Нано-финанс</h2>
    <asp:HyperLink ID="HyperLinkNF_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid25">Отчет по рег формам</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkNF_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports_2.0]&report=report_calls_pid25full">Отчет по звонкам</asp:HyperLink><br/>
   
            <h2>Нано-финанс Исход</h2>
    <asp:HyperLink ID="HyperLinkNF_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportNanofinance]&report=report">Отчет по звонкам</asp:HyperLink><br/>

    <asp:HyperLink ID="HyperLinkNF_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportNanofinance]&report=report_orders">Отчет по звонкам Письма</asp:HyperLink><br/>

	 	</td> 
	 	
	 
		
		<td valign="top"> 
		
            <h2>Сити Риал Эстэйт Групп</h2> 
    <asp:HyperLink ID="HyperLinkCR_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[universal_reports]&report=report_calls_pid21">Отчет по звонкам</asp:HyperLink><br/>
            </td>
		
		<td valign="top"> 
		
            <h2>ФКУ</h2>
    <asp:HyperLink ID="HyperLinkFKU_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[FKU_reports]&report=report_db_cid27">Отчет по анкетам TEST </asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkFKU_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[FKU_reports]&report=report_db_cid28">Отчет по анкетам</asp:HyperLink><br/>
            </td>
		
		<td valign="top">
			<h2>ЦУЗ 14</h2>
    
            <asp:HyperLink ID="HyperLinkCUZ_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cuz_reports]&report=anketa14_cid22">Отчет TEST</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkCUZ_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cuz_reports]&report=anketa14_cid23">Отчет</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkCUZ_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cuz_reports]&report=anketa14nedo_cid23">Отчет по анкетам недоведенные до конца</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLinkCUZ_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cuz_reports]&report=anketa14full_cid23">Отчет по анкетам (все статусы соединения)</asp:HyperLink><br/>
            
        	</td> 
		
		</tr>
	 	<tr>
		
		<td valign="top">
			<h2>HSR</h2>
    
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportsHSR57]&report=report_calls">Отчет</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink01" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportsHSR57]&report=report_reg_tt">Отчет Форма для регистрации обращений </asp:HyperLink><br/>
	 	</td> 
	 	
	 	
		<td valign="top">
			<h2>Polly</h2>
    
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportsPolly]&report=report_calls">Отчет</asp:HyperLink><br/>
          	</td> 
          	<td valign="top">
			<h2>Югра</h2>
    
            <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[jugra_reports]&report=report_calls">Отчет</asp:HyperLink><br/>
            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[jugra_reports]&report=report_regs">Отчет  по обращениям</asp:HyperLink><br/>
          	</td>  
          	<td valign="top"> 
          	
          	
          	
    <h2>Сбербанк - Депо </h2>
   <h3>Основная База</h3>
    <asp:HyperLink ID="HyperLinkDepo_6" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report.aspx?report=anketa1_cid21">Отчет Сбербанк Премьер Исход</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkDepo_4" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report2.aspx?Procedure=CCWS.[dbo].[sberbank8_reports]&report=anketa2_cid21">Отчет по базе</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkDepo_7" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report2CSV.aspx?Procedure=CCWS.[dbo].[sberbank8_reports]&report=anketa2CSV_cid21">Отчет по базе (CSV)</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkDepo_5" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report3.aspx?report=anketa3_cid21">Детализированный отчет</asp:HyperLink><br/>  
    
    <h3>ТЕСТ База</h3>
    <asp:HyperLink ID="HyperLinkDepo_1" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report.aspx?report=anketa1_cid20">Отчет Сбербанк Премьер Исход</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkDepo_2" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report2.aspx?Procedure=CCWS.[dbo].[sberbank8_reports]&report=anketa2_cid20">Отчет по базе</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkDepo_8" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report2CSV.aspx?Procedure=CCWS.[dbo].[sberbank8_reports]&report=anketa2CSV_cid20">Отчет по базе (CSV)</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkDepo_3" runat="server" NavigateUrl="reports/sbrf/sbrf8/Report3.aspx?report=anketa3_cid20">Детализированный отчет</asp:HyperLink><br/>  
    
    
    
    <h2>Сбербанк - Удовлетворенность Молодежь №9</h2>
     <asp:HyperLink ID="HyperLink18" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_cid26">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink19" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_itog_cid26">Отчет итоговый</asp:HyperLink><br/>
    
    <h2>Сбербанк - Удовлетворенность Молодежь №9 МАРК</h2>
    
    <asp:HyperLink ID="HyperLinSBRF29_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_mark_cid29">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLinSBRF29_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_itog_cid29">Отчет итоговый</asp:HyperLink><br/>
   
    	
    
    
    <h2>Сбербанк - Удовлетворенность Социальный №10</h2>
     <asp:HyperLink ID="HyperLinSBRF34_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank10_reports]&report=anketa_10_cid34">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLinSBRF34_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_itog_cid34">Отчет итоговый</asp:HyperLink><br/>
    
    
    
    <h2>Сбербанк - Удовлетворенность Массовый     №11</h2>
     <asp:HyperLink ID="HyperLink6_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank10_reports]&report=anketa_10_cid39">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink7_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_itog_cid39">Отчет итоговый</asp:HyperLink><br/>
    
    
    
    <h2>Сбербанк - ЦА1-МВС №12</h2>
     <asp:HyperLink ID="HyperLinSBRF37_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank12_reports]&report=anketa_12_cid37">Отчет по анкетам</asp:HyperLink><br/>
  
        <asp:HyperLink ID="HyperLinSBRF37_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank9_10_11_reports]&report=anketa_9_10_11_itog_cid37">Отчет итоговый</asp:HyperLink><br/>
    
    	
    
    <h2>Сбербанк - ЦА2 Премьер №13</h2>
     <asp:HyperLink ID="HyperLinSBRF36_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank13_reports]&report=anketa_13_cid36">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLinSBRF36_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank13_reports]&report=anketa_13_itog_cid36">Отчет итоговый</asp:HyperLink><br/>
    
    	
    	 
		
    <h2>Сбербанк - CallBack B2B - ВЭД</h2>
    <asp:HyperLink ID="HyperLinkCallBackB2BVED_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBackB2B_VED_cid1">Отчет по анкетам TEST</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkCallBackB2BVED_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBackB2B_VED_cid2">Отчет по анкетам</asp:HyperLink><br/>
    
    	
    <h2>Сбербанк - претензии</h2>
    <asp:HyperLink ID="HyperLinkSbrf_comp_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reportsSbrfComplaints]&report=complaints_calendar">Отчет по претезиям</asp:HyperLink><br/>
   
    <h2>Сбербанк - Call Back сертификаты</h2>
    <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBackSertificat_cid4">Отчет по анкетам ТЕСТ</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBackSertificat_cid5">Отчет по анкетам</asp:HyperLink><br/>
   
    <h2>Сбербанк - Проект Сбербанка - Доля МВС</h2>
    <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_mbc_cid6">Отчет по анкетам ТЕСТ</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLink9" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_mbc_cid7">Отчет по анкетам</asp:HyperLink><br/>
   
    <asp:HyperLink ID="HyperLink10" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_mbc_itog_cid6">Отчет итоговый ТЕСТ</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLink11" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_mbc_itog_cid7">Отчет итоговый</asp:HyperLink><br/>
   
   
    <h2>Сбербанк - Проект Сбербанка -   3_Удв._Канал Премьер</h2>
     <asp:HyperLink ID="HyperLink13" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_udv2_cid10">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink15" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_udv2_itog_cid10">Отчет итоговый</asp:HyperLink><br/>
   
   
    <h2>Сбербанк - Проект Сбербанка - 2_Удв_сегмент МВС</h2>
     <asp:HyperLink ID="HyperLink12" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_udv3_segment_cid8">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink14" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_udv3_segment_itog_cid8">Отчет итоговый</asp:HyperLink><br/>
   
   
   
    <h2>Сбербанк - Проект Сбербанка -   5_Удв._Канал Премьер</h2>
     <asp:HyperLink ID="HyperLink16" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_udv2_cid13">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink17" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_CallBack_marc_udv2_itog_cid13">Отчет итоговый</asp:HyperLink><br/>
   
   
   
   
    <h2>Сбербанк - Удовлетворенность Молодежный №5</h2>
     <asp:HyperLink ID="HyperLink24_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_full_cid14">Отчет по всем анкетам</asp:HyperLink><br/>
     <asp:HyperLink ID="HyperLink24_" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_cid14">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink25_" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_itog_cid14">Отчет итоговый</asp:HyperLink><br/>
   
   
   
    <h2>Сбербанк - Удовлетворенность Социальный №6</h2>
     <asp:HyperLink ID="HyperLink24_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_full_cid15">Отчет по всем анкетам</asp:HyperLink><br/>
     <asp:HyperLink ID="HyperLink20" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_cid15">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink21" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_itog_cid15">Отчет итоговый</asp:HyperLink><br/>
   
    <h2>Сбербанк - Удовлетворенность Массовый №7</h2>
     <asp:HyperLink ID="HyperLink24_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_full_cid17">Отчет по всем анкетам</asp:HyperLink><br/>
     <asp:HyperLink ID="HyperLink22" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_cid17">Отчет по анкетам</asp:HyperLink><br/>
   
        <asp:HyperLink ID="HyperLink23" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[sberbank_reports]&report=anketa_5_6_7_itog_cid17">Отчет итоговый</asp:HyperLink><br/>
 
           </td>
           </tr>
           <tr>
           <td valign="top"> 
		
            <h2>911</h2>
    <asp:HyperLink ID="HyperLink911_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[reports911]&report=report_db_cid3">Отчет по анкетам</asp:HyperLink><br/>
            </td>
            <td valign="top"> 
		
            <h2>Кардиф</h2>
    <asp:HyperLink ID="HyperLinkCardif_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_calls">Отчет по звонкам</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkCardif_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_agent">Отчет по операторам</asp:HyperLink><br/>
    
    
            <h2>Кардиф 2</h2>
            <h3>Claim</h3>
    <asp:HyperLink ID="HyperLinkCardif_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_calls_claim">Отчет по звонкам</asp:HyperLink><br/> 
    
            <h3>Cancellation</h3>
    <asp:HyperLink ID="HyperLinkCardif_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_calls_cancellation">Отчет по звонкам</asp:HyperLink><br/> 
    
            </td>
            <td valign="top"> 
		
            <h2>ТВ Торг</h2>
    <asp:HyperLink ID="HyperLink_tv_torg_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[tv_torg_reports]&report=anketa1_cid11">Отчет по звонкам</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLink_tv_torg_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[tv_torg_reports]&report=anketa1_cid12">Отчет по звонкам TEST</asp:HyperLink><br/>
            </td>
		</tr>
	</table>
</asp:Content>

