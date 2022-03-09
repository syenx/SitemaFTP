<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DownloadPlanilhas.aspx.cs" Inherits="KS.ABCFarma.DownloadPlanilhas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ucc" %>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.css">
    <link href="../../Styles/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="../../Styles/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="../../Scripts/jquery-3.3.1.slim.min.js"></script>
    <script type="text/javascript" src="../../Scripts/popper.min.js"></script>
    <script type="text/javascript" src="../../Scripts/bootstrap.min.js"></script>
    <link href="../../Styles/bootstrap.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        /* Center the loader */
        #loader {
            position: absolute;
            left: 50%;
            top: 50%;
            z-index: 1;
            width: 150px;
            height: 150px;
            margin: -75px 0 0 -75px;
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 120px;
            height: 120px;
            -webkit-animation: spin 2s linear infinite;
            animation: spin 2s linear infinite;
        }

        @-webkit-keyframes spin {
            0% {
                -webkit-transform: rotate(0deg);
            }

            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        /* Add animation to "page content" */
        .animate-bottom {
            position: relative;
            -webkit-animation-name: animatebottom;
            -webkit-animation-duration: 1s;
            animation-name: animatebottom;
            animation-duration: 1s
        }

        @-webkit-keyframes animatebottom {
            from {
                bottom: -100px;
                opacity: 0
            }

            to {
                bottom: 0px;
                opacity: 1
            }
        }

        @keyframes animatebottom {
            from {
                bottom: -100px;
                opacity: 0
            }

            to {
                bottom: 0;
                opacity: 1
            }
        }

        #myDiv {
            text-align: center;
        }
    </style>
         <div id="loader" style="  display:none;  left: 44%; margin: 0 -122px 0 0; padding: 0 0 0 0; height: 200px; width: 200px; z-index: 2;">
    </div>
  
       <div id="divFundo" style=" display:none;position: absolute;  height: 358px; width: 100%; opacity: 0.5; background-color: black; z-index: 1;">
    </div>

   

    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   
        <div class="modal-dialog">
            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #D9DEE4">

                            <h4 class="modal-title">

                                <%--<asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label>--%></h4>
                            <img src="../../Imagens/Oncoprod_monocromatica.png" style="height: 30px" class="img-responsive" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblModalBody" Font-Size="Medium" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Fechar</button>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>




    <div id="myDiv" class="animate-bottom">
        <div class="card">
            <div class="card-header">
                ABC-FARMA
            </div>
            <div class="card-body">

                <p style="margin: 10px 10px 10px 10px" class="card-text">Funcionalidade para baixar a planilha da ABC-Farma</p>
                <asp:Button ID="btnExcel" Style="margin: 10px 10px 10px 10px" OnClick="btnExcel_Click" Text="Baixar" CssClass="btn btn-primary" runat="server" />

            </div>
        </div>
        <div class="card">
            <div class="card-body">

                <label id="msgRetorno" runat="server" style="color: #ff0000;"></label>
                
 
            </div>
        </div>
    </div>


    <script type="text/javascript">

        function performClick(elemId) {
            var elem = document.getElementById(elemId);
            if (elem && document.createEvent) {
                var evt = document.createEvent("MouseEvents");
                evt.initEvent("click", true, false);
                elem.dispatchEvent(evt);
            }
        }

        //$("#btnAbrirArquivo").click(function (event) {

        //    var myshell = new ActiveXObject("WScript.shell");
        //    myshell.run("file:\\\\10.1.58.6\repositorioabcfarma", 1, true);

        //});

        $("#ContentPlaceHolder1_btnExcel").click(function () {
            setTimeout("", 1000);
            document.getElementById("loader").style.display = "block";
            document.getElementById("divFundo").style.display = "block";

        });


    </script>

</asp:Content>

