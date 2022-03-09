using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace KS.ABCFarma
{
    public partial class DownloadPlanilhas : System.Web.UI.Page
    {
        public static string filepath { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {


            string url = "https://webserviceabcfarma.org.br/webservice/";
            string parametros = "cnpj_cpf=61940292000137&senha=admin123&cnpj_sh=61940292000137&pagina=1";

            var cli = new WebClient();
            cli.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";


            string response = "";

            for (int i = 1; i < 18; i++)
            {

                Console.WriteLine("Carregando pagina :" + i + ".... Aguarde");
                parametros = "cnpj_cpf=61940292004981&senha=admin123&cnpj_sh=61940292004981&pagina=" + i; cli = new WebClient();
                cli.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";

                if (ConfigurationManager.AppSettings["ArquivoLocal"].Equals("TRUE"))
                {
                    response = BaixarAquivoLocal();
                }
                else
                {
                    response = cli.UploadString(url, parametros);
                    if (response.Contains("error"))
                    {
                        response = BaixarAquivoLocal();
                        msgRetorno.InnerText = "Seus arquivos já foram baixados do servidor ABCFARMA, dessa vez foram baixados Local: ";
                    }
                    else
                    {
                        response = CriarArquivoTXT(response);
                    }
                }

                Console.WriteLine(response);
                var json = response;
                jsonStringToCSV(json, i);
            }
            msgRetorno.InnerText += "Seus arquivos foram salvos em : \\\\10.1.58.6\\RepositorioABCFARMA";

        }

        public string BaixarAquivoLocal()
        {
            return File.ReadAllText(System.AppDomain.CurrentDomain.BaseDirectory.ToString() + @"TesteArquivo\ArquivosRetornoABCFARMA.txt"); //
        }


        public string CriarArquivoTXT(string response)
        {
            string retorno = "";
            string fileName = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + @"TesteArquivo\ArquivosRetornoABCFARMA.txt";

            try
            {
                if (File.Exists(fileName))
                {
                    File.Delete(fileName);
                }

                using (FileStream fs = File.Create(fileName))
                {
                    // Add some text to file    
                    Byte[] title = new UTF8Encoding(true).GetBytes(response);
                    fs.Write(title, 0, title.Length);
                }


                // Open the stream and read it back.    
                using (StreamReader sr = File.OpenText(fileName))
                {
                    string s = "";
                    while ((s = sr.ReadLine()) != null)
                    {
                        retorno = s;
                    }
                }
                return retorno;

            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.ToString());
                return "";
            }
        }

        public static void jsonStringToCSV(string jsonContent, int pagina)
        {
            //used NewtonSoft json nuget package
            XmlNode xml = JsonConvert.DeserializeXmlNode("{record:{record:" + jsonContent + "}}");
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.LoadXml(xml.InnerXml);
            XmlReader xmlReader = new XmlNodeReader(xml);
            DataSet dataSet = new DataSet();
            dataSet.ReadXml(xmlReader);
            DataTable dataTable = new DataTable();
            dataTable = dataSet.Tables[1];

            ExportDataSetToExcel(dataSet, pagina);
        }

        public static void ExportDataSetToExcel(DataSet ds, int pagina)
        {

            string AppLocation = "";
            AppLocation = "\\\\10.1.58.6\\RepositorioABCFARMA\\";//Path.GetPathRoot(Environment.SystemDirectory);//System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            AppLocation = AppLocation.Replace("file:\\", "");
            string date = DateTime.Now.ToShortDateString();
            date = date.Replace("/", "_");
            filepath = AppLocation + "ABCFARMA Pagina-" + pagina + " " + date + ".xlsx";

            using (ClosedXML.Excel.XLWorkbook wb = new ClosedXML.Excel.XLWorkbook())
            {
                for (int i = 0; i < ds.Tables.Count; i++)
                {
                    wb.Worksheets.Add(ds.Tables[i], ds.Tables[i].TableName);
                }
                wb.Style.Alignment.Horizontal = ClosedXML.Excel.XLAlignmentHorizontalValues.Center;
                wb.Style.Font.Bold = true;
                wb.SaveAs(filepath);
            }
        }
    }
}